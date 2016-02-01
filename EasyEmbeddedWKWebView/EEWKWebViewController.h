//
//  EEWKWebViewController.h
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

@import UIKit;
@import WebKit;

@class EEWKWebView;

@interface EEWKWebViewController : UIViewController

@property (strong, nonatomic) EEWKWebView *webView;

- (void)setConfiguration:(WKWebViewConfiguration *)configuration;

@end
