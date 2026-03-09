import UIKit

class DinamicViewController: UIViewController {
    
    private let dinamicView = DinamicView()
    
    private var questions: [Question]
    private var questionIndex: Int
    private var selectedOptionIndices: [Int]

    // Inicializador com todas as propriedades de estado do quiz
    init(questionIndex: Int, questions: [Question], selectedOptionIndices: [Int]) {
        self.questionIndex = questionIndex
        self.questions = questions
        self.selectedOptionIndices = selectedOptionIndices
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = dinamicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentQuestion = questions[questionIndex]
        dinamicView.configure(
            question: currentQuestion.text,
            options: currentQuestion.options
        )
        
        let progress = Float(questionIndex + 1) / Float(questions.count)
        dinamicView.progressBar.setProgress(progress, animated: true)
        
        // onOptionSelected agora recebe o índice da opção
        dinamicView.onOptionSelected = { [weak self] selectedText, selectedIndex in
            //print("Pergunta \(self?.questionIndex ?? 0): Opção selecionada: \(selectedText) (Índice: \(selectedIndex))")
            self?.goToNextQuestion(selectedIndex: selectedIndex)
        }
    }
    
    private func goToNextQuestion(selectedIndex: Int) {
        var updatedIndices = selectedOptionIndices
        updatedIndices.append(selectedIndex)
        
        let nextIndex = questionIndex + 1
        
        if nextIndex < questions.count {
            let nextVC = QuestionViewController(
                questionIndex: nextIndex,
                questions: questions,
                selectedOptionIndices: updatedIndices
            )
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let resultsVC = ResultViewController(selectedOptionIndices: updatedIndices)
            navigationController?.pushViewController(resultsVC, animated: true)
        }
    }
}
