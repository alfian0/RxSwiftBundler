//
//  AppViewController.swift
//  RxSwiftBudler
//
//  Created by PayPro on 1/9/18.
//  Copyright © 2018 alfian.official. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AppViewController: UITableViewController {
    
    private var viewModel: AppViewModel!
    private let disposeBag = DisposeBag()
    
    init(viewModel: AppViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AppViewController", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: nil, action: nil)
            refreshButton.rx.tap
                .debounce(0.5, scheduler: MainScheduler.instance)
                .flatMap { (_) -> Observable<[UserModel]> in
                    return self.viewModel.responseStream.catchErrorJustReturn([])
                }
                .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
                    (index, user: UserModel, cell) in
                    cell.textLabel?.text = user.login
                }
                .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = refreshButton
    }
}
