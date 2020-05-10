//
//  ViewController.swift
//  KoreanMaster
//
//  Created by Kayla Williams on 5/10/20.
//  Copyright © 2020 Kayla Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func levelOne() {
             let vc = storyboard?.instantiateViewController(identifier: "levelOne") as! LevelOneViewController
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true)
      }
}
