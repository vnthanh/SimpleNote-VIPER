//
//  NoteDetailPresenter.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/20/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import Foundation

class NoteDetailPresenter: NoteDetailPresenterProtocol {
    weak var view: NoteDetailViewProtocol?
    var theNote: NoteModel?
    
    func viewDidLoad() {
        if let note = theNote {
            view?.showTheNote(note: note)
        }
    }
}
