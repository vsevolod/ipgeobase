class Ipgeobase::Ip < ActiveRecord::Base

  def self.table_name
    "ipgeobase_ips"
  end

  belongs_to :ipgeobase_region, :primary_key => :region_id

  validates :start_ip, :presence => true
  validates :end_ip, :presence => true
  validates :ipgeobase_region_id, :presence => true

end
