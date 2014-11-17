//
//  ViewController.h
//  Patient Monitor
//
//  Created by Ryan Dougherty on 11/5/14.
//  Copyright (c) 2014 team3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    UIWindow *window;
    int number_of_side_doopies;
    int number_of_main_view_breaks;

    // ==========Boxes for view Layouts=========

    // Main view properties (whole screen or 2/3)
    UIView *main_view;
    float main_view_x;
    float main_view_y;
    float main_view_width;
    float main_view_height;

    // Lower options bar properties
    UIView *bottom_bar;
    float bottom_bar_x;
    float bottom_bar_y;
    float bottom_bar_width;
    float bottom_bar_height;

    // Right Sidebar properties
    UIView *hilight_view;
    float hilight_view_x;
    float hilight_view_y;
    float hilight_view_width;
    float hilight_view_height;

    // ============BOXES FOR GRAPHS=============
    // EKG properties
    UIView *EKG;
    UIButton *EKG_Button;

    // Right Sidebar properties
    UIView *SPO2;
    UIButton *SPO2_Button;

    // Right Sidebar properties
    UIView *PULSE;
    UIButton *PULSE_Button;

    // Right Sidebar properties
    UIView *TEMPERATURE;
    UIButton *TEMPERATURE_Button;
}
@end

