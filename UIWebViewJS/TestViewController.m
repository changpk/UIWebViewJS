//
//  TestViewController.m
//  UIWebViewJS
//
//  Created by changpengkai on 13-12-27.
//  Copyright (c) 2013年 changpengkai. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        newsStyle_ = NewsStyleSteel; //根据需要设定，默认显示的新闻类型
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    SteelNewsBTN =[[UIButton  alloc]initWithFrame:CGRectMake(0, 66, 159, 36)];
    [SteelNewsBTN  setBackgroundImage:[UIImage  imageNamed:@"00222.png"] forState:UIControlStateNormal];
    [SteelNewsBTN  setTitle:@"钢铁资讯" forState:UIControlStateNormal];
    
    SteelNewsBTN.tag = NewsStyleSteel;// 赋值新闻类型
    
    [SteelNewsBTN addTarget:self action:@selector(NewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:SteelNewsBTN];
    
    FinancialNewBTN =[[UIButton  alloc]initWithFrame:CGRectMake(161, 66, 159, 36)];
    [FinancialNewBTN  setBackgroundImage:[UIImage  imageNamed:@"00222.png"] forState:UIControlStateNormal];
    [FinancialNewBTN  setTitle:@"财经资讯" forState:UIControlStateNormal];
    
    FinancialNewBTN.tag = NewsStyleFinancial;// 赋值新闻类型
    
    [FinancialNewBTN addTarget:self action:@selector(NewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:FinancialNewBTN];
}

//点击按钮的处理
- (void)NewsBtnClick:(UIButton *)button
{
    newsStyle_ = button.tag; //记录每次点击的状态
    if (button.tag == NewsStyleSteel) {
        
    }else if (button.tag == NewsStyleFinancial){
        
    }
}

//下拉刷新回调事件的处理
- (void)pullToRefreshTable
{
    if (newsStyle_ == NewsStyleSteel) {
        //发送钢铁咨询的请求，请求结束或者失败的方法也可以根据newsStyle_判断，或者其它方法均可
    }else{
        //发送财经咨询的请求，请求结束或者失败的方法也可以根据newsStyle_判断，或者其它方法均可
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
