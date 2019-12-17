//
//  BaseNaviController.swift
//  Demo
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 biben. All rights reserved.
//

import UIKit

class BaseNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // 如果项目中有引入 HBDNavigationController 可以这样写：
        // #selector(HBDNavigationTransitionProtocol.handleNavigationTransition(_:))
        //7.创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}
