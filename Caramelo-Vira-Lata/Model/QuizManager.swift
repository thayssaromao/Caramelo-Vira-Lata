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
                "CAÇAR O PÃO NA RUA", // Caramelo
                "ACOMPANHAR O ÔNIBUS ATÉ O FINAL", // Pretinha (BRT)
                "MARCAR PRESENÇA NA AULA", // Chico (UFSC)
                "ESPERAR A NOTIFICAÇÃO DO INSS", // Tobias (INSS)
                "PASSAR DEBAIXO DA CATRACA DO METRÔ", // Preta (Metrô SP)
                "PROCURAR UM BARRACÃO QUENTE" // Neguinho (Beija-Flor)
            ]
        ),
        Question(
            text: "Quando ouve fogos de artifício, você:",
            options: [
                "CORRE PARA DENTRO DO MUSEU", // Marrom (Museu Nacional)
                "SE ESCONDE NO ALVO DO ENEM", // Cão do Enem
                "SAI LATINDO PARA A LUTA", // Manchinha (Protesto)
                "FINGE QUE É SÓ UM GRILO GIGANTE",
                "MANDA UM LATIDO DE BEIJA-FLOR", // Neguinho (Beija-Flor)
                "PROCURA O ABRAÇO CARAMELO" // Caramelo
            ]
        ),
        Question(
            text: "Qual sua cor favorita de crachá?",
            options: [
                "AMARELO MILHO (O MEU DE NASCENÇA)", // Caramelo (Cor)
                "AZUL BEIJA-FLOR", // Neguinho (Beija-Flor)
                "PRETO TOTAL", // Preta (Cor)
                "VERMELHO DE PROTESTO", // Manchinha (Protesto)
                "VERDE LIMALIMÃO PARA CAMUFLAGEM",
                "MARROM RESISTÊNCIA" // Marrom
            ]
        ),
        Question(
            text: "No rolê, qual seu ponto de encontro ideal?",
            options: [
                "O PRÓXIMO PONTO DE ÔNIBUS", // Pretinha (BRT)
                "A PORTA DO INSS", // Tobias (INSS)
                "O CAMPI DA UFSC", // Chico (UFSC)
                "A PORTA DO ENEM", // Cão do Enem
                "PRÓXIMO AO BUFFET ESCONDIDO",
                "QUALQUER LUGAR VIRA LATA (SOU GLOBAL)" // Caramelo
            ]
        ),
        Question(
            text: "Seu hobby principal é:",
            options: [
                "ACOMPANHAR MANIFESTAÇÃO", // Manchinha (Protest)
                "TIRAR COCHILO NA AULA", // Chico (University)
                "FICAR SÓ ESPERANDO O PRÓXIMO PETISCO",
                "POSAR DE MODELO DE CAMPANHA (PF)", // Caramelo PF
                "VIRAR MEME EM GRUPO DE WHATSAPP", // Caramelo (Meme)
                "FAZER AMIZADE NO GUICHÊ DE ATENDIMENTO" // Tobias (INSS)
            ]
        ),
        Question(
            text: "O que você carrega na mochila (ou boca)?",
            options: [
                "LIVROS DE EXTENSÃO UNIVERSITÁRIA", // Frajola (UFRJ)
                "UMA COXINHA ESQUECIDA DO ALMOÇO",
                "O CRÁCHÁ OFICIAL DO BRT", // Pretinha (BRT)
                "UM RESTO DE SAMBA", // Neguinho (Beija-Flor)
                "A COLEIRA OFICIAL DA PF", // Caramelo PF
                "O BONECO DE PELÚCIA (QUE SOU EU MESMO)" // Caramelo (Merchandise)
            ]
        ),
        Question(
            text: "Você é mais conhecido por ser:",
            options: [
                "DÓCIL E CONSTANTE", // Preta (Metrô SP)
                "SÍMBOLO DE RESISTÊNCIA E SOBREVIVÊNCIA", // Marrom (Museum Fire)
                "O ZELADOR OFICIAL DO CAMPUS", // Chico (University)
                "UM TALISMÃ DE PROVA", // Cão do Enem
                "CARISMÁTICO E ICÔNICO DA NAÇÃO", // Caramelo
                "PARTE DA EQUIPE DE ATENDIMENTO" // Tobias (INSS)
            ]
        ),
        Question(
            text: "Seu jeito de se locomover é:",
            options: [
                "NO METRÔ (PELA CATRACA)", // Preta (Metro)
                "CORRENDO ATRÁS DA CARRETA DE MUDANÇA",
                "DE BRT (TODOS OS DIAS)", // Pretinha (BRT)
                "A PÉ, SEM PRESSA, POR QUAISQUER RUAS",
                "NO CAMINHÃO DA ESCOLA DE SAMBA", // Neguinho (Samba)
                "FUGITIVO DO CARREFOUR" // Manchinha (Escape/Protest)
            ]
        ),
        Question(
            text: "O que te inspira a continuar a jornada?",
            options: [
                "O PRÓXIMO BANQUETE DE OSSOS",
                "UM TÍTULO HONORÁRIO", // Chico (UFSC)
                "A LUTA POR DIREITOS", // Manchinha (Rights)
                "O CHEIRO DE CHURRASCO NA ESQUINA",
                "O CALOR DO FOGO APÓS A TRAGÉDIA", // Marrom (Resilience)
                "SER O ÍCONE DA NAÇÃO INTEIRA" // Caramelo (Icon)
            ]
        ),
        Question(
            text: "QUAL O SEU DESTINO FINAL? (Selecione um final)",
            options: [
                "SER O CARAMELO, O EU MESMO",
                "A LUTA NÃO ACABA",
                "NO PALÁCIO DO SAMBA",
                "O MURO DA UNIVERSIDADE",
                "MEU PRÓPRIO CRÁCHÁ NO INSS",
                "A PRÓXIMA RODOVIÁRIA"
            ]
        )
    ]
}
