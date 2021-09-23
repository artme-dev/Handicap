//
//  CoursesTableViewController.swift
//  HandicapCalculator
//
//  Created by Артём on 20.09.2021.
//

import UIKit

class ScoresTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "scoresTabeCell"

    var presenter: ScoresPresenterProtocol?
    
    private var scores: [ScoreViewData]?
    private var selectedScoreIndex: Int?
    
    private var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = "No scores"
        hintLabel.isHidden = true
        return hintLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        configureTableView()
        configureNavigationBar()
        
        tableView.addSubview(hintLabel)
        setConstraints()
        
        presenter?.updateScores()
    }
    
    private func setConstraints() {
        hintLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        hintLabel.topAnchor.constraint(equalTo: tableView.topAnchor,
                                       constant: 16).isActive = true
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
    }
    
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let creationButton = UIButton()
        let buttonImage = UIImage.createButtonIcon.withTintColor(.tintColor)
        creationButton.setImage(buttonImage, for: .normal)
        creationButton.addTarget(self, action: #selector(showScoreCreationForm), for: .touchUpInside)
        let creationButtonItem = UIBarButtonItem(customView: creationButton)
        self.navigationItem.rightBarButtonItem = creationButtonItem
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let scoresCount = scores?.count ?? 0
        hintLabel.isHidden = (scoresCount != 0)
        return scoresCount
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        guard let scoreCell = cell as? ScoreTableViewCell else {
            return UITableViewCell()
        }
        
        let score = scores![indexPath.row]
        scoreCell.configure(from: score)
        
        return scoreCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        presenter?.deleteScore(withIndex: indexPath.row)
    }
    
    @objc private func showScoreCreationForm() {
        let scoreInfoVC = ScoreInfoViewController()
        scoreInfoVC.saveButtonAction = { [weak self] in
            guard let self = self else { return }
            let scoreInputData = scoreInfoVC.viewData
            self.presenter?.createScores(scoreInputData)
        }
        navigationController?.show(scoreInfoVC, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scoreIndex = indexPath.row
        selectedScoreIndex = scoreIndex
        presenter?.selectScore(withIndex: scoreIndex)
    }

}

extension ScoresTableViewController: ScoresView {
    func showScores(_ scores: [ScoreViewData]) {
        self.scores = scores
        tableView.reloadData()
    }
    
    func showScoreInfo(_ score: ScoreViewData) {
        let scoreInfoVC = ScoreInfoViewController()
        scoreInfoVC.fillFields(using: score)
        
        scoreInfoVC.saveButtonAction = {[weak self] in
            guard let self = self else { return }
            let scoreInputData = scoreInfoVC.viewData
            self.presenter?.editScore(scoreViewData: scoreInputData)
        }
        
        navigationController?.show(scoreInfoVC, sender: self)
    }
    
    func hideScoreInfo() {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlertMessage(_ message: String, titled title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
