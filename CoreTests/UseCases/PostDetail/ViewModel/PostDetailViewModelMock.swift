import Foundation
@testable import Core
import Combine

class PostDetailViewModelMock: PostDetailViewModelType, PostDetailViewModelOutputs {

    var outputs: PostDetailViewModelOutputs { return self }

    let title: AnyPublisher<String, Never> = just("detail.title")
    let author: AnyPublisher<String, Never> = just("detail.author")
    let description: AnyPublisher<String, Never> = just("detail.description")
    let progressHUD: AnyPublisher<MBProgressHUDModel?, Never> = just(nil)
    let numberOfComments: AnyPublisher<String, Never> = just("detail.comments")
    
}
