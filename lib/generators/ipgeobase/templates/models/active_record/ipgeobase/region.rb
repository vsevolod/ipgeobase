class Ipgeobase::Region < ActiveRecord::Base

  self.table_name = "ipgeobase_regions"

  has_ancestry

  has_many :ips, :primary_key => :region_id

  before_save :cache_ancestry
  before_create :cache_ancestry

  validates :name, :presence => true

  def cache_ancestry
    self.names_depth_cache = path.map(&:name).join('/')
  end


end
