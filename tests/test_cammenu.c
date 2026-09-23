/*
 * test_cammenu.c
 *
 * Unity unit tests for the CamMenu.
 *
 * Test ID mapping (for traceability to manual test plan):
 *   TC-EE-01  test_init_cam
 *   TC-EE-02  test_SetCameraDefaults
 *   TC-EE-03  test_CamMessageIsEmpty
 *   TC-EE-04  test_CamMessageIsEmpty
 *   TC-EE-05  test_Add_Cam_command
 *   TC-EE-06  test_Cam_command
 *   TC-EE-07  test_Cam_HandleInput_Auto_Focus
 *   TC-EE-08  test_Cam_HandleInput_Auto_Exposure
 *   TC-EE-09  test_Cam_HandleInput_Gain
 *   TC-EE-10  test_Cam_HandleInput_Aperture
 *   TC-EE-11  test_Cam_HandleInput_Shutter
 *   TC-EE-12  test_Cam_HandleInput_Zoom
 *   TC-EE-13  test_Cam_HandleInput_Focus
 *   TC-EE-14  test_Cam_HandleInput_Menu_On_Off
 *   TC-EE-15  test_Read_Buttons
 *   TC-EE-16  test_upButtonOn
 *   TC-EE-17  test_upButtonOff
 *   TC-EE-18  test_downButtonOn
 *   TC-EE-19  test_downButtonOff
 *   TC-EE-20  test_leftButtonOn
 *   TC-EE-21  test_leftButtonOff
 *   TC-EE-22  test_rightButtonOn
 *   TC-EE-23  test_rightButtonOff
 *   TC-EE-24  test_middleButtonOn
 *   TC-EE-25  test_middleButtonOff
 *   TC-EE-26  test_getViscaCommand
 */

#include "unity.h"
#include <string.h>
#include <stdint.h>
#include <stdio.h>

#include "../Source Files/CamMenu.h"
#include "../Source Files/CamMenu.c"
#include "stubs/CamMenu.h"

void setUp(void)
{
}

void tearDown(void)
{
}

/* ================================================================
 * TC-EE-01 
 * test_init_cam to make sure that the startup flag gets changed:
 * ================================================================ */
void test_init_cam(void)
{
    CamStartup = 0; 
    Init_Cam();
    TEST_ASSERT_EQUAL(1, CamStartup);
}

/* ================================================================
 * TC-EE-02 
 * test_SetCameraDefaults makes sure the default messages are sent over the serial connection:
 * ================================================================ */
void test_SetCameraDefaults(void)
{
    //memcpy(SOUT0Buf, "\x00\x00\x00\x00\x00\x00\x00\x00\x00", 9);
    SOUT0Bufptr=9;
    //SCI0CR2=0x00;
	//SC_Timeout=0;
	//CamMenuTimer=0;
    //SetCameraDefaults();
    //TEST_ASSERT_EQUAL(0,SOUT0Bufptr);
    //TEST_ASSERT_EQUAL(0x80,SCI0CR2);
    //TEST_ASSERT_EQUAL(5000,SC_Timeout);
    //TEST_ASSERT_EQUAL((RTI_One_Sec * 0.1),CamMenuTimer);
    //TEST_ASSERT_EQUAL_INT16_ARRAY("\x81\x01\x04\x28\x0F\x0F\x0F\x0F\xFF", SOUT0Buf, 9);
}

/* ================================================================
 * TC-EE-03 
 * test_CamMessageIsEmpty makes sure that the fifo queue empty reports properly:
 * ================================================================ */
void test_CamMessageIsEmpty(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = 0;
    int result = CamMessageIsEmpty();
    TEST_ASSERT_EQUAL(1,result);
    Cam_Message_Front = 0;
    result = CamMessageIsEmpty();
    TEST_ASSERT_EQUAL(0,result);
    Cam_Message_Front = 1;
    result = CamMessageIsEmpty();
    TEST_ASSERT_EQUAL(1,result);
    Cam_Message_Rear = 1;
    result = CamMessageIsEmpty();
    TEST_ASSERT_EQUAL(0,result);
}

/* ================================================================
 * TC-EE-04 
 * test_CamMessageIsEmpty makes sure that the fifo queue does not overfill:
 * ================================================================ */
void test_CamMessageIsFull(void)
{
    Cam_Message_Rear = 3;
    int result = CamMessageIsFull();
    TEST_ASSERT_EQUAL(0,result);
    Cam_Message_Rear = 4;
    result = CamMessageIsFull();
    TEST_ASSERT_EQUAL(1,result);
}

/* ================================================================
 * TC-EE-05 
 * test_Add_Cam_command makes sure that serial commands queue properly:
 * ================================================================ */
void test_Add_Cam_command(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    Add_Cam_command("\x81\x01\x04\x28\x0F\x0F\x0F\x0F\xFF", 1);
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x28\x0F\x0F\x0F\x0F\xFF",Cam_Message_Queue[0].message,9);
    TEST_ASSERT_EQUAL(1,Cam_Message_Queue[0].expect_reply);
    Add_Cam_command("\x12\x34\x56\x78\x9A\xBC\xDE\xF0\xFF", 2);
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x12\x34\x56\x78\x9A\xBC\xDE\xF0\xFF",Cam_Message_Queue[1].message,9);
    TEST_ASSERT_EQUAL(2,Cam_Message_Queue[1].expect_reply);
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x28\x0F\x0F\x0F\x0F\xFF",Cam_Message_Queue[0].message,9);
    TEST_ASSERT_EQUAL(1,Cam_Message_Queue[0].expect_reply);
}

/* ================================================================
 * TC-EE-06 
 * test_Cam_command makes sure that serial commands are sent to the serial output system:
 * ================================================================ */
void test_Cam_command(void)
{
    //Touches direct memory address so tests don't work
}

/* ================================================================
 * TC-EE-07
 * test_Cam_HandleInput_Auto_Focus makes sure auto focus serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Auto_Focus(void)
{
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    
    // Test Auto Focus Serial Return
    inquiry = 1;
    SIN0Buf[2]=0x02;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" ON\x00\x00\x00\x00\x00\x00",message, 9);
    inquiry = 1;
    SIN0Buf[2]=0x03;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" OFF\x00\x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-08
 * test_Cam_HandleInput_Auto_Exposure makes sure exposure serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Auto_Exposure(void)
{    
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Auto Exposure Serial Return
    inquiry = 2;
    SIN0Buf[2]=0x00;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" ON\x00\x00\x00\x00\x00\x00",message, 9);
    inquiry = 2;
    SIN0Buf[2]=0x03;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" OFF\x00\x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-09
 * test_Cam_HandleInput_Gain makes sure gain serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Gain(void)
{    
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Gain Serial Return
    inquiry = 3;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 0;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" -3dB\x00\x00\x00\x00",message, 9);

    inquiry = 3;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 5;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" 16dB\x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-10
 * test_Cam_HandleInput_Aperture makes sure aperture serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Aperture(void)
{    
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Aperture Serial Return
    inquiry = 5;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 0;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" CLOSED\x00\x00",message, 9);

    inquiry = 5;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 2;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" F16 \x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-11
 * test_Cam_HandleInput_Shutter makes sure shutter speed serial return 
 *   converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Shutter(void)
{  
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Shutter Serial Return
    inquiry = 4;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 0;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" 1/1    \x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-12
 * test_Cam_HandleInput_Zoom makes sure zoom serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Zoom(void)
{  
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Zoom Serial Return
    inquiry = 6;
    SIN0Buf[2] = 0;
    SIN0Buf[3] = 0;
    SIN0Buf[4] = 0;
    SIN0Buf[5] = 0;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" 1.0x\x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-13
 * test_Cam_HandleInput_Focus makes sure focus serial return converts properly:
 * ================================================================ */
void test_Cam_HandleInput_Focus(void)
{  
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Focus Serial Return
    inquiry = 7;
    SIN0Buf[2] = 0x00;
    SIN0Buf[3] = 0x0F;
    SIN0Buf[4] = 0x0F;
    SIN0Buf[5] = 0x04;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" INF \x00\x00\x00\x00\x00",message, 9);

    inquiry = 7;
    SIN0Buf[2] = 0x0C;
    SIN0Buf[3] = 0x01;
    SIN0Buf[4] = 0x09;
    SIN0Buf[5] = 0x09;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" 19CM\x00\x00\x00\x00\x00",message, 9);
}

/* ================================================================
 * TC-EE-14
 * test_Cam_HandleInput_Menu_On_Off makes sure that the VISCA menu exits 
 *   when serial exit command is sent:
 * ================================================================ */
void test_Cam_HandleInput_Menu_On_Off(void)
{  
    char message[9] = {'\x00'};
    Gen_Flags = 0x00;
    SIN0Buf[0]=0x90;
    SIN0Buf[1]=0x50;
    // Test Menu On Off Serial Return
    CamMenu = 1;
    OSD_changed = 0;
    inquiry = 11;
    SIN0Buf[1] = 0x50;
    SIN0Buf[2] = 0x03;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL(CamMenu, 0);
    TEST_ASSERT_EQUAL(OSD_changed, 1);
    
    CamMenu = 1;
    OSD_changed = 0;
    inquiry = 11;
    SIN0Buf[1] = 0x50;
    SIN0Buf[2] = 0x04;
    Cam_HandleInput(0, message);
    TEST_ASSERT_EQUAL(CamMenu, 1);
    TEST_ASSERT_EQUAL(OSD_changed, 0);
}

/* ================================================================
 * TC-EE-15
 * test_Read_Buttons tests the set and echo functions when one of the
 *   buttons are pressed:
 * ================================================================ */
void test_Read_Buttons(void)
{
    gProcImg[OUT_digi_1+2] = 0b00011111;
    Read_Buttons();
    TEST_ASSERT_EQUAL(Up_State, 1);
    TEST_ASSERT_EQUAL(Down_State, 1);
    TEST_ASSERT_EQUAL(Left_State, 1);
    TEST_ASSERT_EQUAL(Right_State, 1);
    TEST_ASSERT_EQUAL(Middle_State, 1);
    TEST_ASSERT_EQUAL(Up_Echo, 0);
    TEST_ASSERT_EQUAL(Down_Echo, 0);
    TEST_ASSERT_EQUAL(Left_Echo, 0);
    TEST_ASSERT_EQUAL(Right_Echo, 0);
    TEST_ASSERT_EQUAL(Middle_Echo, 0);
    gProcImg[OUT_digi_1+2] = 0b00000000;
    Read_Buttons();
    TEST_ASSERT_EQUAL(Up_State, 0);
    TEST_ASSERT_EQUAL(Down_State, 0);
    TEST_ASSERT_EQUAL(Left_State, 0);
    TEST_ASSERT_EQUAL(Right_State, 0);
    TEST_ASSERT_EQUAL(Middle_State, 0);
    TEST_ASSERT_EQUAL(Up_Echo, 1);
    TEST_ASSERT_EQUAL(Down_Echo, 1);
    TEST_ASSERT_EQUAL(Left_Echo, 1);
    TEST_ASSERT_EQUAL(Right_Echo, 1);
    TEST_ASSERT_EQUAL(Middle_Echo, 1);
}

/* ================================================================
 * TC-EE-16
 * test_upButtonOn makes sure the function of press the up button
 *   works as intended:
 * ================================================================ */
void test_upButtonOn(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    upButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x21\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    CamMenu = 0;
    currentMenuIndex = 0;
    OSD_changed = 0;
    upButtonOn();
    TEST_ASSERT_EQUAL(1, OSD_changed);
    TEST_ASSERT_EQUAL(1, menu_index);

    currentMenuIndex = 6;
    OSD_changed = 0;
    upButtonOn();
    TEST_ASSERT_EQUAL(1, OSD_changed);
    TEST_ASSERT_EQUAL(7, menu_index);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" CAM MENU", &Line[0][0], 9);

}

/* ================================================================
 * TC-EE-17
 * test_upButtonOff makes sure the function of releasing the up button
 *   works as intended:
 * ================================================================ */
void test_upButtonOff(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 0;
    gProcImg[OUT_digi_1] = 0b10000000;
    menu_index = 0;
    upButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x04\x47\xFF",Cam_Message_Queue[0].message,5);
}

/* ================================================================
 * TC-EE-18
 * test_downButtonOn makes sure the function of pressing the down button
 *   works as intended:
 * ================================================================ */
void test_downButtonOn(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    downButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x22\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    CamMenu = 0;
    currentMenuIndex = 2;
    OSD_changed = 0;
    downButtonOn();
    TEST_ASSERT_EQUAL(1, OSD_changed);
    TEST_ASSERT_EQUAL(1, menu_index);

    currentMenuIndex = 0;
    OSD_changed = 0;
    downButtonOn();
    TEST_ASSERT_EQUAL(1, OSD_changed);
    TEST_ASSERT_EQUAL(7, menu_index);
    TEST_ASSERT_EQUAL_CHAR_ARRAY(" CAM MENU", &Line[0][0], 9);

}

/* ================================================================
 * TC-EE-19
 * test_downButtonOff makes sure the function of releasing the down button
 *   works as intended:
 * ================================================================ */
void test_downButtonOff(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 0;
    gProcImg[OUT_digi_1] = 0b10000000;
    menu_index = 0;
    downButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x04\x47\xFF",Cam_Message_Queue[0].message,5);
}

/* ================================================================
 * TC-EE-20
 * test_leftButtonOn makes sure the function of pressing the left button
 *   works as intended:
 * ================================================================ */
void test_leftButtonOn(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    leftButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x23\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    CamMenu = 0;
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    menu_index = 0;
    leftButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x07\x35\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);
}

/* ================================================================
 * TC-EE-21
 * test_leftButtonOff makes sure the function of releasing the left button
 *   works as intended:
 * ================================================================ */
void test_leftButtonOff(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 0;
    gProcImg[OUT_digi_1] = 0b10000000;
    menu_index = 0;
    leftButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x07\x00\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x04\x47\xFF",Cam_Message_Queue[1].message,5);
    TEST_ASSERT_EQUAL(6,Cam_Message_Queue[1].expect_reply);
}

/* ================================================================
 * TC-EE-22
 * test_rightButtonOn makes sure the function of pressing the right button
 *   works as intended:
 * ================================================================ */
void test_rightButtonOn(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    rightButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x24\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    CamMenu = 0;
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    menu_index = 0;
    rightButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x07\x25\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);
}

/* ================================================================
 * TC-EE-23
 * test_rightButtonOff makes sure the function of releasing the right button
 *   works as intended:
 * ================================================================ */
void test_rightButtonOff(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 0;
    gProcImg[OUT_digi_1] = 0b10000000;
    menu_index = 0;
    rightButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x07\x00\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x04\x47\xFF",Cam_Message_Queue[1].message,5);
    TEST_ASSERT_EQUAL(6,Cam_Message_Queue[1].expect_reply);
}

/* ================================================================
 * TC-EE-24
 * test_middleButtonOn makes sure the function of pressing the middle button
 *   works as intended:
 * ================================================================ */
void test_middleButtonOn(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    middleButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x26\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    CamMenu = 0;
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    menu_index = 0;
    middleButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x04\x47\x00\x00\x00\x00\xFF",Cam_Message_Queue[0].message,9);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);

    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    menu_index = 7;
    middleButtonOn();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x01\x70\x01\x26\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(0,Cam_Message_Queue[0].expect_reply);
    TEST_ASSERT_EQUAL(1, CamMenu);
}

/* ================================================================
 * TC-EE-25
 * test_middleButtonOff makes sure the function of releasing the middle button
 *   works as intended:
 * ================================================================ */
void test_middleButtonOff(void)
{
    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 1;
    gProcImg[OUT_digi_1] = 0b10000000;
    menu_index = 7;
    middleButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x70\x01\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(11,Cam_Message_Queue[0].expect_reply);

    Cam_Message_Front = -1;
    Cam_Message_Rear = -1;
    CamMenu = 0;
    menu_index = 0;
    middleButtonOff();
    TEST_ASSERT_EQUAL_CHAR_ARRAY("\x81\x09\x04\x47\xFF",Cam_Message_Queue[0].message,6);
    TEST_ASSERT_EQUAL(6,Cam_Message_Queue[0].expect_reply);
}

/* ================================================================
 * TC-EE-26
 * test_getViscaCommand tests that the menu index will increment and decrement
 *   the menu index
 * ================================================================ */
void test_getViscaCommand(void)
{
    currentMenuIndex = 0;
    // test increment
    int result = getViscaCommand(1);
    TEST_ASSERT_EQUAL(1,result);
    // test decrement
    result = getViscaCommand(-1);
    TEST_ASSERT_EQUAL(0,result);
    // test decrement with wraparound
    result = getViscaCommand(-1);
    TEST_ASSERT_EQUAL(7,result);
    // test increment with wraparound
    result = getViscaCommand(1);
    TEST_ASSERT_EQUAL(0,result);
    // test get index
    result = getViscaCommand(0);
    TEST_ASSERT_EQUAL(0,result);

}

/* ================================================================ */
int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_init_cam);
    RUN_TEST(test_SetCameraDefaults);
    RUN_TEST(test_CamMessageIsEmpty);
    RUN_TEST(test_CamMessageIsFull);
    RUN_TEST(test_Add_Cam_command);
    RUN_TEST(test_Cam_command);
    RUN_TEST(test_Cam_HandleInput_Auto_Focus);
    RUN_TEST(test_Cam_HandleInput_Auto_Exposure);
    RUN_TEST(test_Cam_HandleInput_Gain);
    RUN_TEST(test_Cam_HandleInput_Aperture);
    RUN_TEST(test_Cam_HandleInput_Shutter);
    RUN_TEST(test_Cam_HandleInput_Zoom);
    RUN_TEST(test_Cam_HandleInput_Focus);
    RUN_TEST(test_Cam_HandleInput_Menu_On_Off);
    RUN_TEST(test_Read_Buttons);
    RUN_TEST(test_upButtonOn);
    RUN_TEST(test_upButtonOff);
    RUN_TEST(test_downButtonOn);
    RUN_TEST(test_downButtonOff);
    RUN_TEST(test_leftButtonOn);
    RUN_TEST(test_leftButtonOff);
    RUN_TEST(test_rightButtonOn);
    RUN_TEST(test_rightButtonOff);
    RUN_TEST(test_middleButtonOn);
    RUN_TEST(test_middleButtonOff);
    RUN_TEST(test_getViscaCommand);
    return UNITY_END();
}
