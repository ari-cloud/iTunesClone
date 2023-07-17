import UIKit

class PlayerViewController: UIViewController {
    
    private let collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "album")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
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
    
    private let songProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.setProgress(0.3, animated: true)
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(collectionImageView)
        view.addSubview(songLabel)
        view.addSubview(artistLabel)
        view.addSubview(songProgress)
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        collectionImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        collectionImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        
        songLabel.topAnchor.constraint(equalTo: collectionImageView.bottomAnchor, constant: 50).isActive = true
        songLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: songLabel.centerXAnchor).isActive = true
        
        songProgress.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 25).isActive = true
        songProgress.centerXAnchor.constraint(equalTo: songLabel.centerXAnchor).isActive = true
        songProgress.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        songProgress.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
