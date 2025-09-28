//
//  QuizManager.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//


struct QuizManager {
    static let questions: [Question] = [
        Question(
            text: "Sua principal missão matinal é:",
            options: [
                "CAÇAR ALGO QUE SOBROU DE ONTEM",
                "MARCAR PRESENÇA NA AULA",
                "ACOMPANHAR AS NOVAS TRENDS DO TWITTER",
                "FICAR DE BOA E TOMAR UM BANHO DE SOL",
                "CHECAR SEUS AMIGOS",
                "REVER AS PRIORIDADES DO DIA"
            ]
        ),
        Question(
            text: "Em qual reality show você se sairia melhor?",
            options: [
            "A FAZENDA", // ⭐️ Caramelo (Sobrevivência/Caos)
            "Bake Off Brasil", // ⭐️ Neguinho (Serviço/Rotina)
            "Big Brother Brasil", // ⭐️ Chico (Luta/Ativismo)
            "De Férias com o Ex", // ⭐️ Caramelo (Fama/Vibe)
            "MasterChef Brasil", // ⭐️ Neguinho (Rotina/Protocolo)
            "Um documentário sério" // ⭐️ Frajola (Intelectual/Nicho)
            ]
        ),
        Question(
           text: "Você prefere ser reconhecido por:",
           options: [
               "Ser alguém carismático", // ⭐️ Caramelo (0)
               "Ser leal e confiável, a base da comunidade", // ⭐️ Neguinho (1)
               "Ser a voz da mudança em uma causa justa", // ⭐️ Chico (2)
               "Ser um sucesso viral ou o ícone de uma geração", // ⭐️ Caramelo (3)
               "Ser essencial e servir bem na sua função", // ⭐️ Neguinho (4)
               "Ser um intelectual respeitado e qualificado" // ⭐️ Frajola (5)
           ]
       ),
        Question(
            text: "No rolê, qual seu ponto de encontro ideal?",
            options: [
                "PRAÇA LOTADA", // Pretinha (BRT)
                "BAR DA ESQUINA", // Tobias (INSS)
                "UM LUGAR CALMO SEM MUITO FUZUE", // Chico (UFSC)
                "ONDE SER SERÁ", // Cão do Enem
                "ONDE QUISEREM QUE SEJA",
                "ACHO QUE NAO VOU.." // Caramelo
            ]
        ),
        Question(
            text: "Seu hobby principal é:",
            options: [
                "ROLAR O TIKTOK POR 12H", // Manchinha (Protest)
                "SOCIALZINHA COM OS DE FÉ", // Chico (University)
                "ESTUDAR",
                "ANDAR POR AI", // Caramelo PF
                "APRENDER ALGO NOVO", // Caramelo (Meme)
                "LER LER LER" // Tobias (INSS)
            ]
        ),
        Question(
            text: "O que você carrega na mochila?",
            options: [
                "UNS DOCINHOS ALEATÓRIOS", // Frajola (UFRJ)
                "MARMITA, CARTÕES, CPF",
                "CANETAS, FOLHAS DE NOTA", // Pretinha (BRT)
                "TUDO QUE CABER ESTA NA MINHA BOLSA", // Neguinho (Beija-Flor)
                "PRIMEIROS SOCORROS, LENCINHOS", // Caramelo PF
                "BLOCO DE NOTAS CHEIO DE ANOTAÇOES" // Caramelo (Merchandise)
            ]
        ),
        Question(
            text: "Você é mais conhecido por ser:",
            options: [
                "CARISMÁTICO E ENGRAÇADO", // Preta (Metrô SP)
                "GRANDE COMPANHEIRO", // Marrom (Museum Fire)
                "A VOZ DA RAZÃO", // Chico (University)
                "INCRIVELMENTE FOLGADO", // Cão do Enem
                "MELHOR FUNCIONÁRIO DO MÊS", // Caramelo
                "MUITO SÉRIO" // Tobias (INSS)
            ]
        ),
        Question(
                   text: "Você se sente mais convencido por:",
                   options: [
                       "O que o seu 'coração' diz, a intuição", // ⭐️ Caramelo (0)
                       "O consenso geral, o que é melhor para a maioria", // ⭐️ Neguinho (1)
                       "O argumento mais lógico apoiado por dados", // ⭐️ Chico (2)
                       "O que já deu certo no passado e é seguro", // ⭐️ Caramelo (3)
                       "A opinião de quem você mais confia", // ⭐️ Neguinho (4)
                       "A citação de um pensador famoso" // ⭐️ Frajola (5)
                   ]
               ),
        Question(
            text: "O que te inspira a continuar a jornada?",
            options: [
                "A chance de virar estampa de camiseta", // ⭐️ Caramelo (0)
                "O sorriso de quem foi ajudado por mim", // ⭐️ Neguinho (1)
                "A justiça, custe o que custar", // ⭐️ Chico (2)
                "O próximo feriado", // ⭐️ Caramelo (3)
                "O sentimento de dever cumprido", // ⭐️ Neguinho (4)
                "O conhecimento puro, simples e sem fim." // ⭐️ Frajola (5)
            ]
        ),
        Question(
            text: "QUAL O SEU DESTINO FINAL?",
            options: [
                "Viver a vida no modo free play", // ⭐️ Caramelo (0)
                "Fazer parte de uma equipe, sendo a base.", // ⭐️ Neguinho (1)
                "Ser a chama que acende a mudança", // ⭐️ Chico (2)
                "Me tornar o ícone de uma geração inteira", // ⭐️ Caramelo (3)
                "Ter meu próprio lugar e rotina definida", // ⭐️ Neguinho (4)
                "Ser o mestre na minha área." // ⭐️ Frajola (5)
            ]
        )
    ]
}
class QuizResultManager {
    private let selectedOptionIndices: [Int]

    init(selectedOptionIndices: [Int]) {
        self.selectedOptionIndices = selectedOptionIndices
    }

    private let profiles: [String: QuizResult] = [
        "Caramelo": QuizResult(
            title: "VIRA LATA CARAMELO\n(O ÍCONE NACIONAL)",
            imageName: "caramelo",
            description: "O Caramelo é mais que um cão, é um símbolo! Você é adaptável, carismático e está sempre onde precisa estar, transformando o básico em icônico.",
            infoText: "O vira-lata caramelo é o verdadeiro brasileiro. Adaptabilidade e carisma são sua marca registrada. Você se encaixa em qualquer situação e transforma o básico em icônico."
        ),
        "Neguinho": QuizResult(
            title: "VIRA LATA NEGUINHO\n(O SAMBISTA DA RODA)",
            imageName: "neguinho",
            description: "Você é leal à sua comunidade e vive com paixão. Enraizado na cultura e na rotina, seu coração bate no ritmo da bateria.",
            infoText: "Assim como o vira-lata Neguinho, você é parte da comunidade. Valoriza as conexões sociais e a alegria de viver, transformando todo dia em um grande desfile."
        ),
        "Chico": QuizResult(
            title: "VIRA LATA CHICO\n(O INTELECTUAL/ATIVISTA)",
            imageName: "chico",
            description: "Sua vida é dedicada a uma causa, seja ela o conhecimento ou a justiça. Você é engajado, curioso e inspira as pessoas a lutar por um mundo melhor.",
            infoText: "Você é um cão de causas. Seja no campus ou na manifestação, sua presença é um lembrete de que o aprendizado e a luta por direitos são essenciais para a sociedade."
        ),
        "Coitadolandia": QuizResult(
            title: "VIRA LATA COITADOLANDIA\n(O INDEFINIDO)",
            imageName: "coitadinho",
            description: "Hmm, parece que você ainda está se encontrando. Suas respostas ficaram divididas demais! Tente de novo e descubra sua verdadeira vocação vira-lata!",
            infoText: "Você é um mistério, um pouco de tudo e nada ao mesmo tempo. A vida na Coitadolandia é temporária. Encontre seu propósito e volte para o quiz!"
        )
    ]

    private func calculateScores() -> [String: Int] {
        var scores: [String: Int] = ["Caramelo": 0, "Neguinho": 0, "Chico": 0]

        for index in selectedOptionIndices {
            switch index {
            case 0, 3: // Caramelo
                scores["Caramelo", default: 0] += 1
            case 1, 4: // Neguinho
                scores["Neguinho", default: 0] += 1
            case 2,5: // Chico
                scores["Chico", default: 0] += 1
            default:
                break
            }
        }
        return scores
    }

    func getResult() -> QuizResult {
        let scores = calculateScores()
        let maxScore = scores.values.max() ?? 0
        let winners = scores.filter { $0.value == maxScore }

        // Se houver empate ou pontuação muito baixa, retorna Coitadolandia
        if winners.count > 1 || maxScore <= 1 {
            return profiles["Coitadolandia"]!
        }

        let winnerName = winners.keys.first!
        return profiles[winnerName]!
    }
}
