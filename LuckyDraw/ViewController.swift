//
//  ViewController.swift
//  LuckyDraw
//
//  Created by sqluo on 2016/11/21.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,CAAnimationDelegate{

    fileprivate var luckyView: LuckyView!
    fileprivate var btn: UIButton!
    
    fileprivate var labPrise: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let rect = CGRect(x: (self.view.frame.width - 260) / 2, y: 100, width: 260, height: 260)
        let items = ["一","没有","二","没有","三","没有"]
        
        luckyView = LuckyView(frame: rect, items: items)
        
        luckyView.backgroundColor = UIColor.white
        
        self.view.addSubview(luckyView)
        
        
        
        labPrise = UILabel(frame: CGRect(x: (self.view.frame.width - 200) / 2, y: self.view.frame.height - 200 - 20 , width: 200, height: 20))
        labPrise.font = UIFont.systemFont(ofSize: 15)
        labPrise.textAlignment = .center
        labPrise.textColor = UIColor.green
        
        self.view.addSubview(labPrise)
        
        
        btn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: self.view.frame.height - 80 - 100, width: 80, height: 35))
        
        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        btn.setTitle("开始测试", for: UIControlState())
        
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
        
        
        
        
    }
    
    func btnAct(send: UIButton){
        
        btn.setTitle("抽奖中", for: UIControlState())
        labPrise.text = "中奖结果:"+"等待开奖结果"
        btn.isEnabled = false
        
        
        
        var angle = 0
        
        //100以内数字
        let randomNum = arc4random()%100
        
        print(randomNum)
        
//        randomNum = 95
        
        if randomNum >= 91 && randomNum <= 99 {
            angle = 300 + 720
            //测试一
            self.strPrise = "一"
        }else if randomNum >= 76 && randomNum <= 90 {
            angle = 180 + 720
            //测试3
            self.strPrise = "二"
        }else if randomNum >= 51 && randomNum <= 75 {
            angle = 60 + 720
            //测试二
            self.strPrise = "三"
        }else{
            
            angle = 240 + 720
            //其他
            self.strPrise = "其他"
        }
        
        
        let rotation = CGFloat(Double(angle) * M_PI / 180)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.duration = 3
        rotationAnimation.toValue = rotation
        rotationAnimation.isCumulative = true
        rotationAnimation.delegate = self
        rotationAnimation.fillMode=kCAFillModeForwards
        rotationAnimation.isRemovedOnCompletion = false
        
        luckyView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
        
        
        
    }
    
    var strPrise = ""
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.labPrise.text = "中奖结果:" + self.strPrise
        self.btn.setTitle("开始抽奖", for: UIControlState())
        self.btn.isEnabled = true
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

