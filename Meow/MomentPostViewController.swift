//
//  MomentPostViewController.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MomentPostViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    //MARK: - Properties
    
    @IBOutlet weak var momentContentTextView: UITextView!
    @IBOutlet weak var momentImageCollectionView: UICollectionView!
    
    var uploadedImages = [UIImage]()
    let addButtonImage: UIImage = #imageLiteral(resourceName: "AddImagePlaceholder")
    let momentTextPlaceholder = "说点什么吧"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make lines in text view align on top
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Add fake placeholder to text view
        momentContentTextView.text = momentTextPlaceholder
        momentContentTextView.textColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uploadedImages.count + 1;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get reusable cell from collection view
        let cellIdentifier = "ImagePostCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImagePostCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of ImagePostCollectionViewCell.")
        }
        
        if indexPath.row >= uploadedImages.count {
            cell.imageView.image = addButtonImage
        } else {
            cell.imageView.image = uploadedImages[indexPath.row]
        }
        
        return cell
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Add uploaded image to array
        uploadedImages.append(selectedImage)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        momentImageCollectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // response to tapping at the add button
        if indexPath.row >= uploadedImages.count {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = momentTextPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
    
    //MARK: - Action
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        
        logger.log("按下发布（点滴）按钮")
        
        //TODO: Actual send moment post to server
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        logger.log("按下取消（发布点滴）按钮")
        
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
