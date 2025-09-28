//
//  InitialView.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 23/09/25.
//

import UIKit

class InitialViewController: UIViewController {
    private let initialView = InitialView()

    override func loadView() {
//        super.loadView()
        self.view = initialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView.onButtonTap = navigateToOtherView
    }
    
   func navigateToOtherView() {
        print("NAVEGOU COM PUSH")
        let questionVC = QuestionViewController()

        self.navigationController?.pushViewController(questionVC, animated: true)
    }


}


class InitialView: UIView {
    
    var onButtonTap: () -> Void = {}
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "QUAL VIRA LATA É VOCÊ ??"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.263, green: 0.22, blue: 0.875, alpha: 1)
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
        imageView.image = UIImage(named: "bgFull")
        
        
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
    
    // Auto layout, grids, variables, and unit scale are not yet supported
    lazy var spiral : UIImageView = {
        let spiralView = UIImageView()
        spiralView.translatesAutoresizingMaskIntoConstraints = false
        spiralView.image = UIImage(named: "spiral")
        spiralView.alpha = 0.98
        return spiralView
    }()
    
    lazy var customButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BORA!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.backgroundColor = UIColor(red: 0.984, green: 0.38, blue: 0.027, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.opacity = 0.8
        button.titleLabel?.font = UIFont(name: "Bahiana", size: 50)
        button.layer.cornerRadius = 25
        
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func didPressButton(){
        print("bora pressionado")
        onButtonTap()
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
        addSubview(spiral)
        addSubview(label)
        addSubview(customButton)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            spiral.widthAnchor.constraint(equalToConstant: 390),
            spiral.topAnchor.constraint(equalTo: topAnchor, constant: 240.46),
            
            bg.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            bg.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -260),
            label.widthAnchor.constraint(equalToConstant: 290),
            customButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            customButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 724),
            customButton.widthAnchor.constraint(equalToConstant: 209),
            customButton.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
}

#Preview {
       let viewController = InitialViewController()
       return viewController
   }
