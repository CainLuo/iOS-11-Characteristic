//
//  DocumentBrowserController.m
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "DocumentBrowserController.h"

#import "ColorDocument.h"

#import "DocumentActivity.h"

#import "ColorController.h"

@interface DocumentBrowserController () <UIDocumentBrowserViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIDocumentBrowserTransitionController *documentBrowserTransitionController;

@end

@implementation DocumentBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.allowsDocumentCreation = YES;
    
    [self customDocumentBrowserController];
}

#pragma mark - Custom Document Browser Controller
- (void)customDocumentBrowserController {
    
    self.view.tintColor = [UIColor colorNamed:@"MarineBlue"];
    
    self.browserUserInterfaceStyle = UIDocumentBrowserUserInterfaceStyleLight;
    
    UIDocumentBrowserAction *documentBrowserAction = [[UIDocumentBrowserAction alloc] initWithIdentifier:@"com.cainluo.action"
                                                                                          localizedTitle:@"Lighter Color"
                                                                                            availability:UIDocumentBrowserActionAvailabilityMenu
                                                                                                 handler:^(NSArray<NSURL *> * _Nonnull urls) {
        
                                                                                                     ColorDocument *colorDocument = [[ColorDocument alloc] initWithFileURL:urls[0]];
                                                                                                     
                                                                                                     [colorDocument openWithCompletionHandler:^(BOOL success) {
                                                                                                         
                                                                                                         if (success) {
                                                                                                             
                                                                                                             colorDocument.colorModel = [colorDocument.colorModel lighterColorWithToAdd:60];
                                                                                                             
                                                                                                             [self presentColorControllerWithDocument:colorDocument];
                                                                                                         }
                                                                                                     }];
                                                                                                 }];
    
    documentBrowserAction.supportedContentTypes = @[@"com.cainluo.colorExtension"];
    
    self.customActions = @[documentBrowserAction];
    
    UIBarButtonItem *aboutButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(openAbout)];
    
    self.additionalTrailingNavigationBarButtonItems = @[aboutButtonItem];
}

- (void)openAbout {
    
    [self showAlertViewControllerWithTitle:@"关于我们" message:@"Color Document 1.0 by Cain Luo"];
}

#pragma mark - Present Controller
- (void)presentColorControllerWithDocument:(ColorDocument *)colorDocument {
    
    UIStoryboard *mineStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ColorController *colorController = [mineStoryboard instantiateViewControllerWithIdentifier:@"ColorController"];
    
    colorController.colorDocument = colorDocument;
    colorController.transitioningDelegate = self;
    
    self.documentBrowserTransitionController = [self transitionControllerForDocumentURL:colorDocument.fileURL];
    
    [self presentViewController:colorController animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {

    return self.documentBrowserTransitionController;
}

#pragma mark - UIDocumentBrowserViewControllerDelegate
- (void)documentBrowser:(UIDocumentBrowserViewController *)controller
didRequestDocumentCreationWithHandler:(void(^)(NSURL *_Nullable urlToImport, UIDocumentBrowserImportMode importMode))importHandler {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ColorFile"
                                         withExtension:@"color"];
    
    importHandler(url, UIDocumentBrowserImportModeCopy);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller
 didImportDocumentAtURL:(NSURL *)sourceURL
       toDestinationURL:(NSURL *)destinationURL {
 
    [self presentColorControllerWithDocument:[[ColorDocument alloc] initWithFileURL:destinationURL]];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller
failedToImportDocumentAtURL:(NSURL *)documentURL
                  error:(NSError * _Nullable)error {
    
    [self showAlertViewControllerWithTitle:@"Failed" message:@"Failed to import"];
}


- (void)documentBrowser:(UIDocumentBrowserViewController *)controller
    didPickDocumentURLs:(NSArray <NSURL *> *)documentURLs {
 
    [self presentColorControllerWithDocument:[[ColorDocument alloc] initWithFileURL:documentURLs[0]]];
}

#pragma mark - Custom Activity
- (NSArray<__kindof UIActivity *> *)documentBrowser:(UIDocumentBrowserViewController *)controller
               applicationActivitiesForDocumentURLs:(NSArray <NSURL *> *)documentURLs {
  
    ColorDocument *colorDocument = [[ColorDocument alloc] initWithFileURL:documentURLs[0]];
    
    return @[[[DocumentActivity alloc] initDocumentActivityWithColorDocument:colorDocument]];
}

@end
