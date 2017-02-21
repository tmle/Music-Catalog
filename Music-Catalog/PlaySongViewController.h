//
//  PlaySongViewController.h
//  NTD-ThoiNguoiOLaiEmDi
//
//  Created by Thinh Le on 3/7/16.
//  Copyright © 2016 Lac Viet Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PlaySongViewController : UIViewController

@property (strong, nonatomic) NSArray * songList;
@property (assign) int songIndex;

@end