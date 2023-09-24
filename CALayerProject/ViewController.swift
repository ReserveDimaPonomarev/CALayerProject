//
//  ViewController.swift
//  CALayerProject
//
//  Created by Дмитрий Пономарев on 21.03.2023.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 20
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = UIColor(red: 60/255, green: 90/255, blue: 180/255, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 20
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
            let color = UIColor.white.cgColor
            overShapeLayer.strokeColor = color
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = UIColor(red: 85/255, green: 176/255, blue: 236/255, alpha: 1).cgColor
            let endColor = UIColor(red: 64/255, green: 114/255, blue: 151/255, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
            gradientLayer.locations = [0, 0.5]
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.image = UIImage(named: "first")
            let borderColor = UIColor.white
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = 10
        }
    }
    @IBOutlet weak var buttom: UIButton! {
        didSet {
            buttom.layer.shadowOffset =  CGSize(width: 10, height: 20)
            buttom.layer.shadowOpacity = 0.5
            buttom.layer.shadowRadius = 10
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.height)
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
        
        func configShapeLayer(_ shapeLayer: CAShapeLayer) {
            shapeLayer.frame = view.bounds
            let path = UIBezierPath()
            path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
            path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
            shapeLayer.path = path.cgPath
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeGradient()
        makeShapeLayer()
        
    }
    func makeGradient() {
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func makeShapeLayer() {
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
    }
    
    @IBAction func tapOnButton(_ sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        
        overShapeLayer.add(animation, forKey: nil)
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "ShowSecondVc", sender: self)
        
    }
    
}




