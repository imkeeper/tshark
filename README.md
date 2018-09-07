# tshark

本仓库用来收集tshark User  Guide、tshark常用命令以及tshark常用 lua 脚本。


### 常用命令
1.[tshark 中文manual](https://www.cnblogs.com/liun1994/p/6142505.html)
 
```
1. 数据包合并:把后两个数据包并到一个数据包merge.pcap
   mergecap -w merge.pcap 1.pcap 2.pcap

2. 按照ssl/http 条件过滤数据包
   tshark -r 1.pcap -Y [ssl|http] -w ssl.pcap 
   tshark -2R ssl -r toutiao.pcap -w ssl.pcap
   -2: 执行两次分析
　 -R: -R <read filter>,包的读取过滤器，可以在wireshark的filter语法上查看；在wireshark的视图->过滤器视图，在这一栏点击表达式，就会列出来对所有协议的支持。
   
 
3. 分割数据包: 按照数据包数分割一个大的数据
   editcap -c 1000000 merge.pcap split01.pcap
4. tshark -X lua_script:cutflow.lua -r  wireshark.pcap
5. tshark -q -X lua_script:cutflow.lua -r wireshark.pcap
```

```
二.具体使用案例

1.抓取500个包,提取访问的网址打印出来
tshark -s 0 -i eth0 -n -f 'tcp dst port 80' -R 'http.host and http.request.uri' -T fields -e http.host -e http.request.uri -l -c 50

2.抓取500个包,提取访问者访问地址及提交方式和访问者ip
tshark -s 0 -i eth0 -n -f 'tcp dst port 80' -R 'http.host and http.request.uri' -T fields -e frame.time -e ip.src -e http.request.method -e http.host -e http.request.uri -e ip.src -e ip.dst -l -c 500

3.抓取mysql的查询
tshark -i eth1 -d tcp.port==3306,mysql -T fields -e mysql.query 'port 3306'
tshark -i lo -d tcp.port==3306,mysql -T fields -e mysql.query 'port 3306'

指定类型
tshark -i lo -d tcp.port==3306,mysql -T fields -e mysql.query 'port 3306' -R 'mysql matches "SELECT|INSERT|DELETE|UPDATE"'

4.统计http状态
tshark -n -q -z http,stat, -z http,tree


```

### tshark lua教程
* [Wireshark Lua Wiki]https://wiki.wireshark.org/Lua/）
* [Wireshark Wiki](https://wiki.wireshark.org/FrontPage)
* [wireshark csdn专栏](https://blog.csdn.net/javajiawei/article/category/7159545)(https://blog.csdn.net/column/details/20048.html) Pending
* [你不知道的wireshark
](https://zhuanlan.zhihu.com/wireshark)
* [使用lua脚本进行报文读取](https://zhuanlan.zhihu.com/p/34180527)
* [使用Lua脚本对pcap文件按流进行存储
](https://zhuanlan.zhihu.com/p/35188803)

* [tshark批量切流实践和思考](https://blog.csdn.net/javajiawei/article/details/52423573)
* [editcap的使用](https://www.cnblogs.com/hushaojun/p/7680350.html)
* [使用tshark在命令行进行网络抓包](https://kaimingwan.com/post/ji-chu-zhi-shi/wang-luo/shi-yong-tsharkzai-ming-ling-xing-jin-xing-wang-luo-zhua-bao)

## Manual
```
TShark (Wireshark) 2.4.2 (v2.4.2-0-gb6c63ae)
Dump and analyze network traffic.
See https://www.wireshark.org for more information.

Usage: tshark [options] ...

Capture interface:
  -i <interface>           name or idx of interface (def: first non-loopback)
  -f <capture filter>      packet filter in libpcap filter syntax
  -s <snaplen>             packet snapshot length (def: appropriate maximum)
  -p                       don't capture in promiscuous mode
  -I                       capture in monitor mode, if available
  -B <buffer size>         size of kernel buffer (def: 2MB)
  -y <link type>           link layer type (def: first appropriate)
  -D                       print list of interfaces and exit
  -L                       print list of link-layer types of iface and exit

Capture stop conditions:
  -c <packet count>        stop after n packets (def: infinite)
  -a <autostop cond.> ...  duration:NUM - stop after NUM seconds
                           filesize:NUM - stop this file after NUM KB
                              files:NUM - stop after NUM files
Capture output:
  -b <ringbuffer opt.> ... duration:NUM - switch to next file after NUM secs
                           filesize:NUM - switch to next file after NUM KB
                              files:NUM - ringbuffer: replace after NUM files
Input file:
  -r <infile>              set the filename to read from (- to read from stdin)

Processing:
  -2                       perform a two-pass analysis
  -M <packet count>        perform session auto reset
  -R <read filter>         packet Read filter in Wireshark display filter syntax
                           (requires -2)
  -Y <display filter>      packet displaY filter in Wireshark display filter
                           syntax
  -n                       disable all name resolutions (def: all enabled)
  -N <name resolve flags>  enable specific name resolution(s): "mnNtCd"
  -d <layer_type>==<selector>,<decode_as_protocol> ...
                           "Decode As", see the man page for details
                           Example: tcp.port==8888,http
  -H <hosts file>          read a list of entries from a hosts file, which will
                           then be written to a capture file. (Implies -W n)
  --enable-protocol <proto_name>
                           enable dissection of proto_name
  --disable-protocol <proto_name>
                           disable dissection of proto_name
  --enable-heuristic <short_name>
                           enable dissection of heuristic protocol
  --disable-heuristic <short_name>
                           disable dissection of heuristic protocol
Output:
  -w <outfile|->           write packets to a pcap-format file named "outfile"
                           (or to the standard output for "-")
  -C <config profile>      start with specified configuration profile
  -F <output file type>    set the output file type, default is pcapng
                           an empty "-F" option will list the file types
  -V                       add output of packet tree        (Packet Details)
  -O <protocols>           Only show packet details of these protocols, comma
                           separated
  -P                       print packet summary even when writing to a file
  -S <separator>           the line separator to print between packets
  -x                       add output of hex and ASCII dump (Packet Bytes)
  -T pdml|ps|psml|json|jsonraw|ek|tabs|text|fields|?
                           format of text output (def: text)
  -j <protocolfilter>      protocols layers filter if -T ek|pdml|json selected
                           (e.g. "ip ip.flags text", filter does not expand child
                           nodes, unless child is specified also in the filter)
  -J <protocolfilter>      top level protocol filter if -T ek|pdml|json selected
                           (e.g. "http tcp", filter which expands all child nodes)
  -e <field>               field to print if -Tfields selected (e.g. tcp.port,
                           _ws.col.Info)
                           this option can be repeated to print multiple fields
  -E<fieldsoption>=<value> set options for output when -Tfields selected:
     bom=y|n               print a UTF-8 BOM
     header=y|n            switch headers on and off
     separator=/t|/s|<char> select tab, space, printable character as separator
     occurrence=f|l|a      print first, last or all occurrences of each field
     aggregator=,|/s|<char> select comma, space, printable character as
                           aggregator
     quote=d|s|n           select double, single, no quotes for values
  -t a|ad|d|dd|e|r|u|ud|?  output format of time stamps (def: r: rel. to first)
  -u s|hms                 output format of seconds (def: s: seconds)
  -l                       flush standard output after each packet
  -q                       be more quiet on stdout (e.g. when using statistics)
  -Q                       only log true errors to stderr (quieter than -q)
  -g                       enable group read access on the output file(s)
  -W n                     Save extra information in the file, if supported.
                           n = write network address resolution information
  -X <key>:<value>         eXtension options, see the man page for details
  -U tap_name              PDUs export mode, see the man page for details
  -z <statistics>          various statistics, see the man page for details
  --capture-comment <comment>
                           add a capture comment to the newly created
                           output file (only for pcapng)
  --export-objects <protocol>,<destdir> save exported objects for a protocol to
                           a directory named "destdir"

Miscellaneous:
  -h                       display this help and exit
  -v                       display version info and exit
  -o <name>:<value> ...    override preference setting
  -K <keytab>              keytab file to use for kerberos decryption
  -G [report]              dump one of several available reports and exit
                           default report="fields"
                           use "-G ?" for more help
```
