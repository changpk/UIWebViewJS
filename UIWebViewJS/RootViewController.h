//
//  RootViewController.h
//  UIWebViewJS
//
//  Created by changpengkai on 13-12-26.
//  Copyright (c) 2013年 changpengkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,retain)NSURL      *webURL;
@property(nonatomic,retain)UIWebView  *webView;

- (id)initWithWebURL:(NSURL *)webURL;
/*！
 在ViewDidLoad中调用对应方法，查看效果
 */
//修改本地的UIWebView的userAgent（服务器有时通过UA来进行处理，需要客户端自定义）
- (void)modifyWebViewUserAgent;
//加载特定的文档类型
- (void)loadDocumentInWebView;
//加载html字符串
- (void)loadHtmlStr;
//去除UIWebView边框的阴影
- (void)hiddenTheShadowOfWebview;
//UIWebView可以展示GIF图片
- (void)displayGIFImage;
@end
