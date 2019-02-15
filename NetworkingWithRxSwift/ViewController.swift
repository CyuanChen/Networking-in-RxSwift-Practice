//
//  ViewController.swift
//  NetworkingWithRxSwift
//
//  Created by PeterChen on 2019/2/13.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let cellIdentifier = "cellIdentifier"
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for university"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureLayout()
        configureProperties()
        configureReactiveBinding()
    }
    
    private func configureProperties() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.title = "University finder"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
        
    }
    // Typing search phrase in search field → Instance of request created with search phrase → Array of models of university → Refreshed UITableView filled by new data and all of that in 10 lines!!!
    private func configureReactiveBinding() {
        searchController.searchBar.rx.text.asObservable()
            .map { ($0 ?? "").lowercased() } // 沒有東西就用""代替
            .map { UniversityRequest(name: $0)} // 把輸入的值塞到request裡面
            .flatMap { request -> Observable<[UniversityModel]> in // 要把request轉成 model的observable
                return self.apiClient.send(apiRequest: request)
            }
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = model.description
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(UniversityModel.self)
            .map { URL(string: $0.webPages?.first ?? "")!}
            .map { SFSafariViewController(url: $0)}
            .subscribe(onNext: { [weak self]
                safariViewController in
                self?.present(safariViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}

