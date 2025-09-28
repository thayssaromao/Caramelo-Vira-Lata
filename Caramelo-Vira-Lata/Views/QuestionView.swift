//
//  QuestionView.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import SwiftUI

class QuestionViewController: UIViewController {
    private let questionView = QuestionView()
    override func loadView() {
        self.view = questionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

class QuestionView:UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PERGUNTA"
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
    
    
    lazy var cardContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Fundo azul inclinado
        let backLayer = UIView()
        backLayer.backgroundColor = UIColor(red: 0.278, green: 0.224, blue: 0.882, alpha: 1)
        backLayer.layer.cornerRadius = 30
        backLayer.translatesAutoresizingMaskIntoConstraints = false
        
        // Inclinação do fundo
        backLayer.transform = CGAffineTransform(rotationAngle: -2.9)
        
        container.addSubview(backLayer)
        
        NSLayoutConstraint.activate([
            backLayer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            backLayer.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -25),
            backLayer.widthAnchor.constraint(equalToConstant: 306),
            backLayer.heightAnchor.constraint(equalToConstant: 164)
        ])
        
        // Card branco
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 30
        card.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowRadius = 4
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(card)
        card.transform = CGAffineTransform(rotationAngle: -3.05)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            card.widthAnchor.constraint(equalToConstant: 320),
            card.heightAnchor.constraint(equalToConstant: 170)
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

#Preview {
       let viewController = QuestionViewController()
       return viewController
   }
