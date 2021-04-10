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
with pkg_ada_file_read_display;
with strings_edit;

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
   package PAFRD   renames pkg_ada_file_read_display;
   package PASE    renames strings_edit;
      
   -- PROCEDURE-WIDE VARIABLE DEFINITIONS
   startClock, finishClock   : ART.Time;  
   -- startTestClock, finishTestClock : ART.Time;
   -- deadlineDuration : ART.Time_Span;
   
  
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
   
   -- CODE BEGINS HERE
   -- =====================================================
   -- about_this_procedure;
      
   
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
