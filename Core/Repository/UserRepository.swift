import Foundation
import Combine

public protocol UserRepositoryType {
    func getUsers(completion: @escaping (Result<[User]>) -> Void)
}

extension Repository {
    
    public func getUsers(completion: @escaping (Result<[User]>) -> Void) {
        let resource = Resource<[User]>(endpoint: "/users")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension UserRepositoryType /* Combine */ {

    public func getUsers() -> Future<[User], Error> {
        Future { promise in
            self.getUsers { result in
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
