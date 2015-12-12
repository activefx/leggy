module Leggy
  module Mapping
    class Crawl
      include Kartograph::DSL

      kartograph do
        mapping Leggy::Crawl

        property *Leggy::Crawl.attr_accessors, scopes: [ :read ]
      end
    end
  end
end
