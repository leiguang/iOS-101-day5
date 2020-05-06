//
//  HomeViewController.swift
//  iOS-101-day5
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit
import ESPullToRefresh

protocol HomeViewControllerProtocol: class {
    func reloadTableView()
    func stopPullToRefresh()
    func showAlert(message: String)
}

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        viewModel = HomeViewModel(viewController: self)
    }
    
    // MARK: - Life cycle
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        tableView.es.startPullToRefresh()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.es.addPullToRefresh { [weak self] in
            self?.viewModel.loadData()
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func stopPullToRefresh() {
        tableView.es.stopPullToRefresh()
    }
        
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.cellModels[indexPath.row]
        switch model {
        case let model as HomeTotalCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTotalCell", for: indexPath) as! HomeTotalCell
            cell.configure(model: model)
            return cell
        case let model as HomeBookCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBookCell", for: indexPath) as! HomeBookCell
            cell.configure(model: model)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


