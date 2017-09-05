//
//  NewsTableViewController.swift
//  channels
//
//  Created by Preet Shihn on 9/5/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = 80.0 //UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.newsItems.count == 0 {
            refreshNews()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = newsItems[row].title ?? ""
        cell.detailTextLabel?.text = newsItems[row].text ?? ""
        cell.detailTextLabel?.isHidden = false
        cell.selectionStyle = .none
        if let imageUrl = URL(string: newsItems[row].imageUrl ?? "") {
            UIUtils.dataFromUrl(url: imageUrl, completion: { (data, response, error) in
                guard let imageData = data, error == nil else {
                    return
                }
                DispatchQueue.main.async{
                    cell.imageView?.image = UIImage(data: imageData)
                    cell.setNeedsLayout()
                }
            })
        }
        return cell
    }
    
    private func refreshNews() {
        ChannelService.instance.getNews { (response: GetNewsResponse?, err: Error?) in
            if let error = err {
                UIUtils.showError("Failed to fetch news: \(error.localizedDescription)")
                return
            }
            if let items = response?.items {
                self.newsItems = items
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if let linkUrl = newsItems[row].linkUrl {
            if let url = URL(string: linkUrl) {
                UIApplication.shared.open(url)
            }
        }
    }
}
