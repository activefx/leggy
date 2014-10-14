module Leggy
  module Mapping
    class App
      include Kartograph::DSL

      kartograph do
        mapping Leggy::App

        property *Leggy::App.attr_accessors, scopes: :read
      end
    end
  end
end

# name  string  The name given to the app.
# user  string  The user the app is associated with.
# location  string  The internal location for the app.
# date_created  date  The date the app was uploaded.
