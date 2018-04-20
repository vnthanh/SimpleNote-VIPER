//
//  NoteDetailRouter.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/20/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

class NoteDetailRouter: NoteDetailRouterProtocol {
    static func createNoteDetailModule(with note: NoteModel) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        if let noteDetailView = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailView {
            // Prepare VIPER component
            let presenter: NoteDetailPresenterProtocol = NoteDetailPresenter()
            noteDetailView.presenter = presenter
            presenter.view = noteDetailView
            presenter.theNote = note
            
            return noteDetailView
        }
        
        return UIViewController()
    }
}
