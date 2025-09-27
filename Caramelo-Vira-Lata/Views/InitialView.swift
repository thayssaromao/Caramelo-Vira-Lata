//
//  InitialView.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 23/09/25.
//

import UIKit

class InitialView: UIView {
    
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
        
        
//        button.addTarget(self, action: #selector(didPressCustomButton), for: .touchUpInside)
        
        return button
    }()
    
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
        addSubview(customButton)
    }

private func setupConstraints(){
    NSLayoutConstraint.activate([
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
