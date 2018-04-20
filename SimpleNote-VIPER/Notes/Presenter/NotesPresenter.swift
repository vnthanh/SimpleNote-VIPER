//
//  NotesPresenter.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

class NotesPresenter: NotesPresenterProtocol {
    var view: NotesViewProtocol?
    var interactor: NotesInteractorInputProtocol?
    var router: NotesRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchDataLocally()
    }
    
    func addNewNote(_ noteContent: String) {
        var newNote: NoteModel = NoteModel()
        newNote.content = noteContent
        // Ask interactor to save new note locally
        interactor?.saveNewNoteLocally(newNote: newNote)
        // Tell the view to append and show list with new added note
        view?.appendAndShowNewNotes(newNote: newNote)
    }
}

extension NotesPresenter: NotesInteractorOutputProtocol {
    func didRecieveNotesData(_ notes: [NoteModel]) {
        view?.showNotes(notes)
    }
    
    func showNoteDetail(_ note: NoteModel) {
        router?.showNoteDetail(from: view!, note: note)
    }
}
