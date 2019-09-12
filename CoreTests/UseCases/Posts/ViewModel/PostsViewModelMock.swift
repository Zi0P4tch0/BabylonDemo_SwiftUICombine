import Foundation
@testable import Core
import Combine

final class PostsViewModelMock: PostsViewModelType, PostsViewModelOutputs {

    var outputs: PostsViewModelOutputs { return self }
    
    let posts: AnyPublisher<[PostsTableViewCellViewModelType], Never>! = just([
        PostsTableViewCellViewModelMock(),
        PostsTableViewCellViewModelMock(),
        PostsTableViewCellViewModelMock()
    ])
    let title: AnyPublisher<String, Never> = just("title")
    let progressHUD: AnyPublisher<MBProgressHUDModel?, Never> = just(nil)

}
