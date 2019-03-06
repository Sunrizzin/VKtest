//
//  FeedViewController.swift
//  VKtest
//
//  Created by Sunrizz on 04/03/2019.
//  Copyright © 2019 Алексей Усанов. All rights reserved.
//

import UIKit
import SwiftyVK
import SwiftyJSON
import Kingfisher

class FeedViewController: UIViewController {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var feedCollectionView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        feedCollectionView.tableFooterView = UIView()
        feedCollectionView.estimatedRowHeight = 210
        feedCollectionView.rowHeight = UITableView.automaticDimension
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        feedCollectionView.refreshControl = refreshControl
        self.getData()
    }
    
    @objc private func refreshData(_ sender: Any) {
       self.getData()
    }
    
    func getData() {
        VK.API.NewsFeed.get([.filters:"post"])
            .onSuccess {
                let data = JSON($0).dictionaryValue
                AppData.shared.items = data["items"]!.arrayValue
                AppData.shared.groups = data["groups"]!.arrayValue
                AppData.shared.profiles = data["profiles"]!.arrayValue
                AppData.shared.next_from = data["next_from"]!.arrayValue
                
                print(data["next_from"]!)
                
                DispatchQueue.main.async {
                    self.activity.stopAnimating()
                    self.feedCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
            .onError { print("SwiftyVK: NewsFeed.get failed with \n \($0)") }
            .send()
    }
    
    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
        VK.sessions.default.logOut()
        self.dismiss(animated: true, completion: nil)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feed") as! FeedTableViewCell
        
        let image = ImageResource(downloadURL: URL(string: AppData.shared.getAuthorImage(path: indexPath.row))!, cacheKey: AppData.shared.getAuthorImage(path: indexPath.row))
        cell.authorImage.kf.setImage(with: image, placeholder: Image(named: "logo"), options: nil, progressBlock: nil) { (done) in
        }
        cell.newsLabel.text = AppData.shared.items[indexPath.row].dictionary!["text"]!.stringValue
        cell.authorLabel.text = AppData.shared.getAuthor(path: indexPath.row)
        cell.likeCount.text = AppData.shared.items[indexPath.row].dictionary!["likes"]!.dictionary!["count"]?.stringValue
        cell.repostsCount.text = AppData.shared.items[indexPath.row].dictionary!["reposts"]!.dictionary!["count"]?.stringValue
        cell.timeLabel.text = AppData.shared.getDate(time: AppData.shared.items[indexPath.row].dictionary!["date"]!.doubleValue)
        return cell
    }
    
}
