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

class SecretDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var passwordLable: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var spy: Spy
    weak var delegate: SecretDetailsDelegate?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in self?.showPassword()
        }

        // Do any additional setup after loading the view.
    }
    
    init(with spy: Spy, and delegate: SecretDetailsDelegate?) {
        self.spy = spy
        self.delegate = delegate
        
        super.init(nibName: "SecretDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func showPassword(){
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        print("The password is \(spy.password)")
        passwordLable.text = spy.password
    }
    
    
    @IBAction func finishedButtonTapped(_ sender: Any) {
        
        print("button tapped!!")
        
        navigationController?.popViewController(animated: true)
        
            delegate?.passwordCrackingFinished()
    }
    
    

}
