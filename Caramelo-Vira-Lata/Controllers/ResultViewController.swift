//
//  ResultViewController.swift
//  Caramelo-Vira-Lata
//
//  Created by Thayssa Romão on 28/09/25.
//

import UIKit

class ResultViewController: UIViewController {
    private let resultManager: QuizResultManager
    private let resultView = ResultView()
    private var finalResult: QuizResult!

    init(selectedOptionIndices: [Int]) {
        self.resultManager = QuizResultManager(selectedOptionIndices: selectedOptionIndices)
        super.init(nibName: nil, bundle: nil)
        self.finalResult = resultManager.getResult()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.configure(with: finalResult)
        resultView.onArrowButtonTapped = { [weak self] in
            self?.presentInfoSheet()
        }
        
        self.navigationItem.hidesBackButton = true
    }
    
    private func presentInfoSheet() {
            let infoVC = InfoSheetViewController()
            
            // ⭐️ ALTERAÇÃO AQUI: Passar a descrição e o infoText
            infoVC.configure(
                withDescription: finalResult.description,
                infoText: finalResult.infoText
            )
            
            if let sheet = infoVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = false
                sheet.preferredCornerRadius = 30
            }
            
            present(infoVC, animated: true, completion: nil)
        }
}
