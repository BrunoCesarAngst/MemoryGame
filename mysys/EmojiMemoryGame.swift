//
//  EmojiMemoryGame.swift
//  mysys
//
//  Created by Bruno Angst on 23/04/23.
//  A classe possui um array de emojis que serão usados no jogo e um método estático createMemoryGame() que cria um objeto MemoryGame do tipo genérico String. Esse objeto tem um número fixo de pares de cartas que correspondem aos emojis definidos no array. Cada carta contém uma string de emoji.

//  A classe também possui uma propriedade cards que retorna uma matriz de cartas de memória. Essa matriz é obtida a partir do modelo interno da classe MemoryGame que foi criado usando o método createMemoryGame().

//  O objetivo deste código é criar um jogo da memória básico usando o padrão MVVM, onde a classe EmojiMemoryGame atua como o ViewModel, criando o modelo de jogo e fornecendo os dados para exibição na interface do usuário (que seria a View no padrão MVVM).

//  ma classe EmojiMemoryGame que usa o framework SwiftUI. Essa classe é um objeto observável, o que significa que qualquer alteração em seus dados internos (publicados) é notificada automaticamente a todos os objetos que os estão observando.

// O objetivo desta classe é fornecer um modelo de jogo de memória de emojis, onde o jogador deve encontrar pares de cartas com o mesmo emoji. O array estático "emojis" contém os emojis que serão usados no jogo. O método estático "createMemoryGame" é usado para criar uma instância de MemoryGame, que é outra classe utilizada nesse código e que implementa a lógica do jogo em si. Este método recebe como parâmetro o número de pares de cartas que devem ser criados e uma função que define qual emoji será atribuído a cada par.

// A propriedade "model" é do tipo MemoryGame<String>, e é inicializada com a chamada ao método "createMemoryGame()". Como essa propriedade é marcada com "@Published", qualquer alteração nela será notificada automaticamente a todos os objetos que a estão observando.

// Por fim, temos um método "choose" que é usado para informar ao modelo que o usuário escolheu uma determinada carta. Essa escolha é repassada para o método "choose" da instância de MemoryGame, que atualiza o estado do jogo.

// Em resumo, esse código define uma classe que implementa a lógica do jogo de memória de emojis, usando o padrão de design Modelo-Visão-Controle (MVC) e o padrão de programação reativa através do uso do "@Published". O SwiftUI é usado para criar a interface do usuário do jogo, que não está presente neste código em si.

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🦯", "🦽", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚠", "🚟", "🚃", "🚋"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
