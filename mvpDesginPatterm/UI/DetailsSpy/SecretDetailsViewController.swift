//
//  SecretDetailsViewController.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 21/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit


protocol SecretDetailsDelegate: class {
    
    func passwordCrackingFinished()
}

protocol SecretDetailsPresenter {
    //var spy: SpyDTO { get }
    
    var password: String{ get }
}
class SecretDetailsPresenterImp:SecretDetailsPresenter {
    var spy: SpyDTO
    
    var password: String{ return spy.password}
    
    init(with spy: SpyDTO) {
        
        self.spy = spy
    }
    
}
class SecretDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var passwordLable: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    weak var delegate: SecretDetailsDelegate?
    
    fileprivate var secretDetailsPresenter:SecretDetailsPresenter!
    weak var navigationCoordinator: NavigationCoordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in self?.showPassword()
        }

        // Do any additional setup after loading the view.
    }
    
    init(with secretDetailsPresenter: SecretDetailsPresenter, navigationCoordinator:NavigationCoordinator ) {
        self.secretDetailsPresenter = secretDetailsPresenter
      //  self.delegate = delegate
        self.navigationCoordinator = navigationCoordinator
        
        super.init(nibName: "SecretDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    

    func showPassword(){
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        print("The password is \(secretDetailsPresenter.password)")
        passwordLable.text = secretDetailsPresenter.password
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       if isMovingFromParent{
        
        navigationCoordinator?.movingBack()
        }
    }
    
    
    @IBAction func finishedButtonTapped(_ sender: Any) {
        
        print("button tapped!!")
        
//        navigationController?.popViewController(animated: true)
//
//            delegate?.passwordCrackingFinished()
        navigationCoordinator?.next(arguments: [:])
    }
    
    

}
