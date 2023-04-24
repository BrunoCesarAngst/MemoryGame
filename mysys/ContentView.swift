//
//  ContentView.swift
//  mysys
//
//  Created by Bruno Angst on 22/04/23.
//
//  A estrutura ContentView define a interface principal, que inclui uma grade de cartas de memória e uma barra de ferramentas para adicionar ou remover cartas.

//  A estrutura CardsView é usada para definir a aparência de cada carta de memória na grade. As cartas são exibidas como um ZStack (empilhamento de visualizações), com uma forma de retângulo arredondado, que pode ser preenchida com uma cor branca ou preenchida com uma cor dependendo do estado da carta (face para baixo ou correspondida). O texto da carta é exibido no topo da forma quando a carta estiver virada para cima.

//  A estratégia usada para organizar as cartas é uma grade adaptável (LazyVGrid), que se ajusta dinamicamente ao tamanho da tela do dispositivo. A grade é rolável dentro de uma visualização de rolagem (ScrollView) para permitir que o usuário role para ver todas as cartas.

//  As cartas de memória são fornecidas por um objeto viewModel do tipo EmojiMemoryGame. Esse objeto armazena o estado do jogo (por exemplo, quais cartas estão viradas para cima ou correspondidas) e é atualizado sempre que uma carta é selecionada ou correspondida.

//  No geral, este código implementa uma interface de usuário simples, mas eficaz, para um jogo de memória. Ele demonstra o uso de vários recursos do SwiftUI, como o ZStack, VStack, LazyVGrid e ScrollView, bem como o uso de um objeto de modelo de visualização observável (@ObservedObject) para gerenciar o estado do jogo.

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.cards) {
                        card in
                        CardsView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
//            Spacer()
//            HStack {
//                remove
//                Spacer()
//                add
//            }
//            .font(.largeTitle)
//            .padding(.horizontal)

        }
    }
    
    
    
//    var remove: some View {
//        Button {
//            if emojiCount > 1 {
//                emojiCount -= 1
//            }
//        } label: {
//            Image(systemName: "minus.circle")
//        }.disabled(emojiCount <= 4)
//    }
//
//    var add: some View {
//        Button {
//            if emojiCount < emojis.count {
//                emojiCount += 1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//        }.disabled(emojiCount == emojis.count)
//    }
}

struct CardsView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
