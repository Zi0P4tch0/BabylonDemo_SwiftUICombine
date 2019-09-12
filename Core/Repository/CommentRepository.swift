import Foundation
import Combine

public protocol CommentRepositoryType {
    func getComments(completion: @escaping (Result<[Comment]>) -> Void)
}

extension Repository {
    
    public func getComments(completion: @escaping (Result<[Comment]>) -> Void) {
        let resource = Resource<[Comment]>(endpoint: "/comments")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension CommentRepositoryType /* Combine */ {

    public func getComments() -> Future<[Comment], Error> {
        Future { promise in
            self.getComments { result in
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
