import UIKit

class HomeScreenViewController: UIViewController {
    
    private let vm = HomeScreenViewModel()
    
    private let textField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemBackground
        let leftImage = UIImage(systemName: "magnifyingglass")
        textField.leftImage(leftImage, imageWidth: 30, padding: 5)
        let rightImage = UIImage(systemName: "xmark.circle.fill")
        textField.rightImage(rightImage, imageWidth: 30, padding: 5)
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
        setupStack()
        setupAutoLayout()
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
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
}

