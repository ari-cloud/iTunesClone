import Foundation
import RxSwift
import RxCocoa
import UIKit

class Song {
    var songName: String
    var artistName: String
    var collectionName: String
    var imageUrl: String
    var time: String?
    var image: UIImage?
    
    private let disposeBag = DisposeBag()
    
    init(result: Result) {
        self.songName = result.trackName ?? ""
        self.artistName = result.artistName ?? ""
        self.collectionName = result.collectionName ?? ""
        self.imageUrl = result.artworkUrl100 ?? ""
        self.time = getTime(time: result.trackTimeMillis ?? 0)
        getImage(from: self.imageUrl)
    }
    
    func getTime(time: Int) -> String {
        let min = time / 60000
        let sec = time - min * 60
        return String(min) + ":" + String(sec)
    }
    
    func getImage(from url: String) {
            guard let url = URL(string: url) else { return }
            let request = URLRequest(url: url)
            URLSession.shared.rx
                .response(request: request)
                .subscribe(on: MainScheduler.instance)
                .subscribe { result in
                    switch result {
                    case .next(let data):
                        if let image = UIImage(data: data.data) {
                            self.image = image
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
