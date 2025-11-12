#include "button_function.h"


struct FLAGS_B flags_b;





void main_menu_button_manager_func(void)
{  
    int8_t Menu_Item=-1;
    Menu_Item =  Menue_Main_Select_Num+Menue_Main_Num; 
    if(ENTER_BUTTON_PUSHED==1)
    {
        flags_b.enter=0;
        switch (Menu_Item)
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
        lcd_clear();
    }
    else if(UP_BUTTON_PUSHED==1)
    {
        flags_b.up=0;
        Menue_Main_Select_Num--; //0 or 1
        if(Menue_Main_Select_Num<0)
        {
           Menue_Main_Num=Menue_Main_Num-NUM_ROW;
           Menue_Main_Select_Num=NUM_ROW-1; 
           if(Menue_Main_Num<0)
              Menue_Main_Num=MAX_MAIN_MENU_ITEM-NUM_ROW;
        }

    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
        flags_b.down=0;
        Menue_Main_Select_Num++;
        if(Menue_Main_Select_Num>=NUM_ROW || Menue_Main_Select_Num>=MAX_MAIN_MENU_ITEM)
        {
          Menue_Main_Num=Menue_Main_Num+NUM_ROW;
          Menue_Main_Select_Num=0;  
          if(Menue_Main_Num>=(MAX_MAIN_MENU_ITEM-1))
             Menue_Main_Num=0;
        }
    }

}
void run_test_button_manager_func(void)
{
    if(ENTER_BUTTON_PUSHED==1)
    {
         flags_b.enter=0;
         page=MAIN_PAGE;
    }
}
void cable_select_button_manager_func(void)
{
    if(ENTER_BUTTON_PUSHED==1)
    {
        flags_b.enter=0;
        page=MAIN_PAGE;
        lcd_clear();
        //temp = Menue_Cable_Select_Num; 
    }
    else if(UP_BUTTON_PUSHED==1)
    {
        flags_b.up=0;
        Menue_Cable_Select_Select_Num--;
        if(Menue_Cable_Select_Select_Num<0)
        {
            Menue_Cable_Select_Select_Num=NUM_ROW-1;
            Menue_Cable_Select_Num=Menue_Cable_Select_Num-NUM_ROW;
            if(Menue_Cable_Select_Num<0)
                Menue_Cable_Select_Num=MAX_NUMBER_PROFILE-NUM_ROW;
        }

    }
    else if(DOWN_BUTTON_PUSHED==1)
    {
        flags_b.down=0;
        Menue_Cable_Select_Select_Num++;
        if(Menue_Cable_Select_Select_Num>=NUM_ROW)
        {
            Menue_Cable_Select_Select_Num=0;
            Menue_Cable_Select_Num=Menue_Cable_Select_Num+NUM_ROW;
            if(Menue_Cable_Select_Num>=(MAX_NUMBER_PROFILE-1))
                Menue_Cable_Select_Num=0;
        }

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



