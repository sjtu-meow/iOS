//
//  SearchViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/4.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import TagListView


class NoCancelButtonSearchController: UISearchController {
    let noCancelButtonSearchBar = NoCancelButtonSearchBar()
    override var searchBar: UISearchBar {
        return noCancelButtonSearchBar
    }
}

class NoCancelButtonSearchBar: UISearchBar {
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
        super.setShowsCancelButton(false, animated: false);
    }
}
class SearchViewController: UIViewController {
    var searchController: NoCancelButtonSearchController!
    @IBOutlet weak var historyTagListView: TagListView!
    
    @IBAction func clearHistory(_ sender: Any) {
        SearchHistorySource.clearHistory()
        //TODO: update view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = NoCancelButtonSearchController()
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜索.."
        searchController.searchBar.showsCancelButton = false
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        searchController.definesPresentationContext = true
        
        //historyTagListView.delegate = self
    }
}


