//
//  Result.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

// MARK: - Result View Controller

class ResultViewController: UIViewController {
    private let resultView = ResultView()
    
    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Conecta a ação do botão da view com a função deste controller
        // Quando o botão for tocado na ResultView, o código abaixo será executado.
        resultView.onArrowButtonTapped = { [weak self] in
            self?.presentInfoSheet()
        }
    }
    
    private func presentInfoSheet() {
        // 1. Cria a instância do ViewController que será a sheet
        let infoVC = InfoSheetViewController()
        
        // 2. Acessa e configura o "sheet presentation controller"
        if let sheet = infoVC.sheetPresentationController {
            
            // 3. Define os "detents" (pontos de parada)
            // A sheet começará no .medium() e poderá ser expandida para .large()
            sheet.detents = [.medium(), .large()]
            
            // 4. Desabilita o "grabber" nativo, pois já temos um customizado na InfoSheetViewController
            sheet.prefersGrabberVisible = false
            
            // 5. Define os cantos arredondados
            sheet.preferredCornerRadius = 30
        }
        
        // 6. Apresenta o ViewController como uma sheet
        present(infoVC, animated: true, completion: nil)
    }
}

// MARK: - Result View

class ResultView: UIView {
    
    // Closure para notificar o controller quando o botão for tocado
    var onArrowButtonTapped: (() -> Void)?

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "VIRA LATA CARAMELO"
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
    
    lazy var bg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bgResult")
        return imageView
    }()
    
    lazy var spiral: UIImageView = {
        let spiralView = UIImageView()
        spiralView.translatesAutoresizingMaskIntoConstraints = false
        spiralView.image = UIImage(named: "spiralBlue")
        spiralView.alpha = 0.98
        return spiralView
    }()
    
    // --- NOVO BOTÃO DE SETA ---
    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Ícone de seta usando SF Symbols
        let arrowImage = UIImage(systemName: "chevron.up.circle.fill")
        button.setImage(arrowImage, for: .normal)
        
        // Configuração do tamanho e cor da seta
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.tintColor = .white
        
        // Adiciona a ação que será chamada quando o botão for tocado
        button.addTarget(self, action: #selector(arrowTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bg.frame = self.bounds
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        sendSubviewToBack(bg)
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSub()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Função de ação para o botão
    @objc private func arrowTapped() {
        onArrowButtonTapped?()
    }
    
    // MARK: Setup
    private func addSub() {
        addSubview(bg)
        addSubview(label)
        addSubview(spiral)
        addSubview(arrowButton) // Adiciona o novo botão à view
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spiral.widthAnchor.constraint(equalToConstant: 390),
            spiral.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            bg.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 120),
            label.widthAnchor.constraint(equalToConstant: 290),
            
            // Constraints para a seta
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
        label.text = "O vira-lata caramelo é mais do que um cão, é um símbolo nacional! Conhecido por sua inteligência, carisma e capacidade de aparecer nos lugares mais inesperados, ele conquista corações por onde passa. Sua pelagem dourada brilha sob o sol, refletindo a alma calorosa do Brasil."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
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

// MARK: - Preview

#Preview {
    let viewController = ResultViewController()
    return viewController
}
