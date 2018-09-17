

import UIKit

class ThirdViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 120, startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position");
        animation.duration = 5 // 5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let moon = UIImageView()
        let sun  = UIImageView()
        moon.frame = CGRect(x:0, y:0, width:40, height:40);  // 0 0 40 40
        sun.frame = CGRect(x:0, y:0, width:80, height:80)
        moon.image = UIImage(named: "moon.png")
        sun.image = UIImage(named: "sun.png")
        
        view.addSubview(moon)
        view.addSubview(sun)
        sun.layer.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5)
        {
             moon.layer.add(animation, forKey: nil)
        }
       
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backbtn(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
