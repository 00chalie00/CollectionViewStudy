//
//  Collectionview.swift
//  CollectionViewStudy
//
//  Created by formathead on 2020/03/24.
//  Copyright © 2020 formathead. All rights reserved.
//

import UIKit

class Collectionview: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var deleteBTn: UIBarButtonItem!
    
    var collectionData = ["1", "2", "3", "4", "5", "6" , "7", "8", "9", "10"]
    var selectedData = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        
        deleteBTn.isEnabled = false
        
        //navigationBar에 왼쪽 아이템 추가
        navigationItem.leftBarButtonItem = editButtonItem
        //Toolbar 활성화 (storyboard의 navigationController 선택 후 shows toolbar Check
        navigationController?.isToolbarHidden = true
        
    }
    
    //뷰 컨트롤러가 편집 가능한 뷰를 표시할지 여부를 설정합니다.
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //NavigationBarItem의 edit버튼의 edit/done 여부에 따라 editing 변수의 bool이 결정됨
        deleteBTn.isEnabled = !editing
        //collectionview에서 Cell 다수 선택 가능하도록 적용할지 여부 판단
        collectionview.allowsMultipleSelection = editing
        //edit 버튼 선택 후 edit 가능한 상태에서 선택한 cell만 나타나는 상황이며, 이때의 선택된(보이는 활성호된)cell의 indexpath 취득
        let indexpath = collectionview.indexPathsForVisibleItems
        for index in indexpath {
            //cellForItem 지정한 indexpath에 보이는 cell객체를 return
            let cell = collectionview.cellForItem(at: index) as! CollectionviewCell
            cell.isEditing = editing
        }
        
        if editing {
            navigationController?.isToolbarHidden = false
            deleteBTn.isEnabled = true
        } else {
            navigationController?.isToolbarHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailview" {
            let destion = segue.destination as? DetailViewController
//            let index = collectionview.indexPathsForSelectedItems?.first
//            destion?.detailText = collectionData[index!.row]
            
            if let index = sender as? IndexPath {
                destion?.detailText = collectionData[index.row]
            }
        }
    }
    
    //Collectionview에 Item 추가
    @IBAction func addItem() {
        //다수의 Cell 추가, 삭제, Reload, Move시 사용
        collectionview.performBatchUpdates({
            for _ in 0..<5 {
                //Array에 추가할 String 생성
                let addText = "\(collectionData.count + 1)"
                //Array에 생성된 String 추가
                collectionData.append(addText)
                //Array에 Add 후 Index를 생성
                let index = IndexPath(row: collectionData.count - 1, section: 0)
                //Array에 추가된 항목을 Collectionview에 삽입
                collectionview.insertItems(at: [index])
            }
        }, completion: nil)
    }
    
    //Collectionview에서 Item 삭제
    @IBAction func deleteItem() {
        //내가한 방법
        //        //선택한 Item 갯수 확인 (didsel Protocol에서 선택 시 selectData Array에 선택 항목 저장)
        //        let deleteItemCount = selectedData.count
        //        for item in 0..<deleteItemCount {
        //            //Array에서 삭제
        //            collectionData.remove(at: selectedData[item])
        //            let index = IndexPath(row: selectedData[item], section: 0)
        //            //CollectionviewCell에서 삭제
        //            collectionview.deleteItems(at: [index])
        //            //선택항목 초기화
        //            selectedData = []
        //        }
        
        //강의에 나온 내용
        if let selectedIndex = collectionview.indexPathsForSelectedItems {
            //reverse로 sort하는 이유는 선택한 cell을 순서대로 8,9,10 받으면 문제 없지만, 10,9,8으로 선택 되었을 경우 10을 지워 버리면 다음에 9를 지울 때 range error이 발생한다.
            //밑의 indexs는 [int]이다.
            let indexs = selectedIndex.map{$0.item}.sorted().reversed()
            print(indexs)
            for index in indexs {
                collectionData.remove(at: index)
            }
            collectionview.deleteItems(at: selectedIndex)
        }
    }
}

extension Collectionview: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! CollectionviewCell
        cell.titlelabel?.text = collectionData[indexPath.row]
        cell.isEditing = isEditing
        
        return cell
    }
    
    //Cell을 선택하였을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            performSegue(withIdentifier: "detailview", sender: indexPath)
            deleteBTn.isEnabled = true
        }
        //        selectedData.append(indexPath.row)
        //        print(selectedData)
    }
    
    //Cell을 선택하지 않았을 때
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let index = collectionView.indexPathsForSelectedItems, index.count == 0 {
                navigationController?.isToolbarHidden = true
            }
            
        }
    }
}
