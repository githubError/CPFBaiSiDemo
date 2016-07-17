//
//  CPFWebViewController.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/17.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFWebViewController.h"

@interface CPFWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;

@end

@implementation CPFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
