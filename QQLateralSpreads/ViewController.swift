//
//  ViewController.swift
//  QQLateralSpreads
//
//  Created by zhaoP on 16/6/13.
//  Copyright © 2016年 langya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var homeViewController:HomeViewController!
    var distance:CGFloat = 0
    let fullDistace:CGFloat = 0.78
    let proportion:CGFloat = 0.77
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "2cd0afc"))
        imageView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(imageView)
        
        homeViewController = HomeViewController.init()
        let panG = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        homeViewController.view.addGestureRecognizer(panG)
        homeViewController.view.backgroundColor = UIColor.redColor()
        self.view.addSubview(homeViewController.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func pan(panG:UIPanGestureRecognizer) -> Void {
        let x = panG.translationInView(self.view).x
        let trueDistance = distance + x
        
        print("\(trueDistance)")
        if panG.state == .Ended {
            if trueDistance > Common.screenWidth * (proportion / 3) {
                showLeft()
            }else if trueDistance < Common.screenWidth * (-proportion / 3){
                showRight()
            }else{
                showHome()
            }
            return;
        }
        
        // 计算缩放比例
        var prop: CGFloat = fabs(trueDistance) / (Common.screenWidth*fullDistace)
        prop = 1 - prop
        self.homeViewController.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y)
        if prop <= proportion { // 若比例已经达到最小，则不再继续动画
            return
        }


        self.homeViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, prop, prop)
    }
    
    func showLeft() -> Void {
        UIView.animateWithDuration(0.3) { 
            self.homeViewController.view!.center = CGPointMake(self.view!.center.x + Common.screenWidth * self.proportion, self.view!.center.y)
            self.homeViewController.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportion, self.proportion)
        }
        
    }
    
    func showRight() -> Void {
        UIView.animateWithDuration(0.3) {
            self.homeViewController.view!.center = CGPointMake(self.view!.center.x - Common.screenWidth * self.proportion, self.view!.center.y)
            self.homeViewController.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportion, self.proportion)
        }
        
    }
    
    func showHome() -> Void {
        UIView.animateWithDuration(0.3) {
            self.homeViewController.view!.center = CGPointMake(self.view!.center.x , self.view!.center.y)
            self.homeViewController.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

