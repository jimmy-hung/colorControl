

import UIKit
import QuartzCore

class SecondViewController: UIViewController
{
    @IBOutlet weak var sunImage: UIImageView!
    
    @IBOutlet weak var backName: UIButton!
    
    var FV:ViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        backName.center.y -= view.bounds.width
        UIView.animate(withDuration: 2.0, delay: 0.1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.3,
                       options: [], animations: {
                        self.backName.center.y += self.view.bounds.width
        }, completion: nil)
        
        
//        animateTheClouds(cloud: sunImage)
        
        UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
            self.sunImage.alpha = 0.1
        }, completion: nil)

    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        UIView .animate(withDuration: 3.5) {
            self.view.backgroundColor = self.FV.rectColor.backgroundColor
            
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.midX, y: self.view.frame.midY), radius: 120, startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
            
            let animation = CAKeyframeAnimation(keyPath: "position");
            animation.duration = 5
            animation.repeatCount = MAXFLOAT
            animation.path = circlePath.cgPath
            
            let moon = UIImageView()
            moon.frame = CGRect(x:0, y:0, width:40, height:40);
            moon.image = UIImage(named: "moon")
            self.view.addSubview(moon)
            moon.layer.add(animation, forKey: nil)
            
            
        }
        
    }
    
    @IBAction func effectA(_ sender: UIButton)
    {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 120, startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position");
        animation.duration = 5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let moon = UIImageView()
        moon.frame = CGRect(x:0, y:0, width:40, height:40);
        moon.image = UIImage(named: "ball")
        view.addSubview(moon)
        moon.layer.add(animation, forKey: nil)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1)
        {
            self.createFire()
        }
    }
    
    
    @IBAction func effectB(_ sender: UIButton)
    {
        createParticles()
    }
    
    @IBAction func effectC(_ sender: UIButton)
    {
        
    }
    
    
    func createFire()
    {
        let fireEmitter = CAEmitterLayer()
        fireEmitter.emitterPosition = CGPoint(x: 200, y: 650)  // 200  500
        fireEmitter.emitterSize = CGSize(width: 300, height: 1000); // 150 10
        fireEmitter.renderMode = kCAEmitterLayerAdditive;
        fireEmitter.emitterShape = kCAEmitterLayerLine
        fireEmitter.emitterCells = [createFireCell()];
        
        self.view.layer.addSublayer(fireEmitter)
    }
    
    func createFireCell() -> CAEmitterCell
    {
        let fire = CAEmitterCell();
        fire.alphaSpeed = -0.35 ; // -0.3
        fire.birthRate = 800; //600
        fire.lifetime = 600; // 60.0
        fire.lifetimeRange = 0.5  // 0.5
        fire.color = UIColor(red: 204 / 255, green: 102 / 255, blue: 51 / 255, alpha: 0.6).cgColor
        fire.contents = UIImage(named: "fire")?.cgImage
        fire.emissionLongitude = CGFloat(M_PI);
        fire.velocity = 110; // 80
        fire.velocityRange = 8; // 5
        fire.emissionRange = 0.5; // 0.5
        fire.yAcceleration = -260; // -200
        fire.scaleSpeed = 0.00005; // 0.3
        
        return fire
    }
    
    func createParticles() {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.contentMode = UIViewContentMode.scaleAspectFill
        view.image = UIImage(named: "landscape")

        self.view.addSubview(view)

        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        let flake = makeEmitterCell()

        cloud.emitterCells = [flake]

        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 8
        cell.birthRate = 4
        cell.lifetime = 50.0
        cell.velocity = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.5
        cell.spinRange = 1.2
        cell.scaleRange = -0.05
        cell.contents = UIImage(named: "snow")?.cgImage
        
        return cell
    }
    
    func animateTheClouds(cloud : UIImageView) {
        let cloudMovingSpeed = 60.0/view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudMovingSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.5, options: .curveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }, completion: {_ in
            cloud.frame.origin.x = -cloud.frame.size.width
            self.animateTheClouds(cloud: cloud)
        })
    }
 
    @IBAction func btnBack(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
