//
//  CollectionViewActivityIndicator.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/4/21.
//

import UIKit

final class ActivityIndicatorView: UIView {
    
    //MARK: - Properties
    
    private let spinningCircle = CAShapeLayer()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        frame = CGRect(x: -12.5, y: 12.5, width: 25, height: 25)
        
        let rect = bounds
        let circlePath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circlePath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = UIColor.systemRed.cgColor
        spinningCircle.lineWidth = 3
        spinningCircle.strokeEnd = 0.25
        spinningCircle.lineCap = .round
        
        layer.addSublayer(spinningCircle)
        animate()
    }
    
    private func animate() {
        isHidden = true
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in
                self.animate()
            }
        }
    }
    
    ///Start animation
    public func start() {
        isHidden = false
    }
    
    ///Stop animation
    public func stop() {
        layer.removeAllAnimations()
        isHidden = true
    }
}


