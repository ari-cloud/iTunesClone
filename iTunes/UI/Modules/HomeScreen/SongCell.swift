import Foundation
import UIKit

class SongCell: UITableViewCell {
    static let cellId = String(describing: SongCell.self)
    
    let albumImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "album")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is song"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " - It's album"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .black
        contentView.addSubview(albumImage)
        contentView.addSubview(songLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(albumLabel)
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        albumImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        albumImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        songLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 23).isActive = true
        songLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10).isActive = true
        songLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 3).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10).isActive = true
        
        albumLabel.centerYAnchor.constraint(equalTo: artistLabel.centerYAnchor).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: artistLabel.trailingAnchor).isActive = true
    }
}
