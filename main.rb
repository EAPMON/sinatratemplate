require 'bundler/setup'

ENV['RACK_ENV'] ||= 'development'
SINATRA_ROOT = Bundler.root.to_s
Bundler.require(:default, ENV['RACK_ENV'])

Mongoid.load!("#{SINATRA_ROOT}/mongoid.yml", ENV['RACK_ENV'])

require_relative 'app/prueba/api'
require_relative 'app/prueba/prueba'

module Prueba
    class Main < Sinatra::Application

        if ENV['CORS_ORIGIN']
            use Rack::Cors do
            allow do
                origins ENV['CORS_ORIGIN'].split(',')
                resource '*', headers: :any, methods: [
                  :get, :put, :delete, :patch, :post, :options
                ]
            end
            end
        end
      
        use Rack::Parser, parsers: {
            'application/json' => proc { |data| JSON.parse(data).with_indifferent_access },
            'application/xml'  => proc { |data| XML.parse(data).with_indifferent_access },
            /msgpack/          => proc { |data| Msgpack.parse(data).with_indifferent_access }
        }
          
        use PruebaApi
    end
end