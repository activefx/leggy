module Leggy
  module Mapping
    class User
      include Kartograph::DSL

      kartograph do
        mapping Leggy::User

        property *Leggy::User.attr_accessors, scopes: [ :read ]
      end

    end
  end
end
