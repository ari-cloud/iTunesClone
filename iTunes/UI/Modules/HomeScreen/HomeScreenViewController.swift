import UIKit
import RxSwift
import RxCocoa

class HomeScreenViewController: UIViewController, UIScrollViewDelegate {
    
    private let vm = HomeScreenViewModel()
    private let disposeBag = DisposeBag()
    
    private let textField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemBackground
        let leftImage = UIImage(systemName: "magnifyingglass")
        textField.leftImage(leftImage, imageWidth: 30, padding: 5)
        textField.layer.cornerRadius = 10
        let placeholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholder
        return textField
    }()
    
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .black
        return bgView
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "History"
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        return stack
    }()
    
    private let songsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .secondarySystemGroupedBackground
        view.addSubview(textField)
        view.addSubview(bgView)
        bgView.addSubview(historyLabel)
        bgView.addSubview(stack)
        bgView.addSubview(songsTableView)
        setupStack()
        setupAutoLayout()
        bindFavouriteTableView()
        
        textField.rx.text
            .orEmpty
            .bind(to: vm.keyword)
            .disposed(by: disposeBag)
        
        vm.keyword.subscribe { [weak self] text in
            guard let self else { return }
            let btnView = UIButton()
            btnView.addTarget(self, action: #selector(closeBtnDidTap), for: .touchUpInside)
            if text == "" {
                if let rightImage = UIImage(named: "") {
                    self.textField.setRightViewIcon(icon: rightImage, btnView: btnView)
                } else {
                    if let rightImage = UIImage(systemName: "xmark.circle.fill") {
                        self.textField.setRightViewIcon(icon: rightImage, btnView: btnView)
                    }
                }
            }
        }
        .disposed(by: disposeBag)
    }
    
    func setupStack() {
        stack.addArrangedSubview(historyLabel)
        vm.historyList.forEach { text in
            let label = {
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 16)
                label.textColor = .systemBlue
                label.text = text
                return label
            }()
            stack.addArrangedSubview(label)
        }
    }

    func setupAutoLayout() {
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        bgView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stack.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20).isActive = true
        
        songsTableView.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
        songsTableView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor).isActive = true
        songsTableView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func closeBtnDidTap() {
        vm.keyword.onNext("")
        textField.text = ""
    }
    
    private func bindFavouriteTableView() {
        songsTableView.register(SongCell.self, forCellReuseIdentifier: SongCell.cellId)
        songsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        vm.songsPublished.bind(to: songsTableView.rx.items(cellIdentifier: SongCell.cellId, cellType: SongCell.self)) {index, item, cell in
            cell.songLabel.text = item.songName
            cell.artistLabel.text = item.artistName
            cell.albumLabel.text = " - " + item.collectionName
            cell.albumImage.image = item.image
        }.disposed(by: disposeBag)
        songsTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let self else { return }
                let viewController = PlayerViewController()
                let viewModel = PlayerViewModel(song: self.vm.songs[indexPath.row], songs: self.vm.songs, index: indexPath.row)
                viewController.vm = viewModel
                present(viewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {
    func leftImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        imageView.tintColor = .gray
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
    
    func rightImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        imageView.tintColor = .gray
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        rightView = containerView
        rightViewMode = .always
    }
    
    func setRightViewIcon(icon: UIImage, btnView: UIButton) {
        btnView.frame = CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.60), height: ((self.frame.height) * 0.60))
        btnView.setImage(icon , for: .normal)
        btnView.tintColor = .gray
        var configuration = UIButton.Configuration.borderless()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -16, bottom: 0, trailing: 0)
        btnView.configuration = configuration
        self.rightViewMode = .whileEditing
        self.rightView = btnView
    }
}


