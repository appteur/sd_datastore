//
//  ImageSampleTest.m
//  SDDataStore
//
//  Created by Seth on 11/6/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "ImageSampleTest.h"
#import <UIKit/UIKit.h>

 /// Setting a background color to the average color in an image


@interface ImageSampleTest()



@end


@implementation ImageSampleTest





-(void) setupImage
{
    UIImage *sample = [UIImage imageNamed:@""];
    UIView *sampleView = [[UIView alloc] init];
    
    UIColor *bgColor = [self getAverageRGB:sample];
    
    sampleView.backgroundColor = bgColor;
//    document.body.style.backgroundColor = 'rgb('+rgb.r+','+rgb.g+','+rgb.b+')';
}








-(UIColor*) getAverageRGB:(UIImage*)imgEl {
    
    int blockSize   = 5; // only visit every 5 pixels
    int count       = 0;
    int i           = -4;
    
    float width;
    float height;
    float length;
    
    NSDictionary *defaultRGB = @{@"r":@0,@"g":@0,@"b":@0}; // for non-supporting envs
    NSData *data;
    

    //rgb = {r:0,g:0,b:0},

    
//    if (!context) {
//        return defaultRGB;
//    }
    
//    height = canvas.height = imgEl.naturalHeight || imgEl.offsetHeight || imgEl.height;
//    width = canvas.width = imgEl.naturalWidth || imgEl.offsetWidth || imgEl.width;
//    
//    context.drawImage(imgEl, 0, 0);
//    
//    @try
//    {
//        data = context.getImageData(0, 0, width, height);
//    }
//    catch(e)
//    {
//        /* security error, img on diff domain */alert('x');
//        return defaultRGB;
//    }
//    
//    length = data.data.length;
//    
//    while ( (i += blockSize * 4) < length ) {
//        ++count;
//        rgb.r += data.data[i];
//        rgb.g += data.data[i+1];
//        rgb.b += data.data[i+2];
//    }
//    
//    // ~~ used to floor values
//    rgb.r = ~~(rgb.r/count);
//    rgb.g = ~~(rgb.g/count);
//    rgb.b = ~~(rgb.b/count);
    
    return nil;
    
}







//var rgb = getAverageRGB(document.getElementById('i'));
//document.body.style.backgroundColor = 'rgb('+rgb.r+','+rgb.g+','+rgb.b+')';
//
//function getAverageRGB(imgEl) {
//    
//    var blockSize = 5, // only visit every 5 pixels
//    defaultRGB = {r:0,g:0,b:0}, // for non-supporting envs
//    canvas = document.createElement('canvas'),
//    context = canvas.getContext && canvas.getContext('2d'),
//    data, width, height,
//    i = -4,
//    length,
//    rgb = {r:0,g:0,b:0},
//    count = 0;
//    
//    if (!context) {
//        return defaultRGB;
//    }
//    
//    height = canvas.height = imgEl.naturalHeight || imgEl.offsetHeight || imgEl.height;
//    width = canvas.width = imgEl.naturalWidth || imgEl.offsetWidth || imgEl.width;
//    
//    context.drawImage(imgEl, 0, 0);
//    
//    try {
//        data = context.getImageData(0, 0, width, height);
//    } catch(e) {
//        /* security error, img on diff domain */alert('x');
//        return defaultRGB;
//    }
//    
//    length = data.data.length;
//    
//    while ( (i += blockSize * 4) < length ) {
//        ++count;
//        rgb.r += data.data[i];
//        rgb.g += data.data[i+1];
//        rgb.b += data.data[i+2];
//    }
//    
//    // ~~ used to floor values
//    rgb.r = ~~(rgb.r/count);
//    rgb.g = ~~(rgb.g/count);
//    rgb.b = ~~(rgb.b/count);
//    
//    return rgb;
//    
//}







@end
