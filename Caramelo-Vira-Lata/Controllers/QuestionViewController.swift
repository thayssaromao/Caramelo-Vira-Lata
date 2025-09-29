//
//  QuestionViewController.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

class QuestionViewController: UIViewController {
    private let questionView = QuestionView()
    private let progressBar = UIProgressView(progressViewStyle: .default)
    private var hasAnimated = false
    
    private var cardOriginalTransform: CGAffineTransform = .identity

    // PROPRIEDADES DINÂMICAS
    private let questionIndex: Int
    private let questions: [Question]
    // ⭐️ Propriedade para rastrear as respostas
    private let selectedOptionIndices: [Int]

    // ⭐️ CORREÇÃO: Inicializador agora recebe o array de índices
    init(questionIndex: Int, questions: [Question], selectedOptionIndices: [Int]) {
        self.questionIndex = questionIndex
        self.questions = questions
        self.selectedOptionIndices = selectedOptionIndices // Armazena o array
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = questionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBar()
        cardOriginalTransform = questionView.cardContainer.transform

        // 2. Posicione o card FORA da tela ANTES dela aparecer
        questionView.cardContainer.transform = cardOriginalTransform.translatedBy(x: 0, y: self.view.bounds.height)
        
        // Configura o TEXTO do card e o título da tela
        let currentQuestion = questions[questionIndex]
        questionView.configureCardText(with: currentQuestion.text)
        questionView.label.text = "PERGUNTA \(questionIndex + 1)"
        
        // Configura o progresso inicial
        let progress = Float(questionIndex + 1) / Float(questions.count)
        progressBar.setProgress(progress, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hasAnimated {
            hasAnimated = true
            animateCard()
            startLoading()
        }
    }
    
    private func setupProgressBar() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.tintColor = UIColor(red: 0.263, green: 0.22, blue: 0.875, alpha: 1)
        progressBar.trackTintColor = UIColor.lightGray.withAlphaComponent(0.3)
        progressBar.layer.cornerRadius = 6
        progressBar.clipsToBounds = true
        
        view.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            progressBar.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    private func animateCard() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: [.curveEaseOut],
            animations: {
                self.questionView.cardContainer.transform = self.cardOriginalTransform            },
            completion: nil
        )
    }
    
    private func startLoading() {
        let duration: TimeInterval = 2.5

        self.progressBar.setProgress(1.0, animated: false)
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)


        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.goToNextScreen()
        }
    }
    
    
    private func goToNextScreen() {
        // Navega para a TELA DE OPÇÕES (DinamicViewController)
        let nextQuestionVC = DinamicViewController(
            questionIndex: self.questionIndex,
            questions: self.questions,
            selectedOptionIndices: self.selectedOptionIndices // ⭐️ Passa o array de respostas
        )
        // Usa `setViewControllers` para substituir a QuestionViewController na pilha,
        // garantindo que o botão "Voltar" na DinamicViewController não leve de volta para a QuestionViewController
        let viewControllers = self.navigationController?.viewControllers.dropLast() ?? []
        self.navigationController?.setViewControllers(viewControllers + [nextQuestionVC], animated: true)
    }
}

