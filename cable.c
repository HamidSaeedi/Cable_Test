#include "cable.h"

uint8_t Input[MAX_CABLE_PINS];
uint8_t Output[MAX_CABLE_PINS];

uint8_t In_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
uint8_t Out_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
struct FUNC_HANDLE cable_func_handle;
struct FLAG flag;
uint8_t Cable_ID=0;
uint8_t Error_Cable[8];
char Error_Symbol[8];

uint8_t (*Read_Pin)(void) = NULL;
void (*Port_Set)(uint8_t) = NULL;
void (*sleep_ms)(uint32_t) = NULL;
uint8_t (*profile_lcd_menu)(void) = NULL;


struct FUNC_HANDLE Profile_ID(void)
{
    uint8_t Cable_ID;
    Cable_ID=(*profile_lcd_menu)();
    if(Cable_ID>MAX_NUMBER_PROFILE)
    {
        cable_func_handle.e_state=1;
        cable_func_handle.e_code=5;
        return cable_func_handle;
    }
    cable_func_handle.e_state=0;
    cable_func_handle.func_return_val=Cable_ID;
    return cable_func_handle;

}

void Cable_Check(void)
{
    uint8_t i=0,j=0;
    memcpy(Input,In_profile[Cable_ID],sizeof(In_profile[Cable_ID]));
    memcpy(Output,Out_profile[Cable_ID],sizeof(Out_profile[Cable_ID]));
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
                    Error_Cable[i]=2+i;
                    flag.connect=1;
                }
                else if(i==j)
                {
                    flag.connect=1;
                    Error_Cable[i]=0;
                }

            }
            if((*Read_Pin)()>Input[j])
            {
               flag.connect=1;
               Error_Cable[i]=3+i;
            }
        }
        if(flag.connect==1)
        {
            flag.connect=0;
        }
        else if(flag.connect==0)
        {
             Error_Cable[i]=1;
             flag.notconnect=1;
        }
    }

}

struct FUNC_HANDLE Cable_Error_Check(void)
{
    uint8_t i=0;
    for(i=0;i<MAX_CABLE_PINS;i++)
    {
        if(Error_Cable[i]==i+3)
        {
            Error_Symbol[i]='C';
        }
        else if(Error_Cable[i]==i+2)
        {
             Error_Symbol[i]= 'W';
        }
        else if(Error_Cable[i]==0)
        {
             Error_Symbol[i]= 'G';
        }
        else if(Error_Cable[i]==1)
        {
             Error_Symbol[i]= 'N';
        }
    }
    for(i=0;i<MAX_CABLE_PINS;i++)
    {
        if(Error_Symbol[i]!='G')
        {
            flag.test_result=0;
            cable_func_handle.e_state=1;
            cable_func_handle.e_code=6;
            cable_func_handle.func_return_val=0;
            return cable_func_handle;
        }
    }
    cable_func_handle.e_state=0;
    cable_func_handle.func_return_val=0;
    cable_func_handle.e_code=0;
    return cable_func_handle;
}








