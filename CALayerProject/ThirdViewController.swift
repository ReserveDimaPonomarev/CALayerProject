//
//  ThirdViewController.swift
//  CALayerProject
//
//  Created by Дмитрий Пономарев on 21.03.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    var replicatorLayer: CAReplicatorLayer!
    var sourceLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        startAnimation(delay: 0.1, replicator: 10)
        
    }
    
    override func viewWillLayoutSubviews() {
        replicatorLayer.frame = self.view.bounds
        replicatorLayer.position = self.view.center
        sourceLayer.frame = CGRect(x: 0, y: 0, width: 3, height: 10)
        sourceLayer.backgroundColor = UIColor.white.cgColor
        sourceLayer.position = self.view.center
        sourceLayer.anchorPoint = CGPoint(x: 0, y: 2)
    }
    
    func startAnimation(delay: TimeInterval, replicator: Int) {
        replicatorLayer.instanceCount = replicator
        let angle = CGFloat(2.0 * .pi) / CGFloat(replicator)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 2)
        replicatorLayer.instanceDelay = delay
        sourceLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicator) * delay
        opacityAnimation.repeatCount = Float.infinity
        sourceLayer.add(opacityAnimation, forKey: nil)
    }

}
