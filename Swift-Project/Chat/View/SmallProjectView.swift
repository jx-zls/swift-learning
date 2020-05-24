//
//  SmallProjectView.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/18.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class SmallProjectView: UIView {
    
    var scrollView: UIScrollView?
    var collectionView: UICollectionView?
    var tableView: UITableView?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    

}

extension SmallProjectView {
   private func setUI() {
    scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60))
    scrollView?.delegate = self
    scrollView?.backgroundColor  = UIColor.white
    scrollView!.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 59)
    self.addSubview(self.scrollView!)
    let layout = UICollectionViewFlowLayout.init()
    layout.itemSize = CGSize(width: 60, height: 60)
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 61), collectionViewLayout: layout)
    collectionView?.backgroundColor = UIColor.red
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(ProjectCell.classForCoder(), forCellWithReuseIdentifier: smallProject_cell)
    self.scrollView?.addSubview(collectionView!)
    }
}

extension SmallProjectView : UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 3 : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: smallProject_cell, for: indexPath) as! ProjectCell
        cell.passValue(index: indexPath.row)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll ==", scrollView.contentOffset)
        tableView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: SCREEN_WIDTH, right: SCREEN_HEIGHT)
//        tableView?.contentOffset = CGPoint.init(x: 0, y: 0)
    }
}


