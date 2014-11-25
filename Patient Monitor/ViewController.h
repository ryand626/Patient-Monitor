//
//  ViewController.h
//  Patient Monitor
//
//  Created by Ryan Dougherty on 11/5/14.
//  Copyright (c) 2014 team3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"
#import "TheData.h"

//#import <CorePlot/CorePlot.h>

@interface ViewController : UIViewController{
    Graph *graph;
    TheData *graphData;
    
    UIWindow *window;
    int number_of_side_doopies;
    int number_of_main_view_breaks;
    
    float button_width;
    float button_height;

    // ==========Boxes for view Layouts=========

    // Main view properties (whole screen or 2/3)
    UIView *main_view;
    UIButton *main_button;
    Graph *main_graph;
    float main_view_x;
    float main_view_y;
    float main_view_width;
    float main_view_height;

    // Lower options bar properties
    UIView *bottom_bar;
    UIButton *layout;
    int layout_index;
    float bottom_bar_x;
    float bottom_bar_y;
    float bottom_bar_width;
    float bottom_bar_height;
    

    // Right Sidebar properties
    UIView *side_view;
    float side_view_x;
    float side_view_y;
    float side_view_width;
    float side_view_height;

    // ============BOXES FOR GRAPHS=============
    // EKG properties
    UIView *EKG;
    UIButton *EKG_Button;
    UILabel *EKG_Label;
    Graph *EKG_Graph;

    // Right Sidebar properties
    UIView *SPO2;
    UIButton *SPO2_Button;
    UILabel *SPO2_Label;
    Graph *SPO2_Graph;

    // Right Sidebar properties
    UIView *PULSE;
    UIButton *PULSE_Button;
    UILabel * PULSE_Label;
    
    // Right Sidebar properties
    UIView *TEMPERATURE;
    UIButton *TEMPERATURE_Button;
    UILabel * TEMPERATURE_Label;
}
@end

