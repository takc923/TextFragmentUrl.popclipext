#!/usr/bin/env ruby
require 'uri'

raw_text = ENV["POPCLIP_TEXT"]
paragraphs = raw_text.split(/\n+/).map { |t| URI.encode(t) }

text_fragment = ":~:"
text_fragment += "text=#{paragraphs[0]}"
if paragraphs.length > 1
  text_fragment += ",#{paragraphs[-1]}"
end

current_directory = File.expand_path(File.dirname(__FILE__))
url = %x(#{current_directory}/get-current-url-on-chrome.scpt).strip
p url
url.sub!(/(#.*):~:text=.*/, '\1')
p url
unless url.include?('#')
  url += '#'
end
p url
url += text_fragment
p url

system('open', '-b', 'com.google.Chrome', url)