//
//  VideoPlayerViewController.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 03/01/25.
//

import UIKit

class VideoPlayerViewController: UIViewController, ViewModelContract, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var videoPlayerCollectionView: UICollectionView!
        
    private var videosViewModel: VideoListViewModel!
    private var commentsViewModel: CommentsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        videosViewModel = VideoListViewModel()
        videosViewModel.delegate = self
        videosViewModel.setup()
        
        commentsViewModel = CommentsViewModel()
        commentsViewModel.setup()
        commentsViewModel.delegate = self
    }
    
    private func setup() {
        videoPlayerCollectionView.dataSource = self
        videoPlayerCollectionView.delegate = self
        
        videoPlayerCollectionView.isPagingEnabled = true
        
        navigationController?.navigationBar.isHidden = true
        
        videoPlayerCollectionView.register(VideoPlayerCollectionViewCell.self, forCellWithReuseIdentifier: "VideoPlayerCell")
        
        videoPlayerCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
    }
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return videoPlayerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let collectionView = collectionViewFlowLayout.collectionView {
            collectionViewFlowLayout.itemSize = collectionView.frame.size
        }
    }
    
    // MARK: - ViewModel Contract Methods
    
    func willLoadData() {
        print("Load data started")
    }
    
    func didLoadData() {
        videoPlayerCollectionView.reloadData()
    }
    
    func showError(error: any Error) {
        print("Show error")
    }
    
   // MARK: - UICollectionView Datasource methods
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosViewModel.videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VideoPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPlayerCell", for: indexPath) as! VideoPlayerCollectionViewCell
       
        let videoModel = videosViewModel.videoList[indexPath.row]
        cell.videoUrl = videoModel.videoUrl
        cell.videoModel = videoModel
        cell.comments = commentsViewModel.comments
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? VideoPlayerCollectionViewCell else { return }
        cell.playVideo()
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? VideoPlayerCollectionViewCell else { return }
        cell.stopVideo()
    }
        
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewSize = collectionView.frame.size
        return CGSize(width: collectionViewSize.width, height: collectionViewSize.height)
    }
}
