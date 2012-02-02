class << ActiveRecord::Base

  def belongs_to_region options={} 
    belongs_to :region, :class_name => "Ipgeobase::Region", :foreign_key => :region_id, :primary_key => (options[:foreign_key] || :region_id)
  end

end
