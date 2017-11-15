//
//  StudentViewController.swift
//  assigment3
//
//  Created by admin on 11/12/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
	
class RestaurantViewController: UIViewController , UITextFieldDelegate,  UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    

    
    
    
    
    @IBOutlet weak var fnameTextField: UITextField!
 
    @IBOutlet weak var lnameTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    
    @IBOutlet weak var mealPhoto: UIImageView!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    //var imageURL:String?
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        //Dismiss the studen scene without storing any information when the studen scene gets dismissed, the studen list is shown
        dismiss(animated: true, completion: nil)
        
    }
    
    
    var restaurant: Restaurant?
    
    
    
    

    //NAVIGATION:
 
    //This method lets you configure a view controlelr before its presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if sender as AnyObject? === saveButton {
            
       
            let fname = fnameTextField.text ?? ""
            let lname = lnameTextField.text ?? ""
            let id:String? = String(idTextField.text ?? "")
            
            let phone:String? = String(phoneTextField.text ?? "")
           
            let image:UIImage? = mealPhoto.image
            
            
            
            
            
            
            //save the image as a file - locally
            var style1 = id! +  (".jpg")
             Model.instance.saveImageToFileLocal(image: image!, name: style1 )
            
            
            
            
   
            //save image to the firebase storage
            
            RestaurantFirebase.instance.saveImageToFirebase(image: image!, name: style1, callback: { (url) in
            
                print("image has been sucsses fully save to firebase at url: \(url)")

                //set the student to be passed to ResturantTableViewController after the unwind segue
                self.restaurant = Restaurant(fname: fname, lname: lname, id: id , phone: phone!,imageURL: url)
                
                
                //save the details to the firebase as json
                Model.instance.addRestaurantToFireBase(st :self.restaurant!)
                
                //set the student to be passed to ResturantTableViewController after the unwind segue
                //  restaurant = Restaurant(fname: fname, lname: lname, id: id , phone: phone!,image: image!)
                
                //save the resturant info local at the db table each resturt we add we need to update the db table
                Model.instance.addRestaurant(st: self.restaurant!)
                
                
                
          
            })

            
            
           
            
            
      
            
       
            
           // print(student?.id)
            
            
        }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //Disave the Save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        checkVaildStudentName()
 //       navigationItem.title = textField.text
        
    }
    
    
    func checkVaildStudentName() {
        
        //Disable the save button if the text field is empty
        
        let text = fnameTextField.text ?? ""
        let text1 = lnameTextField.text ?? ""
        let text2 = idTextField.text ?? ""
        
        
        if !text.isEmpty && !text1.isEmpty && !text2.isEmpty   {
        //saveButton.isEnabled = !text.isEmpty
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
  
        fnameTextField.delegate = self
        lnameTextField.delegate = self
        idTextField.delegate = self
        
        
        //Enable the Save button only if the text field has a vaild student name
        checkVaildStudentName()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addnewPic(_ sender: AnyObject) {
        
        
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            mealPhoto.image = image
        //   stuImage.image = image
            
            
        }else{
            
            print("There was a problem with getting the image")
        }
        
        self.dismiss(animated: true, completion: nil)
        
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



    
