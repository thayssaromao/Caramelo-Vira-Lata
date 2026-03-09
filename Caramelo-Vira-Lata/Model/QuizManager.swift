struct QuizResult {
    let title: String
    let imageName: String
    let description: String
    let infoText: String
}

struct Question {
    let text: String
    let options: [String]
}

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
            "A FAZENDA",
            "Bake Off Brasil",
            "Big Brother Brasil",
            "De Férias com o Ex",
            "MasterChef Brasil",
            "Um documentário sério"
            ]
        ),
        Question(
           text: "Você prefere ser reconhecido por:",
           options: [
               "Ser alguém carismático",
               "Ser leal e confiável, a base da comunidade",
               "Ser a voz da mudança em uma causa justa",
               "Ser um sucesso viral ou o ícone de uma geração",
               "Ser essencial e servir bem na sua função",
               "Ser um intelectual respeitado e qualificado"
           ]
       ),
        Question(
            text: "No rolê, qual seu ponto de encontro ideal?",
            options: [
                "PRAÇA LOTADA",
                "BAR DA ESQUINA",
                "UM LUGAR CALMO SEM MUITO FUZUE",
                "ONDE SER SERÁ",
                "ONDE QUISEREM QUE SEJA",
                "ACHO QUE NAO VOU.."
            ]
        ),
        Question(
            text: "Seu hobby principal é:",
            options: [
                "ROLAR O TIKTOK POR 12H",
                "SOCIALZINHA COM OS DE FÉ",
                "ESTUDAR",
                "ANDAR POR AI",
                "APRENDER ALGO NOVO",
                "LER LER LER"
            ]
        ),
        Question(
            text: "O que você carrega na mochila?",
            options: [
                "UNS DOCINHOS ALEATÓRIOS",
                "MARMITA, CARTÕES, CPF",
                "CANETAS, FOLHAS DE NOTA",
                "TUDO QUE CABER ESTA NA MINHA BOLSA",
                "PRIMEIROS SOCORROS, LENCINHOS",
                "BLOCO DE NOTAS CHEIO DE ANOTAÇOES"
            ]
        ),
        Question(
            text: "Você é mais conhecido por ser:",
            options: [
                "CARISMÁTICO E ENGRAÇADO",
                "GRANDE COMPANHEIRO",
                "A VOZ DA RAZÃO",
                "INCRIVELMENTE FOLGADO",
                "MELHOR FUNCIONÁRIO DO MÊS",
                "MUITO SÉRIO"
            ]
        ),
        Question(
                   text: "Você se sente mais convencido por:",
                   options: [
                       "O que o seu 'coração' diz, a intuição",
                       "O consenso geral, o que é melhor para a maioria",
                       "O argumento mais lógico apoiado por dados",
                       "O que já deu certo no passado e é seguro",
                       "A opinião de quem você mais confia",
                       "A citação de um pensador famoso"
                   ]
               ),
        Question(
            text: "O que te inspira a continuar a jornada?",
            options: [
                "A chance de virar estampa de camiseta",
                "O sorriso de quem foi ajudado por mim",
                "A justiça, custe o que custar",
                "O próximo feriado",
                "O sentimento de dever cumprido",
                "O conhecimento puro, simples e sem fim."
            ]
        ),
        Question(
            text: "QUAL O SEU DESTINO FINAL?",
            options: [
                "Viver a vida no modo free play",
                "Fazer parte de uma equipe, sendo a base.",
                "Ser a chama que acende a mudança",
                "Me tornar o ícone de uma geração inteira",
                "Ter meu próprio lugar e rotina definida",
                "Ser o mestre na minha área."
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
            title: "VIRA LATA FIAPO DE MANGA\n(O INTELECTUAL/ATIVISTA)",
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

        if winners.count > 1 || maxScore <= 1 {
            return profiles["Coitadolandia"]!
        }

        let winnerName = winners.keys.first!
        return profiles[winnerName]!
    }
}
