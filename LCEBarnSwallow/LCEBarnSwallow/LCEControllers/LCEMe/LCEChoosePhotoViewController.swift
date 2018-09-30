//
//  LCEChoosePhotoViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/30.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

typealias LCEChoosePhotoViewControllerBlock = (_ images: Array<Any>) -> Void

class LCEChoosePhotoViewController: LCEBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LCEPhotoCollectionViewCellDelegate {
    
    var choosePhotoBlock: LCEChoosePhotoViewControllerBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "照片"
        self.view.backgroundColor = .white
        super.addLeftBarItem(target: self, imageName: "common_right1", sel: #selector(leftBarButtonItemAction))
        self.naviView.leftButton.setTitle("取消", for: .normal)
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
        setupViews()
    }
    
    // MARK: - Func
    
    func setupViews() -> Void {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.albumButton)
        self.view.addSubview(self.takePhotoButton)
        updateViewConstraints()
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func rightBarButtonItemAction() -> Void {
        if choosePhotoBlock != nil {
            choosePhotoBlock!(self.dataArray)
        }
        self.dismiss(animated: true, completion: nil)
    }
    func callBackBlock(_ block: @escaping LCEChoosePhotoViewControllerBlock) {
        choosePhotoBlock = block
    }
    @objc func getPhotoFromTheAlbum(sender: UIButton) {
        print("click the album button")
        if self.dataArray.count < 5 {
            let photoPicker =  UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.allowsEditing = true
            photoPicker.sourceType = .photoLibrary
            //        //在需要的地方present出来
            self.present(photoPicker, animated: true, completion: nil)
        }else {
            LCEProgressHUD.sharedInstance.showInfoWithStatus(status: "最多选择5张图片!")
        }
    }

    @objc func getPhotoFromTheCamera(sender: UIButton) {
        print("click the camera button")
        if self.dataArray.count < 5 {
            let photoPicker =  UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.allowsEditing = true
            photoPicker.sourceType = .camera
            //        //在需要的地方present出来
            self.present(photoPicker, animated: true, completion: nil)
        }else {
            LCEProgressHUD.sharedInstance.showInfoWithStatus(status: "最多选择5张图片!")
        }
    }
    
    // MARK: - UICollectionViewDataSource && Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LCEPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LCEPhotoCollectionViewCell", for: indexPath) as! LCEPhotoCollectionViewCell
        cell.delegate = self
        cell.deleteButton.tag = indexPath.row
        cell.photoImageView.image = UIImage.init(named: "place_image\(indexPath.row + 1)")
        cell.deleteButton.isHidden = true
        if self.dataArray.count >= indexPath.row + 1 {
            cell.photoImageView.image = self.dataArray[indexPath.row] as? UIImage
            cell.deleteButton.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row + 1) row")
    }
    
    // MARK: - LCEPhotoCollectionViewCellDelegate
    func photoCollectionViewCellDeletePhoto(index: Int) {
        self.dataArray.remove(at: index)
        self.collectionView.reloadData()
    }
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.dataArray.append(pickedImage)
            self.collectionView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        if error != nil {
            print("保存失败")
        } else {
            print("保存成功")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Layout
    override func updateViewConstraints() {
        super .updateViewConstraints()
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(LCENavHeight + 20)
            make.left.right.equalTo(0)
            make.height.equalTo(LCEScreenWidth * 2 / 3)
        }
        self.albumButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize(width: 260, height: 51))
        }
        
        self.takePhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.albumButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize(width: 260, height: 51))
        }
    }
    
    // MARK: - 懒加载
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let itemWidth: CGFloat = (LCEScreenWidth - 4 * 10) / 3
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: LCENavHeight + 20, width: LCEScreenWidth, height: LCEScreenWidth * 2 / 3), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "LCEPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LCEPhotoCollectionViewCell")
        return collectionView
    }()
    lazy var albumButton: UIButton = {
        let albumButton = UIButton.init()
        albumButton.setTitle("从相册选择", for: .normal)
        albumButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        albumButton.setTitleColor(lceTextColor, for: .normal)
        albumButton.setBackgroundImage(UIImage.init(named: "choose_photo_button"), for: .normal)
        albumButton.addTarget(self, action: #selector(getPhotoFromTheAlbum(sender:)), for: .touchUpInside)
        return albumButton
    }()
    lazy var takePhotoButton: UIButton = {
        let takePhotoButton = UIButton.init()
        takePhotoButton.setTitle("拍照", for: .normal)
        takePhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        takePhotoButton.setTitleColor(lceTextColor, for: .normal)
        takePhotoButton.setBackgroundImage(UIImage.init(named: "choose_photo_button"), for: .normal)
        takePhotoButton.addTarget(self, action: #selector(getPhotoFromTheCamera(sender:)), for: .touchUpInside)
        return takePhotoButton
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
