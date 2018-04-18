//
//  NotesInteractor.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import Foundation

class NotesInteractor: NotesInteractorInputProtocol {
    var presenter: NotesInteractorOutputProtocol?
    
    func fetchDataLocally() {
        if let result: [String] = UserDefaults.standard.array(forKey: "Notes") as? [String] {
            var notes: [NoteModel] = []
            for string in result {
                notes.append(NoteModel(content: string))
            }
            presenter?.didRecieveNotesData(notes)
            return
        }
        // Fetch notes locally
        presenter?.didRecieveNotesData([])
    }
    
    func saveNewNoteLocally(newNote: NoteModel) {
        if var result: [String] = UserDefaults.standard.array(forKey: "Notes") as? [String] {
            result.append(newNote.content!)
            UserDefaults.standard.set(result, forKey: "Notes")
            return
        }
        let notes: [String] = [newNote.content!]
        UserDefaults.standard.set(notes, forKey: "Notes")
    }
}
