//
//  ViewController.swift
//  美颜相机
//
//  Created by 焦英博 on 2017/10/8.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit
import AVKit
import GPUImage

class ViewController: UIViewController {

    @IBOutlet weak var beautyViewBottomCons: NSLayoutConstraint!
    // 视频源
    fileprivate lazy var camera: GPUImageVideoCamera? = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
    // 预览图层
    fileprivate lazy var preview: GPUImageView = GPUImageView(frame: self.view.bounds)
    // 滤镜
    let bilateralFilter = GPUImageBilateralFilter() // 磨皮
    let exposureFilter = GPUImageExposureFilter()   // 曝光
    let brightnessFilter = GPUImageBrightnessFilter()  // 亮度
    let satureationFilter = GPUImageSaturationFilter() // 饱和
    
    // 写入对象
    fileprivate lazy var movieWriter : GPUImageMovieWriter = { [unowned self] in
        let writer = GPUImageMovieWriter(movieURL: self.fileURL, size: self.view.bounds.size)
        return writer!
    }()
    // 写入路径
    fileprivate var fileURL : URL {
        let path = URL(fileURLWithPath: "\(NSTemporaryDirectory())abc.mp4")
        return path
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 先删除，否则会崩溃 https://my.oschina.net/NycoWang/blog/856569
        let path = URL(fileURLWithPath: "\(NSTemporaryDirectory())abc.mp4")
        try? FileManager.default.removeItem(at: path)
        
        // camera方向
        camera?.outputImageOrientation = .portrait
        // 镜像显示
        camera?.horizontallyMirrorFrontFacingCamera = true
        
        // 添加预览层
        view.insertSubview(preview, at: 0)
        
        // 设置GPUImage响应链
        let filterGroup = getGroupFilters()
        camera?.addTarget(filterGroup)
        filterGroup.addTarget(preview)
        
        // 开始采集
        camera?.startCapture()
        
        // 设置writer
        // 是否对视频进行编码
        movieWriter.encodingLiveVideo = true
        
        // 将writer设置成滤镜的target
        filterGroup.addTarget(movieWriter)
        
        // 设置camera的编码
        camera?.delegate = self
        camera?.audioEncodingTarget = movieWriter
        // 开始写入
        movieWriter.startRecording()
    }
}

extension ViewController {
    fileprivate func getGroupFilters() -> GPUImageFilterGroup {
        // 1.创建滤镜组（用于存放各种滤镜：美白、磨皮等）
        let filterGroup = GPUImageFilterGroup()
        
        // 2.创建滤镜(设置滤镜的引来关系)
        bilateralFilter.addTarget(brightnessFilter)
        brightnessFilter.addTarget(exposureFilter)
        exposureFilter.addTarget(satureationFilter)
        
        // 3.设置滤镜组链初始&终点的filter
        filterGroup.initialFilters = [bilateralFilter]
        filterGroup.terminalFilter = satureationFilter
        
        return filterGroup
    }
}

extension ViewController : GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        print("采集到画面")
    }
}

extension ViewController {
    @IBAction func stop(_ sender: Any) {
        camera?.stopCapture()
        preview.isHidden = true
        movieWriter.finishRecording()
    }
    
    @IBAction func play(_ sender: Any) {
        let playerVc = AVPlayerViewController()
        playerVc.player = AVPlayer(url: fileURL)
        present(playerVc, animated: true, completion: nil)
    }
    
    @IBAction func setting(_ sender: Any) {
        adjustBeautyView(constant: 0)
    }
    
    @IBAction func rotate(_ sender: Any) {
        camera?.rotateCamera()
    }
    
    @IBAction func completeClick(_ sender: Any) {
        adjustBeautyView(constant: -250)
    }
    
    @IBAction func switchClick(_ sender: UISwitch) {
        if sender.isOn {
            camera?.removeAllTargets()
            let group = getGroupFilters()
            camera?.addTarget(group)
            group.addTarget(preview)
        } else {
            camera?.removeAllTargets()
            camera?.addTarget(preview)
        }
    }
    
    // 磨皮
    @IBAction func bilateral(_ sender: UISlider) {
        bilateralFilter.distanceNormalizationFactor = CGFloat(sender.value) * 8
    }
    // 曝光
    @IBAction func exposure(_ sender: UISlider) {
        exposureFilter.exposure = CGFloat(sender.value) * 20 - 10
    }
    // 亮度
    @IBAction func brightness(_ sender: UISlider) {
        brightnessFilter.brightness = CGFloat(sender.value) * 2 - 1
    }
    // 饱和度
    @IBAction func saturation(_ sender: UISlider) {
        satureationFilter.saturation = CGFloat(sender.value * 2)
    }
    
    private func adjustBeautyView(constant : CGFloat) {
        beautyViewBottomCons.constant = constant
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
