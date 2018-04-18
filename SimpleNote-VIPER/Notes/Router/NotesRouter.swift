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
        
        if let notesView = storyboard.instantiateViewController(withIdentifier: "NotesViewController") as? NotesView {
            // Prepare the VIPER components
            let presenter: NotesPresenterProtocol & NotesInteractorOutputProtocol = NotesPresenter()
            let interactor: NotesInteractorInputProtocol = NotesInteractor()
            
            notesView.presenter = presenter
            presenter.view = notesView
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return notesView
        }
        return UIViewController()
    }
}
