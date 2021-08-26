//
//  RiskAssessmentVC.swift
//  FoodSafety
//
//  Created by S Yi on 8/22/21.
//

import UIKit

class RiskAssessmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandTVCDelegate {

    let tableView = UITableView.init()
    var areaList = [AreaInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib.init(nibName: "ExpandTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "reuseID")
        // Setup the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        // Setup the header at the top of the page
        let tblHeader = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 58.0))
        tblHeader.text = "  Cooler Facility Risk Assessment"
        tblHeader.font = UIFont.boldSystemFont(ofSize: 33.0)
        tblHeader.backgroundColor = UIColor.white
        tblHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tblHeader)
        // Setup the "Save Changes" button
        let svButton = UIButton.init()
        svButton.setAttributedTitle(NSAttributedString.init(string: "Save Changes", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22.0)]), for: UIControl.State.normal)
        svButton.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        svButton.backgroundColor = UIColor.white
        svButton.layer.borderWidth = 0.25
        svButton.addAction(UIAction.init(handler: {(action) in
            self.svButtonPressed()
        }), for: UIControl.Event.touchUpInside)
        svButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(svButton)
        // Setup the "Final Submit" button
        let sbmtButton = UIButton.init()
        sbmtButton.setAttributedTitle(NSAttributedString.init(string: "Final Submit", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22.0)]), for: UIControl.State.normal)
        sbmtButton.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        sbmtButton.backgroundColor = UIColor.white
        sbmtButton.layer.borderWidth = 0.25
        sbmtButton.addAction(UIAction.init(handler: {(action) in
            self.sbmtButtonPressed()
        }), for: UIControl.Event.touchUpInside)
        sbmtButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sbmtButton)
        // Setup the view's constraints
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: tblHeader, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: svButton, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tblHeader, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tblHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: tblHeader, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tblHeader, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: svButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: svButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0).isActive = true
        NSLayoutConstraint(item: svButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: svButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: sbmtButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: sbmtButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0).isActive = true
        NSLayoutConstraint(item: sbmtButton, attribute: .leading, relatedBy: .equal, toItem: svButton, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: sbmtButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let header = UITableViewHeaderFooterView.init()
            let attributedText = NSAttributedString.init(string: " Areas of observation - please note concern(s) if any, as well as corrective action(s)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0), NSAttributedString.Key.foregroundColor : UIColor.white])
            var configuration = header.defaultContentConfiguration()
            configuration.attributedText = attributedText
            header.contentConfiguration = configuration
            header.backgroundView = UIView.init()
            header.backgroundView?.backgroundColor = UIColor.gray
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 62.0
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let area = self.areaList[indexPath.row]
        if (area.isCommenting) {
            return 105.0
        }
        if let comment = area.comment {
            if comment.count > 0 {
                return 105.0
            }
        }
        return 62.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"reuseID", for: indexPath) as! ExpandTableViewCell
        cell.configure(areaList[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor.init(white: 0.80, alpha: 0.80)
        }
        return cell
    }

    func sbmtButtonPressed() {
        var index = 0
        var selectionsDone = true
        for area in areaList {
            if area.status == .none {
                selectionsDone = false
            }
            if area.isCommenting == true {
                let cell = tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as? ExpandTableViewCell
                if let text = cell?.inputTextField.text {
                    area.comment = text
                    area.commentDate = Date.init(timeIntervalSinceNow: 0)
                }
                cell?.inputTextField.resignFirstResponder()
                area.isCommenting = false
                tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: UITableView.RowAnimation.none)
            }
            index += 1
        }
        if selectionsDone == false {
            print("Selections not finished")
        }
        else {
            print("Continue with submit")
        }
    }
    
    func svButtonPressed() {
        
    }
    
    func segmentSelected() {
        let header = tableView.headerView(forSection: 0)
        var selectionsDone = true
        for area in areaList {
            if area.status == .none {
                selectionsDone = false
            }
        }
        header?.backgroundView?.backgroundColor = selectionsDone ? UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.80) : UIColor.gray
    }
    
    func expand(_ row: Int) {
        self.tableView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: UITableView.RowAnimation.automatic)
    }
}
