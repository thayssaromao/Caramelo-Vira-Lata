import UIKit

class InitialViewController: UIViewController {
    private let initialView = InitialView()

    override func loadView() {
        self.view = initialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView.onButtonTap = navigateToOtherView
        SoundManager.shared.playLoop(sound: .background)
        
    }
    
    func navigateToOtherView() {
        //print("NAVEGOU COM PUSH")
           
        let questionVC = QuestionViewController(
            questionIndex: 0,
            questions: QuizManager.questions,
            selectedOptionIndices: []
        )

        self.navigationController?.pushViewController(questionVC, animated: true)
    }

}
