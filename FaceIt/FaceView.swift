//
//  FaceView.swift
//  FaceIt
//
//  Created by PeterDing on 2017/9/19.
//  Copyright © 2017年 DinDin. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {

    @IBInspectable
    var scale: CGFloat = 0.8
    
    @IBInspectable
    var lineWidth: CGFloat = 5
    
    @IBInspectable
    var isEyesOpen: Bool = true
     @IBInspectable
    var mouthCurve: Double = 0.5
    
     @IBInspectable
    var eyesOffset: CGFloat = 3
     @IBInspectable
    var eyesRadius: CGFloat = 10
     @IBInspectable
    var mouthHeightOfSkull: CGFloat = 4
     @IBInspectable
    var mouthWidthtOfSkull: CGFloat = 1
     @IBInspectable
    var mouthOffSetOfSkull: CGFloat = 3
    
    var skullRaduis: CGFloat {
        return min(bounds.width, bounds.height) / 2 * scale
    }
    
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
   private enum Eyes {
        case left
        case right
    }
    
    private func pathForEye(_ eyes: Eyes) -> UIBezierPath {
        
        func centerOfEyes(_ eyes: Eyes) -> CGPoint {
            
        let eyeOffset = skullRaduis / eyesOffset
        var eyesCenter: CGPoint = skullCenter
        eyesCenter.y -= eyeOffset
        eyesCenter.x += (eyes == .left ? -1 : 1 ) * eyeOffset
        return eyesCenter
        }
        
        let eyeCenter = centerOfEyes(eyes)
        let path = UIBezierPath()
        
        if  isEyesOpen {
        path.addArc(withCenter: eyeCenter, radius: eyesRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)

        } else {
            path.move(to: CGPoint(x: eyeCenter.x - eyesRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyesRadius, y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = skullRaduis / mouthWidthtOfSkull
        let mouthHeight =  skullRaduis / mouthHeightOfSkull
        let mouthOffest = skullRaduis / mouthOffSetOfSkull
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffest, width: mouthWidth, height: mouthHeight)
        
        let smileOffSet: CGFloat = CGFloat(max(-1, min(mouthCurve, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width/3 , y: mouthRect.midY + smileOffSet)
         let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width/3 , y: mouthRect.midY + smileOffSet)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    
        
    }
    
    private func pathForSkull() -> UIBezierPath {
        
        let path = UIBezierPath()
       
        path.addArc(withCenter: skullCenter, radius: skullRaduis, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
         pathForEye(.right).stroke()
        pathForMouth().stroke()
       
    }
    
}
