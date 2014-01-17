//
//  RootViewController.m
//  UIWebViewJS
//
//  Created by changpengkai on 13-12-26.
//  Copyright (c) 2013年 changpengkai. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
- (void)dealloc
{
    [_webURL release];
    _webView.delegate = nil; //release _webView 之前把delegate  = nil
    [_webView release];
    [super dealloc];
}
- (id)initWithWebURL:(NSURL *)webURL
{
    if (self = [super init]) {
        self.webURL = webURL;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self modifyWebViewUserAgent];
    
	// Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(self.view.frame))];
    //webView的个性化定制
    webView.backgroundColor = [UIColor whiteColor]; //默认的颜色是灰色
    webView.delegate = self;
    webView.scalesPageToFit = YES; //是否支持缩放，默认不支持。
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.allowsInlineMediaPlayback = NO; //貌似没用
    webView.mediaPlaybackRequiresUserAction = YES; //默认为YES，允许用户点击播放；设置为NO，进去
                                                   //自动播放。
    self.webView = webView;
    [webView release];
    [self.view addSubview:self.webView];

    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:URLRequest];
    [self hiddenTheShadowOfWebview];
    
    [self displayGIFImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"--内存警告");
}

//修改本地的UIWebView的userAgent（服务器有时通过UA来进行处理，需要客户端自定义）
- (void)modifyWebViewUserAgent
{
    UIWebView *temWebView = [[UIWebView alloc] init];
    //通过JS获得本地默认的navigator.userAgent
    NSString*secretAgent = [temWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if ([secretAgent rangeOfString:@"-souyue"].location == NSNotFound) {
        secretAgent = [NSString stringWithFormat:@"%@-souyue",secretAgent];
    }
    //重新设置自定义的userAgent
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:secretAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    [temWebView release];
    
    NSLog(@"*** %@",[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"UserAgent"]);
    NSLog(@"NSUserDefaults 2 %@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}

#pragma mark - UIWebViewDelegate 

//此方法里面可以拦截和处理请求，每次触发请求开始前一定会回调
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"-request is-%@",request.allHTTPHeaderFields);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"--start loading webView");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"--finishLoad webView");
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"--currentURL=%@",currentURL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"--failLoad webView");
}

#pragma mark - load localDocument

//加载特定的文档类型
- (void)loadDocumentInWebView
{
     NSString *filePath = [[NSBundle mainBundle]pathForResource:@"测试文档" ofType:@"rtf"];
     NSURL *fileURL = [NSURL fileURLWithPath:filePath];
     [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    /*
     NSString *filePath = [[NSBundle mainBundle]pathForResource:@"测试1" ofType:@"html"];
     NSURL *fileURL = [NSURL fileURLWithPath:filePath];
     [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
     */
}

//加载html字符串
- (void)loadHtmlStr
{
    NSString *htmlStr = @"<html>"
	"<body>"
    "<p>链接到<a href=\"http://www.baidu.com/\" target=\"_blank\">百度</a></p>"
    "<p>链接到<a href=\"http://www.google.com/\" target=\"_blank\">google</a></p>"
    "<p>链接到<a href=\"http://www.sina.com.cn/\" target=\"_blank\">新浪</a></p>"
    "<p>学习<a href=\"http://www.dreamdu.com/xhtml/tag_a/\">HTML链接</a></p>"
	"</body>"
    "</html>";
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

//去除UIWebView边框的阴影
- (void)hiddenTheShadowOfWebview
{
    NSArray *subviewsArry = self.webView.scrollView.subviews;
    NSLog(@"--%@",self.webView.subviews); //查看UIWebView的View层次结构
    NSLog(@"--%@",subviewsArry);
    for (UIView *view in subviewsArry) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
}

//UIWebView可以展示GIF图片
- (void)displayGIFImage
{
    //UIWebView相当于UIImageView，只是图片的类型为GIF
    UIWebView *gifView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"2" ofType:@"gif"]];
    //MIME意为多功能Internet邮件扩展,浏览器根据格式类型，调用对应的插件打开。详细查看点击链接：
    //http://baike.baidu.com/link?url=ZPHUCVEpy1uoOIDmJKsSaqyK4jI1AcTh4BdBRIEdEGi-hn75nRaD93nj78Mu3W8T#2
    [gifView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:gifView];
    [gifView release];
}

@end
