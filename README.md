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
