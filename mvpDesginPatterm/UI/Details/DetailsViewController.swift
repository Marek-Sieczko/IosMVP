//
//  DetailsViewController.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 21/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, SecretDetailsDelegate {

    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var ageLable: UILabel!
    
    @IBOutlet weak var genderLable: UILabel!
    
    var spy:Spy!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        superView()
        
        
        
        

        
    }
    
    func configure(with spy: Spy){
        
        self.spy = spy
        
    }
    
    func superView(){
        
        profileImage.image = UIImage(named: spy.imageName)
        nameLable.text = spy.name
        ageLable.text = "\(spy.age)"
        genderLable.text = spy.gender
    }




}

extension DetailsViewController{
    
    func passwordCrackingFinished() {
        // close the middle layer too
        navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController{
    
    @IBAction func briefcaseTapped(_ button:UIButton){
        
        let vc = SecretDetailsViewController(with: spy, and: self as SecretDetailsDelegate)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
