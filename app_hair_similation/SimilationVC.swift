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
    @IBOutlet weak var modelChangeView: UIView!
    
    
    var hairImgScrollview: UIScrollView = UIScrollView()
    var hairImgview: UIImageView = UIImageView()
    var colorChangerView: UIView = UIView()
    var colorListScrollview: UIScrollView = UIScrollView()
    var colorView: UIView = UIView()
    var colorCheckImgview: UIImageView = UIImageView()
    var isFold: Bool = false
    var downloadedBar: UILabel = UILabel()

    var userface: [CGFloat] = [127, 208]
    var model1: [CGFloat] = [147, 198]
    var model2: [CGFloat] = [155, 216]
    var model3: [CGFloat] = [177, 213]
        
    var hairWRatio: CGFloat = 187/200


    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultLyaout()
        switchSimilateView(name: "result")
        setModelHairView()
        setHairColorChanger()
        setDownloadedBar()
        setHairRanking(taglist: [1,2,3])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func hairSetBt(_ sender: UIButton) {
        switchSimilateView(name: "similation")
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
    
    func defaultLyaout() {
        modelChangeView.layer.shadowColor = UIColor.black.cgColor
        modelChangeView.layer.shadowOpacity = 0.25
        modelChangeView.layer.shadowRadius = 4
        modelChangeView.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    func switchSimilateView(name: String) {
        let button = UIButton()
        switch name {
        case "result":
            hairImgview.isHidden = true
            colorChangerView.isHidden = true
            self.navigationItem.title = "判定結果"
            button.setImage(UIImage(named: "close"), for: .normal)
            button.addTarget(self, action: #selector(SimilationVC.backTopView), for: .touchUpInside)
        case "similation":
            hairImgview.isHidden = false
            colorChangerView.isHidden = false
            self.navigationItem.title = "シミュレーション"
            button.setImage(UIImage(named: "back"), for: .normal)
            button.addTarget(self, action: #selector(SimilationVC.backResultView), for: .touchUpInside)
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
        switchSimilateView(name: "result")
    }
    
    func setModelHairView() {
        hairImgScrollview.frame = CGRect(x:0, y:0, width: userImageview.frame.width, height: userImageview.frame.height)
        hairImgScrollview.maximumZoomScale = 2.0
        hairImgScrollview.minimumZoomScale = 0.5
        hairImgScrollview.bounces = false
        hairImgScrollview.showsHorizontalScrollIndicator = false
        hairImgScrollview.showsVerticalScrollIndicator = false
        hairImgScrollview.contentSize = CGSize(width: 800, height: 800)
        let midOffsetX = (800 - hairImgScrollview.frame.width)/2
        let midOffsetY = (800 - hairImgScrollview.frame.height)/2
        hairImgScrollview.contentInset = .init(top: midOffsetY,
                                        left: midOffsetX,
                                        bottom: midOffsetY,
                                        right: midOffsetX)
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
    
    func setHairColorChanger() {
        let colorList: [String] = ["#6D4F4D", "#160803", "#321F10", "#3B291B", "#5E3A37", "#5A442F", "#706B67", "#BDBDBD"]

        colorChangerView.frame = CGRect(x: 0, y: similateView.frame.height-88, width: similateView.frame.width, height: 88)
        similateView.addSubview(colorChangerView)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.frame = CGRect(x: 12, y: 0, width: 44, height: 24)
        titleLabel.text = "カラー"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        colorChangerView.addSubview(titleLabel)
        
        let closeBt: switchColorBt = switchColorBt()
        closeBt.frame = CGRect(x: titleLabel.frame.maxX+10, y: 0, width: 60, height: 24)
        closeBt.setTitle("< 閉じる", for: .normal)
        closeBt.setTitleColor(UIColor.black, for: .normal)
        closeBt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        closeBt.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left


        closeBt.colorList = colorList
        closeBt.color = "#6D4F4D"
      
        closeBt.addTarget(self, action: #selector(SimilationVC.switchColorView), for: .touchUpInside)
        colorChangerView.addSubview(closeBt)
        
        setColorListView(colorList: colorList, senderBt: closeBt)
    }
    
    @objc func switchColorView(_ sender: switchColorBt) {
        if isFold {
            setColorListView(colorList: sender.colorList, senderBt: sender)
            isFold = false
        } else {
            setFolodColorView(color: sender.color, senderBt: sender)
            isFold = true
        }
    }
    
    func setColorListView(colorList: [String], senderBt: switchColorBt) {
        colorListScrollview.isHidden = false
        colorView.isHidden = true
        senderBt.setTitle("< 閉じる", for: .normal)
        colorListScrollview.frame = CGRect(x: 12, y: (colorChangerView.frame.height-48)-10, width: similateView.frame.width, height: 48)
        colorListScrollview.contentSize = CGSize(width: (48+12)*colorList.count, height: 48)
        colorListScrollview.showsHorizontalScrollIndicator = false
        colorListScrollview.showsVerticalScrollIndicator = false
        colorChangerView.addSubview(colorListScrollview)
        
        for (i, color) in colorList.enumerated() {
            let changeColorBt: UIButton = UIButton()
            changeColorBt.backgroundColor = UIColor(hex: color)
            changeColorBt.frame = CGRect(x: CGFloat((48+12)*i), y: 0, width: 48, height: 48)
            changeColorBt.layer.cornerRadius = changeColorBt.frame.width/2
            changeColorBt.addTarget(self, action: #selector(SimilationVC.checkColorBt), for: .touchUpInside)
            colorListScrollview.addSubview(changeColorBt)
        }
    }
    
    func setFolodColorView(color: String, senderBt: switchColorBt) {
        colorListScrollview.isHidden = true
        colorView.isHidden = false
        senderBt.setTitle(">", for: .normal)
        colorView.backgroundColor = UIColor(hex: color)
        colorView.frame = CGRect(x: 12, y: (colorChangerView.frame.height-48)-10, width: 48, height: 48)
        colorView.layer.cornerRadius = colorView.frame.width/2
        colorChangerView.addSubview(colorView)
    }
    
    @objc func checkColorBt(_ sender: UIButton) {
        for subview in sender.subviews {
            subview.removeFromSuperview()
        }
        colorCheckImgview.image = UIImage(named: "colorCheck")
        colorCheckImgview.frame = CGRect(x: 12, y: 16, width: sender.frame.width-24, height: sender.frame.height-32)
        sender.addSubview(colorCheckImgview)
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
        var hex: String = hex
        if hex.contains("#") {
            hex = hex.replace("#", "")
        }
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

extension String {
    func replace(_ from: String,_ to: String) -> String {
        var replacedString = self
        replacedString = replacedString.replacingOccurrences(of: from, with: to)

        return replacedString
    }
}


class switchColorBt:UIButton {
    var colorList: [String] = []
    var color: String = ""
}
