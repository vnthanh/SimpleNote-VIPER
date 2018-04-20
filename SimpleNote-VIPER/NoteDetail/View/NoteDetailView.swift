//
//  NoteDetailView.swift
//  SimpleNote-VIPER
//
//  Created by ThanhVo on 4/20/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

class NoteDetailView: UIViewController {
    @IBOutlet weak var noteTextField: UITextField!
    var presenter: NoteDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension NoteDetailView: NoteDetailViewProtocol {
    func showTheNote(note: NoteModel) {
        self.noteTextField.text = note.content
    }
}
