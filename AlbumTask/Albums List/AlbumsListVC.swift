//
//  ViewController.swift
//  AlbumTask
//
//  Created by Mohamed Ezzat on 27/04/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa  
import Alamofire


final class AlbumsListVC: UIViewController {
    
    static func make(with viewModel: AlbumsListVM) -> AlbumsListVC {
        let view = AlbumsListVC.instantiate()
        view.viewModel = viewModel
        return view
    }

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var listTbl: UITableView!
    
    private var viewModel : MakeListViewModelType!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind ViewModel Outputs
        viewModel.outputs.navigationBarTitle
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.outputs.AlbumCollection
            .observeOn(MainScheduler.instance)
            .bind(to: listTbl.rx.items) { tableView, row, AlbumCollection in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
//                cell.textLabel?.text = "\(githubRepository.name)"
//                cell.detailTextLabel?.textColor = UIColor.lightGray
//                cell.detailTextLabel?.text = "\(githubRepository.description)"
                return cell
            }
            .disposed(by: disposeBag)

//        tableView.rx.modelSelected(MakeRepository.self)
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] in
//                let vc = DetailViewController.make(with: DetailViewModel(repository: $0))
//                self?.navigationController?.pushViewController(vc, animated: true)
//            })
//            .disposed(by: disposeBag)

        viewModel.outputs.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.listTbl.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: $0 ? 50 : 0, right: 0)
            })
            .disposed(by: disposeBag)

        viewModel.outputs.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let ac = UIAlertController(title: "Error \($0)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(ac, animated: true)
            })
            .disposed(by: disposeBag)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTbl.indexPathsForSelectedRows?.forEach { [weak self] in
            self?.listTbl.deselectRow(at: $0, animated: true)
        }
    }
    

    

}

extension AlbumsListVC: StoryboardInstantiable {}


