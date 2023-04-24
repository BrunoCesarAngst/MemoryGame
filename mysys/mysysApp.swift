//
//  mysysApp.swift
//  mysys
//
//  Created by Bruno Angst on 22/04/23.
//
//  Ele define uma estrutura de aplicativo (mysysApp) que implementa o protocolo App do SwiftUI, que é a entrada do aplicativo.

//  Dentro da estrutura mysysApp, uma instância do EmojiMemoryGame é criada e atribuída à constante game. Isso provavelmente é uma instância de um modelo de jogo que gerencia a lógica do jogo.

//  A seguir, a variável body é definida como uma cena (Scene) que é um componente de interface do SwiftUI que define o conteúdo que o usuário vê. Aqui, a cena consiste em um WindowGroup, que é uma cena de nível superior que define uma janela na qual o conteúdo do aplicativo é exibido.

//  Dentro do WindowGroup, um ContentView é exibido, que é um componente de interface que contém as visualizações e controles que são exibidos na janela. A instância do EmojiMemoryGame criada anteriormente é passada como argumento para o ContentView, para que a visualização possa ser atualizada com base no estado do jogo.

//  Em resumo, esse código define a estrutura de um aplicativo iOS que usa o SwiftUI para criar uma interface de usuário. Ele segue uma estratégia comum em SwiftUI para definir um modelo de dados (EmojiMemoryGame) e usar uma visualização (ContentView) para exibir esse modelo de dados. O WindowGroup é usado como um contêiner para exibir o ContentView na janela do aplicativo.

import SwiftUI

@main
struct mysysApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
