class Ipgeobase::IpgeobaseIp < ActiveRecord::Base

  belongs_to :ipgeobase_region, :primary_key => :region_id

  validates :start_ip, :presence => true
  validates :end_ip, :presence => true
  validates :ipgeobase_region_id, :presence => true

end
