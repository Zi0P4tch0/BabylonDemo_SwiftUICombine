import Foundation
import Combine

final class PostDetailViewModel: ObservableObject {

    @Published var id: Int
    @Published var author: String
    @Published var numberOfComments: String
    @Published var description: String

    private let post: Post
    private let userRepository: UserRepositoryType = repository
    private let commentRepository: CommentRepositoryType = repository

    private var userCancellable: AnyCancellable?
    private var commentsCancellable: AnyCancellable?
    
    init(post: Post) {
        
        self.post = post

        id = post.id
        author = "posts.detail.author.loading".localized()
        numberOfComments = "posts.detail.comments.loading".localized()
        description = post.body

    }

    func onAppear() {

        userCancellable = userRepository.getUsers()
            .receive(on: DispatchQueue.main)
            .map { $0.filter { $0.id == self.post.userId }.first }
            .map { $0?.username ?? "posts.detail.author.error".localized() }
            .replaceError(with: "posts.detail.author.error".localized() )
            .assign(to: \.author, on: self)

        commentsCancellable = commentRepository.getComments()
            .receive(on: DispatchQueue.main)
            .map { $0.filter { $0.postId == self.post.id } }
            .map { "\($0.count) comments" }
            .replaceError(with: "posts.detail.comments.error".localized() )
            .assign(to: \.numberOfComments, on: self)

    }
    
}
