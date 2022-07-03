import Combine

public enum RestException: Error {
    case invalidStatusCode(_ statusCode: Int, _ message: String, _ errorCode: Int)
    case other(_ message: String)
}

public enum HttpMethod {
    case get
    case post
    case patch
    case put
    case delete
}

public struct HttpRequest {

    public let baseUrl: String?
    public let path: String
    public let token: String?
    public let method: HttpMethod
    public let queries: [String: String]
    
    public init(baseUrl: String? = nil, path: String, token: String?, method: HttpMethod = .get, queries: [String : String] = [:]) {
        self.baseUrl = baseUrl
        self.path = path
        self.token = token
        self.method = method
        self.queries = queries
    }
    
}

public protocol RestApiClient {
    
    func requestRx<T: Encodable, V: Decodable>(outputType: V.Type, request: HttpRequest, parameters: T) -> Future<V, RestException>
    
    func requestRx<T: Decodable>(outputType: T.Type, request: HttpRequest) -> Future<T, RestException>
    
    func requestRx<T: Encodable>(request: HttpRequest, parameters: T) -> Future<Any?, RestException>
    func requestRx(request: HttpRequest) -> Future<Any?, RestException>
    
}

public struct UploadImageRequest {
   
    public let token: String
    public let image: UIImage?
    public let maxSize: Int
    public let chat: Bool
    
    public init(image: UIImage?, maxSize: Int = 150000, chat: Bool = false, token: String) {
        self.image = image
        self.maxSize = maxSize
        self.chat = chat
        self.token = token
    }
    
}

public enum UploadImageResult {
    case success(_ url: String)
    case progress(_ progress: CGFloat)
    case failure(_ error: Error)
}

public protocol AwsClient {
    
    func uploadImage(request: UploadImageRequest) -> AnyPublisher<UploadImageResult, Never>
    
}
