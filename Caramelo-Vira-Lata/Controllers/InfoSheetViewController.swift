//
//  InfoSheetViewController.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit


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
