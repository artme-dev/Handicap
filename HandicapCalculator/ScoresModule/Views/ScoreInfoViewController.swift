//
//  CourseInfoView.swift
//  HandicapCalculator
//
//  Created by Артём on 21.09.2021.
//

import UIKit

class ScoreInfoViewController: UIViewController {
    
    private var activeTextField: UITextField?
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    private let fieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let nameFieldView: NamedFieldView = {
        let fieldView = NamedFieldView()
        fieldView.configure(name: "Name", placeholder: "Course name")
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        return fieldView
    }()
    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
    }()
    private let slopeFieldView: NamedFieldView = {
        let fieldView = NamedFieldView()
        fieldView.configure(name: "Slope", placeholder: "55 - 155")
        fieldView.field.keyboardType = .numberPad
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        return fieldView
    }()
    private let ratingFieldView: NamedFieldView = {
        let fieldView = NamedFieldView()
        fieldView.configure(name: "Rating", placeholder: "48.0 - 85.0")
        fieldView.field.keyboardType = .decimalPad
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        return fieldView
    }()
    private let pccFieldView: NamedFieldView = {
        let fieldView = NamedFieldView()
        fieldView.configure(name: "PCC", placeholder: "Playing conditions")
        fieldView.field.keyboardType = .decimalPad
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        return fieldView
    }()
    private let grossFieldView: NamedFieldView = {
        let fieldView = NamedFieldView()
        fieldView.configure(name: "Gross", placeholder: "Gross score")
        fieldView.field.keyboardType = .decimalPad
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        return fieldView
    }()
    
    var saveButtonAction: (()->Void)?
    
    @objc private func onSaveButtonTap() {
        saveButtonAction?()
    }
    
    private let saveButton: UIButton = {
        let saveButton = CustomizedButton()
        saveButton.configure(title: "Save")
        saveButton.addTarget(self, action: #selector(onSaveButtonTap), for: .touchUpInside)
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        title = "Score"
        view.backgroundColor = .systemGray6

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let tapRecognise = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapAction))
        scrollView.addGestureRecognizer(tapRecognise)
    
        contentView.addSubview(fieldsStack)
        contentView.addSubview(datePickerView)
    
        fieldsStack.addArrangedSubview(nameFieldView)
        fieldsStack.addArrangedSubview(slopeFieldView)
        fieldsStack.addArrangedSubview(ratingFieldView)
        fieldsStack.addArrangedSubview(pccFieldView)
        fieldsStack.addArrangedSubview(grossFieldView)
        
        contentView.addSubview(saveButton)
        
        setConstraints()
        setFieldsDelegate()
        addKeyboardObservers()
    }
    
    @objc private func scrollViewTapAction() {
        view.endEditing(true)
    }
    
    private func setFieldsDelegate() {
        nameFieldView.field.delegate = self
        slopeFieldView.field.delegate = self
        ratingFieldView.field.delegate = self
        pccFieldView.field.delegate = self
        grossFieldView.field.delegate = self
    }
    
    private func setConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let datePickerConstraints = ConstraintsConstants(top: 24, trailing: nil, bottom: nil, leading: 16)
        datePickerView.fillSuperview(using: datePickerConstraints)
        
        let fieldsStackConstraints = ConstraintsConstants(top: nil, trailing: 16, bottom: nil, leading: 16)
        fieldsStack.fillSuperview(using: fieldsStackConstraints)
        fieldsStack.topAnchor.constraint(equalTo: datePickerView.bottomAnchor,
                                         constant: 16).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 32).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func fillFields(using score: ScoreViewData) {
        
        let course = score.courseViewData
        
        if let date = score.date {
            datePickerView.date = date
        }
        nameFieldView.field.text = course.name
        slopeFieldView.field.text = course.slope
        ratingFieldView.field.text = course.rating
        pccFieldView.field.text = score.pcc
        grossFieldView.field.text = score.grossScore
    }
    
    var viewData: ScoreViewData {
        let courseViewData = CourseViewData(name: nameFieldView.field.text,
                                            slope: slopeFieldView.field.text,
                                            rating: ratingFieldView.field.text)
        
        let scoreViewData = ScoreViewData(courseViewData: courseViewData,
                                          formattedDate: nil,
                                          date: datePickerView.date,
                                          pcc: pccFieldView.field.text,
                                          grossScore: grossFieldView.field.text,
                                          handicapDiff: nil)
        
        return scoreViewData
    }
}

// MARK: - Keyboard Observing

extension ScoreInfoViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardSize = (keyboardFrame as? NSValue)?.cgRectValue else {
            return
        }
        
        let bottomInset = keyboardSize.height - view.safeAreaInsets.bottom
        var contentInsets: UIEdgeInsets = .zero
        contentInsets.bottom = bottomInset
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

// MARK: - UITextFieldDelegate

extension ScoreInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
      }
        
      func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
      }
}
