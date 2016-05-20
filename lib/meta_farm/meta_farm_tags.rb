class MetaFarmTags
  attr_accessor :name, :description, :keywords, :site_name, :canonical_url, :image_url, :image_height, :image_width,
                :fb_app_id, :fb_admins, :fb_object_type, 
                :twitter_card_type,
                :city, :state, :zip, :lat, :lon, :business_name, :country,
                :author, :google_author, :google_publisher
                
                
  def initialize(name, description, keywords, canonical_url, image_url, fb_object_type, image_height: '630', image_width: '1200', defaults: {})
    defaults.each{ |k, v| eval("self.#{k.to_s} = '#{v}'") } 
    self.name = name
    self.description = description
    self.keywords = keywords
    self.image_url = image_url
    self.fb_object_type = fb_object_type
    self.canonical_url = canonical_url
    
    self.image_height = image_height
    self.image_width = image_width
  end
  
  def load_authorship_meta(author, google_author, google_publisher)
     self.author = author
     self.google_author = google_author
     self.google_publisher = google_publisher
  end  
  
  def load_geo_meta(city, state, zip, lat, lon, country = 'US')
     # Helper for adding geo data. Generally, these will be added as defaults, unless, say, each
     # page represents a different geographical location
     self.city = city
     self.state = state
     self.zip = zip
     self.country = country
     self.lat = lat
     self.lon = lon
  end  
    
  def render(skip_title_tag: false, additional_tags: {})
    html = ''
    html += "<title>#{name}</title>\n" unless skip_title_tag
    html += meta_tags(:description => description.to_s[0..149], :keywords => keywords, :author => author)
    html += canonical_link(canonical_url)
    html += render_facebook_meta
    html += render_twitter_meta
    html += render_authorship_meta.to_s
    html += render_geo_meta.to_s
    html += meta_tags(additional_tags)
    # content_for :meta_farm, html.html_safe
    html.html_safe
  end
  
  def render_authorship_meta
    html = ''
    html += meta_tags(:author => author)
    html += %Q|<link rel="author" href="https://plus.google.com/#{google_author}" />| if google_author
    html += %Q|<link rel="publisher" href="https://plus.google.com/#{google_publisher}" />| if google_publisher  
    html
  end
  
  
  def meta_tags(h = {})
    html = ''
    h.each do |k, v|
      html += %Q|<meta property="#{k.to_s}" content="#{v}" />\n| if v
    end
    html
  end
  
  def canonical_link(url)
    %Q|<link rel="canonical" href="#{url}">\n|
  end   
  
  def render_geo_meta()
    html = meta_tags('geo.placename' => city, 'DC.title' => site_name)
    html += meta_tags('geo.region' => "#{country}-#{state}".upcase) if country && state
    html += meta_tags('geo.position' => "#{lat};#{lon}", 'ICBM' => "#{lat}, #{lon}") if lat && lon
    html
  end
  
  def render_facebook_meta
    html = meta_tags('og:title' => name, 'og:url' => canonical_url, 'og:type' => fb_object_type, 'og:image' => image_url,
              'og:site_name' => site_name, 'og:description' => description.to_s[0..299], 
              'og:image:width' => image_width, 'og:image:height' => image_height )
    html += meta_tags('fb:admins' => fb_admins) if fb_admins
    html += meta_tags('fb:app_id' => fb_app_id) if fb_app_id
    html          
  end
  
  def render_twitter_meta
    html = meta_tags('twitter:card' => twitter_card_type, 'twitter:url' => canonical_url, 'twitter:title' => name, 
                     'twitter:description' => description.to_s[0.199], 'twitter:image' => image_url)
    html.html_safe
  end
end
