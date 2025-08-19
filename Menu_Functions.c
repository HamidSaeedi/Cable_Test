#include "Menu_Functions.h"
#include "cable.h"
char Menue_Main_Srting[4][16]={"Test Run" , "Cable Select" , "Cable define" , "About Me"};
char lcd_buffer[16];
uint8_t Menue_Main_Num=0;
int8_t Menue_Cable_Select_Num=0;
uint8_t Menu_Cable_Define_Prof=0;
uint8_t Menu_Cable_Define_Index_In=0;
uint8_t Menu_Cable_Define_Index_Out=0;
uint8_t Menu_Cable_Define_Index_In_Num=0;
uint8_t Menu_Cable_Define_Index_Out_Num=0;
struct FLAGS_MENU flags_menu;
uint8_t page=0;
int8_t Menu_Main (void)
{
	lcd_gotoxy(0,0);
	sprintf(lcd_buffer,"->%s",Menue_Main_Srting[Menue_Main_Num]);
	lcd_puts(lcd_buffer);
	lcd_gotoxy(0,1);
	sprintf(lcd_buffer,"%s",Menue_Main_Srting[Menue_Main_Num+1]);
	lcd_puts(lcd_buffer);
	memset(lcd_buffer,0,sizeof(lcd_buffer));
	if(flag.enter_button==1)
	{
		flag.enter_button=0;
		return Menue_Main_Num;
	}
	return -1;
}

int8_t  Menu_Cable_Select(void)
{
	lcd_gotoxy(0,0);
	sprintf(lcd_buffer,"-> cable%02d",Menue_Cable_Select_Num);
	lcd_puts(lcd_buffer);
	lcd_gotoxy(0,1);
	sprintf(lcd_buffer,"cable%02d",Menue_Cable_Select_Num+1);
	lcd_puts(lcd_buffer);
	memset(lcd_buffer,0,sizeof(lcd_buffer));
	if(flag.enter_button==1)
	{
		flag.enter_button=0;
		return Menue_Cable_Select_Num;
	}
	return -1;
}

void Menu_Cable_Define(void)
{
	lcd_gotoxy(0,0);
	In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In]=Menu_Cable_Define_Index_In_Num;
	Out_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_Out]=Menu_Cable_Define_Index_Out_Num;
	sprintf(lcd_buffer,"%02d->%02d   Prof=%02d",In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In],Out_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_Out],Menu_Cable_Define_Prof);
	lcd_puts(lcd_buffer);
	memset(lcd_buffer,0,sizeof(lcd_buffer));
	lcd_gotoxy(0,1);
	switch (flags_menu.subpage)
	{
	case IN_SELECT:
		sprintf(lcd_buffer," ^               ");
		break;
	case OUT_SELECT:
		lcd_gotoxy(0,1);
		sprintf(lcd_buffer,"     ^           ");
	    break;
	case PROF_SELECT:
		sprintf(lcd_buffer,"               ^");
		break;
	default:
		break;
	}
	lcd_puts(lcd_buffer);


	memset(lcd_buffer,0,sizeof(lcd_buffer));
}

void Menu_About_Me(void)
{
	lcd_gotoxy(0,0);
	sprintf(lcd_buffer," Cable Test V%02d ",Version);
	lcd_puts(lcd_buffer);
	lcd_gotoxy(0,1);
	sprintf(lcd_buffer,"      NSC      ");
	lcd_puts(lcd_buffer);
	memset(lcd_buffer,0,sizeof(lcd_buffer));
}

