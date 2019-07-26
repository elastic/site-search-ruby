require 'elastic/site-search/client'
require 'elastic/site-search/sso'

module Elastic
  module SiteSearch
    extend Elastic::SiteSearch::Configuration

    def self.const_missing(const_name)
      super unless const_name == :Easy
      warn "`Swiftype::Easy` has been deprecated. Use `Swiftype::Client` instead."
      Client
    end
  end
end

