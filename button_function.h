#ifndef BUTTON_FUNCTION_H_
#define BUTTON_FUNCTION_H_

#include <stdint.h>
#include <stdio.h>
#include "Menu_Functions.h"
#include "cable.h"
#define PUSHED 1
#define notPUSHED 0

/*User shoudl provide this pins*/
#define B1_GPIO 
#define B1_PIN

#define B2_GPIO
#define B2_PIN

#define B3_GPIO
#define B3_PIN
/*-----------------------------*/

#define ENTER_BUTTON_PUSHED ((flags_b.enter==PUSHED) && (flags_b.up==notPUSHED) && (flags_b.down==notPUSHED))
#define UP_BUTTON_PUSHED ((flags_b.enter==notPUSHED) && (flags_b.up==PUSHED) && (flags_b.down==notPUSHED))
#define DOWN_BUTTON_PUSHED ((flags_b.enter==notPUSHED) && (flags_b.up==notPUSHED) && (flags_b.down==PUSHED))
#define EXIT_BUTTON_PUSHED ((flags_b.enter==notPUSHED) && (flags_b.up==PUSHED) && (flags_b.down==PUSHED))


struct FLAGS_B
{
    uint8_t enter:1;
    uint8_t up:1; 
	uint8_t down:1;
    uint8_t reserved:5;   
    
};

/*
struct BUTTON_PORTS_PINS
{
    uint16_t b1_port;
    uint16_t b1_pin;
    uint16_t b2_port;
    uint16_t b2_pin;
    uint16_t b3_port;
    uint16_t b3_pin;


};
*/
extern struct FLAGS_B flags_b;


void main_menu_button_manager_func(void);
void cable_select_button_manager_func(void);
void cable_define_button_manager_func(void);
void about_me_button_manager_func(void);
#endif