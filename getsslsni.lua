-- Refer to:https://zhuanlan.zhihu.com/wireshark
local getSslServerName = Field.new("ssl.handshake.extensions_server_name")
local sslServerNameSet = {}

do
    local function packet_listener()
        local tap = Listener.new("frame", "tcp.port == 443")
        -- frame是监听器的名称，tcp是.port wireshark过滤器规则
        
        function tap.packet(pinfo,tvb)
            -- 回调函数，每收到一个包执行一次。
            local sslServerName = getSslServerName()

            if sslServerName then
                table.insert(sslServerNameSet,sslServerName)
                -- print(sslServerName)
            end
        end

        function tap.reset()
            print("tap reset")
        end

        function tap.draw()
            -- 结束执行
            print("tap draw")
            for key, value in ipairs(sslServerNameSet) do
                --print(value)
                print(key)
            end
        end
    end

    -- 监听报文
    packet_listener()

end
