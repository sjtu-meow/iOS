//
//  QuestionViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import UIKit
import RxSwift

class QuestionViewController: UITableViewController {

    var answers: [AnswerSummary]?
    var questions: [QuestionSummary]?
    var allQuestionsAnswers: [ItemProtocol] = [ItemProtocol]()
    
    let disposeBag = DisposeBag()
    
    private func loadData(){
        allQuestionsAnswers.removeAll()
        
        MeowAPIProvider.shared.request(.answers).mapTo(arrayOf: AnswerSummary.self)
            .flatMap {
                [weak self]
                (answers: [AnswerSummary]) -> Observable<Any>
                in
                self?.answers = answers
                return MeowAPIProvider.shared.request(.questions)
            }
            .mapTo(arrayOf: QuestionSummary.self)
            .subscribe(onNext:{
                [weak self]
                questions in
                guard self != nil else { return }
                self!.questions = questions.filter({$0.answerCount == 0})
                for question in self!.questions! {
                    self!.allQuestionsAnswers.append(question)
                }
                for answer in self!.answers! {
                    self!.allQuestionsAnswers.append(answer)
                }
                
                self!.allQuestionsAnswers.sort(by: {$0.createTime > $1.createTime})
                self!.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
        tableView.register(R.nib.answerTableViewCell)
        tableView.register(R.nib.questionTableViewCell)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuestionsAnswers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = allQuestionsAnswers[indexPath.row]
        
        if item.type == .answer {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerTableViewCell)!
        
            view.configure(model: item as! AnswerSummary)
            view.delegate = self
            return view
        } else {
            let question = item as! QuestionSummary
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionTableViewCell)!
            view.configure(model: question)
            return view

        }
        
    }
    
    @IBAction func showPostTypePicker(_ sender: Any) {
        PostTypeViewController.show(from: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = allQuestionsAnswers[indexPath.row]
        if item.type == .answer {
            ArticleDetailViewController.show(item as! AnswerSummary, from: self)
        } else {
            let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
            vc.configure(questionId: item.id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension QuestionViewController: AnswerCellDelegate {
    func onTitleTapped(answer model: AnswerSummary) {
        let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
        vc.configure(questionId: model.questionId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //func didTapAvatar(profile: Profile) {
    //    UserProfileViewController.show(profile, from: self)
    //}
}
