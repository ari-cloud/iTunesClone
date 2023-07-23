import Foundation
import RxSwift
import UIKit

class HomeScreenViewModel {
    let historyList = ["love", "favourite", "zombie", "my last make me think like i would never try again", "something random", "face", "на русском", "eight", "hello", "another long string"]
    let songs = PublishSubject<[Song]>()
    let imagesArray = PublishSubject<[UIImage]>()
    var keyword = PublishSubject<String?>()
    
    private var images: [UIImage] = []
    private let networkManager = NetworkManager()
    private let disposeBag = DisposeBag()
    
    init() {
        keyword
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [weak self] text in
                guard let self = self, let text = text else { return }
                self.getResult(with: text)
            }
            .disposed(by: disposeBag)
    }
    
    func getResult(with keyword: String) {
        networkManager.request(ResultDTO.self, keyword: keyword, httpMethod: .get)
            .subscribe { result in
                switch result {
                case .next(let data):
                    print("DEBUG: Next")
                    guard let result = try? JSONDecoder().decode(ResultDTO.self, from: data) else { return }
                    self.getImages(from: result)
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.songs.onNext(self.getSongs(from: result))
                    }
                case .error(let error):
                    print("DEBUG: Finish with error: \(error.localizedDescription)")
                case .completed:
                    print("DEBUG: Complited")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getImages(from result: ResultDTO) {
        for i in 0..<(result.resultCount ?? 0) {
            guard let url = URL(string: result.results?[i].artworkUrl100 ?? "") else { return }
            let request = URLRequest(url: url)
            URLSession.shared.rx
                .response(request: request)
                .subscribe(on: MainScheduler.instance)
                .subscribe { result in
                    switch result {
                    case .next(let data):
                        if let image = UIImage(data: data.data) {
                            self.images.append(image)
                        }
                    case .error(let error):
                        print("DEBUG: Finish getting imsge with error: \(error.localizedDescription)")
                    case .completed:
                        print("DEBUG: Complete getting image")
                    }
                }
                .disposed(by: disposeBag)
        }
    }
    
    func getSongs(from result: ResultDTO) -> [Song] {
        var songs: [Song] = []
        for i in 0..<(result.resultCount ?? 0) {
            if let resultItem = result.results?[i] {
                let song = Song(result: resultItem)
                songs.append(song)
            }
        }
        return songs
    }
}
