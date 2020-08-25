# CSE 413
# Assignment # 7
# Qiubai Yu
# 1663777

class Token
    attr_reader :kind, :value

    def initialize(kind, value = nil)
        @kind = kind
        @value = value
    end

    def kind
        @kind
    end

    def value
        @value
    end

    def to_s
        # some lexical classes descriptions
        # NUM - numbers
        # ID - identifiers
        # operators: +, -, *, /, (, ), **, =
            # ADD - +
            # SUB - -
            # MUL - *
            # DIV - /
            # LPAREN - (
            # RPAREN - )
            # POW - **
            # EQUAL - =
        # statement operations: sqrt, clear, list, quit, exit
            # SQRT - sqrt
            # CLEAR - clear
            # LIST - list
            # QUIT - quit
            # EXIT - exit
        # EOL - end of line
        if @value == nil
            return @kind
        else
            return @kind + "(" + @value + ")"
        end
    end
end

class Scanner
    # definitions of lexical classes
    OPERATION = /^[\+\-\*\/\(\)\=]$/
    KEYWORD = /^list$|^quit$|^exit$|^clear$|^sqrt$/
    NUMBER = /^[0-9]+(\.[0-9]+)?([Ee][\+\-]?[0-9]+)?$/
    EOL = /^;$/
    IDENTIFIER = /^[a-zA-Z][a-zA-Z0-9_]*$/

    def initialize
        @tokens = Array.new
        @tokenIndex = -1
        @processIndex = 0
    end

    def scan
        raw = gets
        if raw != "\n"
            raw = raw.gsub(/\n/, "") << ";"
        else
            raw = ";"
        end
        process(raw)
    end

    def process(inp)
        @processIndex = 0
        # input is not nil, I can keep extract a token from it
        if inp && inp != ""
            # if the first char of string matches the OPERATIONs
            if (inp[0].match OPERATION)
                if inp[0] == "*"
                    if inp[1] && inp[1] == "*"
                        @tokens.push(Token.new("POW", "**"))
                        process(inp[2..-1])
                    else
                        @tokens.push(Token.new("MUL", "*"))
                        process(inp[1..-1])
                    end
                elsif inp[0] == "+"
                    @tokens.push(Token.new("ADD", "+"))  
                    process(inp[1..-1])
                elsif inp[0] == "-"
                    @tokens.push(Token.new("SUB", "-"))
                    process(inp[1..-1])
                elsif inp[0] == "/"
                    @tokens.push(Token.new("DIV", "/"))
                    process(inp[1..-1])
                elsif inp[0] == "("
                    @tokens.push(Token.new("LPAREN", "("))
                    process(inp[1..-1])
                elsif inp[0] == ")"
                    @tokens.push(Token.new("RPAREN", ")"))
                    process(inp[1..-1])
                elsif inp[0] == "=" 
                    @tokens.push(Token.new("EQUAL", "="))
                    process(inp[1..-1])
                end
            # if the first char of string matches the identifier(including the keywords)
            elsif (inp[@processIndex].match IDENTIFIER)
                temp = String.new
                temp += inp[@processIndex]
                while (inp[0..(@processIndex + 1)].match IDENTIFIER) && (@processIndex + 1) != inp.length
                    @processIndex += 1
                    temp += inp[@processIndex]
                end
                if (temp.match KEYWORD)
                    @tokens.push(Token.new(temp.upcase, temp))
                else
                    @tokens.push(Token.new("ID", temp))
                end
                process(inp[(@processIndex + 1)..-1])
            elsif (inp[@processIndex].match NUMBER)
                temp = String.new
                temp += inp[@processIndex]
                while (inp[0..(@processIndex + 1)].match NUMBER) && (inp[(@processIndex + 1)])
                    @processIndex += 1
                    temp += inp[@processIndex]
                end
                # right here, temp will be a pure number, since 1. or 1e is not considered a number
                # do further tests
                if inp[@processIndex + 1] =~ /[Ee]/
                    if inp[@processIndex + 2] && inp[@processIndex + 2] =~ /[+-]/
                        if inp[@processIndex + 3] && (inp[@processIndex + 3].match NUMBER)
                            temp += inp[(@processIndex + 1)..(@processIndex + 3)]
                            @processIndex += 3
                            while (inp[0..(@processIndex + 1)].match NUMBER) && (inp[(@processIndex + 1)])
                                @processIndex += 1
                                temp += inp[@processIndex]
                            end
                            @tokens.push(Token.new("NUMBER", temp))
                            process(inp[(@processIndex + 1)..-1])
                        else
                            @tokens.push(Token.new("NUMBER", temp))
                            process(inp[(@processIndex + 1)..-1])
                        end
                    elsif inp[@processIndex + 2] && (inp[@processIndex + 2].match NUMBER)
                        temp += inp[(@processIndex + 1)..(@processIndex + 2)]
                        @processIndex += 2
                        while (inp[0..(@processIndex + 1)].match NUMBER) && (inp[(@processIndex + 1)])
                            @processIndex += 1
                            temp += inp[@processIndex]
                        end
                        @tokens.push(Token.new("NUMBER", temp))
                        process(inp[(@processIndex + 1)..-1])
                    else
                        @tokens.push(Token.new("NUMBER", temp))
                        process(inp[(@processIndex + 1)..-1])
                    end
                elsif inp[@processIndex + 1] == "."
                    if (inp[@processIndex + 2] =~ NUMBER)
                        temp += inp[(@processIndex + 1)..(@processIndex + 2)]
                        @processIndex += 2
                        while (inp[0..(@processIndex + 1)].match NUMBER) && (inp[(@processIndex + 1)])
                            @processIndex += 1
                            temp += inp[@processIndex]
                        end
                        @tokens.push(Token.new("NUMBER", temp))
                        process(inp[(@processIndex + 1)..-1])
                    else
                        temp += inp[@processIndex + 1]
                        @processIndex += 1
                        @tokens.push(Token.new("NUMBER", temp))
                        process(inp[(@processIndex + 1)..-1])
                    end
                else
                    @tokens.push(Token.new("NUMBER", temp))
                    process(inp[(@processIndex + 1)..-1])
                end
            elsif inp[0].match EOL
                @tokens.push(Token.new("EOL", ";"))
            else
                #invalid characters or white spaces, skip them 
                process(inp[1..-1])
            end
        end
    end

    # pre-processing the input and stores several tokens in @tokens
    # return one element in @tokens each call
    def next_token
        if  @tokenIndex != @tokens.length
            @tokenIndex += 1
            return @tokens[@tokenIndex]
        end
    end

    def peek
        if (@tokenIndex + 1 != @tokens.length)
            return @tokens[(@tokenIndex + 1)]
        end
    end

    def twoahead
        if (@tokenIndex + 2 != @tokens.length)
            return @tokens[(@tokenIndex + 2)]
        end
    end 
end 
