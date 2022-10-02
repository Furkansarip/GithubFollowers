//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/30/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit
protocol FollowersListVCDelegate : class {
    func didRequestFollowers(for username : String)
}

class FollowerListVC: UIViewController {
    
    enum Section {case main}
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var isLoadingMoreFollowers = false
    var followers: [Follower] = []
    var filteredArray : [Follower] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    init(username : String){
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        isLoadingView()
       
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dissmissLoadingView()
            switch result{
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    
                    guard let error = error else {
                        self.GFAlertPresent(title: "Favorite User", message: "Adding favorite user", buttonTitle: "Hoorayy!")
                        return
                    }
                    self.GFAlertPresent(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
                
                }
            case .failure(let error):
                self.GFAlertPresent(title: "Error 2 ", message: error.rawValue, buttonTitle: "ok")
                
            }
            
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                        = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.placeholder      = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController             = searchController
    }
    
    func getFollowers(username:String,page:Int) {
        isLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dissmissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have followers. Go follow them 😃"
                    DispatchQueue.main.async {
                        self.emptyStateView(with: message, in:self.view)
                        
                    }
                    return
                }
                self.updateData(on: self.followers)
               
                
            case .failure(let error):
                self.GFAlertPresent(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on follower : [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follower,toSection: .main)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offSetY > contentHeight - height {
            guard hasMoreFollowers,!isLoadingMoreFollowers else {return}
            page += 1
            print(page)
            getFollowers(username: username, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredArray : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       
        guard let filter = searchController.searchBar.text,!filter.isEmpty else{
            filteredArray.removeAll()
            isSearching = false
            updateData(on: followers)
            return }
        isSearching = true
        filteredArray = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredArray)
        
    }
    
    
}

extension FollowerListVC : FollowersListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredArray.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: 1)
        
    }
    
    
}
