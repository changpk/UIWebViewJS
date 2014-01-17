//
//  TestViewController.h
//  UIWebViewJS
//
//  Created by changpengkai on 13-12-27.
//  Copyright (c) 2013年 changpengkai. All rights reserved.
//

typedef NS_ENUM(NSInteger, NewsStyle) {
    NewsStyleSteel = 0, //钢铁新闻
    NewsStyleFinancial  //财经新闻
};

#import <UIKit/UIKit.h>
@interface TestViewController : UIViewController{
    NewsStyle   newsStyle_;  //记录展示新闻的类型
    UIButton   *SteelNewsBTN;
    UIButton   *FinancialNewBTN;

}
@end
