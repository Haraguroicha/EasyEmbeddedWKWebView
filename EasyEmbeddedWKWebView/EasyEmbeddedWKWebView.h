//
//  EasyEmbeddedWKWebView.h
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

@import UIKit;
#import "EEWKDataFunction.h"
#import "EEWKWebView.h"
#import "EEWKWebViewProxyDelegate.h"
#import "EEWKWebViewController.h"

//! Project version number for EasyEmbeddedWKWebView.
FOUNDATION_EXPORT double EasyEmbeddedWKWebViewVersionNumber;

//! Project version string for EasyEmbeddedWKWebView.
FOUNDATION_EXPORT const unsigned char EasyEmbeddedWKWebViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <EasyEmbeddedWKWebView/PublicHeader.h>

#define EEWK_JS_INJECT_FILENAME         (@"EEWK-Inject")
#define EEWK_JS_INJECT_FUNCTIONNAME     (@"window.EmbeddedWK")
#define EEWK_JS_INJECT_FUNCTIONTEMPLATE (@"____EmbeddedWK____")
#define EEWK_JS_HANDLER_PATH            (@"/EEWK-Postback")
