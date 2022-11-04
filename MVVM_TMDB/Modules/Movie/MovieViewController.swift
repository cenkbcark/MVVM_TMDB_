//
//  MovieViewController.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import UIKit

final class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MovieViewModelInput
    private var popularList: [PopularResultMovie] = []
    private var upComingList: [UpComingResultMovie] = []
    private var topRatedList: [TopRatedResultMovie] = []
    private var tabList: [TabList] = []
 
    init(viewModel: MovieViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "MovieViewController", bundle: .main)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        registerUpcomingCell()
        registerPopularCell()
        registerTopRatedCell()
        registerHomePageCell()
        setHomePageCell()
        viewModel.viewDidLoad()
        setTitle()
    }
    private func setTitle() {
        self.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    private func registerHomePageCell() {
        let cellIdentifier = String(describing: HomPageTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerUpcomingCell() {
        let cellIdentifier = String(describing: UpComingTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: PopularTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func registerTopRatedCell() {
        let cellIdentifier = String(describing: TopRatedTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    private func setHomePageCell(){
        tabList.append(.homePage(UIImage(named: "deneme")!))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension MovieViewController: MovieViewModelOutput {
    
    func upComing(_ upComingViewModel: MovieViewModelInput, upComingMovieListDidLoad list: [UpComingResultMovie]) {
        tabList.append(.upcomingList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func home(_home viewModel: MovieViewModelInput, popularMovieListDidLoad list: [PopularResultMovie]) {
        tabList.append(.popularList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func topRated(_ topRatedViewModel: MovieViewModelInput, topRatedMovieListDidLoad list: [TopRatedResultMovie]) {
        tabList.append(.topRatedList(list))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tabList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabList[section] {
        case .upcomingList(_):
            return 1
        case .popularList(_):
            return 1
        case .topRatedList(_):
            return 1
        case .homePage:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabList[indexPath.section] {
        case .upcomingList(let upComingList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpComingTableViewCell", for: indexPath) as! UpComingTableViewCell
            cell.prepareCategory(with: upComingList)
            return cell
        case .popularList(let popularList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            cell.prepareCategory(with: popularList)
            return cell
        case .topRatedList(let topRatedList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! TopRatedTableViewCell
            cell.prepareCategory(with: topRatedList)
            return cell
        case .homePage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomPageTableViewCell", for: indexPath) as! HomPageTableViewCell
            cell.setHomePage()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabList[indexPath.section] {
        case .upcomingList(_):
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
    case upcomingList(_ model: [UpComingResultMovie])
    case popularList(_ model: [PopularResultMovie])
    case topRatedList(_ model: [TopRatedResultMovie])
    case homePage(_ model: UIImage)
}
