//
//  HandicapViewController.swift
//  Handicap
//
//  Created by Артём on 23.09.2021.
//

import UIKit

class HandicapViewController: UIViewController {
    
    static let handicapScoreFont: UIFont = .systemFont(ofSize: 48)
    static let handicapInfoColor: UIColor = .gray
    
    var presenter: HandicapPresenterProtocol?
    
    private var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "Your personal handicap index"
        infoLabel.textAlignment = .center
        infoLabel.textColor = HandicapViewController.handicapInfoColor
        return infoLabel
    }()
    private var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.numberOfLines = 0
        hintLabel.textColor = HandicapViewController.handicapInfoColor
        hintLabel.textAlignment = .center
        hintLabel.text = "You should have at least 3 score records to get your handicap index"
        hintLabel.isHidden = false
        return hintLabel
    }()
    
    private var handicapScoreLabel: UILabel = {
        let handicapLabel = UILabel()
        handicapLabel.translatesAutoresizingMaskIntoConstraints = false
        handicapLabel.font = HandicapViewController.handicapScoreFont
        handicapLabel.textColor = .tintColor
        return handicapLabel
    }()
    
    var handicapScore: String? {
        get {
            return handicapScoreLabel.text
        }
        set {
            handicapScoreLabel.text = newValue
            if handicapScore != nil {
                setScoreHidden(false)
            } else {
                setScoreHidden(true)
            }
        }
    }
    
    private func setScoreHidden(_ isHidden: Bool) {
        handicapScoreLabel.isHidden = isHidden
        infoLabel.isHidden = isHidden
        hintLabel.isHidden = !isHidden
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        view.addSubview(infoLabel)
        view.addSubview(handicapScoreLabel)
        view.addSubview(hintLabel)
        
        handicapScore = nil
        
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handicapScore = presenter?.getHandicapIndex()
    }
    
    private func setConstraints() {
        handicapScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        handicapScoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hintLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let hintLabelConstants = ConstraintsConstants(top: nil, trailing: 32, bottom: nil, leading: 32)
        hintLabel.fillSuperview(using: hintLabelConstants)
        
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: handicapScoreLabel.bottomAnchor,
                                       constant: 8).isActive = true
        let infoLabelConstants = ConstraintsConstants(top: nil, trailing: 32, bottom: nil, leading: 32)
        infoLabel.fillSuperview(using: infoLabelConstants)
    }
}
