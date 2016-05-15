//
//  HappinessViewController.swift
//  Happiness2
//
//  Created by Марина Звягина on 08.05.16.
//  Copyright © 2016 Марина Звягина. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended, .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness+=happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }
    
    var happiness: Int = 0 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min (max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    
    
    private func updateUI()
    {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    
    func smilinessForFaceView(sendler: FaceView) -> Double? {
        return Double(happiness-50)/50
    }


}
