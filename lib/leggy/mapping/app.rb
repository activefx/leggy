module Leggy
  module Mapping
    class App
      include Kartograph::DSL

      kartograph do
        mapping Leggy::App

        property *Leggy::App.attr_accessors, scopes: [ :read ]
      end
    end
  end
end
