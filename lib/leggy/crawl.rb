module Leggy
  class Crawl
    include Leggy::Helpers

    attr_accessor(
      :name,
      :app,
      :user,
      :id,
      :urllist,
      :data,
      :user_agent,
      :depth,
      :max_depth,
      :urls_crawled,
      :maxUrls,
      :status,
      :results
    )

  end
end

