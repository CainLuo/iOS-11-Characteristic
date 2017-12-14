//
//  ColorController.m
//  ColorDocument
//
//  Created by CainLuo on 2017/12/14.
//  Copyright © 2017年 EStrongersoft Co., LTD. All rights reserved.
//

#import "ColorController.h"

@interface ColorController ()

@property (weak, nonatomic) IBOutlet UILabel *documentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UIView *colorPreview;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation ColorController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ColorDocument *colorDocument = self.colorDocument;
    
    if (!colorDocument) {
        return;
    }
    
    if (colorDocument.documentState == UIDocumentStateNormal) {
        
        [self configControllerUI];
        
    } else {
        
        [colorDocument openWithCompletionHandler:^(BOOL success) {
            
            if (success) {
                
                [self configControllerUI];

            } else {
                
                [self showAlertViewControllerWithTitle:@"Error"
                                               message:@"Can't Open Document"];
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redSlider.maximumValue   = 255;
    self.greenSlider.maximumValue = 255;
    self.blueSlider.maximumValue  = 255;
}

#pragma mark - Dismiss Controller
- (IBAction)dismissController:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Save Color Model
- (IBAction)saveColorModel:(UIButton *)sender {
    
    ColorDocument *colorDocument = self.colorDocument;
    
    if (!colorDocument) {
        return;
    }

    colorDocument.colorModel = [[ColorModel alloc] initColorModelWithRedValue:self.redSlider.value
                                                                   greenValue:self.greenSlider.value
                                                                    blueValue:self.blueSlider.value];
    
    [colorDocument saveToURL:colorDocument.fileURL
            forSaveOperation:UIDocumentSaveForOverwriting
           completionHandler:^(BOOL success) {
        
               if (success) {
                   
                   [self showAlertViewControllerWithTitle:@"Success"
                                                  message:@"Saved file"];

               } else {
                   
                   [self showAlertViewControllerWithTitle:@"Error"
                                                  message:@"Failed to save file"];
               }
           }];
}

#pragma mark - Slider Change
- (IBAction)didChangeSliderValue:(id)sender {
    
    [self updateColorPreviewWithRed:self.redSlider.value
                              green:self.greenSlider.value
                               blue:self.blueSlider.value];
}

#pragma mark - Up Date UI
- (void)configControllerUI {
    
    self.documentNameLabel.text = self.colorDocument.fileURL.lastPathComponent;
    
    ColorModel *colorModel = self.colorDocument.colorModel;
    
    if (colorModel) {
        
        CGFloat redValue   = colorModel.redValue;
        CGFloat greenValue = colorModel.greenValue;
        CGFloat blueValue  = colorModel.blueValue;

        self.redSlider.value   = redValue;
        self.greenSlider.value = greenValue;
        self.blueSlider.value  = blueValue;
        
        [self updateColorPreviewWithRed:redValue
                                  green:greenValue
                                   blue:blueValue];
    }
}

- (void)updateColorPreviewWithRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue {
    
    
    self.colorLabel.text = [NSString stringWithFormat:@"Red: %.1f, Green: %.1f, Blue: %.1f", red, green, blue];
    
    self.colorPreview.backgroundColor = [UIColor colorWithRed:red / 255.0
                                                        green:green / 255.0
                                                         blue:blue / 255.0
                                                        alpha:1.0];
}

@end
