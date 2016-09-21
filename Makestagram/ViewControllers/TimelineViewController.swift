//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by 廖慶麟 on 2016/9/20.
//  Copyright © 2016年 Make School. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    var photoTakingHelper:  PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takePhoto(){
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            print("received a callback")
        })
    }
}

extension TimelineViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController is PhotoViewController {
            takePhoto()
            return false
        }else {
            return true
        }
    }
}
