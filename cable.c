#include "cable.h"

uint8_t Input[MAX_CABLE_PINS];
uint8_t Output[MAX_CABLE_PINS];

uint8_t In_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
uint8_t Out_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
struct FUNC_HANDLE cable_func_handle;
struct FLAG flag;



/*
uint8_t (*Read_Pin)(void) = NULL;
void (*Port_Set)(uint8_t) = NULL;
void (*sleep_ms)(uint32_t) = NULL;
int8_t (*profile_lcd_menu)(void) = NULL;
*/

struct FUNC_HANDLE Profile_ID(void)
{
    uint8_t Cable_ID=0;
    Cable_ID=(*profile_lcd_menu)();
    if(Cable_ID>MAX_NUMBER_PROFILE)
    {
        cable_func_handle.error_other=MAXPROFILELIMIT;
        return cable_func_handle;
    }
    cable_func_handle.cable_id=Cable_ID;
    return cable_func_handle;

}

void Cable_Check(void)
{
    uint8_t i=0,j=0;
    memcpy(Input,In_profile[cable_func_handle.cable_id],MAX_CABLE_PINS);
    memcpy(Output,Out_profile[cable_func_handle.cable_id],MAX_CABLE_PINS);
    for(i=0;i<sizeof(Output);i++)
    {
        (*Port_Set)(Output[i]);
        for(j=0;j<sizeof(Input);j++)
        {
            //(*sleep_ms)(1);
            if((*Read_Pin)()==Input[j])
            {
                if(i!=j)
                {
                    cable_func_handle.error_cable[i]=2+i;
                    flag.connect=1;
                }
                else if(i==j)
                {
                    flag.connect=1;
                    cable_func_handle.error_cable[i]=0;
                }

            }
            if((*Read_Pin)()>Input[j])
            {
               flag.connect=1;
               cable_func_handle.error_cable[i]=3+i;
            }
        }
        if(flag.connect==1)
        {
            flag.connect=0;
        }
        else if(flag.connect==0)
        {
             cable_func_handle.error_cable[i]=1;
             flag.notconnect=1;
        }
    }

}

struct FUNC_HANDLE Cable_Error_Check(void)
{
    uint8_t i=0;
    for(i=0;i<MAX_CABLE_PINS;i++)
    {
        if(cable_func_handle.error_cable[i]==i+3)
        {
            cable_func_handle.error_symbol[i]=CONFLICT;
        }
        else if(cable_func_handle.error_cable[i]==i+2)
        {
             cable_func_handle.error_symbol[i]= WRONG;
        }
        else if(cable_func_handle.error_cable[i]==0)
        {
             cable_func_handle.error_symbol[i]= GOOD;
             cable_func_handle.pass_pins++;
        }
        else if(cable_func_handle.error_cable[i]==1)
        {
             cable_func_handle.error_symbol[i]= NOCONNECT;
        }
    }

    return cable_func_handle;
}








