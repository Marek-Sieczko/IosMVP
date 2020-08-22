//
//  SpyCell.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 17/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit
import CoreData

class SpyCell: UITableViewCell {
    
    
    @IBOutlet weak var imageContainer: UIView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var ageLable: UILabel!
    
    @IBOutlet weak var nameValueLable: UILabel!
    
    @IBOutlet weak var ageValueLable: UILabel!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var spy:Spy!
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageContainer.subviews.forEach { $0.removeFromSuperview()
        
        }
        
        nameValueLable.text = ""
        
        ageValueLable.text = ""
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commonInit()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SpyCell{
    
    
    func commonInit(){
        
         setAccessibilityProperties()
        
        if #available(iOS 10 , *){
            
            commonInit_iOS10()
            
        } else {
            
            commonInit_iOS7PLUS()
            
        }
        
        
    }
    
    func setAccessibilityProperties(){
        
        nameValueLable.isAccessibilityElement = true
    }
    
    func set(name:String){
        
        nameValueLable.text = name
        nameValueLable.accessibilityValue = name
        
        
    }
    
    func set(age:Int){
        ageValueLable.text = String(age)
    }
}
@available(iOS 10, *)
extension SpyCell{
    
    func commonInit_iOS10(){
       
        
        nameValueLable.adjustsFontForContentSizeCategory = true
        
    }
}

//MARK: Dynamic Sizing font - iOS 8

@available(iOS 7, *)
extension SpyCell{
    
    fileprivate func commonInit_iOS7PLUS(){
        assignFonts()
        
        NotificationCenter.default.removeObserver(self)

        
    }
    
    @objc func userChangedTextSize(notification:NSNotification){
        
        assignFonts()
    }
    
    
    
    
    fileprivate func assignFonts(){
        
        nameValueLable.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
}
extension SpyCell{
    
    func configure(with spy: Spy){
        
        getSomeData {
            
            [weak self] in
            
            guard let strongSelf =  self else{return}
            
            strongSelf.set(age: Int(spy.age))
            strongSelf.set(name: spy.name!)
            strongSelf.add(imageName: spy.imageName)
            
        }
    }
    
    fileprivate func getSomeData(finished: @escaping ()->Void){
        
        activityIndicator.startAnimating()
        
        activityIndicator.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
             self?.activityIndicator.stopAnimating()
             self?.activityIndicator.isHidden = true
            
            finished()
            
        }
        
    }
}

//MARK: adding images

extension SpyCell{
    
    func add(imageName: String){
        
        guard let image = UIImage(named: imageName)else{ return}
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        imageView.image = image
        
        imageContainer.addSubview(imageView)
        
    }
}
//MAKR: - Helper Methods

extension SpyCell{

    public static var cellId: String{

        return "SpyCell"
    }

    public static var bundle:Bundle {
        return Bundle(for: SpyCell.self)

    }

    public static var nib: UINib{

        return UINib(nibName: "SpyCell", bundle: SpyCell.bundle)

    }

    public static func register(with tableView:UITableView){

        tableView.register(SpyCell.nib, forCellReuseIdentifier: SpyCell.cellId)
    }

    public static func loadFromNib(owner: Any?) -> SpyCell{

        return bundle.loadNibNamed(SpyCell.cellId, owner: owner, options: nil)?.first as! SpyCell
    }

    public static func dequeue(from tableView: UITableView, for indexPath:IndexPath, with spy: Spy) -> SpyCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: SpyCell.cellId, for: indexPath) as! SpyCell

       cell.configure(with: spy)

        return cell



    }
}
