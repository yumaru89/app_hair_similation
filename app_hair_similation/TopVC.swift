//
//  ViewController.swift
//  app_hair_similation
//
//  Created by 喜連祐大 on 2020/09/09.
//

import UIKit

class TopVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

