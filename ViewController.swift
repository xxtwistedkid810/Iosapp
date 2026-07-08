import UIKit

final class ViewController: UIViewController {
    private let codeLabel = UILabel()
    private let refreshButton = UIButton(type: .system)
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        showNewCode()
    }

    private func setupUI() {
        titleLabel.text = "OTP Code"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textAlignment = .center

        codeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .bold)
        codeLabel.textAlignment = .center
        codeLabel.adjustsFontSizeToFitWidth = true

        refreshButton.setTitle("Generate New Code", for: .normal)
        refreshButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        refreshButton.addTarget(self, action: #selector(showNewCode), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, codeLabel, refreshButton])
        stack.axis = .vertical
        stack.spacing = 28
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func showNewCode() {
        var digits = ""
        for _ in 0..<12 {
            let d = Int.random(in: 0...9)
            digits.append(String(d))
        }
        codeLabel.text = digits
    }
}
