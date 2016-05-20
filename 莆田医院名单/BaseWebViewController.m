//
//  BaseWebViewController.m
//  card
//
//  Created by Hale Chan on 5/21/15.
//  Copyright (c) 2015 Papaya Mobile Inc. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];

        [self.view addSubview:webView];
        [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _webView = webView;
    }
    _webView.delegate = self;
    
    if (_startURL) {
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:_startURL]];
    }
}

- (void)setStartURL:(NSURL *)startURL
{
    _startURL = startURL;
    //if (self.isViewLoaded) {
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:_startURL]];
    //}
}

#pragma mark  -- WebView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSDictionary *params = [self dictionaryFromQuery:request.URL.query usingEncoding:NSUTF8StringEncoding];
//    NSString *scheme = request.URL.scheme;
//    NSString *host = request.URL.host;
//    NSLog(@"request url = %@ host = %@ scheme = %@, parameters = %@",request.URL, request.URL.host, request.URL.scheme, request.URL.query);
//    NSLog(@"params = %@",params);
  
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('title')[0].innerHTML;"];
    if (title.length) {
        self.title = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UILabel *label = [[UILabel alloc]initWithFrame:webView.bounds];
    label.numberOfLines = 0;
    [label setText:@"对不起，您请求的页面暂时无法显示\n\n请稍候重试"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [webView addSubview:label];
}

- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}




@end
