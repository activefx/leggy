module Leggy
  class Url
    include Leggy::Helpers

    attr_accessor \
      :name,
      :user,
      :location,
      :date_created

  end
end
