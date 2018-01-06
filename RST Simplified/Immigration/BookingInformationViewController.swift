//
//  BookingInformationViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 02/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox




class BookingInformationViewController: UIViewController, ImagePickerDelegate {
    let imagePickerController = ImagePickerController()
    var imagearray  = [UIImage]()
    
    @IBOutlet var notesAboutWhyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        let myColor = UIColor.lightGray
        notesAboutWhyTextView.layer.borderWidth = 0.5
        notesAboutWhyTextView.layer.cornerRadius = 5
        notesAboutWhyTextView.layer.borderColor = myColor.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitRequest(_ sender: UIButton) {
       self.performSegue(withIdentifier: "paymentSummary", sender: self)
    }
    @IBAction func uploadDocumentButton(_ sender: UIButton) {
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }

        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)

    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagearray = images
       
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
         imagePicker.dismiss(animated: true, completion: nil)
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
