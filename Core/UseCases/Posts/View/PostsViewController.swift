import UIKit
import Combine

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: PostsViewModelType!
    var dataSource: PostsDataSource! {
        didSet {
            tableView.delegate = dataSource
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }

    private var titleCancellable: AnyCancellable?
    private var postsCancellable: AnyCancellable?
    private var progressHUDCancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    func bind(_ outputs: PostsViewModelOutputs) {

        titleCancellable =
        outputs.title
            .map { $0 as String? }
            .assign(to: \.title, on: navigationItem)

        postsCancellable =
        outputs.posts
            .sink { [weak self] viewModels in
                guard let self = self else { return }
                self.dataSource = PostsDataSource(viewModels: viewModels)
            }

        progressHUDCancellable =
        outputs.progressHUD
            .assign(to: \.progressHUD, on: self)
                
    }
    
}
