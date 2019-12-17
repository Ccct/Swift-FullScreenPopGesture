//
//  BaseNavigationController.swift
//  BiBen
//
//  Created by JuKun on 2019/10/8.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class BaseNavigationController: HBDNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 配置navi
        self.navigationBar.setBackgroundImage(UIImage.creatImg(with: UIColor.white, size: CGSize(width: ScreenWidth, height: navHeight)), for: UIBarMetrics.default)
        //标题颜色
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor:UIColor.withHex(hexInt: 0x2A2A2A),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        //item颜色
        self.navigationBar.tintColor = UIColor.gray
        self.navigationBar.backItem?.backBarButtonItem = nil
        //navi下面线
        self.navigationBar.shadowImage = UIImage.creatImg(with: MainLineColorE7, size: CGSize(width: ScreenWidth, height: 0.5))
        
        /// 全屏右滑返回
        //1.将导航栏自带的右滑手势去掉
        self.interactivePopGestureRecognizer?.isEnabled = false
        //2.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        //3.获取手势添加到的View中
        guard  let gesView = systemGes.view else { return }
        //4.获取target／action
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        //5.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        //6.取出action
        let action = Selector(("handleNavigationTransition:"))
            //#selector(HBDNavigationTransitionProtocol.handleNavigationTransition(_:))
        //7.创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        self.navigationItem.backBarButtonItem = nil
        //self.navigationTSColor()
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true

            // 边距
            let navigationSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            navigationSpace.width = -8
            
            //返回按钮
            var backimg = "return"
            if  viewController.isKind(of: AboutController.self) ||
                viewController.isKind(of: PersonalPageVC.self)  ||
                viewController.isKind(of: ReadAwardVC.self)     ||
                viewController.isKind(of: InviteVC.self)        ||
                viewController.isKind(of: FillInCodeVC.self)    ||
                viewController.isKind(of: MyWalletVC.self)      ||
                viewController.isKind(of: ShowH5VC.self)        ||
                viewController.isKind(of: ExchangeKanVC.self)     {

                backimg = "back_white"
            }
            let backItem = UIBarButtonItem(target: self, action: #selector(back), image: backimg, highImage: "return")
            viewController.navigationItem.leftBarButtonItems = ([backItem] as! [UIBarButtonItem])
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func navBarHeight() {
        var rect = self.navigationBar.frame
        rect.size.height = navHeight + 16
        self.navigationBar.frame = rect
    }
}

//MARK: UINavigationController 扩展
extension UINavigationController: UINavigationControllerDelegate {
    
    /// 配置返回按钮 (默认黑色)
    @objc func configureBackBtn(vc: UIViewController, islight: Bool = false) {
        self.navigationItem.backBarButtonItem = nil
        vc.navigationItem.backBarButtonItem = nil
        // 边距
        let navigationSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        navigationSpace.width = -8
        let img = islight ? "search_return_white":"home_follow_return"
        let backItem = UIBarButtonItem(target: self, action: #selector(back), image: img, highImage: img)
        vc.navigationItem.leftBarButtonItems = ([backItem] as! [UIBarButtonItem])
    }
    
    /// 返回事件
    @objc func back() {
        ShowDismiss()
        if self.viewControllers.count <= 2 {
            self.tabBarController?.tabBar.isHidden = false
        } else {
            self.tabBarController?.tabBar.isHidden = true
        }
        self.popViewController(animated: true)
    }
}
