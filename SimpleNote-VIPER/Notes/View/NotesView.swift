//
//  NotesView.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/18/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit
import RxSwift

class NotesView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearNotesButton: UIButton!
    @IBOutlet weak var notesCountLabel: UILabel!
    //    var notes: [NoteModel] = []
    weak var presenter: NotesPresenterProtocol?
    
    // Play with RxSwift
    private let bag = DisposeBag()
    private let notes = Variable<[NoteModel]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        // Add subscriber to notes
        notes.asObservable().subscribe(onNext: { [weak self] notes in
            self?.updateUI()
        }).disposed(by: bag)
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
    
    @IBAction func clearAllNotes() {
        presenter?.clearAllNotes()
    }
    
    private func updateUI() {
        // UI update each time notes [] changes
        clearNotesButton.isHidden = !(notes.value.count > 0)
        notesCountLabel.text = "Notes: \(notes.value.count)"
    }
}

extension NotesView: NotesViewProtocol {
    func appendAndShowNewNotes(newNote: NoteModel) {
        self.notes.value.append(newNote)
        tableView.reloadData()
    }
    
    func showNotes(_ notes: [NoteModel]) {
        self.notes.value = notes
        tableView.reloadData()
    }
    
    
}

extension NotesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes.value[indexPath.row]
        presenter?.showNoteDetail(selectedNote)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes.value[indexPath.row]
        cell.textLabel?.text = note.content
        
        return cell
    }
}
