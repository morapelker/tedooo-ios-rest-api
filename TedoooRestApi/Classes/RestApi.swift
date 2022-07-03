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

public protocol RestExtensions {
    
    func requestRx<T: Encodable, V: Decodable>(outputType: V.Type, request: HttpRequest, parameters: T) -> Future<V, RestException>
    
    func requestRx<T: Decodable>(outputType: T.Type, request: HttpRequest) -> Future<T, RestException>
    
    func requestRx<T: Encodable>(request: HttpRequest, parameters: T) -> Future<Any?, RestException>
    func requestRx(request: HttpRequest) -> Future<Any?, RestException>
    
}
