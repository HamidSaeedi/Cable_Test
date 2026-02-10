#ifndef _CABLE_H_
#define _CABLE_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define MAX_CABLE_PINS 8
#define MAX_NUMBER_PROFILE 12
#define ERROR_CABLE_ID_SET 100

#define GOOD 'G'
#define CONFLICT 'C'
#define WRONG 'W'
#define NOCONNECT 'N'
#define MAXPROFILELIMIT 0X09



#define Version 1
struct FUNC_HANDLE
{ 
 uint8_t error_cable[MAX_CABLE_PINS+1];
 uint8_t error_other;
 char error_symbol[MAX_CABLE_PINS+1];
 uint8_t cable_id;
 uint8_t pass_pins;

};
struct FLAG
{
    uint8_t connect:1;
    uint8_t notconnect:1;
    uint8_t test_result:1; //1 okay 0 not okay
	uint8_t enter_button:1;
    uint8_t reserved:5;
};


extern uint8_t In_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
extern uint8_t Out_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
extern struct FUNC_HANDLE cable_func_handle;
extern struct FLAG flag;
extern uint8_t Cable_ID;
extern uint8_t Input[MAX_CABLE_PINS];
extern uint8_t Output[MAX_CABLE_PINS];

struct FUNC_HANDLE Profile_ID(void);
void Cable_Check(void);
struct FUNC_HANDLE Cable_Error_Check(void);


extern int8_t (*profile_lcd_menu)(void);
extern void (*Port_Set)(uint8_t);
extern void (*sleep_ms)(uint32_t);
extern uint8_t (*Read_Pin)(void);
#endif // _CABLE_H_
