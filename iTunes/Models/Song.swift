import Foundation

class Song {
    var songName: String
    var artistName: String
    var collectionName: String
    var image: String
    var time: String?
    
    init(result: Result) {
        self.songName = result.trackName ?? ""
        self.artistName = result.artistName ?? ""
        self.collectionName = result.collectionName ?? ""
        self.image = result.artworkUrl100 ?? ""
        self.time = getTime(time: result.trackTimeMillis ?? 0)
    }
    
    func getTime(time: Int) -> String {
        let min = time / 60000
        let sec = time - min * 60
        return String(min) + ":" + String(sec)
    }
}
