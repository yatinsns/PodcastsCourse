//
//  PodcastsSearchController.swift
//  PodcastsCourse
//
//  Created by Yatin Sarbalia on 8/23/18.
//  Copyright © 2018 Yatin Sarbalia. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
  let podcasts = [
    Podcast(trackName: "podcast 1", artistName: "Yatin Sarbalia"),
    Podcast(trackName: "podcast 2", artistName: "Yatin Sarbalia"),
    Podcast(trackName: "podcast 3", artistName: "Yatin Sarbalia")
  ]

  let cellId = "cellId"

  let searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSearchBar()
    setupTableView()
  }

  //MARK:- Setup work

  fileprivate func setupSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }

  fileprivate func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }

  //MARK:- UITableBiew

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return podcasts.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

    let podcast = podcasts[indexPath.row]
    cell.textLabel?.text = "\(podcast.trackName)\n\(podcast.artistName)"
    cell.textLabel?.numberOfLines = -1
    cell.imageView?.image = #imageLiteral(resourceName: "appicon")
    return cell
  }

  //MARK:- UISearchBarDelegate
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)

    let url = "https://itunes.apple.com/search?term=\(searchText)"
    Alamofire.request(url).responseData { (dataResponse) in
      if let err = dataResponse.error {
        print("failed to contact yahoo", err)
        return
      }

      guard let data = dataResponse.data else { return }
      let dummyString = String(data: data, encoding: .utf8)
      print(dummyString ?? "")

      do {
        let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
        print("Result count: ", searchResult.resultCount)
      } catch let decodeErr {
        print("failed to decode: ", decodeErr)
      }
    }
  }

  struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Podcast]
  }
}
