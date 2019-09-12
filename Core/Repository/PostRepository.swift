import Foundation
import Combine

public protocol PostRepositoryType {
    func getPosts(completion: @escaping (Result<[Post]>) -> Void)
}

extension Repository {
    
    public func getPosts(completion: @escaping (Result<[Post]>) -> Void) {
        let resource = Resource<[Post]>(endpoint: "/posts")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension PostRepositoryType /* Combine */ {
    
    public func getPosts() -> Future<[Post], Error> {
        Future { promise in
            self.getPosts { result in
                switch result {
                case .success(let result):
                    promise(.success(result))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
}
