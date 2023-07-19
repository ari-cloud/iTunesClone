import Foundation
import RxSwift

class HomeScreenViewModel {
    let historyList = ["love", "favourite", "zombie", "my last make me think like i would never try again", "something random", "face", "на русском", "eight", "hello", "another long string"]
    let result = PublishSubject<ResultDTO>()
    
    private let networkManager = NetworkManager()
    private let disposeBag = DisposeBag()
    
    init() {
        getResult()
    }
    
    func getResult() {
        networkManager.request(ResultDTO.self, keyword: "love", httpMethod: .get)
            .subscribe { result in
                switch result {
                case .next(let data):
                    print("DEBUG: Next")
                    guard let result = try? JSONDecoder().decode(ResultDTO.self, from: data) else { return }
                    print("RESULT \(result)")
                    DispatchQueue.main.async {
                        self.result.onNext(result)
                    }
                case .error(let error):
                    print("DEBUG: Finish with error: \(error.localizedDescription)")
                case .completed:
                    print("DEBUG: Complited")
                }
            }
            .disposed(by: disposeBag)
    }
}
