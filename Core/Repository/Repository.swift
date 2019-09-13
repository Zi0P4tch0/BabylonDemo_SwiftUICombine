import Foundation

public protocol RepositoryType: PostRepositoryType,
                                UserRepositoryType,
                                CommentRepositoryType {
    
}

public final class Repository: RepositoryType {
        
    let webservice: WebserviceType
    
    public init(webservice: WebserviceType) {
        self.webservice = webservice
    }
    
}

var repository: RepositoryType = {
    let configuration = Configuration()
    let baseWebservice = Webservice(baseURL: configuration.baseURL)
    let webservice = CachedWebservice(decorated: baseWebservice,
                                  storage: UserDefaults.standard)
    return Repository(webservice: webservice)
}()
