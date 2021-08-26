//
//  ExpandTVC.swift
//  FoodSafety
//
//  Created by S Yi on 8/22/21.
//

import UIKit

protocol ExpandTVCDelegate {
    func segmentSelected()
    func expand(_ row:Int)
}

class ExpandTableViewCell: UITableViewCell, UITextFieldDelegate {
    let titleLabel:UILabel
    let commentButton:UIButton
    let segmentedCtrl:UISegmentedControl
    let commentLabel:UILabel
    let inputTextField:UITextField
    var area:AreaInfo?
    var delegate:ExpandTVCDelegate?

    required init?(coder: NSCoder) {
        self.titleLabel = UILabel.init()
        self.commentButton = UIButton.init()
        self.segmentedCtrl = UISegmentedControl.init(items: ["", "", ""])
        self.commentLabel = UILabel.init()
        self.inputTextField = UITextField.init()
        super.init(coder:coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup title label
        titleLabel.font = UIFont.systemFont(ofSize: 18.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        // Setup comment button
        commentButton.setImage(UIImage.init(systemName:"plus.bubble"), for: UIControl.State.normal)
        commentButton.tintColor = UIColor.systemRed
        commentButton.addAction(UIAction.init(handler: {(action) in
            if let area = self.area {
                area.isCommenting = !area.isCommenting
                if (area.isCommenting == false && self.inputTextField.isFirstResponder) {
                    self.inputTextField.resignFirstResponder()
                }
                self.delegate?.expand(self.tag)
            }
        }), for: UIControl.Event.touchUpInside)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(commentButton)
        // Setup segmented control
        segmentedCtrl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13.0)], for: UIControl.State.normal)
        segmentedCtrl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13.0), NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.selected)
        let firstAction = UIAction(title:"Acceptable") {(action) in
            self.segmentedCtrl.selectedSegmentTintColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.8)
            self.area?.status = .acceptable
            self.delegate?.segmentSelected()
        }
        let secondAction = UIAction(title:"Unacceptable") {(action) in
            self.segmentedCtrl.selectedSegmentTintColor = UIColor.init(red: 0.5, green: 0.0, blue: 0.0, alpha: 0.8)
            self.area?.status = .unacceptable
            self.delegate?.segmentSelected()
        }
        let thirdAction = UIAction(title:"N/A") {(action) in
            self.segmentedCtrl.selectedSegmentTintColor = UIColor.systemGray
            self.area?.status = .notAvailable
            self.delegate?.segmentSelected()
        }
        segmentedCtrl.setAction(firstAction, forSegmentAt: 0)
        segmentedCtrl.setAction(secondAction, forSegmentAt: 1)
        segmentedCtrl.setAction(thirdAction, forSegmentAt: 2)
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(segmentedCtrl)
        // Setup comment label
        commentLabel.font = UIFont.systemFont(ofSize: 18.0)
        commentLabel.textColor = UIColor.systemRed
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(commentLabel)
        // Setup input text field
        inputTextField.font = UIFont.systemFont(ofSize: 17.0)
        inputTextField.textColor = UIColor.black
        inputTextField.backgroundColor = UIColor.white
        inputTextField.layer.borderColor = UIColor.black.cgColor
        inputTextField.layer.borderWidth = 1.0
        inputTextField.layer.cornerRadius = 5.0
        inputTextField.delegate = self
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(inputTextField)
        // Setup constraints
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 3.0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 350.0).isActive = true
        NSLayoutConstraint(item: commentButton, attribute: .centerY, relatedBy: .equal, toItem: self.segmentedCtrl, attribute: .centerYWithinMargins, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: commentButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0).isActive = true
        NSLayoutConstraint(item: commentButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0).isActive = true
        NSLayoutConstraint(item: commentButton, attribute: .trailing, relatedBy: .equal, toItem: segmentedCtrl, attribute: .leadingMargin, multiplier: 1.0, constant: -15.0).isActive = true
        NSLayoutConstraint(item: segmentedCtrl, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1.0, constant: 4.0).isActive = true
        NSLayoutConstraint(item: segmentedCtrl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 33.0).isActive = true
        NSLayoutConstraint(item: segmentedCtrl, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 330.0).isActive = true
        NSLayoutConstraint(item: segmentedCtrl, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: commentLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: commentLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 3.0).isActive = true
        NSLayoutConstraint(item: commentLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: commentLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 350.0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 37.0).isActive = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func updateCommentLabel(_ text:String, user:String, date:Date) {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MM/dd/yy"
        commentLabel.text = "\(user) on \(formatter.string(from: date)): \(text)"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if let thisArea = area {
                commentLabel.isHidden = false
                thisArea.comment = text
                thisArea.commentDate = Date.init(timeIntervalSinceNow: 0)
                updateCommentLabel(text, user: thisArea.commentUser!, date: thisArea.commentDate!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        area?.isCommenting = false
        textField.resignFirstResponder()
        self.delegate?.expand(self.tag)
        return true
    }
    
    func configure(_ area: AreaInfo) {
        self.area = area
        titleLabel.text = area.title
        switch area.status {
        case.acceptable:
            segmentedCtrl.selectedSegmentIndex = 0
            segmentedCtrl.selectedSegmentTintColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.85)
        case.unacceptable:
            segmentedCtrl.selectedSegmentIndex = 1
            segmentedCtrl.selectedSegmentTintColor = UIColor.init(red: 0.5, green: 0.0, blue: 0.0, alpha: 0.85)
        case.notAvailable:
            segmentedCtrl.selectedSegmentIndex = 2
            segmentedCtrl.selectedSegmentTintColor = UIColor.systemGray
        case.none:
            segmentedCtrl.isSelected = false
        }
        if let comment = area.comment {
            commentLabel.isHidden = area.isCommenting ? true : false
            updateCommentLabel(comment, user: area.commentUser!, date: area.commentDate!)
        }
        else {
            commentLabel.isHidden = false
        }
        if (area.isCommenting) {
            commentButton.setImage(UIImage.init(systemName:"xmark"), for: UIControl.State.normal)
            inputTextField.isHidden = false
            inputTextField.becomeFirstResponder()
        }
        else {
            commentButton.setImage(UIImage.init(systemName:"plus.bubble"), for: UIControl.State.normal)
            inputTextField.isHidden = true
        }
    }
}
