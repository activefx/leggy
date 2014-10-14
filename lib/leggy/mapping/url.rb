module Leggy
  module Mapping
    class Url
      include Kartograph::DSL

      kartograph do
        mapping Leggy::Url

        property *Leggy::Url.attr_accessors, scopes: :read
      end
    end
  end
end

