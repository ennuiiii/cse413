# CSE 413
# Assignment # 8
# Qiubai Yu
# 1663777

require_relative "scan.rb"

class Calculator

   def initialize
    @list = Hash.new
    @list["PI"] = Math::PI
    @scanner = Scanner.new
    program
   end

   def factor
    temp = @scanner.next_token
    if (temp.kind == "NUMBER")
        return temp.value.to_f
    elsif (temp.kind == "ID")
        if !@list[temp.value].nil?
            return @list[temp.value]
        else
            puts "No such variable exists"
            restart
        end
    elsif (temp.kind == "LPAREN")
        result = exp
        #consume the ")"
        if !@scanner.peek.nil? && @scanner.peek.kind == "RPAREN"
            @scanner.next_token
        else
            puts "Right Paren expected, restarting..."
            restart
        end
        return result
    elsif (temp.kind == "SQRT")
        if (!@scanner.peek.nil? && @scanner.peek.kind == "LPAREN")
            @scanner.next_token
        else
            puts "left paren expected, restarting..."
            restart
        end
        result = Math.sqrt(exp)
        if (!@scanner.peek.nil? && @scanner.peek.kind == "RPAREN")
            @scanner.next_token
        else
            puts "right paren expected, restarting..."
            restart
        end
        return result
    elsif (temp.kind == "EOL")
        program
    else 
        puts "Something is wrong, type in another command"
        restart
    end
   end

   def power
    result = factor
    if !@scanner.peek.nil? && @scanner.peek.kind != "EOL" && @scanner.peek.kind == "POW"
        @scanner.next_token
        result **= power
    end
    return result
   end

   # rewrite the term grammar
   # term ::= power auxterm
   # auxterm ::= * power auxterm | / power auxterm | ε
   def term
    result = power
    result *= auxterm
    return result
   end

   def auxterm
    result = 1
    test = @scanner.peek
    if !test.nil? && test.kind != "EOL" && (test.kind == "MUL" || test.kind == "DIV")
        if test.kind == "MUL"
            @scanner.next_token
            result *= power
        elsif test.kind == "DIV"
            @scanner.next_token
            result /= power
        end
        return result *= auxterm
    else
        return result    
    end
   end

   # rewrite the exp grammar
   # exp ::= term auxexp
   #auxexp ::= + term auxexp | - term auxexp | ε
   def exp 
    result = term
    result += auxexp
    return result
   end

   def auxexp
    result = 0
    test = @scanner.peek
    if !test.nil? && test.kind != "EOL" && (test.kind == "ADD" || test.kind == "SUB")
        if test.kind == "ADD"
            @scanner.next_token
            result += term
        elsif test.kind == "SUB"
            @scanner.next_token
            result -= term
        end
        return result += auxexp
    else
        return result
    end
   end

   def statement
    test = @scanner.peek
    if !test.nil?
        if test.kind == "ID" && !@scanner.twoahead.nil? && @scanner.twoahead.kind == "EQUAL"
            id = @scanner.next_token.value
            # Consume the "=" token
            @scanner.next_token
            puts ""
            result = exp
            @list[id] = result
            puts id + " sets to be : " + result.to_s
        elsif test.kind == "CLEAR"
            @scanner.next_token
            id = @scanner.next_token
            @list.delete(id.value)
            puts "value deleted : " + id.value
            return
        elsif test.kind == "LIST"
            # prints all the pairs in the list
            @list.each do |key, value|
                puts key + " : " + value.to_s
            end
            # Consume the LIST token
            @scanner.next_token
            return
        elsif test.kind == "QUIT" || test.kind == "EXIT"
            #Consume the QUIT or EXIT token
            @scanner.next_token
            puts "Calculator terminated..."
            exit
        else
            return exp
        end
    else
        return "nothing happened"
    end
   end

   def program
    @scanner.scan
    while @scanner.peek #could be a problem
        st = statement
        puts st
        # Consume the EOL token
        @scanner.next_token
        if @scanner.peek.nil? 
            break
        end 
    end
    puts
   program
   end

   def restart
    @scanner = Scanner.new
    program
   end
end

cal = Calculator.new