module Leggy
  module Mapping
    class CrawlOptions
      include Kartograph::DSL

      kartograph do
        mapping Leggy::CrawlOptions

        property *Leggy::CrawlOptions.attr_accessors, scopes: [ :create ]
      end
    end
  end
end
