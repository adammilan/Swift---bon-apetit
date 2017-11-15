//
//  LoginViewController.swift
//  assigment3
//
//  Created by admin on 20/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    
    
    var segueShouldOccur = false
    var loginUsername: String?
    
    var enterPhotoURL:String?
    
    @IBAction func LoginButton(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == ""
        {
            
            let alertController = UIAlertController(title: "Oops!", message: "please enter email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController,animated: true,completion: nil)
        }else {
            
            
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            alert.view.tintColor = UIColor.black
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true, completion: nil)
            
            
            
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
            
                ////if error == nill , all ok the user can enter
                if error == nil {
                    
        
                    
                    if let user = user{
                        
                        
                        UserFirebase.instance.getUserByUid(uid: user.uid, callback: { (user) in
                            
                            print ("user : \(user.username)")
                      
                            self.loginUsername = user.username
                            print("good")
                            
                            self.segueShouldOccur = true
                            
                            self.enterPhotoURL = user.userPhotoURL //this is for the FB if the photo dont exist local, so in "prepare" func we go and take it from fb
                            
                            self.performSegue(withIdentifier: "Login", sender: self)
                            
                        })
                        
                    }
                  
              
                }else{
                    
                    
                    self.dismiss(animated: false, completion: nil) //this is for the spining circle "Loading.."
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController,animated: true,completion: nil)
                    
                    
                }
                
                
                
            })
            
        
        
    }
    
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Login" {
            
            
            //not enter wait for auth for firebase first
            if !segueShouldOccur {
                print("*** NOPE, segue wont occur")
                return false
            }
            else {
                print("*** YEP, segue will occur")
            }
        }
        
        
        dismiss(animated: false, completion: nil) //this is for the spining circle "Loading.."

        // by default, transition
        return true
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == "Login" {
 
            
            let tabBarController: UITabBarController = segue.destination as! UITabBarController
            
            
            if let tabBarViewControllers = tabBarController.viewControllers {
                let btTableController = tabBarViewControllers[0] as! AboutViewController
                

                btTableController.welcome = loginUsername!
            
                btTableController.enterphotoURL = self.enterPhotoURL //this is for the FB function at viewdidLoad (AboutViewControler)
                
                var style4 = self.emailTextField.text! + (".jpg")
                btTableController.style44 = style4 //this for the "AboutViewControlelr" if there is no photo exist at local so we can save the pic under the exact name(email of the user)
                
                btTableController.userimage = Model.instance.getImageFromFileLocal(name: style4)
                
                
            
        }
        }else{
            
            print ("Somthing went wrong,Try again Later")
      
                
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FIRApp.configure()
        
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "coffe1.jpg")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "HelloAutoLayout1.jpg")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        if let user = FIRAuth.auth()?.currentUser {
            
            print("user already connected")
            
            
        }
        // Do any additional setup after loading the view.
    }

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
  
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
