//
//  UserProfilePhotoCell.swift
//  PetSaver
//
//  Created by Boaz Froog on 15/09/2019.
//  Copyright © 2019 Boaz Froog. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch post image: ", err)
                    return
                }
                
                guard let imageData = data else { return }
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
            }.resume()
            
        }
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
