//
//  SignupViewController.swift
//  assigment3
//
//  Created by admin on 20/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import  Firebase


class SignupViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    
    var segueShouldOccur = false
    
    var userpicURL: String?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    
    @IBOutlet var userImageView: UIImageView!
    
    
    
    @IBAction func userImagePressed(_ sender: AnyObject) {
        
        
        
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            userImageView.image = image
          //  mealPhoto.image = image
            //   stuImage.image = image
            
            
        }else{
            
            print("There was a problem with getting the image")
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func userInfoSaveButton(_ sender: AnyObject) {
        if self.emailTextField.text == "" || self.passwordTextField.text == ""
        {
            
            let alertController = UIAlertController(title: "Oops!", message: "please enter email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController,animated: true,completion: nil)
        }else {
            
            //Create an account

            print ("email: \(self.emailTextField.text)")
            FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                
                if error == nil {
                    
                    print("good")
                    
                    
                    
                    self.segueShouldOccur = true
                    
                    //save the picure of the user to Firebase (and then we save the URL that return and enter this to the database so we can use it later)
                    
                    RestaurantFirebase.instance.saveImageToFirebase(image: self.userImageView.image!, name: self.emailTextField.text! + (".jpg"), callback: { (url) in
                    
                    
                    print("url of the download photo user: \(url)")
                    
                    self.userpicURL = url
                    
                    
                    //save the new account for Firebase ,waiting for the upper function to save the imageof the user and return the userimageurl and then we save it in the firebase
                    //so we need to wait caple of sec to this to finish
                    
                    var userz = User(username: self.usernameTextField.text, email: self.emailTextField.text, password: self.passwordTextField.text, userPhotoURL: url )
                    UserFirebase.instance.addUser(user: user!,st: userz!)
                    
                        print("user has been added to the firebase data")
                    
                })
                    
                   
                    
                    //save the user photo local
                    
                    //this is happend asy so its happend faster then the firebase upper. in the meantime beacuse its callback when it will finish it will just updated and will print the msg above "user has been added to the firebase data"
                    var style3 = self.emailTextField.text! +  (".jpg")
                    
                    Model.instance.saveImageToFileLocal(image: self.userImageView.image!, name: style3)
                    
                    self.performSegue(withIdentifier: "Signup", sender: self)

                    
                   
//                    
           
//                    let next = self.storyboard?.instantiateViewController(withIdentifier: "firstscreen") as! AboutViewController
//                    self.present(next, animated: true, completion: nil)
//                    
                    //0. account has been scusfully created + saved to the FB
                    //1. save the account in firebase
                    //2. move to the bonapette screen with the username gratuated
                    
                    
                }else
                {
                    
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController,animated: true,completion: nil)
                    
                    
                }
                
                
                
            })
            
        }
        
        
        
    }
    
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Signup" {
            
            if !segueShouldOccur {
                print("*** NOPE, segue wont occur")
                return false
            }
            else {
                print("*** YEP, segue will occur")
            }
        }
        
        // by default, transition
        return true
    }
    
  
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "Signup"{
     
        let tabBarController: UITabBarController = segue.destination as! UITabBarController
        
        
        if let tabBarViewControllers = tabBarController.viewControllers {
            let btTableController = tabBarViewControllers[0] as! AboutViewController
        
            
            btTableController.welcome = usernameTextField.text!
            btTableController.userimage = userImageView.image
        }
        
       
        
        
        }else{
            
            print("unwind to Login")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

//        //asdas
//       let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "woodbackground.jpg")
//        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
        
//        if let user = FIRAuth.auth()?.currentUser
//
//        {
//            
//            //self.usernameTextField.text = user.email
//        
//            
//        }else {
//            
//            
//           // self.usernameTextField.text = ""
//            
//        }
//        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
