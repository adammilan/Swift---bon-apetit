//
//  PostViewController.swift
//  assigment3
//
//  Created by admin on 22/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController, UITextFieldDelegate,  UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //we put it on start so we will have enoguh time to make auth and get his name for the fire base database we cant use user.DisplayName cuz they have bug and its not working so we have to go fb and take it from there
        if let user = FIRAuth.auth()?.currentUser {
            
            print(user.email)
            print (user.displayName)
            
                UserFirebase.instance.getUserByUid(uid: user.uid, callback: { (user) in
                print("user \(user.username) already connected")
                self.useraccountname = user.username
                
                    self.emailUser = user.email //this is for saving the user  posted photo image for firebase we choose save as email because its uniqe
                    
               self.userImageFromFile = Model.instance.getImageFromFileLocal(name: user.email! + (".jpg"))
            })
            
        }
        
    }
    
    var emailUser:String?

    var userImageFromFile: UIImage?
    
    var useraccountname:String?
    
    @IBOutlet weak var postImageUser: UIImageView!
    
    @IBOutlet weak var contentPostTextField: UITextView!
    
    @IBOutlet weak var savePostButton: UIBarButtonItem!
    
    
    var post: Post?
    
    @IBAction func cancel(_ sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func userImagePost(_ sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            
            postImageUser.image = image
   
            
        }else{
            
            print("There was a problem with getting the image")
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
        
  
    
    var postImageURL1:String?
 
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//        
//        alert.view.tintColor = UIColor.black
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        
//        
//        alert.view.addSubview(loadingIndicator)
//        self.present(alert, animated: true, completion: nil)
   
        
        if sender as AnyObject? === savePostButton {
            
       
            
            let username = useraccountname ?? ""
            let content = contentPostTextField.text ?? ""
            let postImage = postImageUser.image
            let userImage = userImageFromFile //this is the imageFrom file we already took
            
            //set the post to be passed to PostsTableViewController after the unwind segue
            

          // let postId = "\(FIRAuth.auth()!.currentUser!.uid)\(NSUUID().uuidString)"
            
            let postImageId = "\(FIRAuth.auth()!.currentUser!.uid)\(NSUUID().uuidString)"
            
            
  
            
            //1.saving the postimage to firebase with ranodom postImageid
            
            PostFireBase.instance.saveImageToFirebase(image: postImage!, name: postImageId + (".jpg") , callback: { (url) in
        
            print ("url: \(url)")
        
            self.postImageURL1 = url //saving the image post of the URL and then we save it to the post db (in firebase)
        
        
        
        
        if let userPost = FIRAuth.auth()?.currentUser {
            
           // let userPotoURL = String(describing: userPost.photoURL) // NOT Working.casting beacuse userPost.PhotoURL is type "URL" -> so we cast to String
    
            //we go seraching the user and we take the userPhotoURL
            
            UserFirebase.instance.getUserByUid(uid: userPost.uid, callback: { (user) in
                
                
                
                    print ("user: \(user.username)")
                    print ("user \(user.email)")
 
                    print("user: \(user.userPhotoURL) ")
                
                
                self.post = Post(username: username, content: content, userimageURL: user.userPhotoURL, postImageURL: self.postImageURL1, email:userPost.email)
                
     
                PostFireBase.instance.addPost(post:userPost,st: self.post!)
                
            })
            

            
        }
})
            
        }
        
        
        
    }
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
