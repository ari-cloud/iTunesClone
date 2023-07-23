import UIKit

class PlayerViewController: UIViewController {
    
    private var vm: PlayerViewModel = PlayerViewModel()
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private let collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "album")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favouriteButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    private let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is song"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let textButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "textformat.size", withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    private let songProgress: UISlider = {
        let progress = UISlider()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.setValue(0.3, animated: true)
        return progress
    }()
    
    private let backwardButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "backward.fill", withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    private let playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        let playImage = UIImage(systemName: "play.fill", withConfiguration: config)
        let pauseImage = UIImage(systemName: "pause.fill", withConfiguration: config)
        btn.setImage(playImage, for: .normal)
        btn.setImage(pauseImage, for: .selected)
        btn.tintColor = .gray
        return btn
    }()
    
    private let forwardButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "forward.fill", withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    private let songStartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let songDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2:57"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let soundLevel: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.setProgress(0.45, animated: true)
        progress.progressTintColor = .gray
        return progress
    }()
    
    private let speakerSilentView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 12)
        imageView.image = UIImage(systemName: "speaker.fill", withConfiguration: config)
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let speakerLoudView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 12)
        imageView.image = UIImage(systemName: "speaker.wave.3.fill", withConfiguration: config)
        imageView.tintColor = .gray
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .secondarySystemGroupedBackground
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(collectionImageView)
        view.addSubview(favouriteButton)
        view.addSubview(songLabel)
        view.addSubview(artistLabel)
        view.addSubview(textButton)
        view.addSubview(songProgress)
        view.addSubview(songStartLabel)
        view.addSubview(songDurationLabel)
        view.addSubview(backwardButton)
        view.addSubview(playButton)
        view.addSubview(forwardButton)
        view.addSubview(soundLevel)
        view.addSubview(speakerSilentView)
        view.addSubview(speakerLoudView)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        collectionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        collectionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.45 - 20).isActive = true
        collectionImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.45 - 20).isActive = true
        
        favouriteButton.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor).isActive = true
        favouriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        
        songLabel.topAnchor.constraint(equalTo: collectionImageView.bottomAnchor, constant: 30).isActive = true
        songLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: songLabel.centerXAnchor).isActive = true
        
        textButton.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor).isActive = true
        textButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.05)).isActive = true
        
        songProgress.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 25).isActive = true
        songProgress.centerXAnchor.constraint(equalTo: songLabel.centerXAnchor).isActive = true
        songProgress.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        songProgress.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        songStartLabel.topAnchor.constraint(equalTo: songProgress.bottomAnchor, constant: 8).isActive = true
        songStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        
        songDurationLabel.topAnchor.constraint(equalTo: songProgress.bottomAnchor, constant: 8).isActive = true
        songDurationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.05)).isActive = true
        
        backwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        backwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20).isActive = true
        backwardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        playButton.topAnchor.constraint(equalTo: songProgress.bottomAnchor, constant: 20).isActive = true
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3).isActive = true
        
        forwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        soundLevel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20).isActive = true
        soundLevel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        soundLevel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        
        speakerSilentView.centerYAnchor.constraint(equalTo: soundLevel.centerYAnchor).isActive = true
        speakerSilentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        
        speakerLoudView.centerYAnchor.constraint(equalTo: soundLevel.centerYAnchor).isActive = true
        speakerLoudView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width * 0.05)).isActive = true
    }
}
