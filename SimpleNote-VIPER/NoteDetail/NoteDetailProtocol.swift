//
//  NoteDetailProtocol.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/20/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

protocol NoteDetailViewProtocol: class {
    var presenter: NoteDetailPresenterProtocol? {get set}
    
    func showTheNote(note: NoteModel)
}

protocol NoteDetailPresenterProtocol: class {
    var view: NoteDetailViewProtocol? {get set}
    var theNote: NoteModel? {get set}
    
    func viewDidLoad()
}

protocol NoteDetailRouterProtocol: class {
    static func createNoteDetailModule(with note: NoteModel) -> UIViewController
}
