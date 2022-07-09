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
    public let withAuth: Bool
    public let method: HttpMethod
    public let queries: [String: String]
    
    public init(baseUrl: String? = nil, path: String, withAuth: Bool, method: HttpMethod = .get, queries: [String : String] = [:]) {
        self.baseUrl = baseUrl
        self.path = path
        self.withAuth = withAuth
        self.method = method
        self.queries = queries
    }
    
}

public protocol RestApiClient {
    
    func requestRx<T: Encodable, V: Decodable>(outputType: V.Type, request: HttpRequest, parameters: T) -> AnyPublisher<V, RestException>
    
    func requestRx<T: Decodable>(outputType: T.Type, request: HttpRequest) -> AnyPublisher<T, RestException>
    
    func requestRx<T: Encodable>(request: HttpRequest, parameters: T) -> AnyPublisher<Any?, RestException>
    func requestRx(request: HttpRequest) -> AnyPublisher<Any?, RestException>
    
}

public struct UploadImageRequest {
    
    public let id : String
    public let token: String
    public let image: UIImage?
    public let maxSize: Int
    public let chat: Bool
    
    public init(id: String = "", image: UIImage?, maxSize: Int = 150000, chat: Bool = false, token: String) {
        self.id = id
        self.image = image
        self.maxSize = maxSize
        self.chat = chat
        self.token = token
    }
    
}
 
public struct UploadImageResponse {
    public init(id: String, result: UploadImageResult) {
        self.id = id
        self.result = result
    }
    
    public let id: String
    public let result: UploadImageResult
}

public enum UploadImageResult {
    case success(_ url: String)
    case progress(_ progress: CGFloat)
    case failure(_ error: Error)
}

public protocol AwsClient {
    
    func uploadImage(request: UploadImageRequest) -> AnyPublisher<UploadImageResponse, Never>
    
}
