//
//  AppDelegate.swift
//  JoyCamera
//
//  Created by Clara Carneiro on 7/28/17.
//  Copyright (c) 2017 Joy. All rights reserved.
//

import UIKit
import AVFoundation

class View2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var cameraView: UIView!
    @IBOutlet var pickedImage: UIImageView!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var sessionOutputSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecJPEG])
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)

        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDuoCamera, AVCaptureDeviceType.builtInTelephotoCamera,AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
        
        for device in (deviceDiscoverySession?.devices)! {
            if(device.position == AVCaptureDevicePosition.front){
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if(captureSession.canAddInput(input)){
                        captureSession.addInput(input)
                        
                        if(captureSession.canAddOutput(sessionOutput)){
                            
                            captureSession.addOutput(sessionOutput)
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                            cameraView.layer.addSublayer(previewLayer)
                            
                            captureSession.startRunning()}}
                } catch{ print("exception on front camera!") }}}
    }
    
    
//    @IBAction func cameraButtonAction(_ sender: UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)}
//    }
//    
//    @IBAction func saveAction(_ sender: UIButton) {
//        let imageData = UIImageJPEGRepresentation(pickedImage.image!, 0.6)
//        let compressedJPEGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
//        saveNotice()
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [String: Any]){
//        
//        pickedImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage!
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func saveNotice(){
//        let alertController = UIAlertController(title: "Imagem Salva", message: "Sua foto foi salva com sucesso", preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(defaultAction)
//        present(alertController, animated: true, completion: nil)
//    }
}
