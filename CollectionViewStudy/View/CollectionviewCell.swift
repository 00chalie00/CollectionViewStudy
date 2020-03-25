//
//  CollectionViewCell.swift
//  CollectionViewStudy
//
//  Created by formathead on 2020/03/25.
//  Copyright © 2020 formathead. All rights reserved.
//

import UIKit

class CollectionviewCell: UICollectionViewCell {
    @IBOutlet weak var titlelabel: UILabel?
    @IBOutlet weak var checkImg: UIImageView?
    
    
    var isEditing: Bool = false {
        //didset 값이 저장된 직후 호출 willset: 값이 저장되기 직전에 호출 프로퍼티 옵져버라고 함
        didSet {
            checkImg?.isHidden = !isEditing
        }
    }
    
    //UICollectionViewCell기본 클래스 내부에 있는 isSelected변수는 cell이 선택되어있을 경우에는 true
    //다른 cell이 선택되어있을 경우에는 false값으로 설정됩니다.
    
    override var isSelected: Bool {
        didSet{
            if isEditing {
                checkImg?.image = isSelected ? UIImage(systemName: "checkmark.seal.fill") : UIImage(systemName: "checkmark.seal")
            }
        }
    }
    
}
