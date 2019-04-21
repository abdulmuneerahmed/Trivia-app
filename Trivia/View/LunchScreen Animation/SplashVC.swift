//
//  SplashViewController.swift
//  Trivia
//
//  Created by admin on 18/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK: - Constants -
    private let pulselayer = CAShapeLayer()
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addSubViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 169/255, alpha: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startPulse()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var brandLogo:UIImageView = {
        let brandImage = UIImageView()
        brandImage.image = UIImage(named: "Splash")
        brandImage.layer.cornerRadius = 5
        brandImage.clipsToBounds = true
        brandImage.translatesAutoresizingMaskIntoConstraints = false
        brandImage.contentMode = .scaleAspectFit
        return brandImage
    }()
    
    fileprivate lazy var brandTitle:UILabel = {
        let brandLabel = UILabel()
        brandLabel.textColor = .white
        brandLabel.text = "Trivia"
        brandLabel.font = UIFont(name: "Avenirnext-Heavy", size: 20)
        brandLabel.textAlignment = .center
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        return brandLabel
    }()
    
    // MARK: - custom functions -
    private func addSubViews(){
        activateLogoConstraints()
        activateLabelConstraints()
    }
    
    private func activateLogoConstraints(){
        view.addSubview(brandLogo)
        NSLayoutConstraint.activate([
            brandLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            brandLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
             brandLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            brandLogo.heightAnchor.constraint(equalTo: brandLogo.widthAnchor)
           
            ])
    }
    
    private func activateLabelConstraints(){
        view.addSubview(brandTitle)
        NSLayoutConstraint.activate([
            brandTitle.topAnchor.constraint(equalTo: brandLogo.bottomAnchor, constant: 20),
            brandTitle.leadingAnchor.constraint(equalTo: brandLogo.leadingAnchor, constant: 0),
            brandTitle.trailingAnchor.constraint(equalTo: brandLogo.trailingAnchor, constant: 0),
            brandTitle.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func deactiveConstraints(){
        brandLogo.removeFromSuperview()
        brandTitle.removeFromSuperview()
    }
    
    private func startPulse(){
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(animation), userInfo: nil, repeats: false)
    }
    
    private func createPulse(){
        
        let circlePath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.height/2 + (view.frame.width/3)/2, startAngle: 0, endAngle: view.frame.size.height/2, clockwise: true)
        
        pulselayer.path = circlePath.cgPath
        pulselayer.lineWidth = 10.0
        pulselayer.fillColor = UIColor(red: 37/255, green: 42/255, blue: 64/255, alpha: 1).cgColor
        pulselayer.strokeColor = UIColor(red: 255/255, green: 0/255, blue: 169/255, alpha: 1).cgColor
        pulselayer.lineCap = CAShapeLayerLineCap.square
        pulselayer.position = view.center
        view.layer.addSublayer(pulselayer)
        
        animate()
    }
    
   private func animate(){
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.duration = 0.40
        anim.fromValue = 0.0
        anim.toValue  = 0.9
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        pulselayer.add(anim, forKey: "scale")
        
    }
    
    // MARK: - Selectors -
    @objc func animation(){
        UIView.animate(withDuration: 0.2, animations: {
            self.createPulse()
            self.deactiveConstraints()
            self.activateLogoConstraints()
            self.activateLabelConstraints()
        }) { (_) in
            Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.rootViewController), userInfo: nil, repeats: false)
        }
    }
    
    @objc func rootViewController(){
        UIApplication.shared.keyWindow?.rootViewController = MainVC()
    }
    

}
