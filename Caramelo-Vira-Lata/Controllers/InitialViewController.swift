//
//  ViewController.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 23/09/25.
//

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
        print("NAVEGOU COM PUSH")
           
        // ⭐️ CORREÇÃO: Passa o índice 0, todas as perguntas, e INICIA o array de respostas
        let questionVC = QuestionViewController(
            questionIndex: 0,
            questions: QuizManager.questions,
            selectedOptionIndices: []
        )

        self.navigationController?.pushViewController(questionVC, animated: true)
    }

}
