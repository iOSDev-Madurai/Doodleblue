//
//  OptionsViewController.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {

    @IBOutlet weak var viewModel: DropDownViewModel!

    // MARK:- ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        hideKeyboardWhenTappedAround()

        tableView.hideEmptyRows()
    }

    // MARK:- Delegate & DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.attributes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let attribute = viewModel.attributes[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.Identifiers.dropDown, for: indexPath) as? DropDownTableViewCell
            else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.attribute = attribute
        return cell
    }

}

