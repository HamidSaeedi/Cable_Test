#include "cable.h"
#include <mega16a.h>
#include "Menu_Functions.h" 
#include "button_function.h"        
#include <delay.h>



//Declare your global variables here                                   
void write_port(uint8_t);
uint8_t port_vlaue;
void Delay(uint32_t);
void Cable_Check(void);
void Menu(void);
uint8_t read_PIN(void);








 
 

         
interrupt [EXT_INT2] void ext_int2_isr(void)
{

  if(PINB.3==0)
  {
    flags_b.enter=1;
  }

  if(PINB.5==0)
  {
    flags_b.up=1;
  }
  if(PINB.4==0)
  {
    flags_b.down=1;
  }

}



// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Reinitialize Timer 0 value
TCNT0=0x64;
// Place your code here
switch (page)
{
    case MAIN_PAGE:
        Menu_Main();
        main_menu_button_manager_func();
        break;
    case RUN_TEST_PAGE:
        Menu_Cable_Select();
        cable_select_button_manager_func();
        break;
    case CABLE_SELSECT_PAGE:
        Menu_Cable_Define();
        cable_define_button_manager_func();
        break;
    case ABOUT_ME_PAGE:
        Menu_About_Me();
        about_me_button_manager_func();
        break;
}    

}


void main(void)

{
// Declare your local variables here

In_profile[1][0] = 0x01;
In_profile[1][1] = 0x02;
In_profile[1][2] = 0x04;
In_profile[1][3] = 0x08;
In_profile[1][4] = 0x10;
In_profile[1][5] = 0x20;
In_profile[1][6] = 0x40;
In_profile[1][7] = 0x80;

Out_profile[1][0] = 0x01;
Out_profile[1][0] = 0x02;
Out_profile[1][0] = 0x04;
Out_profile[1][0] = 0x08;
Out_profile[1][0] = 0x10;
Out_profile[1][0] = 0x20;
Out_profile[1][0] = 0x40;
Out_profile[1][0] = 0x80;







//Out_profile[1] = {0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
 // External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: On
// INT2 Mode: Falling Edge
GICR|=(0<<INT1) | (0<<INT0) | (1<<INT2);
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(0<<INTF1) | (0<<INTF0) | (1<<INTF2);



// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 31.250 kHz
// Mode: Normal top=0xFF
// OC0 output: Disconnected
// Timer Period: 4.992 ms
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x64;
OCR0=0x00;


// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
DDRB.0=1;
lcd_init(16);
// Global enable interrupts
#asm("sei")                                           
while (1)
{
 
}
}

void write_port(uint8_t In_value){


PORTC = In_value;

}

void Delay(uint32_t T){

delay_ms(T);

}

uint8_t read_PIN(void){

return PIND;

}     








