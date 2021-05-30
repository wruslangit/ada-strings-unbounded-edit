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
use  Ada.Strings.Unbounded;
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
   procedure vectorize_eachline (linestring : String; out_fhandle_02, out_fhandle_03 : ATIO.File_Type; linecount : Integer) is 
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
     
      -- =================================================================
      --  LOOP THROUGH substrings ARRAY.
      --  Report results, starting with the count of substrings created.
      for I in 1 .. GSS.Slice_Count (substrings) loop
      
         declare
            -- Pull the next substring out into a string object for easy handling.   
            the_token : constant String := GSS.Slice (substrings, I);
            
            ubs_feedrate_20, ubs_feedrate_21, ubs_scaling_z, ubs_scaling_xy : ASU.Unbounded_String; 
            ubs_offset_x,    ubs_offset_y,    ubs_offset_z : ASU.Unbounded_String; 
            
            
            ubs_token, ubs_action, ubsnext_x, ubsnext_y, ubsnext_z, ubsnext_i, ubsnext_j, ubsnext_f : ASU.Unbounded_String; 
            
         begin
            -- WRITE TO FILE AND WRITE TO SCREEN
            -- Output the individual substrings (tokens), and its length.
            ATIO.Put_Line (out_fhandle_02, GSS.Slice_Number'Image (I) & " -> " & the_token );  
            ATIO.Put_Line (GSS.Slice_Number'Image (I) & " -> " & the_token );
            
            -- RESET VALUES 
            ubs_token := ASU.To_Unbounded_String ("none");  ubs_action := ASU.To_Unbounded_String ("none");
            ubsnext_x := ASU.To_Unbounded_String ("none");  ubsnext_y  := ASU.To_Unbounded_String ("none");
            ubsnext_z := ASU.To_Unbounded_String ("none");  ubsnext_i  := ASU.To_Unbounded_String ("none");
            ubsnext_j := ASU.To_Unbounded_String ("none");  ubsnext_f  := ASU.To_Unbounded_String ("none");
            
            ubs_feedrate_20 := ASU.To_Unbounded_String ("none"); ubs_feedrate_21 := ASU.To_Unbounded_String ("none");
            ubs_scaling_xy  := ASU.To_Unbounded_String ("none"); ubs_scaling_z   := ASU.To_Unbounded_String ("none");
            ubs_offset_x    := ASU.To_Unbounded_String ("none"); ubs_offset_y    := ASU.To_Unbounded_String ("none");
            ubs_offset_z    := ASU.To_Unbounded_String ("none"); 
            
                        
            -- THE ACTUAL STRING TOKEN = the_token FROM THE LOOP
            ubs_token := ASU.To_Unbounded_String (the_token);
            
            -- ACTION CODES ===================================================
            -- FOR first character % = Control
            if (ubs_token = "%") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = % ============"  );
            end if;
            
            -- FOR first 2 chars M2 = Control
            if (ubs_token = "M2") then
              ubs_action := ubs_token;
              ATIO.Put_Line ("=========== ubs_token = M2 ============"  );
            end if;
            
            -- FOR first 2 chars M3 = Control
            if (ubs_token = "M3") then
              ubs_action := ubs_token;
              ATIO.Put_Line ("=========== ubs_token = M3 ============"  );
            end if;
            
            -- FOR first 2 chars M5 = Control
            if (ubs_token = "M5") then
              ubs_action := ubs_token;
              ATIO.Put_Line ("=========== ubs_token = M5 ============"  );
            end if;
            
            -- FOR first 3 chars G21 = All units in mm
            if (ubs_token = "G21") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = G21 ============"  );
            end if;
            
            -- AXIS OFFSET CODES ==============================================
            -- X-axis Offset
            if (ubs_token = "#6") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #6 X-axis_offset ============"  );
               
               ubs_offset_x := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #6 ubs_offset_x = " & ASU.To_String (ubs_offset_x) ); 
               
            end if;
            
            -- Y-axis Offset
            if (ubs_token = "#7") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #7 Y-axis_offset ============"  );
               
               ubs_offset_y := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #7 ubs_offset_y = " & ASU.To_String (ubs_offset_y) ); 
               
            end if;
                        
            -- Z-axis Offset
            if (ubs_token = "#8") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #8 Z-axis_offset ============"  );
               
               ubs_offset_z := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #8 ubs_offset_z = " & ASU.To_String (ubs_offset_z) ); 
               
            end if;
            
            -- XY-axis_scaling
            if (ubs_token = "#10") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #10 XY_scaling ============"  );
               ubs_scaling_xy := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #10 ubs_scaling_xy = " & ASU.To_String (ubs_scaling_xy) ); 
            end if;
            
            -- Z-axis_scaling
            if (ubs_token = "#11") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #11 Z-axis_scaling ============"  );
               ubs_scaling_z := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #11 ubs_scaling_z = " & ASU.To_String (ubs_scaling_z) ); 
            end if;
            
            -- Feed_definition
            if (ubs_token = "#20") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #20 Feed_definition ============"  );
               
               ubs_feedrate_20 := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #20 feedrate_20 = " & ASU.To_String (ubs_feedrate_20) );   
            end if;
            
            -- Feed_definition
            if (ubs_token = "#21") then
               ubs_action := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = #21 Feed_definition ============"  );
               
               ubs_feedrate_21 := ASU.To_Unbounded_String (GSS.Slice (substrings, 3));
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " #21 feedrate_21 = " & ASU.To_String (ubs_feedrate_21) );               
            end if;
                    
            
            -- MOTION CODES ===================================================
            if (ubs_token = "G00") then
               ATIO.Put_Line ("=========== ubs_token = G00 ============"  ); 
               ubs_action := ubs_token;
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsaction = " & ASU.To_String (ubs_action) );
            end if;   
            
            if (ubs_token = "G01") then
               ATIO.Put_Line ("=========== ubs_token = G01 ============"  ); 
               ubs_action := ubs_token;
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsaction = " & ASU.To_String (ubs_action) );
            end if;   
            
            if (ubs_token = "G02") then
               ATIO.Put_Line ("=========== ubs_token = G02 ============"  ); 
               ubs_action := ubs_token;
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsaction = " & ASU.To_String (ubs_action) );
            end if;   
            
            if (ubs_token = "G03") then
               ATIO.Put_Line ("=========== ubs_token = G03 ============"  );
               ubs_action := ubs_token;
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsaction = " & ASU.To_String (ubs_action) );
            end if;   
            
            -- POINT COORDINATE CODES =========================================
            -- FOR first character X
            if (ASU.Slice(ubs_token, 1, 1) = "X") then
               ubsnext_x := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_x ============"  );
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_x = " & ASU.To_String (ubsnext_x) );
            end if;
                    
            -- FOR first character Y
            if (ASU.Slice(ubs_token, 1, 1) = "Y") then
               ubsnext_y := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_y ============"  );
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_y = " & ASU.To_String (ubsnext_y) );
            end if;
            
            -- FOR first character Z
            if (ASU.Slice(ubs_token, 1, 1) = "Z") then
               ubsnext_z := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_z ============"  );
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_z = " & ASU.To_String (ubsnext_z) );
            end if;
            
            -- FOR first character I
            if (ASU.Slice(ubs_token, 1, 1) = "I") then
               ubsnext_i:= ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_i ============"  );
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_i = " & ASU.To_String (ubsnext_i) );
            end if;
                        
            -- FOR first character J
            if (ASU.Slice(ubs_token, 1, 1) = "J") then
               ubsnext_j := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_j ============"  );
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_j = " & ASU.To_String (ubsnext_j) );
               
            end if;
            
            -- FOR first character F
            if (ASU.Slice(ubs_token, 1, 1) = "F") then
               ubsnext_f := ubs_token;
               ATIO.Put_Line ("=========== ubs_token = ubsnext_f ============"  );
               
               
               ATIO.Put_Line (out_fhandle_03, Integer'Image(10*linecount) & " ubsnext_f = " & ASU.To_String (ubsnext_f) );
            end if;
            
                    
            
            -- ================================================================
            -- WRITE VECTOR LINE (INTERNAL PACKAGE CALL)
            -- write_vector_line (straction, str_next_x, next_y, next_z, next_i, next_j, next_f);
            
            
         end;
         
      end loop;
  
   end vectorize_eachline;
   
   -- =====================================================
   procedure write_vector_line (straction, strnext_x, strnext_y, strnext_z, strnext_i, strnext_j, strnext_f : in String )
   -- =====================================================
   is   
   
   begin
   
      
      
      null;
   end write_vector_line;
   
-- ========================================================
begin -- PACKAGE BEGIN
   null;
-- ========================================================
end pkg_ada_vectorize_splitline;
-- ========================================================
