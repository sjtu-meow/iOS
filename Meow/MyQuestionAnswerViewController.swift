//
//  MyQuestionAnswerViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MyQuestionAnswerViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    enum ContentType: Int { case questions = 0, answers = 1 }
    
    var contentType = ContentType.questions
    
    var questions = [QuestionSummary]()
    var answers = [AnswerSummary]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func switchContentType(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        self.contentType = ContentType(rawValue:index)!
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(R.nib.answerTableViewCell)
        tableView.register(R.nib.questionTableViewCell)
        loadData()
    }
    
    func loadData() {
        MeowAPIProvider.shared
            .request(.myQuestions)
            .mapTo(arrayOf: QuestionSummary.self)
            .subscribe(onNext: {
                [weak self]
                questions in
                self?.questions.append(contentsOf: questions)
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
        
        MeowAPIProvider.shared
            .request(.myAnswers)
            .mapTo(arrayOf: AnswerSummary.self)
            .subscribe(onNext: {
                [weak self]
                answers in
                self?.answers.append(contentsOf: answers)
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
        
    }
    
    
    
    
}

extension MyQuestionAnswerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.contentType == .questions {
            return questions.count
        } else {
            return answers.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.contentType == .questions {
            let question = questions[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionTableViewCell)! 
            view.configure(model: question)
            return view
        } else {
            let answer = answers[indexPath.row]
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerTableViewCell)!
            view.configure(model: answer)
            return view
        }
    }
    
}

extension MyQuestionAnswerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.contentType == .questions {
            let question = questions[indexPath.row]
            QuestionDetailViewController.show(question.id, from: self)
        } else {
            let answer = answers[indexPath.row]
            ArticleDetailViewController.show(answer, from: self)
        }
    }
}
