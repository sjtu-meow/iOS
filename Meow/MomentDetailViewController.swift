//
//  MomentDetailViewController.swift
//  Meow
//
//  Created by 林树子 on 2017/9/9.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift


class MomentDetailViewController: UITableViewController {
    class func show (_ moment: Moment, from viewController: UIViewController) {
        let vc = R.storyboard.homePage.momentDetailViewController()!
        vc.moment = moment
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: CGRect.zero)
            
        tableView.register(R.nib.momentHomePageTableViewCell)
        tableView.allowsSelection = false
    }
    var moment: Moment!

    var isLiked = false
    
    let disposeBag = DisposeBag()

    func configure(moment: Moment) {
        self.moment = moment
    }
    
    func loadMoment() {
        MeowAPIProvider.shared.request(.moment(id: moment.id))
            .mapTo(type: Moment.self)
            .subscribe(onNext:{
                [weak self]
                (item) in
                self?.moment = item
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = R.nib.momentHomePageTableViewCell.firstView(owner: nil)!
        // let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.momentHomePageTableViewCell)!
        view.configure(model: moment)
        view.delegate = self
        return view
    }
}

extension MomentDetailViewController : MomentCellDelegate {
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
                self?.loadMoment()
            })
    }

}
