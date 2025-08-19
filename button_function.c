#include "button_function.h"


struct FLAGS_B flags_b;

uint8_t (*Read_Pin_B)(uint8_t,uint8_t)=NULL;



void main_menu_button_manager_func(void)
{    
    if(ENTER_BUTTON_PUSHED==1)
    {
        flags_b.enter=0;
        switch (Menue_Cable_Select_Num)
        {
        case RUN_TEST_PAGE:
            page=RUN_TEST_PAGE;
            break;
        case CABLE_SELSECT_PAGE:
            page=CABLE_SELSECT_PAGE;
            break;
        case CABLE_DEFINE_PAGE:
            page=CABLE_DEFINE_PAGE;
            break;
        case ABOUT_ME_PAGE:
            page=ABOUT_ME_PAGE;
            break;
        default:
            break;
        }
    }
    else if(UP_BUTTON_PUSHED==1)
    {
        flags_b.up=0;
        Menue_Cable_Select_Num++;
        if(Menue_Cable_Select_Num>=(MAX_MAIN_MENU_ITEM-1))
            Menue_Cable_Select_Num=0;
    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
        flags_b.down=0;
        Menue_Cable_Select_Num--;
        if(Menue_Cable_Select_Num<0)
            Menue_Cable_Select_Num=(MAX_MAIN_MENU_ITEM-1);
    }

}

void cable_select_button_manager_func(void)
{
    if(ENTER_BUTTON_PUSHED==1)
    {
        flags_b.enter=0;
        page=MAIN_PAGE;
    }
    else if(UP_BUTTON_PUSHED==1)
    {
        flags_b.up=0;
        Menue_Cable_Select_Num++;
        if(Menue_Cable_Select_Num>MAX_NUMBER_PROFILE)
           Menue_Cable_Select_Num=0;
    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
        flags_b.down=0;
        Menue_Cable_Select_Num--;
        if(Menue_Cable_Select_Num<0)
            Menue_Cable_Select_Num=MAX_NUMBER_PROFILE;
    }
}

void cable_define_button_manager_func(void)
{
    if(ENTER_BUTTON_PUSHED==1)
    {
        flags_b.enter=0;
        if (flags_menu.subpage==IN_SELECT)
        {
           flags_menu.subpage=OUT_SELECT; 
        }
        else if (flags_menu.subpage==OUT_SELECT)
        {
            flags_menu.subpage=PROF_SELECT;
        }
        else if(flags_menu.subpage==PROF_SELECT)
        {
            flags_menu.subpage=IN_SELECT;
        }        
        
    }
    else if(UP_BUTTON_PUSHED==1)
    {
        flags_b.up=0;
        Menue_Cable_Select_Num++;
        if(Menue_Cable_Select_Num>MAX_NUMBER_PROFILE)
           Menue_Cable_Select_Num=0;
    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
        flags_b.down=0;
        Menue_Cable_Select_Num--;
        if(Menue_Cable_Select_Num<0)
            Menue_Cable_Select_Num=MAX_NUMBER_PROFILE;
    }
    else if(EXIT_BUTTON_PUSHED==1)
    {
         flags_b.up=0;
          flags_b.down=0;
          page=MAIN_PAGE;
    }
}

void about_me_button_manager_func(void)
{
    if(ENTER_BUTTON_PUSHED==1)
    {
         flags_b.enter=0;
        page=MAIN_PAGE;
    }
    else if(UP_BUTTON_PUSHED==1)
    {
         flags_b.up=0;
        page=MAIN_PAGE;
    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
         flags_b.down=0;
        page=MAIN_PAGE;
    }


}


/*
int8_t button_read(struct BUTTON_PORTS_PINS port)
{
    if((*Read_Pin_B)(port.b1_port,port.b1_pin)==PUSHED)
    {
         flags_b.enter=1;
    }
    if((*Read_Pin_B)(port.b2_port,port.b2_pin)==PUSHED)
    {
         flags_b.up=1;
    }
    if((*Read_Pin_B)(port.b3_port,port.b3_pin)==PUSHED)
    {
         flags_b.down=1;
    }

}
*/



