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
        
        self.navigationItem.hidesBackButton = true
    }
    
    private func presentInfoSheet() {
            let infoVC = InfoSheetViewController()
            
            // ⭐️ ALTERAÇÃO AQUI: Passar a descrição e o infoText
            infoVC.configure(
                withDescription: finalResult.description,
                infoText: finalResult.infoText
            )
            
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
    
    private let bg: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgResult"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dogImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Bahiana", size: 55) ?? UIFont.systemFont(ofSize: 55, weight: .bold)
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
        dogImage.image = UIImage(named: result.imageName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
        startRotation()
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
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 170),
            label.widthAnchor.constraint(equalToConstant: 360),
            
            arrowButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func startRotation() {
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            // O valor '2 * .pi' representa uma volta completa (360 graus)
            rotation.toValue = NSNumber(value: Double.pi * 2)
            // Duração de cada ciclo de rotação (em segundos)
            rotation.duration = 10.0
            // Número de vezes que a animação se repetirá (infinito)
            rotation.repeatCount = .infinity
            // Garante que o estado final (uma rotação completa) não volte ao inicial
            rotation.isRemovedOnCompletion = false
            
            self.spiral.layer.add(rotation, forKey: "spinAnimation")
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
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OBAAAA!!"
        label.font = UIFont(name: "Bahiana", size: 50) ?? UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let infoLabel: UILabel = { // <- texto explicativo
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()
    
    func configure(withDescription description: String, infoText: String) {
            descriptionLabel.text = description
            infoLabel.text = infoText // <- Atribui o novo texto à infoLabel
        }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        setupViews()
    }

    @objc private func closeTapped() {
        // Volta para a tela inicial substituindo a pilha do Navigation Controller
        let initialVC = InitialViewController()
        
        if let presenter = self.presentingViewController {
            // Caso o apresentador seja um UINavigationController
            if let navController = presenter as? UINavigationController {
                self.dismiss(animated: true) {
                    navController.setViewControllers([initialVC], animated: true)
                }
            }
            // Caso o apresentador esteja dentro de um UINavigationController
            else if let navController = presenter.navigationController {
                self.dismiss(animated: true) {
                    navController.setViewControllers([initialVC], animated: true)
                }
            }
            // Sem Navigation Controller por baixo: apresenta a tela inicial em full screen
            else {
                self.dismiss(animated: true) {
                    initialVC.modalPresentationStyle = .fullScreen
                    presenter.present(initialVC, animated: true)
                }
            }
        }
        // Caso raro: este controller está dentro de um nav controller
        else if let navController = self.navigationController {
            navController.setViewControllers([initialVC], animated: true)
        }
        // Fallback: apresenta modalmente
        else {
            initialVC.modalPresentationStyle = .fullScreen
            self.present(initialVC, animated: true)
        }
    }

    private func setupViews() {
        view.addSubview(grabberView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            grabberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 40),
            grabberView.heightAnchor.constraint(equalToConstant: 5),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                        // Adicione uma margem inferior se desejar que o conteúdo se ajuste corretamente
                        infoLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

#Preview {
    let viewController = ResultViewController(selectedOptionIndices: [0, 5, 2])
    viewController.loadViewIfNeeded()
    return viewController
}
