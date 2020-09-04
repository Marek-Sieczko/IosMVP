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
import RxSwift
import RxDataSources
import RxCocoa

class SpyListViewController: UIViewController, UITableViewDelegate{
 
    
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    fileprivate var presenter : SpyListPresenter!
//    fileprivate var detailViewControllerMaker : DependencyRegistry.DetailViewControllerMaker!
    fileprivate var spyCellMaker: DependencyRegistry.SpyCellMaker!
    
    fileprivate var bag = DisposeBag()
    fileprivate var dataSource : RxTableViewSectionedReloadDataSource<SpySection>?
   // fileprivate var configCell : ConfigureCell?
    
    
    
    func configure(with presenter:SpyListPresenter,navigationCoordinator: NavigationCoordinator, spyCellMaker: @escaping DependencyRegistry.SpyCellMaker  ){
        
        self.presenter = presenter
        self.spyCellMaker = spyCellMaker
        self.navigationCoordinator =  navigationCoordinator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       

        SpyCell.register(with: tableView)
        dataSource = RxTableViewSectionedReloadDataSource<SpySection>(configureCell: { _, tableView, indexPath, spy in
            
            let cell = self.spyCellMaker(tableView,indexPath,spy)
            
            return cell
            
        })

  
        

        initDataSource()
        initTableView()

        
        presenter.loadData { [weak self] source in
            //
            self?.newDataReceived(from: source)
        }
   
        
    }
    

    
    @IBAction func updateData(_ sender:Any){
        
        presenter.makeSomeChanges()
        
    }
    
    func newDataReceived(from source: Source){
        
        Toast(text: "New Data from \(source)").show()
        tableView.reloadData()
    }



}


//MARK: UITableViewDataSource


//MARK: - UITableViewDelegate
extension SpyListViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    
    func next(spy:SpyDTO){
        
        let args = ["spy":spy]
        navigationCoordinator!.next(arguments: args)
    }
    
    
}
extension SpyListViewController{
    
    //MARK: - reactive section
    
    func initDataSource(){
        
        dataSource!.configureCell = { _, tableView, indexPath, spy in

            let cell = self.spyCellMaker(tableView,indexPath,spy)

            return cell

        }
        dataSource!.titleForHeaderInSection = { ds, index in
            
            return ds.sectionModels[index].header
            
            
        }
        
    }
    
    func initTableView(){
        
        presenter.section.asObservable().bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: bag)
        
        // handle actions on cell
        
        tableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource![indexPath])
        }.subscribe(onNext: { (indexPath,spy) in
            self.next(spy: spy)
            }).disposed(by: bag)
    
        tableView.rx.setDelegate(self)
        .disposed(by: bag)
        
    }
    
    
}

