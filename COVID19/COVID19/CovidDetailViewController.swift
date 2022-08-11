//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by 이민아 on 2022/08/11.
//

import UIKit

//static tableView 사용
class CovidDetailViewController: UITableViewController {

    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
