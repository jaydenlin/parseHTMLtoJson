require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

#config
configfile = ARGV[0]
config = JSON.parse(File.read(configfile))
name=config['name']
uri=config['uri']
structure=config['structure']
append=config['append'] || { selector:"",field:""}
#get doc
doc = Nokogiri::HTML(open(uri)) 

#use first result to decide json output 's length
  firstKey, firstValue = structure.first
  jsonLength = doc.css(firstValue["selector"]).length
  jsonItem = Hash.new
  jsonArray = Array.new(jsonLength) { Hash.new }
  jsonOutput = Hash.new


def cleanHTMLTrash(foundField)
     if foundField!=nil 
       foundField=foundField.gsub("<br>","")
       foundField=foundField.gsub("<br/>","")
       foundField=foundField.gsub("<br >","")
       foundField=foundField.gsub("<br />","") 

       return foundField
    else
       return foundField
    end
end  

def searchField(doc,selector,field)
  if field=="text" 
     return doc.css(selector).map {|element| element.text}
  else
     return doc.css(selector).map {|element| element[field]}
  end

end

def replaceStructureValue(doc,structure)

  structure.each do |key,value|
     structure[key]=searchField(doc,value["selector"],value["field"])
  end

  return structure
end


def replaceAppendValue(doc,append)

  append.each do |key,value|
     append[key]=cleanHTMLTrash(searchField(doc,value["selector"],value["field"])[0])
  end

  return append
end

structure = replaceStructureValue(doc,structure)
append = replaceAppendValue(doc,append)

puts "structure:"
puts structure
puts "append:"
puts append


  structure.each do |key,list|
    puts "====================="
    puts "#{key}"
    puts "#{list}"
    puts "====================="
    
    #jsonItem[key] = 

    jsonArray.each_with_index do |structure, index|
        structure[key]=cleanHTMLTrash(list[index])

    end

  end

  jsonOutput["title"]=append
  jsonOutput["itemList"]=jsonArray
  puts jsonOutput.to_json

  File.write("output/#{name}.html", jsonOutput.to_json)
