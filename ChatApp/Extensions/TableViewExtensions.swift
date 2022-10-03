//
//  TableViewExtensions.swift
//  ChatApp
//
//  Created by Michal Fereniec on 01/10/2022.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToTheBottom() {
        DispatchQueue.main.async {
            let section = self.numberOfSections - 1
            let row = self.numberOfRows(inSection: section) - 1
            
            if section >= 0 && row >= 0 {
                let bottomIndexPath =  IndexPath(row: row, section: section)
                self.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
            }
        }
        
    }
}
