//
//  ChildCell.swift
//  Alef
//
//  Created by black on 16.11.2021.
//

import UIKit
import TableKit

final class ChildCell: UITableViewCell, ConfigurableCell {
    typealias CellData = ChildCellModel

    @IBOutlet private weak var nameChildLabel: UILabel!
    @IBOutlet private weak var ageChildLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    @IBAction private func deleteChildButton(_ sender: Any) {
        TableCellAction(key: Constants.ActionCellNames.delete.rawValue, sender: self).invoke()
    }
    
    func configure(with data: CellData) {
        nameChildLabel.text = data.name
        ageChildLabel.text = data.age
    }
}
