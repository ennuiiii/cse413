#CSE 413
#Assignment #6
#Qiubai Yu
#1663777

input = ARGV[0]
freqs = Hash.new(0)
text = String.new
File.open(input) {|f| text = f.read}
words = text.split(/[^a-zA-Z]/)
words.each {|word| freqs[word] += 1}
temp = Hash[freqs.sort_by{|k,v| k}].to_h
temp.each do |key, value|
    puts key + " " + value.to_s
end