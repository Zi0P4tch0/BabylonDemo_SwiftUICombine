import Foundation
import Combine

public final class PostsViewModel: ObservableObject {

    private var postsCancellable: AnyCancellable?

    private let postRepository: PostRepositoryType = repository

    @Published var posts: [Post]
    @Published var isLoading: Bool
    @Published var loadingMessage: String

    // MARK: - Lifecycle

    public init() {

        posts = []
        isLoading = true
        loadingMessage = "posts.loading".localized()

    }

    func onAppear() {

        postsCancellable =
            postRepository.getPosts()
                .handleEvents(receiveCompletion: { _ in
                    self.isLoading = false
                })
                .receive(on: DispatchQueue.main)
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .assign(to: \.posts, on: self)

    }

}
