//
//  ModalViewController.swift
//  ModalViewSample
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    

    @IBAction func save(_ sender: AnyObject) {
        self.dismiss(animated: true) { () -> Void in
             print("点击Save按钮，关闭模态视图")
        }
    }

    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true) { () -> Void in
            print("点击Cancel按钮，关闭模态视图")
        }
    }
}
