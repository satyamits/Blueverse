//
//  CollectionViewCell.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//


import UIKit

class CollectionViewCell: UICollectionViewCell {

	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}
	
    weak var delegate: NSObjectProtocol?
	
	func configure(_ item: Any?) {
		
	}
	
}

class CollectionReusableView: UICollectionReusableView {
	
	var item: Any? {
		didSet {
			self.configure(self.item)
		}
	}
	
    weak var delegate: NSObjectProtocol?
	
	func configure(_ item: Any?) {
		
	}
	
}
