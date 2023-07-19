import Foundation
import RxSwift
import RxCocoa

class NetworkManager {
    private let disposeBag = DisposeBag()
    func request<T: Codable>(_ t: T.Type, keyword: String, httpMethod: HttpMethod) -> Observable<Data> {
        let baseUrl = "https://itunes.apple.com/search?media=music&term="
        guard
            let url = URL(string: baseUrl + keyword.lowercased().replacingOccurrences(of: " ", with: "+"))
        else {
            fatalError("DEBAG: Error with url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return URLSession.shared.rx.data(request: request)
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case connect  = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case atch = "PATCH"
}

