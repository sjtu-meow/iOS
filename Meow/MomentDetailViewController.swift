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
        // 
    }

    var moment: Moment?

    var isLiked = false

    func configure(moment: Moment) {
        self.moment = moment
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
        guard let moment = moment else { return UITableViewCell() }
        let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.momentHomePageTableViewCell)!
        view.configure(model: moment)
        return view
    }
}
