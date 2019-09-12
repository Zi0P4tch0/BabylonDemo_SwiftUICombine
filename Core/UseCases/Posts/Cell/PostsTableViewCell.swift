import UIKit
import Combine

final class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: PostsTableViewCellViewModelType! {
        didSet {
            titleCancellable = nil
            bind(viewModel.outputs)
        }
    }

    private var titleCancellable: AnyCancellable?

    func bind(_ outputs: PostsTableViewCellViewModelOutputs) {

        titleCancellable =
        outputs.title
            .map { $0 as String? }
            .assign(to: \.text, on: self.titleLabel)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
