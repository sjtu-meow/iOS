//
//  HomeViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift
import Rswift

class HomeViewController: UITableViewController {
    let bannerViewIdentifier = "bannerViewCell"
    
    let disposeBag = DisposeBag()
    
    var banners = [Banner]()
    
    var currentPage = 0
    
    var moments = [Moment]()
    
    let searchBar =  NoCancelButtonSearchBar()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
        
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        //let vc = R.storyboard.main.searchViewController()
        
        //present(vc!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc!, animated: true)
        //let vc = R.storyboard.articlePage.articleDetailViewController()

        // let vc = R.storyboard.loginSignupPage.loginViewController()
        
        //present(vc!, animated: true, completion: nil)
        // let vc = R.storyboard.articlePage.articleDetailViewController()

        // let vc = R.storyboard.loginSignupPage.loginViewController()
        
         // present(vc!, animated: true, completion: nil)
        //logger.log("hello world")
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    
        tableView.register(R.nib.bannerViewCell)
        tableView.register(R.nib.momentHomePageTableViewCell)
        tableView.register(R.nib.answerHomePageTableViewCell)
        tableView.register(R.nib.questionHomePageTableViewCell)
        tableView.register(R.nib.articleHomePageTableViewCell)
        
    }
    

    func loadData() {
       MeowAPIProvider.shared.request(.banners)
            .mapTo(arrayOf: Banner.self)
            .subscribe(onNext: {
                [weak self] (banners) in
                self?.banners = banners
            })
            .addDisposableTo(disposeBag)
        

        loadMore()
        MeowAPIProvider.shared.request(.moments)    // FIXME: need to support other item types
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self]
                (items) in
                self?.moments = items
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 /* banners */ + 1 /* items */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 /* banners: one cell */ {
            return 1
        }
        /* item sections: one cell for each item */
        return self.moments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* banners */
        if indexPath.section == 0 {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.bannerViewCell)!
            view.configure(banners: self.banners)
            view.onTapBanner = {
                [weak self] banner in
                self?.onTapBanner(banner!)
            }
            
            return view
        }
        
        /* items */
        let item = self.moments[indexPath.row ]
        
        // FIXME: check whether it is a comment cell
        switch(item.type!) {
        case .moment:
            let view = R.nib.momentHomePageTableViewCell.firstView(owner: nil)!
            // let view = tableView.dequeueReusableCell(withIdentifier: R.nib.momentHomePageTableViewCell)!
            view.configure(model: item as! Moment)
            view.delegate = self
            
            return view
        case .answer:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.answerHomePageTableViewCell.identifier)!
            (view as! AnswerHomePageTableViewCell).configure(model: item as! AnswerSummary)
            return view
        case .article:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.articleHomePageTableViewCell.identifier)!
            (view as! ArticleHomePageTableViewCell).configure(model: item as! ArticleSummary)
            return view
        case .question:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.questionHomePageTableViewCell.identifier)!
            (view as! QuestionHomePageTableViewCell).configure(model: item as! Question)
            return view
        }
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard section == 1 else { return }
        loadMore()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moment = moments[indexPath.row]
        MomentDetailViewController.show(moment, from: self)
    }
    
    func loadMore() {
        MeowAPIProvider.shared.request(.moments) // FIXME: need to support other item types
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self] (items) in
                self?.moments = items // FIXME
                self?.tableView.reloadData()
                self?.currentPage += 1
            })
            .addDisposableTo(disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let moment = moments[indexPath.row]
        MomentDetailViewController.show(moment, from: self)
    }



    @IBAction func showPostTypePicker(_ sender: Any) {
        PostTypeViewController.show(from: self)
    }
    
    func onTapBanner(_ banner: Banner) {
        let type = banner.itemType!
        switch type {
        case .moment:
            MeowAPIProvider.shared.request(.moment(id: banner.itemId)).mapTo(type: Moment.self).subscribe(onNext: {
                [weak self] moment in
                if let self_ = self {
                    MomentDetailViewController.show(moment, from: self_)
                }
            }).addDisposableTo(disposeBag)
        case .article:
            MeowAPIProvider.shared.request(.article(id: banner.itemId)).mapTo(type: Article.self).subscribe (onNext: {
                [weak self] article in
                if let self_ = self {
                    ArticleDetailViewController.show(article, from: self_)
                }
            }).addDisposableTo(disposeBag)
        case .answer:
            MeowAPIProvider.shared.request(.answer(id: banner.itemId)).mapTo(type: Answer.self).subscribe (onNext: {
                [weak self] answer in
                if let self_ = self {
                    ArticleDetailViewController.show(answer, from: self_)
                }
            }).addDisposableTo(disposeBag)
        case .question:
            let vc = R.storyboard.questionAnswerPage.questionDetailViewController()!
            vc.configure(questionId: banner.itemId)
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
        
        
        
        
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        DispatchQueue.main.async {
            let vc = R.storyboard.main.searchViewController()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        return false
    }
}

extension HomeViewController: MomentCellDelegate {
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
