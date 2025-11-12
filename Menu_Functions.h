#ifndef MENUE_FUNC_H
#define MENUE_FUNC_H
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <alcd.h>
//Maximum Item we have in the main menue
#define MAX_MAIN_MENU_ITEM 3
//pages number 
#define RUN_TEST_PAGE  0
#define CABLE_SELSECT_PAGE  1
#define CABLE_DEFINE_PAGE 3
#define ABOUT_ME_PAGE  2
#define MAIN_PAGE 4

#define IN_SELECT 2
#define OUT_SELECT 3
#define PROF_SELECT 4
//LCD PARAMETERS
#define NUM_ROW 4
#define NUM_COLUMN 20

/*This variable will be used in the cable define and will change the arrow under the 
   parameter we want to change for exanple input index number or profile number.
*/
struct FLAGS_MENU
{
    uint8_t subpage:3;
    uint8_t reserved:5;
};

extern int8_t Menue_Main_Num; //this will scroll on the Menue_Main_Srting variable.
extern int8_t Menue_Main_Select_Num;//this will scroll on the arrow wchich select the item from the main menu.

extern int8_t Menue_Cable_Select_Num; /*This is the beggining of the cable number in the cable select menu 
                                         this is just for scrolling and fit the cables in the cable select
                                         menu. in other word this is a offset that we will print the cable
                                         from this.*/
extern int8_t Menue_Cable_Select_Select_Num;/*The cable we select will have this nubmer but
                                             we should add this by the Menue_Cable_Select_Num and 
                                             of course multiply  Menue_Cable_Select_Num by MAX_MAIN_MENU_ITEM */

extern uint8_t Menu_Cable_Define_Prof;
extern uint8_t Menu_Cable_Define_Index_In;
extern uint8_t Menu_Cable_Define_Index_Out;
extern uint8_t Menu_Cable_Define_Index_In_Num;
extern uint8_t Menu_Cable_Define_Index_Out_Num;

extern struct FLAGS_MENU flags_menu;




extern uint8_t page;
void Menu_Main(void);
int8_t Menu_Run_Test(void);
int8_t  Menu_Cable_Select(void);
void Menu_Cable_Define(void);
void Menu_About_Me(void);
#endif