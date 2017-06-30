//
//  AppDelegate.swift
//  JoyCamera
//
//  Created by Clara Carneiro on 7/28/17.
//  Copyright (c) 2017 Joy. All rights reserved.
//

import UIKit
import AVFoundation

class View2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraView: UIView!
    @IBOutlet var pickedImage: UIImageView!

    var captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var stillImageOutput = AVCaptureStillImageOutput()
    var frontCamera: Bool = false
    var didtakePhoto = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        frontCamera(frontCamera)
        if captureDevice != nil { beginSession() }
        
        // Do any additional setup after loading the view.
    }
    
    func beginSession() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.cameraView.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.cameraView.layer.bounds
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureSession.startRunning()
        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        if captureSession.canAddOutput(stillImageOutput) {captureSession.addOutput((stillImageOutput))}
    }
    
    func frontCamera(_ front: Bool){
        let devices = AVCaptureDevice.devices()
        
        do {try captureSession.removeInput(AVCaptureDeviceInput(device: captureDevice))} catch { print ("error while looking for devices")}
        
        for device in devices!{
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)){
                if front {
                    if (device as AnyObject).position == AVCaptureDevicePosition.front {
                        captureDevice = device as? AVCaptureDevice
                        do {try captureSession.addInput(AVCaptureDeviceInput(device:captureDevice))} catch { print ("error while setting camera position")}
                        break }}
                else {
                    if (device as AnyObject).position == AVCaptureDevicePosition.back {
                        captureDevice = device as? AVCaptureDevice
                            
                        do {try captureSession.addInput(AVCaptureDeviceInput(device:captureDevice))} catch { print ("error while setting camera position")}
                        break }}}}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func activateFlash(_ sender: UIButton) {
        if captureDevice!.hasTorch{
            do {try captureDevice!.lockForConfiguration()
                captureDevice!.torchMode = captureDevice!.isTorchActive ? AVCaptureTorchMode.off : AVCaptureTorchMode.on
                captureDevice!.unlockForConfiguration()
            } catch { print ("error while trying to activate flash") }
        }
    }
    
    @IBAction func setCamera(_ sender: UIButton) {
        //switch camera to frontal 
        frontCamera = !frontCamera
        captureSession.beginConfiguration()
        let inputs = captureSession.inputs as! [AVCaptureInput]
        for oldInput: AVCaptureInput in inputs {captureSession.removeInput(oldInput)}
        
        frontCamera(frontCamera)
        captureSession.commitConfiguration()
    }
    
    
    @IBAction func startCapture(_ sender: UIButton) {
        captureAnotherPicture()
    }
    
    func capturePicture() {
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo){
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (imageDataSampleBuffer, error) in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    let image = UIImage(data: imageData!)
                    print("image taked: \(image)")
                    self.pickedImage.image = image!
                    self.cameraView.addSubview(self.pickedImage)
                    self.pickedImage.isHidden = false})
        }
    }
    
    func captureAnotherPicture(){
        if didtakePhoto == true {
            self.pickedImage.isHidden = true
            didtakePhoto = false}
        else {
            captureSession.startRunning()
            didtakePhoto = true
            capturePicture()}
        
    }
    
}
