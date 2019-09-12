import Foundation
import Combine

protocol PostsViewModelDelegate: class {
    func tapped(post: Post)
}

protocol PostsViewModelOutputs {
    var title: AnyPublisher<String, Never> { get }
    var posts: AnyPublisher<[PostsTableViewCellViewModelType], Never>! { get }
    var progressHUD: AnyPublisher<MBProgressHUDModel?, Never> { get }
}

protocol PostsViewModelType {
    var outputs: PostsViewModelOutputs { get }
}

final class PostsViewModel: PostsViewModelType, PostsViewModelOutputs {

    weak var delegate: PostsViewModelDelegate?

    private let postRepository: PostRepositoryType

    var outputs: PostsViewModelOutputs { self }

    var title: AnyPublisher<String, Never>
    var posts: AnyPublisher<[PostsTableViewCellViewModelType], Never>!
    var progressHUD: AnyPublisher<MBProgressHUDModel?, Never>

    private var progressHUDSubject = PassthroughSubject<MBProgressHUDModel?, Never>()

    // MARK: - Lifecycle

    public init(postRepository: PostRepositoryType,
                localizer: StringLocalizing = Localizer()) {

        self.postRepository = postRepository

        title = just(localizer.localize("posts.title"))

        progressHUD = progressHUDSubject.eraseToAnyPublisher()

        additionalInit(with: localizer)

    }

    private func additionalInit(with localizer: StringLocalizing) {

        posts =
            postRepository.getPosts()
                .handleEvents(receiveSubscription: { [weak self] _ in
                    guard let self = self else { return }
                    let message = localizer.localize("posts.loading")
                    let model = MBProgressHUDModel(message: message)
                    self.progressHUDSubject.send(model)
                },
                receiveOutput: { [weak self] _ in
                    guard let self = self else { return }
                    self.progressHUDSubject.send(nil)
                })
                .map {
                    self.viewModels(withPosts: $0, delegate: self)
                }
                .receive(on: DispatchQueue.main)
                .prepend([])
                .replaceError(with: [])
                .eraseToAnyPublisher()

    }

    // MARK: - View models mapping

    private func viewModels(withPosts posts: [Post],
                            delegate: PostsTableViewCellViewModelDelegate) -> [PostsTableViewCellViewModel] {
        
        return posts.map { post in
            let viewModel = PostsTableViewCellViewModel(post: post)
            viewModel.delegate = delegate
            return viewModel
        }
        
    }

}

extension PostsViewModel: PostsTableViewCellViewModelDelegate {
    
    func tapped(from viewModel: PostsTableViewCellViewModel) {
        delegate?.tapped(post: viewModel.post)
    }
    
}
