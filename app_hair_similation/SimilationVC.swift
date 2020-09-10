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
        
        setHairRanking(taglist: [1,2,3])
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
    
    func setHairRanking(taglist: [Int]) {
        for tag in taglist {
            let button = self.view.viewWithTag(tag) as? UIButton
            print(tag)
            let rankingIcon: UILabel = UILabel()
            rankingIcon.frame = CGRect(x: 8, y: 8, width: 16, height: 16)
            rankingIcon.layer.cornerRadius = 8
            rankingIcon.clipsToBounds = true
            rankingIcon.text = String(tag)
            rankingIcon.font = rankingIcon.font.withSize(12)
            rankingIcon.textAlignment = NSTextAlignment.center
            var rankingBgColor: String = ""
            switch tag {
            case 1:
                rankingBgColor = "DCC48E"
            case 2:
                rankingBgColor = "AAAEAC"
            case 3:
                rankingBgColor = "CBA37E"
            default:
                rankingBgColor = "000000"
            }
            rankingIcon.backgroundColor = UIColor(hex: rankingBgColor)
            button?.addSubview(rankingIcon)
        }
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

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
