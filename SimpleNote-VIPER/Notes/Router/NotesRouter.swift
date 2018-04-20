//
//  NotesRouter.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import Foundation
import UIKit

class NotesRouter: NotesRouterProtocol {
    static func createNotesModule() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        if let notesNavigationController = storyboard.instantiateViewController(withIdentifier: "NotesNavigationController") as? UINavigationController {
            if let notesView = notesNavigationController.childViewControllers.first as? NotesView {
                // Prepare the VIPER components
                let presenter: NotesPresenterProtocol & NotesInteractorOutputProtocol = NotesPresenter()
                let interactor: NotesInteractorInputProtocol = NotesInteractor()
                let router: NotesRouterProtocol = NotesRouter()
                
                notesView.presenter = presenter
                presenter.view = notesView
                presenter.interactor = interactor
                presenter.router = router
                interactor.presenter = presenter
                
                return notesNavigationController
            }
        }
        return UIViewController()
    }
    
    func showNoteDetail(from view: NotesViewProtocol, note: NoteModel) {
        let detailNoteView = NoteDetailRouter.createNoteDetailModule(with: note)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailNoteView, animated: true)
        }
    }
}
