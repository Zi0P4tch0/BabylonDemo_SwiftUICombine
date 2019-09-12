import Foundation
import Combine

protocol PostsTableViewCellViewModelInputs {
    func tapped()
}

protocol PostsTableViewCellViewModelOutputs {
    var title: AnyPublisher<String, Never> { get }
}

protocol PostsTableViewCellViewModelType {
    var inputs: PostsTableViewCellViewModelInputs { get }
    var outputs: PostsTableViewCellViewModelOutputs { get }
}

protocol PostsTableViewCellViewModelDelegate: class {
    func tapped(from viewModel: PostsTableViewCellViewModel)
}

final class PostsTableViewCellViewModel: PostsTableViewCellViewModelType,
PostsTableViewCellViewModelInputs,
PostsTableViewCellViewModelOutputs {
    
    weak var delegate: PostsTableViewCellViewModelDelegate?
    
    var inputs: PostsTableViewCellViewModelInputs { return self }
    var outputs: PostsTableViewCellViewModelOutputs { return self }

    let title: AnyPublisher<String, Never>
        
    let post: Post

    init(post: Post) {
        self.post = post
        title = just(post.title)
    }
    
    func tapped() {
        delegate?.tapped(from: self)
    }
}
