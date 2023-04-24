//
//  MemoryGame.swift
//  mysys
//
//  Created by Bruno Angst on 23/04/23.
//  Esse código implementa uma estrutura de dados MemoryGame que representa um jogo de cartas da memória. A estrutura tem um tipo genérico CardContent que representa o conteúdo das cartas, que pode ser definido ao inicializar a estrutura através do parâmetro createCardContent.

//  A propriedade cards contém um array de objetos do tipo Card, que representa as cartas do jogo. A propriedade private(set) define que essa propriedade só pode ser lida fora da estrutura, mas não pode ser modificada.

//  O método chose é responsável por permitir que o usuário escolha uma carta e realizar as ações necessárias em resposta a essa escolha, mas neste caso o método está vazio.

//  O método init é responsável por criar o conjunto de cartas do jogo. Ele recebe o parâmetro numberOfPairsOfCards que representa o número de pares de cartas que devem ser criados e uma função createCardContent que é usada para definir o conteúdo das cartas. Dentro do método, um loop é executado para adicionar numberOfPairsOfCards * 2 cartas ao array de cartas. Cada par de cartas tem o mesmo conteúdo que é definido pela função createCardContent passando o índice do par como parâmetro. A estrutura interna Card representa uma única carta, e armazena informações sobre se a carta está virada para cima (isFaceUp), se a carta já foi correspondida (isMatched) e o conteúdo da carta (content).

// Ele utiliza a estrutura MemoryGame que é um genérico com um tipo CardContent que é especificado como sendo Equatable. A estrutura possui um array de cartas (cards) que são definidas pela estrutura Card, e um índice (indexOfTheOneAndOnlyFaceUpCard) que indica a posição da única carta virada para cima no momento.

// O método choose(_ card: Card) é responsável por controlar a lógica do jogo. Ele recebe uma carta escolhida pelo jogador e verifica se essa carta pode ser escolhida ou não. Para uma carta ser escolhida, ela não pode estar virada para cima e nem ter sido previamente combinada com outra carta.

//  Caso a carta escolhida possa ser virada, o método verifica se já existe outra carta virada e a lógica continua de acordo com a seguinte condição: se a carta escolhida tiver o mesmo conteúdo que a carta anteriormente virada, ambas são marcadas como combinadas e o índice da carta virada é resetado. Caso contrário, a carta anteriormente virada é desvirada e a carta escolhida é virada para cima e seu índice é armazenado.

//  O método init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) é responsável por criar as cartas do jogo. Ele recebe o número de pares de cartas que devem ser criados e uma função que recebe um número inteiro e retorna o conteúdo da carta correspondente a esse número. O método cria o número especificado de pares de cartas e adiciona-os ao array de cartas.

//  Por fim, a estrutura Card define as propriedades de uma carta, incluindo se ela está virada para cima, se já foi combinada com outra carta, seu conteúdo e um identificador único.

//  O código utiliza a biblioteca padrão Foundation para ter acesso a tipos básicos do Swift, como Array. A estratégia utilizada foi de criar uma estrutura genérica para representar o jogo e uma estrutura interna para representar cada carta do jogo, permitindo que o conteúdo das cartas seja especificado pelo usuário ao criar o jogo. Além disso, o código utiliza o método toggle() para mudar o estado de uma carta de virada para cima para virada para baixo e vice-versa.

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // temos cartas
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex =
            cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched  {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // adicionar numberOfPairsOfCards * 2 cartas ao array de cartas
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
