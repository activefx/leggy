module Leggy
  class CrawlOptions
    include Leggy::Helpers

    def initialize(attrs = {})
      attrs.slice(*Leggy::CrawlOptions.attr_accessors).each { |k,v| send("#{k}=",v) }
    end

    attr_accessor(
      :app,
      :urllist,
      :data,
      :max_depth,
      :max_urls
    )

  end
end
