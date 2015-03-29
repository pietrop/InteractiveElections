# Convert XML Youtube subtitles to SubRip (srt) format
# To download the subtitle in XML, put de code of the Youtube video
# at the end of the next url:
# http://video.google.com/timedtext?hl=en&lang=en&v=

require 'rubygems'
require 'hpricot'

youtube_xml = ARGV[0]
xml = Hpricot.XML(open(youtube_xml))
srt = File.open(ARGV[1] || youtube_xml.gsub('.xml', '.srt'), 'w+')

i = 1
(xml/'text').each do |sub|
  ini = Time.at(sub['start'].to_f)
  fi = ini + sub['dur'].to_f
  srt.write(
%{#{i}
#{'%02d:%02d:%02d,%03d' % [ini.hour-1, ini.min, ini.sec, ini.usec/1000]} --> #{'%02d:%02d:%02d,%03d' % [fi.hour-1, fi.min, fi.sec, fi.usec/1000]}
#{sub.inner_text}

}
)
  i += 1
end

srt.close