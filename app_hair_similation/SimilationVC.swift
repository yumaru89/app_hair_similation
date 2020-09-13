//
//  SimilationVC.swift
//  app_hair_similation
//
//  Created by 喜連祐大 on 2020/09/10.
//

import UIKit

class SimilationVC: UIViewController {
    
    @IBOutlet weak var similateView: UIView!
    @IBOutlet weak var userImageview: UIImageView!
    var hairImgScrollview: UIScrollView = UIScrollView()
    var hairImgview: UIImageView = UIImageView()
    var downloadedBar: UILabel = UILabel()

    var userface: [CGFloat] = [127, 208]
    var model1: [CGFloat] = [147, 198]
    var model2: [CGFloat] = [155, 216]
    var model3: [CGFloat] = [177, 213]
        
    var hairWRatio: CGFloat = 187/200


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavbarLayout(name: "result")
        setModelHairView()
        setDownloadedBar()
        setHairRanking(taglist: [1,2,3])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func hairSetBt(_ sender: UIButton) {
        setNavbarLayout(name: "similation")
        removeButtonBorder(taglist: [1,2,3])
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderWidth = 4.0
        switch sender.tag {
        case 1:
            setModelHiar(modelName: "model1", modelLm: model1)
        case 2:
            setModelHiar(modelName: "model2", modelLm: model2)
        case 3:
            setModelHiar(modelName: "model3", modelLm: model3)
        default:
            break
        }
    }
    
    @IBAction func similateDwonloadBt(_ sender: UIButton) {
        downloadedBar.isHidden = false
        sender.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.downloadedBar.isHidden = true
            sender.isEnabled = true
        }
    }
    
    func setNavbarLayout(name: String) {
        let button = UIButton()
        switch name {
        case "result":
            hairImgview.isHidden = true
            self.navigationItem.title = "判定結果"
            button.setImage(UIImage(named: "close"), for: .normal)
            button.addTarget(self, action: #selector(SimilationVC.backTopView), for:  UIControl.Event.touchUpInside)
        case "similation":
            hairImgview.isHidden = false
            self.navigationItem.title = "シミュレーション"
            button.setImage(UIImage(named: "back"), for: .normal)
            button.addTarget(self, action: #selector(SimilationVC.backResultView), for:  UIControl.Event.touchUpInside)
        default:
            break
        }
        let backBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc func backTopView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backResultView() {
        removeButtonBorder(taglist: [1,2,3])
        setNavbarLayout(name: "result")
    }
    
    func setModelHairView() {
        hairImgScrollview.frame = CGRect(x:0, y:0, width: userImageview.frame.width, height: userImageview.frame.height)
        hairImgScrollview.maximumZoomScale = 2.0
        hairImgScrollview.minimumZoomScale = 0.5
        hairImgScrollview.bounces = false
//        hairImgScrollview.contentSize = CGSize(width: 1000, height: 1000)
//
//        let midOffsetX = (1000 - hairImgScrollview.frame.size.width)/2
//        let midOffsetY = (1000 - hairImgScrollview.frame.size.height)/2
//        hairImgScrollview.contentOffset = CGPoint(x: midOffsetX, y: midOffsetY)
        hairImgScrollview.delegate = self
        similateView.addSubview(hairImgScrollview)
        hairImgScrollview.addSubview(hairImgview)
        hairImgview.isHidden = true
    }

    
    func setModelHiar(modelName: String, modelLm: [CGFloat]) {
        let hairImg: UIImage = UIImage(named: "\(modelName)/hair")!
        hairImgview.image = hairImg
        hairImgview.frame = CGRect(x: userface[0]-modelLm[0]*hairWRatio, y: userface[1]-modelLm[1]*hairWRatio, width: hairImg.size.width*hairWRatio, height: hairImg.size.height*hairWRatio)
    }

    func setDownloadedBar() {
        downloadedBar.frame = CGRect(x: 0, y: userImageview.frame.height-32, width: userImageview.frame.width, height: 32)
        downloadedBar.tag = 4
        downloadedBar.backgroundColor = UIColor(hex: "434343")
        downloadedBar.text = "  端末に画像を保存しました"
        downloadedBar.textColor = UIColor.white
        downloadedBar.font = downloadedBar.font.withSize(13)
        userImageview.addSubview(downloadedBar)
        downloadedBar.isHidden = true
    }
    
    func setHairRanking(taglist: [Int]) {
        for tag in taglist {
            let button = self.view.viewWithTag(tag) as? UIButton
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
    
    func removeButtonBorder(taglist: [Int]) {
        for tag in taglist {
            let button = self.view.viewWithTag(tag) as? UIButton
            button?.layer.borderWidth = 0.0
        }
    }
}

extension SimilationVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return hairImgview
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
