//
//  TvViewController.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import UIKit

final class TvViewController: UIViewController {
    
    private var viewModel: TvViewModelInput
    private var popularList: [PopularResultTV] = []
    private var onAirList: [OnAirResultTV] = []
    private var topRatedList: [TopRatedResultTV] = []
    private var tabList: [TabList] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: TvViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "TvViewController", bundle: .main)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerHomePageCell()
        registerOnAirCell()
        registerPopularCell()
        registerTopRatedCell()
        setHomePageCell()
        viewModel.viewDidLoad()
    }
    private func registerHomePageCell() {
        let cellIdentifier = String(describing: HomeTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerOnAirCell() {
        let cellIdentifier = String(describing: OnAirTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: PopularTvTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerTopRatedCell() {
        let cellIdentifier = String(describing: TopRatedTvTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func setHomePageCell(){
        tabList.append(.homePage(UIImage(named: "dahmer")!))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension TvViewController: TvViewModelOutput {
    func popularTv(_home viewModel: TvViewModelInput, popularTvListDidLoad list: [PopularResultTV]) {
        tabList.append(.popularList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onAirTv(_home viewModel: TvViewModelInput, onAirTvListDidLoad list: [OnAirResultTV]) {
        tabList.append(.onAirList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func topRatedTv(_home viewModel: TvViewModelInput, topRatedTvListDidLoad list: [TopRatedResultTV]) {
        tabList.append(.topRatedList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension TvViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tabList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabList[section] {
        case .onAirList(_):
            return 1
        case .popularList(_):
            return 1
        case .topRatedList(_):
            return 1
        case .homePage(_):
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabList[indexPath.section] {
        case .onAirList(let onAirList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnAirTableViewCell", for: indexPath) as! OnAirTableViewCell
            cell.prepareCategory(with: onAirList)
            return cell
        case .popularList(let popularList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTvTableViewCell", for: indexPath) as! PopularTvTableViewCell
            cell.prepareCategory(with: popularList)
            return cell
        case .topRatedList(let topRatedList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTvTableViewCell", for: indexPath) as! TopRatedTvTableViewCell
            cell.prepareCategory(with: topRatedList)
            return cell
        case .homePage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.setHomePage()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabList[indexPath.section] {
        case .onAirList(_):
            return 210
        case .popularList(_):
            return 250
        case .topRatedList(_):
            return 250
        case .homePage:
            return 414
        }
    }
}
private enum TabList {
    case onAirList(_ model: [OnAirResultTV])
    case popularList(_ model: [PopularResultTV])
    case topRatedList(_ model: [TopRatedResultTV])
    case homePage(_ model: UIImage)
}
