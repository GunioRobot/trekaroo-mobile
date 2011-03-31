//
//  PhotoPreviewViewController.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoPreviewViewController : UIViewController < UITextFieldDelegate> {
	UIImage *uiImage;
	UITextField *captionField;
	NSMutableDictionary *photoOptions;
}

@property (nonatomic, retain) UIImage *uiImage;
@property (nonatomic, retain) IBOutlet UIImageView *uiImageView;
@property (nonatomic, retain) IBOutlet UITextField *captionField;
@property (nonatomic, retain) NSMutableDictionary *photoOptions;

- (id)init:(UIImage*)inImage options:(NSMutableDictionary *)dict;

- (IBAction)cancelAction:(id)sender;
- (IBAction)sendPhotoAction:(id)sender;

@end
