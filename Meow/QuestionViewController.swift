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
    
    let disposeBag = DisposeBag()
    
    private func loadData(){
        MeowAPIProvider.shared.request(.answers).mapTo(arrayOf: AnswerSummary.self)
            .subscribe(onNext:{
                [weak self]
                (answers) in
                
                self?.answers = answers 
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionAnswerPageAnswerCell.identifier)! as! QuestionAnswerPageAnswerCell
        if let answer = self.answers?[indexPath.row]{
            view.configure(model: answer)
            view.delegate = self
        }
        return view
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        //return UITableViewAutomaticDimension
    }
    
}

extension QuestionViewController: AnswerCellDelegate {
    func onTitleTapped(model: AnswerSummary) {
        let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
        vc.configure(questionId: model.questionId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
