#CSE 413
#Assignment #6
#Qiubai Yu
#1663777

class Document
    attr_reader :contents, :modified

    def initialize
        @modified = Time.now
        @contents = ""
        @current = 0
        @temp = Array.new
        @temp[@current] = @contents
    end

    def contents=(new_contents)
        @contents = new_contents
        @modified = Time.now
        @current += 1
        @temp[@current] = @contents
    end

    def contents
        @contents
    end

    def modified
        @modified
    end

    def size
        @contents.length
    end

    def undo(n = 1)
        if @current <= n
            nil
        else
            @modified = Time.now
            @current -= n
            @contents = @temp[@current]
            # no need to truncate the rest of the array
        end
    end
end

class Directory
    def initialize
        @hash = {}
    end

    def store(name, child)
        @hash[name] = child
    end

    def get(name)
        @hash[name]
    end

    def delete(name)
        @hash.delete(name)
    end

    def size
        @result = 0
        @hash.each do |k, v|
            #although if and else is unnecessary here
            if v.is_a?(Document)
                @result += v.size
            else
                #it's a directory
                @result += v.size
            end
        end
         @result
    end
        
    def undo(n)
        @hash.each do |k, v|
            if v.is_a?(Document)
                v.undo(n)
            else
                #it's a directory
                v.undo(n)
            end
        end
    end

    def get_by_path(path)
        word = path.split("/")
        aux(word)
    end

    protected
    def aux(words)
        if get(words[0]) #if it's not nil, otherwise will return nil
            if get(words[0]).is_a?(Document)
                get(words[0])
            else
                get(words[0]).aux(words[1..-1])
            end
        end
    end
end

