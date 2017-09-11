//
//  PostMomentViewController.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import Qiniu
import RxSwift

class PostMomentViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var momentContentTextView: UITextView!
    @IBOutlet weak var momentImageCollectionView: UICollectionView!
    
    
    let disposeBag = DisposeBag()
    
    
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
    
    //MARK: - Action
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        
        logger.log("按下发布（点滴）按钮")
        
        guard let content = momentContentTextView.text else { return }
        
        
        Observable<UIImage>.from(uploadedImages)
            .concatMap {
                (image: UIImage) -> Observable<String> in
                let result: Observable<String> = QiniuProvider.shared.upload(data: UIImagePNGRepresentation(image)!)
                return result
            }
            .map {
                (key) -> Media in
                logger.log(key)
                let domain = "http://osg5c99b1.bkt.clouddn.com/" // FIXME
                return Media(type: .Image, url: URL(string: domain + key))
            }
            .reduce([Media]()) {(medias, media) in
                var mutableMedias = medias!
                mutableMedias.append(media)
                logger.log(mutableMedias.debugDescription)
                return mutableMedias
            }
            .flatMap {
                medias in
                return MeowAPIProvider.shared.request(.postMoment(content: content, medias: medias))
            }
            .subscribe(onNext:{
                [weak self] _ in
                logger.log("[Success] Post moment.")
                self?.navigationController!.popTwice(animated: true)
            })
            .addDisposableTo(disposeBag)
  
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        logger.log("按下取消（发布点滴）按钮")
        
        self.navigationController!.popTwice(animated: true)
        
    }
    
}
extension PostMomentViewController: UICollectionViewDataSource, UINavigationControllerDelegate {
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
}

extension PostMomentViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        uploadedImages.append(selectedImage)
    
        dismiss(animated: true, completion: nil)
        
        momentImageCollectionView.reloadData()
    }
}

extension PostMomentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // response to tapping at the add button
        if indexPath.row >= uploadedImages.count {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            
            present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension PostMomentViewController: UITextViewDelegate {

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
}

