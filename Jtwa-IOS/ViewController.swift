//
//  ViewController.swift
//  Jtwa-IOS
//
//  Created by 김대희 on 2021/11/25.
//

import UIKit
import QuartzCore
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var enView: UIView!
    @IBOutlet weak var jpView: UIView!
    
    @IBOutlet weak var enTextView: UITextView!
    @IBOutlet weak var jpTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar()
        
        jpTextView.isEditable = false
        jpTextView.isSelectable = false
        enView.layer.cornerRadius = 10
        jpView.layer.cornerRadius = 10
    }
    
    @IBAction func sendPstButton(_ sender: Any) {
        AF.request("http://192.168.8.103:8080/test" ,
                   method: .post,
                   parameters: ["text" : "\(String(describing: enTextView.text))"],
                   encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseString { response in
                //            return response
                switch(response.result) {
                case .success(_):
                    if let data = response.value{
                        print("-----------\(data)--------------")
                        self.jpTextView.text = "\(data)"
                    }
                case .failure(_):
                    print("Error message:\(String(describing: response.error))")
                    self.jpTextView.text = "서버 에러가 발생했습니다. 0824dh#naver.com으로 문의주세요."
                    break
                }
            }
    }
    func setNavagationBar() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainLogio")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
    }
}

