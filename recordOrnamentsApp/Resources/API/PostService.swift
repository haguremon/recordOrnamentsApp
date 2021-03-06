//
//  PostService.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/10/26.
//

import Foundation
import Firebase

struct  PostService {
    //MARK: - Firebaseに保存する処理
    static func uploadPost(caption: String, image: UIImage, imagename: String, user: User,completion: @escaping(FirestoreCompletion)){
        // typealias FirestoreCompletion = (Error?) -> Void
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //ここでストレージにイメージを入れてからimageUrlのコールバックを使って（completion: @escaping (String) -> Void）なのでimageUrlを取得する
        ImageUploader.uploadImage(image: image) { (imageUrl) in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "imageUrl": imageUrl,
                        "imagename": imagename,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.name] as [String: Any]
            
            COLLETION_POSTS.addDocument(data: data, completion: completion)
            // DocumentReference.documentID
           // self.updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        //フィルーどのownerUidと引数が同じ時に
        let query = COLLETION_POSTS.whereField("ownerUid", isEqualTo: uid)
        //そのユーザーの情報を取得することができる
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({Post(postId: $0.documentID, dictonary: $0.data())})
            //並び替え？
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)
            
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post) -> Void) {
        COLLETION_POSTS.document(postId).getDocument { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            let post = Post(postId: snapshot.documentID, dictonary: data)
            completion(post)
        }
    }

    
    
    
}
