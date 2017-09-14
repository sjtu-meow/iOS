//
//  MyMomentViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MyMomentViewController: UITableViewController {
    let disposeBag = DisposeBag()
    var items: [Moment] = [Moment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.register(R.nib.momentHomePageTableViewCell)
        loadData()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moment = items[indexPath.row]
        //let view = tableView.dequeueReusableCell(withIdentifier: R.nib.momentHomePageTableViewCell.identifier)! as! MomentHomePageTableViewCell
        // Reuseable cells incur bug in height calculation
        let view = R.nib.momentHomePageTableViewCell.firstView(owner: nil)!
        view.configure(model: moment)
        view.delegate = self
        return view
    }
    
    func loadData() {
        MeowAPIProvider.shared
            .request(.myMoments)
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext:{
                [weak self]
                items in
                self?.items = items
                //self?.items.append(contentsOf: items)
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
}

extension MyMomentViewController: MomentCellDelegate {
    func didTapAvatar(profile: Profile) {
        if let userId = UserManager.shared.currentUser?.userId, userId == profile.userId {
            MeViewController.show(from: navigationController!)
        } else {
            UserProfileViewController.show(profile, from: self)
        }
    }
    
    func didToggleLike(id: Int, isLiked: Bool) -> Bool {
        var liked = isLiked
        let request = isLiked ? MeowAPI.unlikeMoment(id: id) : MeowAPI.likeMoment(id: id)
        MeowAPIProvider.shared.request(request)
            .subscribe(onNext: {
                _ in
                liked = !isLiked
            })
            .addDisposableTo(disposeBag)
        return liked
    }
    
    func didPostComment(moment: Moment, content: String, from cell: MomentHomePageTableViewCell) {
        MeowAPIProvider.shared.request(.postComment(item: moment, content: content))
            .subscribe(onNext:{
                [weak self]
                _ in
                cell.clearComment()
                cell.model!.commentCount! += 1
                cell.updateCommentCountLabel()
                self?.loadData()
            })
    }
    
}


