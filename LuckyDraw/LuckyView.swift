//
//  LuckyView.swift
//  LuckyDraw
//
//  Created by sqluo on 2016/11/21.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class LuckyView: UIView {

    //奖区
    fileprivate var itemArray = [String]()
    //frame
    fileprivate var myFrame: CGRect!
    //外圆半径
    fileprivate var radiu: CGFloat!
    //线条的宽度
    fileprivate let lineWidth: CGFloat = 1
    //外圆中心点
    fileprivate var arcCenter: CGPoint!
    //每个item的弧度
    fileprivate var oneRadian: CGFloat!
    
    init(frame: CGRect,items: [String]) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellow
        
        self.itemArray = items
        self.myFrame = frame
        
        self.radiu = (frame.width - lineWidth * 2) / 2

        
        self.arcCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        //每个的弧度
        self.oneRadian = CGFloat(M_PI) * 2 / CGFloat(itemArray.count)
        

    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let color = UIColor.red
        color.set()
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: radiu, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        path.lineWidth = lineWidth
        
        path.stroke()
        

        for i in 0..<self.itemArray.count {
            
            let linePath = UIBezierPath()
            
            linePath.lineWidth = lineWidth
            
            linePath.lineCapStyle = .round
            linePath.lineJoinStyle = .round
            
            linePath.move(to: self.arcCenter)
            //第一个从y轴上画,x = 0
            /*
            if i == 0{ //区分下颜色，看看那个是第一个
                let color = UIColor.red
                color.set()
            }else{
                let color = UIColor.blue
                color.set()
            }
            */
            
            let x = radiu + (sin(CGFloat(i) * oneRadian) * radiu) + lineWidth
            
            let y = radiu - (cos(CGFloat(i) * oneRadian) * radiu) + lineWidth

            
            let toPoint = CGPoint(x: x, y: y)
            
            linePath.addLine(to: toPoint)

            linePath.stroke()
            
            
            
            //label
            //label的中心，应该是 oneRadian 的 一半跟 radiu 的位置
            
            
            let labelRadiu = radiu / 2
            let labelOneRadian = oneRadian / 2
            
            let hudu = CGFloat(i) * oneRadian + labelOneRadian
            
            let labelX: CGFloat = radiu + (sin(hudu) * labelRadiu) + lineWidth
            let labelY = radiu - (cos(hudu) * labelRadiu) + lineWidth
            
            
            let labelCent = CGPoint(x: labelX, y: labelY)
            
//            let labelW = radiu / 5 * 3
            let labelW: CGFloat = radiu
            
            let labelH: CGFloat = 18
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelW, height: labelH))
            label.center = labelCent
            
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 11)
            
            label.text = self.itemArray[i]
            
            label.textAlignment = .center
            
            label.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2) + hudu + CGFloat(M_PI))
            
//            label.transform = CGAffineTransform(rotationAngle: hudu)

            
            self.addSubview(label)
            
            
        }
        
    
    }
    
    
   

}
