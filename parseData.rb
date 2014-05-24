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
#get doc
doc = Nokogiri::HTML(open(uri)) 

#use first result to decide json output 's length
  firstKey, firstValue = structure.first
  jsonLength = doc.css(firstValue["selector"]).length
  jsonItem = Hash.new
  jsonOutput=Array.new(jsonLength) { Hash.new }


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

structure = replaceStructureValue(doc,structure)

puts structure



  structure.each do |key,list|
    puts "====================="
    puts "#{key}"
    puts "#{list}"
    puts "====================="
    
    #jsonItem[key] = 

    jsonOutput.each_with_index do |structure, index|
        structure[key]=list[index]  

    end

  end

  puts jsonOutput.to_json

  File.write("output/#{name}.html", jsonOutput.to_json)
