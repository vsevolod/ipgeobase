# coding: utf-8
module Ipgeobase
  module Task
    def self.obtain_content_by_filename( filename )
      if file_path = ENV['file'] || ENV['FILE']
        `iconv -f cp1251 -t utf8 #{file_path}`
      else
        url = ENV['url'] || ENV['URL'] || 'http://ipgeobase.ru/files/db/Main/geo_files.tar.gz'
        `curl -0 #{url} | tar -xzO #{filename} | iconv -f cp1251 -t utf8`
      end
    end
  end
end

namespace :ipgeobase do

  namespace :upload do

    desc 'Update cities and regions from FILE or by URL(default)'
    task :cities => :environment do
      russia  = Ipgeobase::Region.where( name: 'Россия' ).first_or_create
      ukraine = Ipgeobase::Region.where( name: 'Украина' ).first_or_create
      content = Ipgeobase::Task.obtain_content_by_filename( 'cities.txt' )
      content.each_line do |c|
        options = c.split("\t")[0..3]
        parent = if options.last.include? "Украина"
                   ukraine
                 else
                   russia
                 end
        names_depth_cache = [parent]
        3.times do |t|
          region = names_depth_cache.last.children.where( :name => options[3-t] ).first || Ipgeobase::Region.new(:name => options[3-t])
          region.parent = names_depth_cache.last
          region.region_id = options[0] if t == 2
          region.save
          names_depth_cache << region 
        end
      end
    end

    desc 'Update geo ips from FILE or by URL(default)'
    task :ips => :environment do
      content = Ipgeobase::Task.obtain_content_by_filename( 'cidr_optim.txt' )
      Ipgeobase::Ip.delete_all
      content.each_line do |c|
        options = c.split("\t")
        next if options.last.to_i.zero?
        Ipgeobase::Ip.create( :start_ip => options.first, :end_ip => options.second, :ipgeobase_region_id => options.last )
      end

    end


  end

end
