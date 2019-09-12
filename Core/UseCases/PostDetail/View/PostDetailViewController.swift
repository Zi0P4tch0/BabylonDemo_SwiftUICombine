import UIKit
import Combine

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var viewModel: PostDetailViewModelType!

    var titleBag: AnyCancellable?
    var authorBag: AnyCancellable?
    var commentsBag: AnyCancellable?
    var descriptionBag: AnyCancellable?
    var progressBag: AnyCancellable?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    private func bind(_ outputs: PostDetailViewModelOutputs) {

        titleBag =
        outputs.title
            .map { $0 as String? }
            .assign(to: \.title, on: navigationItem)

        authorBag =
        outputs.author
            .map { $0 as String? }
            .assign(to: \.text, on: authorLabel)

        commentsBag =
        outputs.numberOfComments
            .map { $0 as String? }
            .assign(to: \.text, on: commentsLabel)

        descriptionBag =
        outputs.description
            .map { $0 as String? }
            .assign(to: \.text, on: descriptionLabel)

        progressBag =
        outputs.progressHUD
            .assign(to: \.progressHUD, on: self)

    }
}
