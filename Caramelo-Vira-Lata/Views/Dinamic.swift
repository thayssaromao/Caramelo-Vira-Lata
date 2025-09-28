// Dinamic.swift
// Caramelo-Vira-Lata
//
// Created by Thayssa Romão on 28/09/25.
//

import UIKit
// MARK: - 1. Modelo de Dados para o Quiz

struct Question {
    let text: String
    let options: [String]
}

// Mantemos o DinamicViewController como está, ele apenas carrega a DinamicView
class DinamicViewController: UIViewController {
    
    private let dinamicView = DinamicView()
    
    // Novas propriedades para gerenciar o estado
    private var questions: [Question]
    private var questionIndex: Int
    
    // Inicializador customizado para passar os dados do quiz
    init(questionIndex: Int, questions: [Question]) {
        self.questionIndex = questionIndex
        self.questions = questions
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
        
        // Configura a view com a pergunta correta
        let currentQuestion = questions[questionIndex]
        dinamicView.configure(
            question: currentQuestion.text,
            options: currentQuestion.options
        )
        
        // Atualiza a barra de progresso dinamicamente
        let progress = Float(questionIndex + 1) / Float(questions.count)
        dinamicView.progressBar.setProgress(progress, animated: true)
        
        // Define a ação a ser tomada quando uma opção for selecionada
        dinamicView.onOptionSelected = { [weak self] selectedText in
            print("Pergunta \(self?.questionIndex ?? 0): Opção selecionada: \(selectedText)")
            self?.goToNextQuestion()
        }
    }
    
    private func goToNextQuestion() {
        let nextIndex = questionIndex + 1
        
        // Verifica se ainda há perguntas no quiz
        if nextIndex < questions.count {
            // Se houver, cria e apresenta a próxima tela de pergunta
            let nextVC = DinamicViewController(questionIndex: nextIndex, questions: questions)
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            // Se não, vai para a tela de resultados
            let resultsVC = ResultViewController() // Tela de finalização
            navigationController?.pushViewController(resultsVC, animated: true)
        }
    }
}

class DinamicView: UIView {
    
    // Propriedade para notificar o ViewController quando uma opção for selecionada
    var onOptionSelected: ((String) -> Void)?
    
    // MARK: - Componentes de UI
    
    lazy var questionLabel: UILabel = { // Renomeado para maior clareza
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PERGUNTA 1" // Este texto será configurado dinamicamente
        label.numberOfLines = 2
        label.textColor = .white
        if let customFont = UIFont(name: "Bahiana", size: 70) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 0.529, green: 0.941, blue: 0.208, alpha: 1) // Verde claro
        progressView.trackTintColor = UIColor.white.withAlphaComponent(0.3) // Fundo branco transparente
        progressView.setProgress(0.3, animated: true) // Exemplo de progresso
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true // Essencial para o cornerRadius funcionar no track
        return progressView
    }()
    
    // MARK: - Novo: StackView para organizar os botões
    lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical // Stack principal para as duas linhas de botões
        stackView.distribution = .fillEqually
        stackView.spacing = 20 // Espaçamento entre as linhas
        return stackView
    }()
    
    lazy var bg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bgDinamic") // Certifique-se que esta imagem existe
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bg.frame = self.bounds
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        sendSubviewToBack(bg)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSub()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func addSub() {
        addSubview(bg)
        addSubview(questionLabel) // Usando o novo nome
        addSubview(progressBar)
        addSubview(optionsStackView) // Adiciona a stack view
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30), // Ajuste para o topo
            questionLabel.widthAnchor.constraint(equalToConstant: 290),
            
            optionsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            optionsStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50), // Centraliza aproximadamente na vertical
            optionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            progressBar.heightAnchor.constraint(equalToConstant: 12), // Um pouco mais alta para ser visível como na imagem
            
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Método para configurar a View dinamicamente
    func configure(question: String, options: [String]) {
        questionLabel.text = question
        addOptionButtons(with: options)
    }
    
    private func createOptionButton(title: String) -> UIButton {
        let button = UIButton(type: .system) // Use .system para ter estados de highlight
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        if let customFont = UIFont(name: "Bahiana", size: 42) { // Ajuste o tamanho da fonte se necessário
            button.titleLabel?.font = customFont
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        }
        
        button.backgroundColor = UIColor(red: 0.941, green: 0.784, blue: 0.043, alpha: 1) // Amarelo
        button.layer.cornerRadius = 25 // Raio dos cantos
        button.clipsToBounds = true
        
        // Adicionar sombra (opcional, mas comum para botões)
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        
        // Define uma altura fixa para os botões
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true // Ajuste a altura conforme necessário
        
        button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func addOptionButtons(with options: [String]) {
        // Limpa quaisquer botões existentes antes de adicionar novos
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Assumimos que sempre teremos um número par de opções para 2 colunas
        // Se o número de opções for ímpar, a última linha terá apenas 1 botão.
        
        var currentHStack: UIStackView?
        
        for (index, optionText) in options.enumerated() {
            if index % 2 == 0 { // Inicia uma nova linha (Horizontal Stack)
                currentHStack = UIStackView()
                currentHStack!.axis = .horizontal
                currentHStack!.distribution = .fillEqually
                currentHStack!.spacing = 20 // Espaçamento entre os botões na mesma linha
                optionsStackView.addArrangedSubview(currentHStack!)
            }
            
            let button = createOptionButton(title: optionText)
            currentHStack?.addArrangedSubview(button)
        }
    }
    
    @objc private func optionButtonTapped(_ sender: UIButton) {
           
           
           for hStack in optionsStackView.arrangedSubviews {
               guard let horizontalStack = hStack as? UIStackView else { continue }
               
               for case let button as UIButton in horizontalStack.arrangedSubviews {
                   if button == sender {
                       // Botão selecionado fica cinza
//                       button.backgroundColor = UIColor(red: 0.486, green: 0.71, blue: 0.094, alpha: 1)
//                       button.setTitleColor(UIColor.white, for: .normal)
                       button.backgroundColor = UIColor(red: 0.48, green: 0.941, blue: 0.094, alpha: 1)
                       
                   } else {
                       // Outros ficam transparentes
                       button.alpha = 0.5
                   }
               }
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Aumentei um pouco o delay
               if let selectedTitle = sender.titleLabel?.text {
                   self.onOptionSelected?(selectedTitle)
               }
           }
       }
   }


//class ResultsViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemTeal
//        
//        let label = UILabel()
//        label.text = "FIM DO QUIZ! 🎉"
//        label.font = UIFont(name: "Bahiana", size: 80)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}

// Para usar no Canvas de Preview do Xcode
#Preview {
    // Para o preview funcionar, iniciamos com a primeira pergunta
    let firstQuestionVC = DinamicViewController(questionIndex: 0, questions: QuizManager.questions)
    // Para ter a navegação no preview, o ideal é embarcá-lo em um Navigation Controller
    return UINavigationController(rootViewController: firstQuestionVC)
}
