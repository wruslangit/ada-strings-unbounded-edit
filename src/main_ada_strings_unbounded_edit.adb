-- File: main_ada_strings_unbounded_edit.adb
-- Date: Sat 10 Apr 2021 11:18:02 AM +08
-- Author: WRY wruslan.ump@gmail.com
-- ========================================================
-- IMPORT STANDARD ADA PACKAGES
with Ada.Text_IO;
with Ada.Real_Time; 
use  Ada.Real_Time;
with Ada.Strings.Unbounded;

-- IMPORT USER-DEFINED ADA PACKAGES
with pkg_ada_datetime_stamp;
with pkg_ada_realtime_delays;
with pkg_ada_linestring_split;
with strings_edit;
with pkg_ada_vectorize_splitline;

-- ========================================================
procedure main_ada_strings_unbounded_edit
-- ========================================================
--	with SPARK_Mode => on
is 
   -- RENAME STANDARD ADA PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package ART     renames Ada.Real_Time;
   package ASU     renames Ada.Strings.Unbounded;
   
   -- RENAME USER-DEFINED ADA PACKAGES FOR CONVENIENCE
   package PADTS   renames pkg_ada_datetime_stamp;
   package PARTD   renames pkg_ada_realtime_delays;
   package PALSS   renames pkg_ada_linestring_split;
   package PASE    renames strings_edit;
   package PAVSL   renames pkg_ada_vectorize_splitline;
      
   -- PROCEDURE-WIDE VARIABLE DEFINITIONS
   startClock, finishClock   : ART.Time;  
   -- startTestClock, finishTestClock : ART.Time;
   -- deadlineDuration : ART.Time_Span;
   
   
   -- INPUT FILE 
   inp_fhandle      : ATIO.File_Type;
   inp_fmode        : ATIO.File_Mode  := ATIO.In_File;
   -- inp_fname        : String := "files/bismillah.ngc"; 
   inp_fname        : String := "files/ngc-code.ngc"; 
   inp_fform        : String := "shared=yes"; 
   inp_fOwnID       : String := "bsm-001";
   
   inp_lineCount    : Integer := 0;
   inp_UBlineStr    : ASU.Unbounded_String;
   
   -- OUTPUT FILES
   out_fhandle_01    : ATIO.File_Type;
   out_fhandle_02    : ATIO.File_Type;
   out_fhandle_03    : ATIO.File_Type;
   
   out_fmode_01      : ATIO.File_Mode  := ATIO.Out_File;
   out_fmode_02      : ATIO.File_Mode  := ATIO.Out_File;
   out_fmode_03      : ATIO.File_Mode  := ATIO.Out_File;
   
   out_fname_01  : String := "files/ngc-code.ngc_file_01.txt";
   out_fname_02  : String := "files/ngc-code.ngc_file_02.txt";
   out_fname_03  : String := "files/ngc-code.ngc_file_03.txt";
   
  
   -- =====================================================
   procedure display_help_file is 
   -- =====================================================
      inp_fhandle : ATIO.File_Type; 
      inp_fmode   : ATIO.File_Mode := ATIO.In_File;
      inp_fname   : String := "src/main_ada_strings_unbounded_edit.hlp";
      inp_UBlineStr : ASU.Unbounded_String;
   
   begin
      ATIO.Open (inp_fhandle, inp_fmode, inp_fname); 
      
      -- Traverse file line by line and display line to screen
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBlineStr)); 
      end loop;   
      
      ATIO.Close(inp_fhandle);
   end display_help_file;
    
   -- =====================================================
   procedure about_this_procedure is
   -- =====================================================   
   begin
      -- Read external file to read description
      display_help_file;
      
   end about_this_procedure;
      
begin  -- =================================================
   
   startClock := ART.Clock; PADTS.dtstamp;
   ATIO.Put_Line ("STARTED: main Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;
   -- about_this_procedure;
   
   -- CODE BEGINS HERE
   -- =====================================================
   
      
   -- OPEN INPUT FILE WITH SHARING = YES 
   -- CREATE OUTPUT FILES
   ATIO.Open (inp_fhandle, inp_fmode, inp_fname, inp_fform); 
   ATIO.Create (out_fhandle_01, out_fmode_01, out_fname_01); 
   ATIO.Create (out_fhandle_02, out_fmode_02, out_fname_02);
   ATIO.Create (out_fhandle_03, out_fmode_03, out_fname_03);
   
    -- GET TOTAL LINE COUNT
   while not ATIO.End_Of_File (inp_fhandle) loop
      inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      inp_lineCount := inp_lineCount + 1;
   end loop;   
   ATIO.Put_line ("Total inp_lineCount = " & Integer'Image(inp_lineCount));
   
   ATIO.reset(inp_fhandle); -- Set line pointer back to the top of file
   inp_lineCount := 0;
    
   -- PROCESS EACH LINE
   while not ATIO.End_Of_File (inp_fhandle) loop
      inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      inp_lineCount := inp_lineCount + 1;
      
      -- WRITE LINE TO SCREEN
      -- ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBlineStr));
   
      -- WRITE LINE TO FILE
      ATIO.Put_Line (out_fhandle_01, ASU.To_String (inp_UBlineStr));
      
      -- TOKENIZE EACH LINE AND WRITE TO FILE 
      -- PALSS.tokenize_line (ASU.To_String (inp_UBlineStr), out_fhandle_02, inp_lineCount);
      
      -- VECTORIZE EACH LINE AND WRITE TO FILE
      -- To mark with line numbers
      PAVSL.vectorize_eachline (ASU.To_String (inp_UBlineStr), out_fhandle_02, out_fhandle_03, inp_lineCount); 
      
   end loop;  
   ATIO.Close (out_fhandle_01);
   ATIO.Close (out_fhandle_02);
   ATIO.Close (out_fhandle_03);
   ATIO.Close (inp_fhandle);
      
   -- CODE ENDS HERE
   -- =====================================================
   ATIO.New_Line; PADTS.dtstamp;
   ATIO.Put_line ("ENDED: main Alhamdulillah 3 times WRY. ");
   finishClock := ART.Clock;
   PADTS.dtstamp; ATIO.Put ("Current main() Total ");
   PARTD.exec_display_execution_time(startClock, finishClock); 
-- ========================================================   
end main_ada_strings_unbounded_edit;
-- ========================================================
