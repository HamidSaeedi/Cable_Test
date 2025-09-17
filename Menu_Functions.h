#ifndef MENUE_FUNC_H
#define MENUE_FUNC_H
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <alcd.h>

#define MAX_MAIN_MENU_ITEM 4
#define RUN_TEST_PAGE  0
#define CABLE_SELSECT_PAGE  1
#define CABLE_DEFINE_PAGE 2
#define ABOUT_ME_PAGE  3
#define MAIN_PAGE 4
#define IN_SELECT 2
#define OUT_SELECT 3
#define PROF_SELECT 4
struct FLAGS_MENU
{
    uint8_t subpage:3;
    uint8_t reserved:5;
};

extern int8_t Menue_Main_Num;
extern int8_t Menue_Cable_Select_Num;
extern uint8_t Menu_Cable_Define_Prof;
extern uint8_t Menu_Cable_Define_Index_In;
extern uint8_t Menu_Cable_Define_Index_Out;
extern uint8_t Menu_Cable_Define_Index_In_Num;
extern uint8_t Menu_Cable_Define_Index_Out_Num;
extern struct FLAGS_MENU flags_menu;




extern uint8_t page;
int8_t Menu_Main(void);
int8_t  Menu_Cable_Select(void);
void Menu_Cable_Define(void);
void Menu_About_Me(void);
#endif