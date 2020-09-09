//
//  FaceLoadingVC.swift
//  app_hair_similation
//
//  Created by 喜連祐大 on 2020/09/09.
//

import UIKit
import Lottie

class FaceLoadingVC: UIViewController {
    
    var AVView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVView = earthLoadingAnimation(view: self.view)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FaceLoadingVC.toResultVC), userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func toResultVC() {
        self.performSegue(withIdentifier: "toResult", sender: nil)
    }
    
    @IBAction func closeBt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.AVView?.removeFromSuperview()
    }
}


extension UIViewController {
    func earthLoadingAnimation(view: UIView) -> UIView {
        // self.viewにしてみる
        let AVView = UIView.init(frame: CGRect.init(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height))
        AVView.backgroundColor = .black
        AVView.alpha = 0.8
        AVView.contentMode = .scaleAspectFit
        view.addSubview(AVView)
        
        
        let loadingAnimation =  AnimationView(name: "loading")
        let sideLength = view.frame.width - 100
        loadingAnimation.frame = CGRect(x: view.frame.midX - sideLength / 2, y: view.frame.midY - sideLength / 2 , width: sideLength, height: sideLength)
        loadingAnimation.loopMode = .loop
        AVView.addSubview(loadingAnimation)
        
        let earthImageView = UIImageView(frame: loadingAnimation.frame)
        earthImageView.image = UIImage(named: "earth_logo")
        earthImageView.contentMode = .scaleAspectFit
        AVView.addSubview(earthImageView)
        earthImageView.alpha = 0
        
        // animation
        loadingAnimation.play()
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn, .autoreverse, .repeat], animations: {
            earthImageView.alpha = 1.0
        })

        return AVView
    }
}
