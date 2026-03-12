import UIKit

// MARK: - Dinamic View (Layout e Botões)
class DinamicView: UIView {

var onOptionSelected: ((String, Int) -> Void)?

    // MARK: - Componentes de UI
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PERGUNTA 1"
        label.numberOfLines = 0 
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        if let customFont = UIFont(name: "Bahiana", size: 55) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()

    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 0.529, green: 0.941, blue: 0.208, alpha: 1)
        progressView.trackTintColor = UIColor.white.withAlphaComponent(0.3)
        progressView.setProgress(0.3, animated: true)
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
        return progressView
    }()

    lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    lazy var bg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bgDinamic")
        imageView.contentMode = .scaleAspectFill
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

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSub()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func addSub() {
        addSubview(bg)
        addSubview(questionLabel)
        addSubview(progressBar)
        addSubview(optionsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            optionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            progressBar.heightAnchor.constraint(equalToConstant: 12),

            optionsStackView.bottomAnchor.constraint(lessThanOrEqualTo: progressBar.topAnchor, constant: -20),

            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Método para configurar a View dinamicamente
    func configure(question: String, options: [String]) {
        questionLabel.text = question
        addOptionButtons(with: options)
    }

    private func createOptionButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        
        if let customFont = UIFont(name: "Bahiana", size: 24) {
            button.titleLabel?.font = customFont
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        }
        
        button.backgroundColor = UIColor(red: 0.941, green: 0.784, blue: 0.043, alpha: 1)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }

    private func addOptionButtons(with options: [String]) {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var currentHStack: UIStackView?
        
        for (index, optionText) in options.enumerated() {
            if index % 2 == 0 {
                currentHStack = UIStackView()
                currentHStack!.axis = .horizontal
                currentHStack!.distribution = .fillEqually
                currentHStack!.spacing = 20
                optionsStackView.addArrangedSubview(currentHStack!)
            }
            
            let button = createOptionButton(title: optionText)
            button.tag = index
            currentHStack?.addArrangedSubview(button)
        }
    }

    @objc private func optionButtonTapped(_ sender: UIButton) {
        
        let soundToPlay: Sound
          
          switch sender.tag {
          case 1:
              soundToPlay = .option1
          case 2:
              soundToPlay = .option2
          case 3:
              soundToPlay = .option3
          case 4:
              soundToPlay = .option4
          case 5:
              soundToPlay = .option5
          case 6:
              soundToPlay = .option6
          default:
           
              print("Tag de botão não reconhecida: \(sender.tag)")
              soundToPlay = .option1
          }
        SoundManager.shared.play(sound: soundToPlay)

        
        for hStack in optionsStackView.arrangedSubviews {
               guard let horizontalStack = hStack as? UIStackView else { continue }
               
               for case let button as UIButton in horizontalStack.arrangedSubviews {
                   if button == sender {
                       button.backgroundColor = UIColor(red: 0.48, green: 0.941, blue: 0.094, alpha: 1)
                       
                   } else {
                       button.alpha = 0.5
                   }
               }
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               if let selectedTitle = sender.titleLabel?.text {
                   self.onOptionSelected?(selectedTitle, sender.tag)
               }
           }
       }
}
