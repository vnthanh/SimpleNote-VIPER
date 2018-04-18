//
//  NotesView.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

class NotesView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var notes: [NoteModel] = []
    weak var presenter: NotesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func addNote() {
        let alert = UIAlertController(title: "New note",message: "Add a new note",preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",style: .default) {
                                        [unowned self] action in
                                        guard let textField = alert.textFields?.first,
                                            let noteToSave = textField.text else {
                                                return
                                        }
            
                                        // Tell the presenter that user adding new note
                                        self.presenter?.addNewNote(noteToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension NotesView: NotesViewProtocol {
    func appendAndShowNewNotes(newNote: NoteModel) {
        self.notes.append(newNote)
        tableView.reloadData()
    }
    
    func showNotes(_ notes: [NoteModel]) {
        self.notes = notes
        tableView.reloadData()
    }
    
    
}

extension NotesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.content
        
        return cell
    }
}
