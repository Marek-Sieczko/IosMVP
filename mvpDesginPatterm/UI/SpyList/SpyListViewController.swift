//
//  ViewController.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 16/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit
import Foundation
import Toaster



class SpyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    fileprivate var presenter : SpyListPresenter!
//    fileprivate var detailViewControllerMaker : DependencyRegistry.DetailViewControllerMaker!
    fileprivate var spyCellMaker: DependencyRegistry.SpyCellMaker!
    
    
    func configure(with presenter:SpyListPresenter,navigationCoordinator: NavigationCoordinator, spyCellMaker: @escaping DependencyRegistry.SpyCellMaker  ){
        
        self.presenter = presenter
        self.spyCellMaker = spyCellMaker
        self.navigationCoordinator =  navigationCoordinator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        SpyCell.register(with: tableView)
   //     Toast(text:"processing...").show()
        
       // presenter = SpyListPresenter()
        
       // loadData()
        
        presenter.loadData { [weak self] source in
            //
            self?.newDataReceived(from: source)
        }
   
        
    }
    
    func newDataReceived(from source: Source){
        
        Toast(text: "New Data from \(source)").show()
        tableView.reloadData()
    }



}


//MARK: UITableViewDataSource

extension SpyListViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell
        
        let spy = presenter.data[indexPath.row]
        let cell = spyCellMaker(tableView, indexPath, spy)
        return cell
     }
}
//MARK: - UITableViewDelegate
extension SpyListViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let spy = presenter.data[indexPath.row]
        
        print(" row with \(indexPath.row)")
      //  let detailViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
     //   let detailsPresenter = DetailsPresenter(with: spy)
      //  detailViewController.configure(with: detailsPresenter)
      //  let detailsPresenter = detailViewControllerMaker(spy)
       // navigationController?.pushViewController(detailsPresenter, animated: true)
        next(spy: spy)
    }
    
    func next(spy:SpyDTO){
        
        let args = ["spy":spy]
        navigationCoordinator!.next(arguments: args)
    }
    
    
}

