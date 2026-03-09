import UIKit

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
            rotation.duration = 10.0
            rotation.repeatCount = .infinity
            rotation.isRemovedOnCompletion = false
            
            self.spiral.layer.add(rotation, forKey: "spinAnimation")
        }
}
