module Ipgeobase
  module Task
    def self.obtain_content_by_filename( filename )
      if file_path = ENV['file'] || ENV['FILE']
        # FIXME >> Need iconv to utf8 or not?
        File.read( file_path )
      else
        url = ENV['url'] || ENV['URL'] || 'http://ipgeobase.ru/files/db/Main/geo_files.tar.gz'
        `curl -0 wget #{url} | tar -xzO #{filename} | iconv -f cp1251 -t utf8`
      end
    end
  end
end

namespace :ipgeobase do

  namespace :upload do

    desc 'Update cities and regions from FILE or by URL(default)'
    task :cities => :environment do
      content = Ipgeobase::Task.obtain_content_by_filename( 'cities.txt' )
      puts content.first

    end

    desc 'Update geo ips from FILE or by URL(default)'
    task :cities => :environment do
      content = Ipgeobase::Task.obtain_content_by_filename( 'cidr_optim.txt' )
      puts content.first

    end


  end

end
