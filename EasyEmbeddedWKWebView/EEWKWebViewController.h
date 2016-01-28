//
//  EEWKWebViewController.h
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "EEWKWebView.h"

#define EEWK_JS_INJECT_FILENAME         (@"EEWK-Inject")
#define EEWK_JS_INJECT_FUNCTIONNAME     (@"window.EmbeddedWK")
#define EEWK_JS_INJECT_FUNCTIONTEMPLATE (@"____EmbeddedWK____")
#define EEWK_JS_HANDLER_PATH            (@"/EEWK-Postback")

@interface EEWKWebViewController : UIViewController

@property (strong, nonatomic) EEWKWebView *webView;

- (void)setConfiguration:(WKWebViewConfiguration *)configuration;

@end
