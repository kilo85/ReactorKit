//
//  ViewController.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.red
        

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = NTViewController() // 1. Native ViewController
        
//        let vc = RKViewController() // 2. ReactorKit ViewController
        
        self.present(vc, animated: true)


    }
    
    @IBAction func clickButton(_ sender: Any) {

    }
    
}

