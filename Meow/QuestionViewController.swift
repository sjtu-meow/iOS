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
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
        tableView.register(R.nib.answerTableViewCell)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerTableViewCell.identifier)! as! AnswerTableViewCell
        if let answer = self.answers?[indexPath.row]{
            view.configure(model: answer)
            view.delegate = self
        }
        return view
    }
    
    @IBAction func showPostTypePicker(_ sender: Any) {
        PostTypeViewController.show(from: self)
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
