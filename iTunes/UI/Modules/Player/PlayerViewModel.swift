import Foundation
import AVFoundation

class PlayerViewModel {
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    var isPlaying: Bool = true
    var currentSongIndex: Int
    var currentSong: Song
    var songs: [Song]
     
    init(song: Song, songs: [Song], index: Int) {
        self.currentSongIndex = index
        self.songs = songs
        self.currentSong = song
        initPlayer(with: song.songUrl)
    }
    
    func initPlayer(with urlString: String) {
        if let url = URL(string: urlString) {
            do {
                let playerItem = AVPlayerItem(url: url)
                self.player = AVPlayer(playerItem: playerItem)
                player?.volume = 1.0
                player?.play()
            }
        }
    }
    
    func playStopButtonDidTap() {
        if player?.rate == 0 {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    func backwardStopButtonDidTap() {
        player?.pause()
        currentSongIndex -= 1
        currentSong = songs[currentSongIndex]
        initPlayer(with: currentSong.songUrl)
    }
    
    func farwardStopButtonDidTap() {
        player?.pause()
        currentSongIndex += 1
        currentSong = songs[currentSongIndex]
        initPlayer(with: currentSong.songUrl)
    }
}
