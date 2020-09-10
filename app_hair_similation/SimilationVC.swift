//
//  SimilationVC.swift
//  app_hair_similation
//
//  Created by 喜連祐大 on 2020/09/10.
//

import UIKit

class SimilationVC: UIViewController {
    
    @IBOutlet weak var userImageview: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var userface:[Int] = [127, 208]
    var userfaceHairW: Int = 187
    var model1:[Int] = [147, 198]
    var model2:[Int] = [155, 216]
    var model3:[Int] = [177, 213]


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func setHairButton(_ sender: UIButton) {
        removeSubviews(parentView: userImageview)
        removeButtonBorder(taglist: [1,2,3])
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderWidth = 4.0
        switch sender.tag {
        case 1:
            setHiar(modelName: "model1", modelLm: model1)
        case 2:
            setHiar(modelName: "model2", modelLm: model2)
        case 3:
            setHiar(modelName: "model3", modelLm: model3)
        default:
            break
        }
    }
    
    @IBAction func closeBt(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setHiar(modelName: String, modelLm: [Int]) {
        let imgRatio: CGFloat = CGFloat(userfaceHairW) / 200
        let modelImage: UIImage = UIImage(named: "\(modelName)/hair")!
        let hairImgview: UIImageView = UIImageView(image: modelImage)
        hairImgview.frame = CGRect(x: CGFloat(CGFloat(userface[0]) - CGFloat(modelLm[0])*imgRatio), y: CGFloat(CGFloat(userface[1]) - CGFloat(modelLm[1])*imgRatio), width: modelImage.size.width*imgRatio, height: modelImage.size.height*imgRatio)
        userImageview.addSubview(hairImgview)
    }
    
    func removeSubviews(parentView: UIImageView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func removeButtonBorder(taglist: [Int]) {
        for tag in taglist {
            let button = self.view.viewWithTag(tag) as? UIButton
            button?.layer.borderWidth = 0.0
        }
    }
}
