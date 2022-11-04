//
//  DownloadViewController.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class DownloadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var downloadList: [UpComingResultMovie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerDownload()
        downloadList = DownloadList.shared.downloadList
    }
    private func registerDownload() {
        let cellIdentifier = String(describing: DownloadTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
        cell.setCell(with: downloadList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
