#!/usr/bin/env ruby
# encoding: utf-8

# This is needed because Ruby 2.0 doesn't include '.' by default in the load path
# and Mavericks ships with Ruby 2 now.
($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require 'bundle/bundler/setup'
require 'alfred'
require 'net/https'
require 'JSON'

def url_from_query query
  if query.empty?
    'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.json'
  else
    "https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.json?keyword=#{URI::encode(query)}"
  end
end

def fetch_datasets url
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  results = http.request(request).body
  JSON.parse(results)
end


Alfred.with_friendly_error do |alfred|
  datasets = fetch_datasets(url_from_query(ARGV.join(' ')))
  alfred.ui.debug "Found #{datasets['feed']['entry'].count} datasets"

  fb = alfred.feedback
  datasets['feed']['entry'].each { |dataset|
    alfred.ui.debug "Adding #{dataset['dataset_id']} with id: #{dataset['id']}..."
    fb.add_item({
      :uid      => dataset['id'],
      :title    => dataset['dataset_id'],
      :subtitle => dataset['links'][0]['href'],
      :arg      => dataset['id'],
      :valid    => 'yes',
    })
  }

  puts fb.to_xml
end
