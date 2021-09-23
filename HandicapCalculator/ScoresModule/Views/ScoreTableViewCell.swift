//
//  CoursesTableViewCell.swift
//  HandicapCalculator
//
//  Created by Артём on 20.09.2021.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    static let titleFont = UIFont.systemFont(ofSize: 18)
    
    private let mainCellStack: UIStackView = {
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 8
        
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        mainStack.axis = .horizontal
        mainStack.spacing = 16
        mainStack.distribution = .fill
        return mainStack
    }()
    private let scoreInfoStack: UIStackView = {
        let scoreInfoStack = UIStackView()
        
        scoreInfoStack.spacing = 8
        scoreInfoStack.axis = .vertical
        scoreInfoStack.distribution = .fill
        
        return scoreInfoStack
    }()
    
    private let scoreHandicapLabel: UILabel = {
        let handicapLabel = UILabel()
        handicapLabel.textColor = .tintColor
        handicapLabel.font = .systemFont(ofSize: 24)
        handicapLabel.textAlignment = .center
        handicapLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return handicapLabel
    }()
    
    private let separatorView = SeparatorView()
    
    private let propertiesStack: UIStackView = PropertiesStack()
    
    private var titleStack: UIStackView = {
        let titleStack = UIStackView()
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.distribution = .fill
        return titleStack
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = ScoreTableViewCell.titleFont
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = ScoreTableViewCell.titleFont
        dateLabel.textColor = PropertiesStack.parameterNameColor
        return dateLabel
    }()
    
    private lazy var slopeLabel: UILabel = PropertiesStack.createValueLabel()
    private lazy var ratingLabel: UILabel = PropertiesStack.createValueLabel()
    private lazy var grossLabel: UILabel = PropertiesStack.createValueLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from score: ScoreViewData) {
        let course = score.courseViewData
        
        nameLabel.text = course.name
        dateLabel.text = score.formattedDate
        ratingLabel.text = course.rating
        slopeLabel.text = course.slope
        grossLabel.text = score.grossScore
        scoreHandicapLabel.text = score.handicapDiff
    }
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(mainCellStack)
        
        mainCellStack.addArrangedSubview(scoreInfoStack)
        mainCellStack.addArrangedSubview(scoreHandicapLabel)
        
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(dateLabel)
        
        scoreInfoStack.addArrangedSubview(titleStack)
        scoreInfoStack.addArrangedSubview(separatorView)
        scoreInfoStack.addArrangedSubview(propertiesStack)
        
        let slopePropertyView = PropertiesStack.propertyView(named: "SR", valueLabel: slopeLabel)
        propertiesStack.addArrangedSubview(slopePropertyView)
    
        let ratingPropertyView = PropertiesStack.propertyView(named: "CR", valueLabel: ratingLabel)
        propertiesStack.addArrangedSubview(ratingPropertyView)
        
        let grossPropertyView = PropertiesStack.propertyView(named: "Gross", valueLabel: grossLabel)
        propertiesStack.addArrangedSubview(grossPropertyView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        let mainStackConstants = ConstraintsConstants(top: 8, trailing: 16, bottom: 8, leading: 16)
        mainCellStack.fillSuperview(using: mainStackConstants)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        separatorView.backgroundColor = selected ? .tintColor : .systemGray6
    }
}
