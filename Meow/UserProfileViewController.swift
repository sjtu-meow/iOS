//
//  UserProfileViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/19.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class UserProfileViewController: UITableViewController {
    enum ContentType: Int {
        case article = 1, moment = 0, questionAnswer = 2
    }
    
    let disposeBag = DisposeBag()
    var userId: Int!
    var contentType = ContentType.moment
    
    // var answers = [AnswerSummary]()
    // var questions = [QuestionSummary]()
    
    var isFollowing = false
    
    var questionAnswers = [ItemProtocol]()
    var articles = [ArticleSummary]()
    var moments = [Moment]()
    var profile: Profile?

    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(R.nib.articleUserPageTableViewCell)
        tableView.register(R.nib.momentHomePageTableViewCell)
        tableView.register(R.nib.questionRecordTableViewCell)
        tableView.register(R.nib.answerRecordTableViewCell)
        
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section <= 1 {
            return profile != nil ? 1: 0
        }
        switch contentType {
        case .article:
            return articles.count 
        case .moment:
            return moments.count 
        case .questionAnswer:
            return questionAnswers.count 
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userProfileWithButtonsTableViewCell)!
            view.configure(model: profile!)
            view.delegate = self
            view.updateFollowingButton(isFollowing: isFollowing)
            
                      
            return view
        } else if indexPath.section == 1 {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userProfileContentSwitcherCell)!
            initContentSwitcher(switcher: view)
            return view
        }
        
        switch contentType {
        case .moment:
            let item = moments[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.momentHomePageTableViewCell)!
            view.configure(model: item)
            return view
        case .article:
            let item = articles[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleUserPageTableViewCell)!
            view.configure(model: item)
            return view
        case .questionAnswer:
            let item = questionAnswers[indexPath.row]
            if item is QuestionSummary {
                let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionRecordTableViewCell)!
                view.configure(model: item as! QuestionSummary)
                return view 
            } else {
                let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerRecordTableViewCell)!
                view.configure(model: item as! AnswerSummary)
                return view
            }
        }
    }
 
    func initContentSwitcher(switcher: UserProfileContentSwitcher) {
        switcher.momentButton.tag = 0
        switcher.articleButton.tag = 1
        switcher.answerButton.tag = 2
        
        for button in [switcher.momentButton, switcher.articleButton, switcher.answerButton] {
        button!.addTarget(self, action: #selector(self.switchContent(_:)), for: .touchUpInside)
        }
        
    }
    func switchContent(_ sender: UIButton) {
        let raw = sender.tag
        contentType = ContentType(rawValue: raw)!
        tableView.reloadData()
    }
    func configure(userId: Int) {
        self.userId = userId
    }
    
    func loadData() {
        MeowAPIProvider.shared
            .request(.herMoments(id: self.userId))
        .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self]
                items in
                self?.moments.append(contentsOf: items)
                    self?.tableView.reloadData()
            })
        .addDisposableTo(disposeBag)
        MeowAPIProvider.shared.request(.herArticles(id: self.userId))
        .mapTo(arrayOf: ArticleSummary.self)
            .subscribe(onNext: {
                [weak self]
                items in
                self?.articles.append(contentsOf: items)
                    self?.tableView.reloadData()
             })

        .addDisposableTo(disposeBag)
        
        
        
        let observableQuestions = MeowAPIProvider.shared.request(.herQuestions(id: userId)).mapTo(arrayOf: QuestionSummary.self)
        
        
        MeowAPIProvider.shared
            .request(.herAnswers(id: userId))
            .mapTo(arrayOf: AnswerSummary.self)
            .flatMap{[weak self] items -> Observable<[QuestionSummary]> in
                for item in items {
                    self?.questionAnswers.append(item)
                }
                return observableQuestions
        }   .subscribe(onNext: {
                [weak self]
                items in
                for item in items {
                    self?.questionAnswers.append(item)
                
                }
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
        
        MeowAPIProvider.shared.request(.herProfile(id: userId)).mapTo(type: Profile.self).subscribe(onNext: {
            [weak self] profile in self?.profile = profile
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        
        MeowAPIProvider.shared.request(.isFollowingUser(id: userId))
            .subscribe(onNext: {
                [weak self] json in
                self?.isFollowing = (json as! JSON)["following"].bool!
                self?.tableView.reloadData()
            }).addDisposableTo(disposeBag)
    }
    
    func isCurrentContentType(_ type: ContentType) -> Bool {
        return type == self.contentType
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else { return }
        switch contentType {
        case .article :
            let article = articles[indexPath.row]
            let vc = R.storyboard.articlePage.articleDetailViewController()!
            vc.configure(article: article)
            navigationController?.pushViewController(vc, animated: true)
        
        case .questionAnswer:
            let item = questionAnswers[indexPath.row]
            if item.type == .question {
                let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
                vc.configure(questionId: item.id)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                // TODO: Show answer detail
            }
        default:
            break 
        }
    }
    
}

extension UserProfileViewController: UserProfileCellDelegate {
    func didTapFollowButton(_ sender: UIButton) {
        if isFollowing {
            MeowAPIProvider.shared
                .request(.unfollowUser(id: userId))
                .subscribe(onNext: {
                    [weak self] _ in
                    self?.isFollowing = false
                    self?.tableView.reloadData()
                    }).addDisposableTo(disposeBag)
        } else {
            MeowAPIProvider.shared
                .request(.followUser(id: userId))
                .subscribe(onNext: {
                    [weak self]
                    _ in self?.isFollowing = true
                    self?.tableView.reloadData()
                })
                .addDisposableTo(disposeBag) 
        }
    }
    
    func didTapSendMessageButton(_ sender: UIButton) {
        
    }
}
