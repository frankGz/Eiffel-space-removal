note
  description: "Copy a file by remove leading and trailing spaces."
  author: "??"
  date: "??"
  version: "1.0"

class SPACE_REMOVAL

create execute

--------------------------------------------------------------------------------
feature {NONE} -- Attributes

input_filename : STRING_32 = "input_1.text"
output_filename : STRING_32 = "output_1.text"
input, output: PLAIN_TEXT_FILE

EOL: CHARACTER = '%N'        -- End of line
EOF: CHARACTER = '%/26/'     -- End of file
Space_char: CHARACTER = ' '  -- blank space character

ch: CHARACTER -- The last character that has been read

--------------------------------------------------------------------------------
feature {NONE} -- Creation

execute
  do
    create input.make_open_read (input_filename)
    create output.make_open_write (output_filename)
    copy_file
  end

--------------------------------------------------------------------------------
feature {NONE} -- Main routine

copy_file
    -- Copy a file character by character from input to output
  require
    input_open: input.is_readable
    output_open: output.is_writable
    local a_boolean : BOOLEAN

  do
    from read_char  -- Must prime the pump by reading the first character
    until ch = EOF
    loop
    	if ch = Space_char then
    	read_char

    	if not (ch = Space_char) then
    		output.put_character (Space_char)
    	end

    	else
    	output.put_character (ch)
    	read_char

   		end

   		do 

    end

      -- At end of file, nothing to do in Eiffel except close the files
    input.close
    output.close
  end

--------------------------------------------------------------------------------
feature {NONE} -- Support routines

read_char
    -- The routine can be called at any time after the input has been
    -- opened.  The routine treats a file as ending with an unbounded
    -- sequence of EOF characters.
  require input_open: input.is_readable
  do
      -- Need a guard to permit unbound number of read_char calls.
    if not input.off then input.read_character end
      -- The following cannot be an else clause because we need to
      -- check for EOF whether or not the previous read_char operation
      -- was executed.
    if input.off then ch := EOF
                 else ch := input.last_character
    end
  end

end
