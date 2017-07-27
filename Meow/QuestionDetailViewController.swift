//
//  QuestionDetailViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/10.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class QuestionDetailViewController: UITableViewController {
    class func show(_ id: Int, from viewController: UIViewController) {
        let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
        vc.questionId = id
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    var questionId: Int!
    var question: Question?
    let disposeBag = DisposeBag()
    
    func configure(questionId: Int) {
        self.questionId = questionId
    }
    
    override func viewDidLoad() {
    
        tableView.estimatedRowHeight  = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
    }
    
    func loadData() {
        MeowAPIProvider.shared.request(.question(id: self.questionId))
        .mapTo(type: Question.self)
        .subscribe(onNext: {
                [weak self]
                question in
                self?.question = question
                self?.tableView.reloadData()
            })
        .addDisposableTo(disposeBag)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let question = question else { return 0 }
        if section == 0 {
            return 1
        } else {
            return question.answers!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let question = question else { return UITableViewCell() }
        if indexPath.section == 0 {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionDetailQuestionCell)!
            view.addAnswerButton.addTarget(self, action: #selector(addAnswer(_:)), for: .touchUpInside)
            
            view.configure(model: question)
            return view
        } else {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionDetailAnswerCell, for: indexPath)!
            view.configure(model: question.answers![indexPath.row])
            return view
        }
    }
    
    func addAnswer(_ sender: UIButton) {
        let vc = R.storyboard.postPages.postArticleController()!
        vc.configure(question: question!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let question = question, indexPath.section == 1 else { return }
        let answer = question.answers![indexPath.row]
        ArticleDetailViewController.show(answer, from: self)
        
    }
}
