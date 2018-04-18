//
//  NotesProtocol.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

protocol NotesViewProtocol: class {
    // View talk to presenter only
    var presenter: NotesPresenterProtocol? {get set}
    
    // View display what it's been told
    func showNotes(_ notes: [NoteModel])
    func appendAndShowNewNotes(newNote: NoteModel)
}

protocol NotesPresenterProtocol: class {
    // Presenter is the center heart
    var view: NotesViewProtocol? {get set}
    var interactor: NotesInteractorInputProtocol? {get set}
    var router: NotesRouterProtocol? {get set}
    
    // Get didLoad event from view
    func viewDidLoad()
    func addNewNote(_ noteContent: String)
}

protocol NotesInteractorInputProtocol: class {
    var presenter: NotesInteractorOutputProtocol? {get set}
    
    // Get data request from presenter
    func fetchDataLocally()
    func saveNewNoteLocally(newNote: NoteModel)
}

protocol NotesInteractorOutputProtocol: class {
    // Pass data result to presenter
    func didRecieveNotesData(_ notes: [NoteModel])
}

protocol NotesRouterProtocol: class {
    static func createNotesModule() -> UIViewController
}
