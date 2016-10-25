
//
//  chatController.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class ChatController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var chatBox: UITextField!
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    let username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ("Chat - " + username)
        
        // remove back button
        self.hideBackButton()
        // add logout button
        self.addLogoutButton()
        // configure collection
        self.collectionFlowLayout.estimatedItemSize = CGSize.init(width: self.view.bounds.size.width, height: 50.0)
        self.collectionFlowLayout.minimumInteritemSpacing = 10.0
        let nib : UINib = UINib(nibName: "ChatCollectionViewCell", bundle: nil)
        self.collection.register(nib, forCellWithReuseIdentifier: "ChatCollectionViewCell")
        //fetch chat info - needs repository
        
        //animations for text and keyboard
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func addLogoutButton() {
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutPressed))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    func logoutPressed() {
        self.userlogout()
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
    }
    
    // -- Collection Delegates --
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCollectionViewCell", for: indexPath) as! ChatCollectionViewCell
        cell.chatInfo.text = "Raimon - 23:53"
        cell.conversationText.text = "askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf askjfald jfadlsfkja lñdkfjañlsdkfj añlsdfkj añlsdjkf "
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
