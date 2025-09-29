//
//  QuestionView.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

// ⭐️ NOVO: Extension para o método de configuração
extension QuestionView {
    func configureCardText(with text: String) {
        // Encontra o UILabel dentro da hierarquia do cardContainer
        if let card = cardContainer.subviews.compactMap({ $0 as? UIView }).first(where: { $0.backgroundColor == .white }),
           let cardLabel = card.subviews.first(where: { $0 is UILabel }) as? UILabel {
            cardLabel.text = text
        }
        
        // A label principal de título será configurada no ViewController.
        // self.label.text = "PERGUNTA \(questionIndex + 1)" // Removido daqui
    }
}


class QuestionView:UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PERGUNTA"
        label.numberOfLines = 2
        label.textColor = .white
        if let customFont = UIFont(name: "Bahiana", size: 60) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var cardContainer: UIView = {
        let container = UIView()
        // ... (resto do código do cardContainer) ...
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let backLayer = UIView()
        backLayer.backgroundColor = UIColor(red: 0.278, green: 0.224, blue: 0.882, alpha: 1)
        backLayer.layer.cornerRadius = 30
        backLayer.translatesAutoresizingMaskIntoConstraints = false
        
        // Inclinação do fundo
        backLayer.transform = CGAffineTransform(rotationAngle: -3.0)
        
        container.addSubview(backLayer)
        
        NSLayoutConstraint.activate([
            backLayer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            backLayer.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -25),
            backLayer.widthAnchor.constraint(equalToConstant: 306),
            backLayer.heightAnchor.constraint(equalToConstant: 164)
        ])
        
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 30
        card.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowRadius = 4
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(card)
        // Fix: Use positive angle to avoid upside down
        card.transform = CGAffineTransform(rotationAngle: 0)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            card.widthAnchor.constraint(equalToConstant: 320),
            card.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        let cardLabel = UILabel()
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        cardLabel.text = "Texto do Card"
        cardLabel.textColor = .black
        cardLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        cardLabel.textAlignment = .center
        cardLabel.numberOfLines = 3
        if let customFont = UIFont(name: "Bahiana", size: 45) {
            cardLabel.font = customFont
        } else {
            cardLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        }
        
        card.addSubview(cardLabel)
        
        NSLayoutConstraint.activate([
            cardLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            cardLabel.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            cardLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            cardLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16)
        ])
        
        return container
    }()

    
    lazy var bg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bgQuestion")
        
        
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
    
    //MARK: INITIALIZERS
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        
        addSub()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SETUP
    private func addSub(){
        addSubview(bg)
        addSubview(label)
        addSubview(cardContainer)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            cardContainer.widthAnchor.constraint(equalToConstant: 338.92),
            cardContainer.heightAnchor.constraint(equalToConstant: 222.84),
            cardContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            cardContainer.topAnchor.constraint(equalTo: topAnchor, constant: 349),
            bg.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            bg.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -260),
            label.widthAnchor.constraint(equalToConstant: 290),
           ])
    }
}

// ⭐️ Corrigido o Preview para usar o inicializador dinâmico
#Preview {
    // Para o preview funcionar, iniciamos com a primeira pergunta
    let mockQuestions = [
        Question(text: "SUA PRINCIPAL MISSAO MATINAL É?", options: ["CAÇAR O PÃO", "ACOMPANHAR ÔNIBUS", "MARCAR PRESENÇA NA AULA", "ESPERAR INSS", "PASSAR CATRACA", "PROCURAR BARRACÃO"]),
        // Adicione mais Questions mockadas se necessário para evitar crash.
    ]
    
    // Inicia com um array vazio de respostas
    let firstQuestionVC = DinamicViewController(questionIndex: 0, questions: mockQuestions, selectedOptionIndices: [])
    
    // Para ter a navegação no preview, o ideal é embarcá-lo em um Navigation Controller
    // ⭐️ CORREÇÃO: Remova o 'return' explícito
    UINavigationController(rootViewController: firstQuestionVC)
}
