//
//  DinamicViewController.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

class DinamicViewController: UIViewController {
    
    private let dinamicView = DinamicView()
    
    // Propriedades dinâmicas
    private var questions: [Question]
    private var questionIndex: Int
    // Array para rastrear as respostas (índices das opções)
    private var selectedOptionIndices: [Int]

    // ⭐️ Inicializador com todas as propriedades de estado do quiz
    init(questionIndex: Int, questions: [Question], selectedOptionIndices: [Int]) {
        self.questionIndex = questionIndex
        self.questions = questions
        self.selectedOptionIndices = selectedOptionIndices // Armazena as respostas passadas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = dinamicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentQuestion = questions[questionIndex]
        dinamicView.configure(
            question: currentQuestion.text,
            options: currentQuestion.options
        )
        
        let progress = Float(questionIndex + 1) / Float(questions.count)
        dinamicView.progressBar.setProgress(progress, animated: true)
        
        // ⭐️ onOptionSelected agora recebe o índice da opção
        dinamicView.onOptionSelected = { [weak self] selectedText, selectedIndex in
            print("Pergunta \(self?.questionIndex ?? 0): Opção selecionada: \(selectedText) (Índice: \(selectedIndex))")
            self?.goToNextQuestion(selectedIndex: selectedIndex)
        }
    }
    
    private func goToNextQuestion(selectedIndex: Int) {
        // 1. Armazena a resposta atual
        var updatedIndices = selectedOptionIndices
        updatedIndices.append(selectedIndex) // Adiciona a resposta atual
        
        let nextIndex = questionIndex + 1
        
        // Verifica se ainda há perguntas no quiz
        if nextIndex < questions.count {
            // Se houver, navega para a próxima TELA DE PERGUNTA (QuestionViewController)
            let nextVC = QuestionViewController(
                questionIndex: nextIndex,
                questions: questions,
                selectedOptionIndices: updatedIndices // ⭐️ Passa o array ATUALIZADO
            )
            // Usa PUSH para manter o histórico de navegação
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            // Se não, vai para a tela de resultados
            // ⭐️ Passa o array ATUALIZADO para o ResultViewController
            let resultsVC = ResultViewController(selectedOptionIndices: updatedIndices)
            navigationController?.pushViewController(resultsVC, animated: true)
        }
    }
}
