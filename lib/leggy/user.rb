module Leggy
  class User
    include Leggy::Helpers

    attr_accessor \
      :token,
      :organization,
      :email,
      :first_name,
      :last_name,
      :phone_number,
      :plan_id,
      :active,
      :urls_crawled,
      :date_registered

  end
end
