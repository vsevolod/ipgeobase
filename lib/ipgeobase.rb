require "ipgeobase/version"
require "ipgeobase/railtie"
require "ipgeobase/belongs_to_region"
require "resolv"

module Ipgeobase
  extend self

  # find_region_by_ip
  # TODO this method only for postgresql database
  def find_region_by_ip( user_ip )
    raise ArgumentError, "Must have a valid IPv4 or IPv6 addres" unless !!((user_ip =~ Resolv::IPv4::Regex) || (user_ip =~ Resolv::IPv6::Regex))
    long = ip2long( user_ip )
    Ipgeobase::Ip.select( <<-SELECT ).where( "start_ip <= #{long}" ).order( 'start_ip DESC' ).first.try(:region)
      CASE WHEN #{long} <= end_ip
           THEN region_id
           ELSE NULL END AS region_id
    SELECT
  end

  private

    def ip2long(ip)
      long = 0
      ip.split(/\./).reverse.each_with_index do |b, i|
        long += b.to_i << (8*i)
      end
      long
    end

end
