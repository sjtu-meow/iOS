//
//  UserProfileViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/19.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class UserProfileViewController: UITableViewController {
    enum ContentType {
        case article, moment, questionAnswer
    }
    
    let disposeBag = DisposeBag()
    var userId: Int!
    var contentType = ContentType.moment
    
    // var answers = [AnswerSummary]()
    // var questions = [QuestionSummary]()
    
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
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
            return view
        }
        
        switch contentType {
        default: return UITableViewCell()
        }
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
    }
    
    func isCurrentContentType(_ type: ContentType) -> Bool {
        return type == self.contentType
    }
    
}
