# meituan
高仿美团iOS版，版本号5.7，不可用于其他商业用途  
iOS技术交流群：112365317  

# 运行
1.终端切换到工程目录  

$ pod install  

2.双击meituan.xcworkspace运行  

注：采用cocoapods管理第三方库，请双击meituan.xcworkspace启动工程。不要双击meituan.xcodeproj启动，否则会提示“library not found for -lPods-AFNetworking”

# 注
百度糯米官方版：采用少量的xib文件 + 大量的纯代码方式开发的。  

高仿糯米版本：采用storyboard创建界面为主方式来开发，跟官方版做区别。  

美团官方版：storyboard创建界面为主方式开发。  

高仿的美团5.7：以纯代码方式来开发，以作区别。  

[高仿糯米iOS](https://github.com/lookingstars/nuomi)  

[高仿美团iOS](https://github.com/lookingstars/meituan)  

React Native仿美团小demo [https://github.com/lookingstars/RNMeituan](https://github.com/lookingstars/RNMeituan)

---


注：采用cocoapods管理第三方库，请双击meituan.xcworkspace启动工程。不要双击meituan.xcodeproj启动，否则会提示“library not found for -lPods-AFNetworking”

截图链接：http://blog.csdn.net/l863784757/article/details/46912223


Xcode7，真机调试，如果出现下面的错误提示，提示友盟的library不支持bitcode

解决办法：1.更新library

          2.关闭bitcode（Xcode7+以上才有，以下的没有这个配置项）

![image](https://github.com/lookingstars/meituan/blob/master/meituan/screenshots/youmeng_ios9.png)

1.更新library：
友盟官方适配iOS9方案，暂时还没有适配iOS9的library。
友盟官方解决方案：http://dev.umeng.com/social/ios/ios9

2.关闭bitcode
选择工程，target-》build setting -》enable bitcode设置为NO


