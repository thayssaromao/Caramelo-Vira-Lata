//
//  Result.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//


import UIKit

class ResultViewController: UIViewController {
    private let resultView = ResultView()
    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

class ResultView:UIView {
    
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
    
    lazy var spiral : UIImageView = {
        let spiralView = UIImageView()
        spiralView.translatesAutoresizingMaskIntoConstraints = false
        spiralView.image = UIImage(named: "spiralBlue")
        spiralView.alpha = 0.98
        return spiralView
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
        addSubview(spiral)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            spiral.widthAnchor.constraint(equalToConstant: 390),
            spiral.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            bg.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            bg.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 120),
            label.widthAnchor.constraint(equalToConstant: 290),
           ])
    }
}

#Preview {
       let viewController = ResultViewController()
       return viewController
   }
