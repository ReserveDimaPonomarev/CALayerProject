//
//  SecondViewController.swift
//  CALayerProject
//
//  Created by Дмитрий Пономарев on 21.03.2023.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 5
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            shapeLayer.strokeColor = UIColor.white.cgColor
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeColor = UIColor.red.cgColor
            overShapeLayer.lineCap = .round
            overShapeLayer.lineWidth = 10
            overShapeLayer.strokeEnd = 0
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
//            imageView.layer.borderWidth = 10
            let borderColor = UIColor.green
//            imageView.layer.borderColor = borderColor.cgColor
            imageView.image = UIImage(named: "second")
            imageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var button: UIButton! {
        didSet {
            let shadowCOlor = UIColor.yellow
            button.layer.shadowColor = shadowCOlor.cgColor
            button.layer.shadowRadius = 40
            button.layer.shadowOpacity = 0.7
            button.layer.shadowOffset = .zero
            button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeShapeLayer()
//        configShapeLayer(shapeLayer: shapeLayer)
        configShapeLayer(shapeLayer: overShapeLayer)
        
    }
    func makeShapeLayer() {
//        shapeLayer = CAShapeLayer()
        overShapeLayer = CAShapeLayer()
//        view.layer.addSublayer(shapeLayer)
        view.layer.addSublayer(overShapeLayer)
    }
    
    func configShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        var path = UIBezierPath()
        path = UIBezierPath(arcCenter: CGPoint(x: imageView.bounds.maxX + 15, y: imageView.frame.midY), radius: imageView.frame.width / 2, startAngle: 0, endAngle: 7, clockwise: true)
        shapeLayer.path = path.cgPath
    }
    
    @IBAction func tapOnButtonBack(_ sender: UIButton) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        overShapeLayer.add(animation, forKey: animation.keyPath)
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "goPreviousVC", sender: self)
    }
}

