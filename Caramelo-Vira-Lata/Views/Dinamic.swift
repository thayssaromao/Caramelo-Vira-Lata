//
//  Dinamic.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

class DinamicViewController: UIViewController {
    private let dinamicView = DinamicView()
    override func loadView() {
        self.view = dinamicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}



class DinamicView:UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PERGUNTA 1"
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
        progressView.progressTintColor = .white
        progressView.trackTintColor = .green
        progressView.setProgress(0.9, animated: true)
        return progressView
    }()
    

    
    lazy var cardContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false

        let yellowLayer = CALayer()
        yellowLayer.backgroundColor = UIColor(red: 0.941, green: 0.784, blue: 0.043, alpha: 1).cgColor
        yellowLayer.cornerRadius = 45
        yellowLayer.frame = CGRect(x: 20, y: 20, width: 280, height: 130)
        card.layer.insertSublayer(yellowLayer, at: 0)

        // Add label
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "Bahiana-Regular", size: 42)
        text.textAlignment = .center
        text.text = "corro atras"
        text.numberOfLines = 1

        card.addSubview(text)

        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            text.widthAnchor.constraint(lessThanOrEqualToConstant: 260)
        ])

        container.addSubview(card)

        NSLayoutConstraint.activate([
            card.widthAnchor.constraint(equalToConstant: 320),
            card.heightAnchor.constraint(equalToConstant: 170),
            card.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            container.widthAnchor.constraint(equalTo: card.widthAnchor),
            container.heightAnchor.constraint(equalTo: card.heightAnchor)
        ])

        return container
    }()
  
    lazy var bg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bgDinamic")
        
        
        
        return imageView
    }()
    
    lazy var star: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "star")
        
        
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
        addSubview(progressBar)
        addSubview(cardContainer)
        addSubview(star)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            cardContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 370),
            bg.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            bg.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -300),
            label.widthAnchor.constraint(equalToConstant: 290),
           ])
    }
}

#Preview {
       let viewController = DinamicViewController()
       return viewController
   }
