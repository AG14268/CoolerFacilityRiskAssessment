//
//  DocumentsVC.swift
//  FoodSafety
//
//  Created by S Yi on 8/22/21.
// 

import UIKit

class DocumentsVC: UIViewController {

    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.title = "Documents"
        self.navigationController?.title = "Food Safety"
        let area1 = AreaInfo.init()
        area1.title = "Surrounding Areas / Adjacent Activities"
        let area2 = AreaInfo.init()
        area2.title = "Building Grounds"
        let area3 = AreaInfo.init()
        area3.title = "Building Stucture"
        let area4 = AreaInfo.init()
        area4.title = "Water System"
        let area5 = AreaInfo.init()
        area5.title = "Other"
        let vc = RiskAssessmentVC.init()
        vc.areaList = [area1, area2, area3, area4, area5]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
