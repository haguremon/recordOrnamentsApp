//
//  DescriptionViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/08.
//

import UIKit

class DescriptionViewController: UIViewController {
    struct Photo {
        var imageName: String
    }
    //"gear","magnifyingglass","clock"
    var photoList = [
        Photo(imageName: "gear"),
        Photo(imageName: "magnifyingglass"),
        Photo(imageName: "clock")
    ]
    private var offsetX: CGFloat = 0
    private var timer: Timer!
    
    
    @IBOutlet weak var belowView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        scrollViewsetup()
        setUpImageView()
        
        self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
    }
    
    // タイマーを破棄
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let workingTimer = self.timer {
            workingTimer.invalidate()
        }
    }
    
    func scrollViewsetup(){
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: belowView.frame.size.width * 3, height: belowView.frame.size.height)
    }
    func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: Photo) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        let image = UIImage(systemName:  image.imageName)
        imageView.image = image
        return imageView
    }
    func setUpImageView() {
        for i in 0 ..< self.photoList.count {
            let photoItem = self.photoList[i]
            let imageView = createImageView(x: 0, y: 0, width: self.belowView.frame.size.width, height: self.scrollView.frame.size.height, image: photoItem)
            imageView.frame = CGRect(origin: CGPoint(x: self.belowView.frame.size.width * CGFloat(i), y: 0), size: CGSize(width: self.belowView.frame.size.width, height: self.scrollView.frame.size.height))
            self.scrollView.addSubview(imageView)
        }
        
        
    }
    // offsetXの値を更新することページを移動
    @objc func scrollPage() {
        // 画面の幅分offsetXを移動
        self.offsetX += scrollView.frame.size.width
        // 3ページ目まで移動したら1ページ目まで戻る
        if self.offsetX < scrollView.frame.size.width * 3 {
            UIView.animate(withDuration: 0.3) {
                self.scrollView.contentOffset.x = self.offsetX
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.offsetX = 0
                self.scrollView.contentOffset.x = self.offsetX
            }
        }
    }
    
    
    @IBAction func backToSreenButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}



extension DescriptionViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scrollViewのページ移動に合わせてpageControlの表示も移動
        self.pageControl.currentPage = Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        print("\(pageControl.currentPage)")
        // offsetXの値を更新
        self.offsetX = self.scrollView.contentOffset.x
    }
    
}
