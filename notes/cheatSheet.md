"WORKING WITH SPLITS
"========================================================="
NOTE: splits can also take files, directories and some programs as a param
Navigate between splits: [ctrl]+[w], [h], [j], [k], [l]:
Split Resizing:
  - Horizontal: [ctrl]+[w], [>], [<]
  - Vertical: [ctrl]+[w], [-], [+]

"----------------------------------------------------------"
Split horizontally from top:
[ctrl]+[w], [s]
:split
:sp

Split horizontally from bottom:
:belowright

Split horizontally from bottom and make split a terminal:
:belowright terminal
:bel term

"----------------------------------------------------------"
Split vertically:
[ctrl]+[w], [v]
:vsplit
:vsp
:vs

"========================================================="
"TABS"
List active tabs:
:tabs

Select specific tab:
:tagn<num>

"========================================================="
"EDITING FILES"
:e <file path>
:edit <file path>
:open <file path>

"========================================================="
"EDITING TEXT"
Modifying text case:
  - Single letter toLowerCase: vu
  - Single letter toUpperCase: vU
  - single word toUpperCase: veU
  - Single word toLowerCase: veu

"----------------------------------------------------------"
Searching:
:%s/word/replacement/g "replace all instances in file"
:<start>,<end>s/word/replacement/g "replace all within a span of lines"
  - EX - :6,10s/someVarName/SomeOtherVarName/g
"========================================================="
"BUFFERS"
List active buffers: "will show buffer ids, can be used for selecting and deleting"
:ls 
:files
:buffers

Selecting buffer:
:b<buffer id> "order of id and command can be reversed"
:b<file name> "select by file name"
:bn "next buffer"
:bp "previous buffer"

Add a buffer:
:badd <filename> "stands for 'buffer add'"
"using the edit command or creating a split also create buffers"

Delete buffer:
:<buffer id>bdelete
:<buffer id>bd
:<id1,id2,id3>bd "multiple buffers can be deleted simultaneously"

"========================================================="
"REGISTERS"
List registers:
:reg

"registers are [0 - 9]: normal copy slots, [+]: this register can be used to copy from inside to outside of vim and vice versa"
"=============================================================================================================================="
" Favorite Motions "
"=============================================================================================================================="

"--------------------------------------------------------"
Bulk replace in file
*           to do a file wide search for word being hovered over
<Shift-n>   to go back to previous match
c,g,n       to change the searched token at the cursor to something new
jj          to escape
n,.         to go to next find, and replay the motion
