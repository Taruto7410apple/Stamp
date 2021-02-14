//
//  ViewController.swift
//  Stamp
//
//
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var imageNameArray:[String]=["hana", "hoshi","onpu","shitumon"]
    
    var imageIndex:Int=0
    
    @IBOutlet var haikeiImageView:UIImageView!
    
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedFirst(){
        imageIndex=1
        
    }
    
    @IBAction func selectedSecond(){
        imageIndex=2
        
    }
    @IBAction func selectedThrid(){
        imageIndex=3
        
    }
    
    @IBAction func selectedForth(){
        imageIndex=4
        
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?){
        //タッチされたいちを取得
        let touch:UITouch=touches.first!
        let location:CGPoint=touch.location(in: self.view)
        
        //押すボタンが選ばれている
        if imageIndex != 0{
            //スタンプサイズを40pxの正方形に指定
            imageView=UIImageView(frame: CGRect(x:0,y:0,width:40,height:40))
            //押されたスタンプの画像を設定
            let image: UIImage = UIImage(named: imageNameArray[imageIndex-1])!
            imageView.image=image
            
            //タッチされた位置に画像を置く
            imageView.center=CGPoint(x: location.x,y:location.y)
            
            //画像を表示する
            self.view.addSubview(imageView)
        }
    }
    
    @IBAction func bak(){
        self.imageView.removeFromSuperview()
    }
    
    @IBAction func selectedBackground(){
        
        //UIImagePickerControllerのインスタンスを作る
        let imagePickerController: UIImagePickerController=UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType=UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate=self
        imagePickerController.allowsEditing=true
        
        //フォトライブラリを呼び出す・画面遷移
        self.present(imagePickerController,animated:true,completion:nil)
    }
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]){
        //imageに選んだ画像を設定する
        let image = info[.originalImage] as? UIImage
        //imageを背景に設定する
        haikeiImageView.image=image
        //フォトライブラリを閉じる
        self.dismiss(animated: true,completion:nil)
    }
    
    //スタンプを押した画像を保存する
    @IBAction func save(){
        //スクリーンショットを作成
        let rect:CGRect=CGRect(x:0,y:30,width:320,height:380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }


}

