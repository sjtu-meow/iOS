//
//  MyFollowingViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/20.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MyFollowingViewController: UIViewController {
    
    enum ContentType: Int { case user = 0, question = 1 }
    
    var contentType = ContentType.user
    
    @IBOutlet weak var tableView: UITableView!
    
    var questions = [QuestionSummary]()
    var users = [Profile]()
    
    let disposeBag = DisposeBag()
    
    @IBAction func switchContent(_ sender: Any) {
        let control = sender as! UISegmentedControl
        let raw = control.selectedSegmentIndex
        contentType = ContentType(rawValue: raw)!
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.userRecordTableViewCell)
        tableView.register(R.nib.questionTableViewCell)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadFollowing()
        self.tableView.reloadData()
    }
    
    func loadData() {
        MeowAPIProvider.shared.request(.myFollowingUsers)
        .mapTo(arrayOf: Profile.self)
            .subscribe(onNext: {
                [weak self]
                items in
                self?.users.append(contentsOf: items)
                self?.tableView.reloadData()
            })
        .addDisposableTo(disposeBag)
        MeowAPIProvider.shared
            .request(.myFollowingQuestions)
            .mapTo(arrayOf: QuestionSummary.self)
            .subscribe(onNext: {
                [weak self]
                items in 
                self?.questions.append(contentsOf: items)
                self?.tableView.reloadData()
            })
        .addDisposableTo(disposeBag)
    }
    
    // for following reloading
    func reloadFollowing() {
        MeowAPIProvider.shared.request(.myFollowingUsers)
            .mapTo(arrayOf: Profile.self)
            .subscribe(onNext: {
                [weak self]
                items in
                self?.users = items
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
        MeowAPIProvider.shared
            .request(.myFollowingQuestions)
            .mapTo(arrayOf: QuestionSummary.self)
            .subscribe(onNext: {
                [weak self]
                items in
                self?.questions = items
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
}

extension MyFollowingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentType == .user {
            return users.count
        }
        return questions.count 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contentType == .user {
            let model = users[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userRecordTableViewCell)!
            view.delegate = self
            view.configure(model: model)
            
            return view 
        }
        
        else {
            let model = questions[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionTableViewCell)!
            view.configure(model: model)
            //view.delegate = self
            return view 
        }
    }
}

extension MyFollowingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if contentType == .question {
            let question = questions[indexPath.row]
            QuestionDetailViewController.show(question.id, from: self)
        }
        else {
            let user = users[indexPath.row]
            UserProfileViewController.show(user, from: self)
        }
    }
}

extension MyFollowingViewController: UserRecordTableViewCellDelegate {
    func didTapAvatar(profile: Profile) {
        UserProfileViewController.show(profile, from: self)
    }
    func didClickUnfollow(profile: Profile) {
        MeowAPIProvider.shared
            .request(.unfollowUser(id: profile.userId))
            .subscribe(onNext: {
                [weak self] _ in
                if let index = self?.users.index(where: { other in other.userId == profile.userId}) {
                    self?.users.remove(at: index)
                    self?.tableView.reloadData()
                }
            })
            .addDisposableTo(disposeBag)
    }
}
