//
//  ViewController.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import UIKit

final class ViewController: UIViewController {

    private var viewModel: ViewModelProtocol
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.backgroundColor = .systemBackground
        questionLabel.font = .systemFont(ofSize: 24.0, weight: .semibold)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        return questionLabel
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        return submitButton
    }()
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchQuestions()
    }
    
    @objc private func onSubmit() {
        viewModel.onSubmit { [weak self] isCorrect in
            if isCorrect {
                let alertVC = UIAlertController(title: "Yay..!",
                                                message: "Correct Answer",
                                                preferredStyle: .alert)
                alertVC.addAction(.init(title: "Dismiss", style: .cancel))
                self?.present(alertVC,
                              animated: true)
            } else {
                let alertVC = UIAlertController(title: "Oops..!",
                                                message: "Incorrect Answer",
                                                preferredStyle: .alert)
                alertVC.addAction(.init(title: "Dismiss", style: .cancel))
                self?.present(alertVC,
                              animated: true)
            }
        }
    }
    
    private func fetchQuestions() {
        updateView(isLoading: true)
        viewModel.fetchQuestions { [weak self] result in
            DispatchQueue.main.async {
                self?.updateView(isLoading: false)
                self?.collectionView.reloadData()
                if case .failure(let error) = result {
                    self?.present(UIAlertController(title: "nil",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert),
                                  animated: true)
                }
            }
        }
    }
}

extension ViewController {
    
    private func updateView(isLoading: Bool) {
        collectionView.isUserInteractionEnabled = !isLoading
        activityIndicator.isHidden = !isLoading
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        questionLabel.text = viewModel.questions?.first?.question
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicator)
        view.addSubview(stackView)
        
        navigationItem.title = "Instacart Challenge"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.dataSource = self
        collectionView.delegate = self
        submitButton.addTarget(self, action: #selector(onSubmit), for: .touchDown)
        
        [questionLabel, collectionView, submitButton].forEach { stackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            collectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            submitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        let viewModel = viewModel.imageCellViewModels[indexPath.row]
        cell.configureCell(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (stackView.frame.width - 40)/2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        viewModel.imageCellViewModels[indexPath.row].isChosen.toggle()
        cell.animateTap()
    }
}
