import Foundation
@testable import Core
import Combine

class PostsTableViewCellViewModelMock: PostsTableViewCellViewModelType,
PostsTableViewCellViewModelInputs,
PostsTableViewCellViewModelOutputs {
    
    var inputs: PostsTableViewCellViewModelInputs { return self }
    var outputs: PostsTableViewCellViewModelOutputs { return self }
    
    let title: AnyPublisher<String, Never> = just("title")

    var tappedCalled = 0
    func tapped() {
        tappedCalled += 1
    }

}
