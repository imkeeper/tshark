* 100个gdb小技巧:https://wizardforcel.gitbooks.io/100-gdb-tips/content/
* Debugging with GDB:https://sourceware.org/gdb/onlinedocs/gdb/index.html
* gdbinit - GDB initialization scripts:https://www.linux.org/docs/man5/gdbinit.html
 
 (gdb) help set height
Set number of lines in a page for GDB output pagination.
This affects the number of lines after which GDB will pause
its output and ask you whether to continue.
Setting this to zero causes GDB never pause during output.
(gdb) set height 0   
/*在运行过程中经常出现： --Type <return> to continue, or q<return> to quit. 程序就被阻塞了，需要人手动敲一下回车才能继续。可通过设置height解决*/
  
  ```
  set print pretty
  set print pretty on
  set pagination off
  set print repeats 16
  ```
  (gdb) help set print repeats
Set threshold for repeated print elements.
"set print repeats 0" causes all elements to be individually printed.

 #21 0x0000000000506f3b in ngx_http_v2_state_headers (h2c=0x7f0b5220d800, pos=0x7f0b596e500e "\202", <incomplete sequence \355\207>,
    end=0x7f0b596e5056 "\214g\210\325\316z\213\023\253\204+\203\202\303\302\017\032\220\344\307\362!\210K\005\306\334jWC!Z\376\177\301\300\277\276\301\300\277\276", '\020' <repeats 16 times>, "\177\a\027\361\374:&\234\003\240\023\313\364\256o\354\353\276\351\350\347\346", <incomplete sequence \345>) at src/http/v2/ngx_http_v2.c:1318
    
 (gdb) help set print pretty
Set prettyprinting of structures.
(gdb) help set pagination
Set state of GDB output pagination.
When pagination is ON, GDB pauses at end of each screenful of
its output and asks you whether to continue.
Turning pagination off is an alternative to "set height 0".

```
(gdb) help set print
Generic command for setting how things print.

List of set print subcommands:

set print address -- Set printing of addresses
set print array -- Set prettyprinting of arrays
set print array-indexes -- Set printing of array indexes
set print asm-demangle -- Set demangling of C++/ObjC names in disassembly listings
set print demangle -- Set demangling of encoded C++/ObjC names when displaying symbols
set print elements -- Set limit on string chars or array elements to print
set print entry-values -- Set printing of function arguments at function entry
set print frame-arguments -- Set printing of non-scalar frame arguments
set print inferior-events -- Set printing of inferior events (e.g.
set print max-symbolic-offset -- Set the largest offset that will be printed in <symbol+1234> form
set print null-stop -- Set printing of char arrays to stop at first null char
set print object -- Set printing of object's derived type based on vtable info
set print pascal_static-members -- Set printing of pascal static members
set print pretty -- Set prettyprinting of structures
set print repeats -- Set threshold for repeated print elements
set print sevenbit-strings -- Set printing of 8-bit characters in strings as \nnn
set print static-members -- Set printing of C++ static members
set print symbol -- Set printing of symbol names when printing pointers
set print symbol-filename -- Set printing of source filename and line number with <symbol>
set print thread-events -- Set printing of thread events (such as thread start and exit)
set print type -- Generic command for setting how types print
set print union -- Set printing of unions interior to structures
set print vtbl -- Set printing of C++ virtual function tables

Type "help set print" followed by set print subcommand name for full documentation.
Type "apropos word" to search for commands related to "word".
```
```
https://blog.csdn.net/dyoldfish/article/details/1752681
whatis   #察看变量类型
ptype    #察看类型的定义
bt  [full]    #查看堆栈[详细]
frame [num]   #显示当前[或指定num]的堆栈。
--------------------------------------------------------------------
在gdb中，运行程序使用r或是run命令。程序的运行，你有可能需要设置下面四方面的事。
1、程序运行参数。
    set args 可指定运行时参数。（如：set args 10 20 30 40 50）
    show args 命令可以查看设置好的运行参数。
2、运行环境。
    path <dir> 可设定程序的运行路径。
    show paths 查看程序的运行路径。
    set environment varname [=value] 设置环境变量。如：set env USER=hchen
    show environment [varname] 查看环境变量。
3、工作目录。
    cd <dir> 相当于shell的cd命令。
    pwd 显示当前的所在目录。
4、程序的输入输出。
    info terminal 显示你程序用到的终端的模式。
    使用重定向控制程序输出。如：run > outfile
    tty命令可以指写输入输出的终端设备。如：tty /dev
5、
checkpoint   ＃设置程序的快照 
```
