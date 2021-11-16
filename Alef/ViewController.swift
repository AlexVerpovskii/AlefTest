//
//  ViewController.swift
//  Alef
//
//  Created by black on 16.11.2021.
//

import UIKit
import TableKit

final class ViewController: UIViewController {
    @IBOutlet private weak var lastNameTF: UITextField!
    @IBOutlet private weak var firstNameTF: UITextField!
    @IBOutlet private weak var midleNameTF: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var ageTF: UITextField!
    @IBOutlet weak var addChildButton: UIButton!
    
    private var tableDirector: TableDirector?
    private var countChild: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDirector = TableDirector(tableView: tableView)
        tableDirector?.tableView?.separatorStyle = .none
    }

    @IBAction private func clearActionButton(_ sender: Any) {
        clearAll()
    }
    
    @IBAction private func addChildActionButton(_ sender: Any) {
        addChild()
    }
}












extension ViewController {
    
    private func addChild() {
        
        let deleteAction = TableRowAction<ChildCell>(.custom(Constants.ActionCellNames.delete.rawValue)) { [weak self] (options) in
            
            self?.tableDirector?.sections[options.indexPath.section].delete(rowAt: options.indexPath.row)
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [options.indexPath], with: .automatic)
            self?.tableView.endUpdates()
            self?.addChildButton.isHidden = false
            self?.tableDirector?.reload()
        }
        
        let alert = UIAlertController(title: "Добавить ребенка", message: "Заполните форму", preferredStyle: .alert)
        alert.addTextField { text in
            text.placeholder = "Имя"
        }
        alert
            .addTextField { text in
            text.placeholder = "Возраст"
        }
        
        let save = UIAlertAction(title: "+", style: .default) {[weak self] action in
            let name = alert.textFields![0].text
            let age = alert.textFields![1].text
            let child = ChildCellModel(name: name!, age: age!)
            self?.tableDirector?.append(rows: [TableRow<ChildCell>(item: ChildCellModel(name: child.name, age: child.age), actions: [deleteAction])])
            self?.tableDirector?.reload()
            self?.countChild += 1
        }
        
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
        
        if self.countChild == 5 {
            self.addChildButton.isHidden = true
        }
    }
    
    private func clearAll() {
        let alert = UIAlertController(title: "Очистить", message: "Очистить все?", preferredStyle: .actionSheet)
        let clear = UIAlertAction(title: "Сбросить данные", style: .default) { [weak self] action in
            self?.lastNameTF.text = ""
            self?.firstNameTF.text = ""
            self?.midleNameTF.text = ""
            self?.ageTF.text = ""
            self?.tableDirector?.clear()
            self?.tableDirector?.reload()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(clear)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
