import Foundation
import Combine

protocol PostDetailViewModelOutputs {
    var title: AnyPublisher<String, Never> { get }
    var author: AnyPublisher<String, Never> { get }
    var numberOfComments: AnyPublisher<String, Never> { get }
    var description: AnyPublisher<String, Never> { get }
    var progressHUD: AnyPublisher<MBProgressHUDModel?, Never> { get }
}

protocol PostDetailViewModelType {
    var outputs: PostDetailViewModelOutputs { get }
}

final class PostDetailViewModel: PostDetailViewModelType, PostDetailViewModelOutputs {
    
    var outputs: PostDetailViewModelOutputs { return self }

    let title: AnyPublisher<String, Never>
    let author: AnyPublisher<String, Never>
    let numberOfComments: AnyPublisher<String, Never>
    let description: AnyPublisher<String, Never>
    let progressHUD: AnyPublisher<MBProgressHUDModel?, Never>

    private let post: Post
    private let userRepository: UserRepositoryType
    private let commentRepository: CommentRepositoryType
    
    init(post: Post,
         userRepository: UserRepositoryType,
         commentRepository: CommentRepositoryType,
         localizer: StringLocalizing = Localizer()) {
        
        self.post = post
        self.userRepository = userRepository
        self.commentRepository = commentRepository

        title = just(String(format: localizer.localize("posts.detail.title"), "\(post.id)"))

        let users = userRepository.getUsers()
            .receive(on: DispatchQueue.main)
            .prepend([])
            .replaceError(with: [])
            .share()
            .eraseToAnyPublisher()

        let comments = commentRepository.getComments()
            .receive(on: DispatchQueue.main)
            .prepend([])
            .replaceError(with: [])
            .share()
            .eraseToAnyPublisher()

        author = users.map { $0.filter { $0.id == post.userId } }
                      .map { $0.first?.username ?? localizer.localize("posts.detail.author.error") }
                      .prepend(localizer.localize("posts.detail.loading"))
                      .replaceError(with: localizer.localize("posts.detail.author.error"))
                      .eraseToAnyPublisher()

        numberOfComments = comments.map { $0.filter { $0.postId == post.id } }
                    .map { String(format: localizer.localize("posts.detail.comments"), "\($0.count)") }
                    .prepend(localizer.localize("posts.detail.loading"))
                    .replaceError(with: localizer.localize("posts.detail.comments.error"))
                    .eraseToAnyPublisher()

        description = just(post.title)

        progressHUD =
        users.map { _ in MBProgressHUDModel(message:localizer.localize("posts.detail.comments.loading")) }
        .merge(with: comments.map { _ in nil as MBProgressHUDModel? })
        .prepend(MBProgressHUDModel(message: localizer.localize("posts.detail.users.loading")))
        .eraseToAnyPublisher()

    }
    
}
