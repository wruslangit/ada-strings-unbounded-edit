-- File   : pkg_ada_vectorize_splitline.adb
-- Date   : Sun 30 May 2021 05:11:11 PM +08
-- Author : wruslandr@gmail.com
-- Version: Sun 30 May 2021 05:11:11 PM +08
-- ========================================================
with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Real_Time; 
use  Ada.Real_Time;  
with Ada.Strings.Unbounded;
with Ada.Strings.Maps;

with Ada.Characters.Latin_1;
with GNAT.String_Split;
-- use  Ada.Characters;
-- use  GNAT;

-- ========================================================
package body pkg_ada_vectorize_splitline 
-- ========================================================
--   with SPARK_Mode => on
is
   -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO   renames Ada.Text_IO;
   package ART    renames Ada.Real_Time;
   package ASU    renames Ada.Strings.Unbounded;
   package ACL1   renames Ada.Characters.Latin_1;
   package ASM    renames Ada.Strings.Maps;
   package GSS    renames GNAT.String_Split;
   
   -- ALL REQUIRED FOR INITIALIZATION ONLY
      
   -- ALL VARIABLES DEFINITIONS
   -- type StrArray is array (Positive range <>) of ASU.Unbounded_String;
        
      
   -- =====================================================
   procedure tokenize_line (linestring : String; out_fhandle_02 : ATIO.File_Type; linecount : Integer) is 
   -- =====================================================
      -- Define substrings array to be populated by the actual substring elements   
      -- separated by TabAndSpace
      substrings : GSS.Slice_Set;
      TabAndSpace : constant String :=  (" " & ACL1.HT);
      
    begin 
    
      -- WRITE TO FILE AND WRITE TO SCREEN
      -- Identify and write each line read in steps of 10 (so that 10 count intervals can be used for others)
      ATIO.Put_Line (out_fhandle_02, Integer'Image(10*linecount) & " Splitting '" & linestring & "' at whitespace.");
      ATIO.Put_Line (Integer'Image(10*linecount) & " Splitting '" & linestring & "' at whitespace.");
      
      -- CREATE ARRAY OF SUBSTRINGS
      -- Create the split, using Multiple mode to treat strings of multiple
      -- whitespace characters as a single separator. This populates the subsrings array object.
      GSS.Create (S          => substrings,
                  From       => linestring,
                  Separators => TabAndSpace,
                  Mode       => GSS.Multiple);
      
      -- WRITE TO FILE AND WRITE TO SCREEN
      ATIO.Put_Line (out_fhandle_02, Integer'Image(10*linecount) & " captured total count =" & GSS.Slice_Number'Image (GSS.Slice_Count (substrings)) & " substrings:");      
      ATIO.Put_Line (Integer'Image(10*linecount) & " captured total count =" & GSS.Slice_Number'Image (GSS.Slice_Count (substrings)) & " substrings:");
            
      --  LOOP THROUGH substrings ARRAY.
      --  Report results, starting with the count of substrings created.
      for I in 1 .. GSS.Slice_Count (substrings) loop
      
         declare
            -- Pull the next substring out into a string object for easy handling.   
            the_token : constant String := GSS.Slice (substrings, I);
        
         begin
            -- WRITE TO FILE AND WRITE TO SCREEN
            -- Output the individual substrings (tokens), and its length.
            ATIO.Put_Line (out_fhandle_02, GSS.Slice_Number'Image (I) & " -> " & the_token & " (length" & Positive'Image (the_token'Length) & ")");  
            ATIO.Put_Line (GSS.Slice_Number'Image (I) & " -> " & the_token & " (length" & Positive'Image (the_token'Length) & ")");
         end;
         
      end loop;
  
   end tokenize_line;
   
   -- =====================================================
   
   -- =====================================================
      
   
   
   

  
-- ========================================================
begin -- PACKAGE BEGIN
   null;
-- ========================================================
end pkg_ada_vectorize_splitline;
-- ========================================================
