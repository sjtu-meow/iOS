//
//  MeViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/21.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MeViewController: UITableViewController {
    var profile: Profile?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var profileCell: UserProfileCell!
  
    
    override func viewDidLoad() {
        loadData()
        
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.showEditProfileMenu))
        profileCell.addGestureRecognizer(tapAction)

    }
    
    func loadData(){
        MeowAPIProvider.shared
            .request(.myProfile)
            .mapTo(type: Profile.self)
            .subscribe(onNext: {
                [weak self]
                profile in
                self?.profile = profile
                self?.profileCell.configure(model: profile)
            })
            .addDisposableTo(disposeBag)
    
    }

    
    func showEditProfileMenu() {
        guard profile != nil else { return }
        let alert = UIAlertController(title: "编辑个人资料", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let editNicknameAction = UIAlertAction(title: "修改昵称", style: .default) { _ in
            self.editNickname()
        }
        let editBioAction = UIAlertAction(title: "修改简介", style: .default) { _ in
            self.editBio()
        }
        let cancelAction = UIAlertAction(title:"取消", style:.cancel, handler: nil)
        alert.addAction(editNicknameAction)
        alert.addAction(editBioAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func editNickname() {
        let alert = UIAlertController(title: "修改昵称", message: "请输入新的昵称。", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "好", style: .default) { (action) in
            self.profile!.nickname = alert.textFields![0].text!
            self.updateProfile(self.profile!)
        }
        alert.addTextField(configurationHandler: nil)
        ok.isEnabled = true
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func editBio() {
        let alert = UIAlertController(title: "修改个人简介", message: "请输入新的个人简介。", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "好", style: .default) { (action) in
            self.profile!.bio = alert.textFields![0].text!
            self.updateProfile(self.profile!)
        }
        alert.addTextField(configurationHandler: nil)
        ok.isEnabled = true
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateProfile(_ profile: Profile) {
        MeowAPIProvider.shared.request(.updateProfile(profile: profile)).subscribe(onNext: {
            [weak self ]
            _ in
            self?.loadData()
        })
        .addDisposableTo(disposeBag)
        
        
    }
}

extension MeViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //        QiniuProvider.shared.upload(data: UIImagePNGRepresentation(selectedImage))
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
