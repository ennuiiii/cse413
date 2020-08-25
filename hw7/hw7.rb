# CSE 413
# Assignment # 7
# Qiubai Yu
# 1663777
require_relative "scan.rb"

myScanner = Scanner.new
while 1
    myScanner.scan
    temp = myScanner.next_token
    while temp
        if temp.kind == "EOL"
            puts
            myScanner.scan
            temp = myScanner.next_token
        elsif temp.kind == "QUIT" || temp.kind == "EXIT"
            puts "quit/exit command given, ending..."
            exit
        else
            puts temp.to_s
            temp = myScanner.next_token
        end
    end
end