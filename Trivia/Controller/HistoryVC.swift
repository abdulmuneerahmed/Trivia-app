//
//  HistoryVC.swift
//  Trivia
//
//  Created by admin on 20/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit
import CoreData

class HistoryVC: UIViewController {
    
    // MARK: - reusableCell -
    fileprivate let reuseCell = "CellID"
    
    // MARK: - Variables -
    var users:[NSManagedObject] = []
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 36/255, green: 42/255, blue: 64/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 64/255, blue: 88/255, alpha: 1)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
        tabledataSources()
        reloadData()
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var tableView:UITableView = {
        let tableview = UITableView()
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.isHidden = true
        return tableview
    }()
    
    fileprivate lazy var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .whiteLarge
        spinner.color = .orange
        return spinner
    }()
    
    // MARK: - Adding SubViews -
    private func addSubviews(){
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: -10, paddingRight: 0)
        view.addSubview(spinner)
        spinner.setAnchor(width: 50, height: 50)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(dismissMe))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Avenirnext-Medium", size: 25)!], for: .normal)
    }
    
    // MARK: - Table Delegate and datasource func -
    private func tabledataSources(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: reuseCell)
        spinner.startAnimating()
    }
    
    // MARK: - Fetching Function -
    fileprivate func reloadData(){
        fetch {[weak self] (finish) in
            guard let self = self else{return}
            if finish{
                self.spinner.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Selectors -
    @objc func dismissMe(){
        dismiss(animated: true, completion: nil)
    }
    
//    deinit {
//        print("History VC Deallocated")
//    }
}

// MARK: - extensions -
extension HistoryVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        cell.updateTableCell(history: users[indexPath.row] as! History)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row] as! History
        let vc = DetailsViewController()
        vc.history = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Fetching data from coreData -
    fileprivate func fetch(completionHandler: @escaping (_ status:Bool)->()){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "History")
        let sort = NSSortDescriptor(key: #keyPath(History.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            users = try managedContext.fetch(fetchRequest)
            completionHandler(true)
            
        }catch let error as NSError {
            print("Could not Fetch. \(error), \(error.userInfo)")
            completionHandler(false)
        }
    }
}
