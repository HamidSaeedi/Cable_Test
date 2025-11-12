#include "Menu_Functions.h"
#include "cable.h"
//char Menue_Main_Srting[4][NUM_COLUMN+1]={"Test Run" , "Cable Select" , "Cable define" , "About Me"};
char Menue_Main_Srting[4][NUM_COLUMN+1]={"Test Run" , "Cable Select"  , "About Me"};
char Menue_Main_Arrow_String[2][3]={"  ","->"};
char lcd_buffer[NUM_COLUMN];
int8_t Menue_Main_Num=0;
int8_t Menue_Main_Select_Num=0; //0 .. NUM_ROW

int8_t Menue_Cable_Select_Num=0;
int8_t Menue_Cable_Select_Select_Num=0;  //0 .. NUM_ROW

uint8_t Menu_Cable_Define_Prof=0;
uint8_t Menu_Cable_Define_Index_In=0;
uint8_t Menu_Cable_Define_Index_Out=0;
uint8_t Menu_Cable_Define_Index_In_Num=0;
uint8_t Menu_Cable_Define_Index_Out_Num=0;
struct FLAGS_MENU flags_menu;
uint8_t page=MAIN_PAGE;

void Menu_Main (void)
{
	int byteWrite=0;
	uint8_t i=0; //just a simple loop counter.
	for(i=0;(i<NUM_ROW) && (i<MAX_MAIN_MENU_ITEM);i++)
	{
		lcd_gotoxy(0,i);
		memset(lcd_buffer,' ',sizeof(lcd_buffer));
		
		byteWrite=snprintf(lcd_buffer, sizeof(lcd_buffer), "%s%s",Menue_Main_Arrow_String[(i==Menue_Main_Select_Num)] ,Menue_Main_Srting[Menue_Main_Num+i]);
		/*We just fill the remainnig part of the lcd_buffer with null to insure clean update 
		we did not use the lcd_clear becuse it cuse blinking in the lcd.
		*/
		// Fill remaining space with spaces
        if(byteWrite < NUM_COLUMN && byteWrite >= 0) 
		{
           memset(lcd_buffer + byteWrite, ' ', NUM_COLUMN - byteWrite);
        }
    
        // Ensure null termination at LCD width
        lcd_buffer[NUM_COLUMN] = '\0';
	    lcd_puts(lcd_buffer);
	}

}

int8_t  Menu_Cable_Select(void)
{
	int byteWrite=0;
	uint8_t i=0; //just a simple loop counter.
	for(i=0;i<NUM_ROW;i++)
	{
		lcd_gotoxy(0,i);
		memset(lcd_buffer,' ',sizeof(lcd_buffer));
		
		byteWrite=snprintf(lcd_buffer, sizeof(lcd_buffer), "%sCable%02d",Menue_Main_Arrow_String[(i==Menue_Cable_Select_Select_Num)] ,Menue_Cable_Select_Num+i);
		/*We just fill the remainnig part of the lcd_buffer with null to insure clean update 
		we did not use the lcd_clear becuse it cuse blinking in the lcd.
		*/
		// Fill remaining space with spaces
        if(byteWrite < NUM_COLUMN && byteWrite >= 0) 
		{
           memset(lcd_buffer + byteWrite, ' ', NUM_COLUMN - byteWrite);
        }
    
        // Ensure null termination at LCD width
        lcd_buffer[NUM_COLUMN] = '\0';
	    lcd_puts(lcd_buffer);
	}
	/*
	lcd_gotoxy(0,0);
	sprintf(lcd_buffer,"-> cable%02d     ",Menue_Cable_Select_Num);
	lcd_puts(lcd_buffer);
	lcd_gotoxy(0,1);
	sprintf(lcd_buffer,"   cable%02d    ",Menue_Cable_Select_Num+1);
	lcd_puts(lcd_buffer);
	memset(lcd_buffer,0,sizeof(lcd_buffer));
	*/
	if(flag.enter_button==1)
	{
		flag.enter_button=0;
		cable_func_handle.cable_id=Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num;
		return Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num;
	}
	return -1;
}

int8_t Menu_Run_Test(void)
{
	//Profile_ID();
	if( cable_func_handle.error_other==MAXPROFILELIMIT)
	{
		//print the error in here!
		return 0;
	}
	else
	{
	Cable_Check();
	Cable_Error_Check();
	lcd_gotoxy(0,0);
	memset(lcd_buffer,' ',sizeof(lcd_buffer));
	sprintf(lcd_buffer,"--> %s",cable_func_handle.error_symbol);
	lcd_puts(lcd_buffer);
	if(cable_func_handle.pass_pins==MAX_CABLE_PINS)
	{
		lcd_gotoxy(0,1);
		memset(lcd_buffer,' ',sizeof(lcd_buffer));
		sprintf(lcd_buffer," cable%02d PASS!   ", Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num);
		lcd_puts(lcd_buffer);
		cable_func_handle.pass_pins=0;
	}
	else
	{
		lcd_gotoxy(0,1);
		memset(lcd_buffer,' ',sizeof(lcd_buffer));
		sprintf(lcd_buffer,"cable%02d Failed!", Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num);
		lcd_puts(lcd_buffer);
		cable_func_handle.pass_pins=0;
	}
	return 0;
	}
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

