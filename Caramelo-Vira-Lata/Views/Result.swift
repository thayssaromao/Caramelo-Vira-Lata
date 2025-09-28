//
//  Result.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

// MARK: - Result Models

struct QuizResult {
    let title: String
    let imageName: String
    let description: String
    let infoText: String
}

// MARK: - Quiz Result Manager (Lógica de Pontuação)

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
            imageName: "Neguinho",
            description: "Você é leal à sua comunidade e vive com paixão. Enraizado na cultura e na rotina, seu coração bate no ritmo da bateria.",
            infoText: "Assim como Neguinho da Beija-Flor, você é parte da comunidade. Valoriza as conexões sociais e a alegria de viver, transformando todo dia em um desfile."
        ),
        "Chico": QuizResult(
            title: "VIRA LATA CHICO\n(O INTELECTUAL/ATIVISTA)",
            imageName: "caramelo2",
            description: "Sua vida é dedicada a uma causa, seja ela o conhecimento ou a justiça. Você é engajado, curioso e inspira as pessoas a lutar por um mundo melhor.",
            infoText: "Você é um cão de causas. Seja no campus ou na manifestação, sua presença é um lembrete de que o aprendizado e a luta por direitos são essenciais para a sociedade."
        )
    ]

    private func calculateScores() -> [String: Int] {
        var scores: [String: Int] = ["Caramelo": 0, "Neguinho": 0, "Chico": 0]

        for index in selectedOptionIndices {
            switch index {
            case 0, 3:
                scores["Caramelo"]! += 1
            case 1, 4:
                scores["Neguinho"]! += 1
            case 2, 5:
                scores["Chico"]! += 1
            default:
                break
            }
        }
        return scores
    }

    func getResult() -> QuizResult {
        let scores = calculateScores()
        let winningProfileName = scores.max { $0.value < $1.value }?.key ?? "Caramelo"
        return profiles[winningProfileName]!
    }
}

// MARK: - Result View Controller

class ResultViewController: UIViewController {
    private let resultManager: QuizResultManager
    private let resultView = ResultView()
    private var finalResult: QuizResult!

    init(selectedOptionIndices: [Int]) {
        self.resultManager = QuizResultManager(selectedOptionIndices: selectedOptionIndices)
        super.init(nibName: nil, bundle: nil)
        self.finalResult = resultManager.getResult()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.configure(with: finalResult)
        resultView.onArrowButtonTapped = { [weak self] in
            self?.presentInfoSheet()
        }
    }
    
    private func presentInfoSheet() {
        let infoVC = InfoSheetViewController()
        infoVC.configure(with: finalResult.infoText)
        
        if let sheet = infoVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 30
        }
        
        present(infoVC, animated: true, completion: nil)
    }
}

// MARK: - Result View

class ResultView: UIView {
    var onArrowButtonTapped: (() -> Void)?
    
    // Fundo fixo
    private let bg: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgResult"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Imagem dinâmica (cachorro do resultado)
    private let dogImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .white
        label.textAlignment = .center
        if let customFont = UIFont(name: "Bahiana", size: 55) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
        }
        return label
    }()
    
    lazy var spiral: UIImageView = {
        let spiralView = UIImageView()
        spiralView.translatesAutoresizingMaskIntoConstraints = false
        spiralView.image = UIImage(named: "spiralBlue")
        spiralView.alpha = 0.98
        return spiralView
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let arrowImage = UIImage(systemName: "chevron.up.circle.fill")
        button.setImage(arrowImage, for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(arrowTapped), for: .touchUpInside)
        return button
    }()
    
    func configure(with result: QuizResult) {
        label.text = result.title
        dogImage.image = UIImage(named: result.imageName) // só o cachorro muda
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func arrowTapped() {
        onArrowButtonTapped?()
    }
    
    private func addSubviews() {
        addSubview(bg)
        addSubview(spiral)
        addSubview(dogImage)
        addSubview(label)
        addSubview(arrowButton)
        
        sendSubviewToBack(bg)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spiral.widthAnchor.constraint(equalToConstant: 390),
            spiral.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            spiral.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dogImage.centerXAnchor.constraint(equalTo: spiral.centerXAnchor),
                        dogImage.centerYAnchor.constraint(equalTo: spiral.centerYAnchor),
                        dogImage.widthAnchor.constraint(equalToConstant: 250),
                        dogImage.heightAnchor.constraint(equalToConstant: 250),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 170),
            label.widthAnchor.constraint(equalToConstant: 360),
            
            arrowButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


// MARK: - Info Sheet View Controller

class InfoSheetViewController: UIViewController {
    private let grabberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SAIBA MAIS"
        label.font = UIFont(name: "Bahiana", size: 50) ?? UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    func configure(with description: String) {
        descriptionLabel.text = description
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white  // fundo liso
        setupViews()
    }

    private func setupViews() {
        view.addSubview(grabberView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            grabberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 40),
            grabberView.heightAnchor.constraint(equalToConstant: 5),
            
            titleLabel.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}

#Preview {
    let viewController = ResultViewController(selectedOptionIndices: [0, 1, 2])
    viewController.loadViewIfNeeded()
    return viewController
}
