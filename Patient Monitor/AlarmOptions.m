//
//  AlarmOptions.m
//  Patient Monitor
//
//  Created by Ryan Dougherty on 12/2/14.
//  Copyright (c) 2014 team3. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AlarmOptions.h"

@interface AlarmOptions ()

@end

@implementation AlarmOptions

- (void)initializeAlarms{
    NSLog(@"gonna initialize stuff");
    [self initializeDimentions];
    
    isBloodPressureOn = YES;
    isTemperatureOn = YES;
    isPulseOn = YES;
    isSPO2On = YES;
    [self makeAlarmWindow];
}

-(void)initializeDimentions{
    highBloodPressure = 300;
    highTemperature = 100;
    highPulse = 130;
    highSPO2 = 3;
    
    lowBloodPressure = 10;
    lowTemperature = 97;
    lowPulse = 20;
    lowSPO2 = .4;
    
    window_width = 400;
    window_height = 400;
    frame_height = 100;
}

-(void) makeAlarmWindow{
    // Create the window frame
    alarmOptionsWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, window_width, window_height)];
    [alarmOptionsWindow setBackgroundColor:[UIColor whiteColor]];
    [main_screen addSubview:alarmOptionsWindow];
    
    // Create Menu Bar
    alarmText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, alarmOptionsWindow.frame.size.width, frame_height)];
    
    // Change settings of menu bar
    [alarmText setTextAlignment:NSTextAlignmentCenter];
    [alarmText setText:@"Alarm Settings"];
    [alarmText setBackgroundColor:[UIColor lightGrayColor]];
    [alarmText setFont:[alarmText.font fontWithSize:32]];
    // Add menu bar to view
    [alarmOptionsWindow addSubview:alarmText];
    
    // Create List Scrollable options List
    alarmScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, frame_height, window_width, window_height-frame_height)];
    alarmScroll.contentSize=CGSizeMake(alarmScroll.frame.size.width,800);
    [alarmOptionsWindow addSubview:alarmScroll];
    
    
    alarmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, edit_button_width, edit_button_height)];
    alarmButton.titleLabel.text = @"testing";
    [alarmScroll addSubview:alarmButton];
    [alarmButton setBackgroundColor:[UIColor blueColor]];
    

    alarmScroll.scrollEnabled = true;
    
    
    // Set up display toggle in options bar
    isWindowUp = false;
    [main_screen sendSubviewToBack:alarmOptionsWindow];
}

-(void)addLabels{
  //  BloodPressureLabel = [[UILabel alloc]initWithFrame:]
}

-(void)addButtons{
    
}

- (void)EditClicked:(UIButton*)sender{
    
}


- (void)ToggleSwitched:(UISwitch*)sender{
    if(sender == BloodPressureToggle){
        isBloodPressureOn = !isBloodPressureOn;
    }
    if(sender == TemperatureToggle){
        isTemperatureOn = ! isTemperatureOn;
    }
    if(sender == PulseToggle){
        isPulseOn = !isPulseOn;
    }
    if(sender == SPO2Toggle){
        isSPO2On = !isSPO2On;
    }
}

- (void)ViewButtonPressed:(UIButton*)sender{
    [main_screen bringSubviewToFront:alarmOptionsWindow];
    if(!isWindowUp){
        
       // alarmOptionsWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2,bottom_bar_y,alarmOptionsWindow.frame.size.width,alarmOptionsWindow.frame.size.height);
        alarmOptionsWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2,window.frame.size.height,alarmOptionsWindow.frame.size.width,alarmOptionsWindow.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        alarmOptionsWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2, window.frame.size.height/2-window_height/2, window_width, window_height);
        
        [UIView commitAnimations];
    }else{
        
        alarmOptionsWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2, window.frame.size.height/2-window_height/2, window_width, window_height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        alarmOptionsWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2,window.frame.size.height,alarmOptionsWindow.frame.size.width,alarmOptionsWindow.frame.size.height);
        [UIView commitAnimations];
        
    }
    isWindowUp = !isWindowUp;
}

- (void) checkThresholds{
    
}

- (void) loadSoundFiles{
    
}

- (void) setMainView:(UIView*)view window:(UIWindow *)screen{
    main_screen = view;
    window = screen;
}

- (void) setButton:(UIButton*)button{
    showButton = button;
    [showButton addTarget:self action:@selector(ViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

@end