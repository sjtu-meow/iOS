//
//  SearchViewController.swift
//  Meow
//
//  Created by 林树子 on 2017/7/4.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import TagListView


class NoCancelButtonSearchBar: UISearchBar {
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
        super.setShowsCancelButton(false, animated: false);
    }
}

class NoCancelButtonSearchController: UISearchController {
    private let noCancelButtonSearchBar = NoCancelButtonSearchBar()
    override var searchBar: UISearchBar {
        return noCancelButtonSearchBar
    }
}


class SearchViewController: UIViewController {
    var searchController: NoCancelButtonSearchController!
    @IBOutlet weak var historyTagListView: TagListView!
    
    @IBAction func clearHistory(_ sender: Any) {
        SearchHistorySource.clearHistory()
        updateTags()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController = NoCancelButtonSearchController()
        
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜索.."
        searchController.searchBar.showsCancelButton = false
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        searchController.definesPresentationContext = true
        
        historyTagListView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //searchController.isActive = true;
        var result = searchController.searchBar.becomeFirstResponder()
        SearchHistorySource.addHistory(historyEntry: "meow")
        SearchHistorySource.addHistory(historyEntry: "???")
        updateTags()
    }
    
    
}
//
//extension SearchViewController: UISearchControllerDelegate {
//    func didPresentSearchController(searchController: UISearchController) {
//        searchController.searchBar.becomeFirstResponder()
//    }
//}


extension SearchViewController {
    func addTags(_ tags: Set<String>) {
        for tag in tags {
            historyTagListView.addTag(tag)
        }
    }
    
    func updateTags() {
        let history = SearchHistorySource.getHistory()
        historyTagListView.removeAllTags()
        addTags(history)
    }
    
        
}

extension SearchViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        searchController.searchBar.text = title
        searchController.searchBar.becomeFirstResponder()
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryKeyword = searchController.searchBar.text else { return }
        SearchHistorySource.addHistory(historyEntry: queryKeyword)
        
        let vc = R.storyboard.main.searchResultViewController()!
        vc.configure(keyword: queryKeyword)
        // TODO
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


