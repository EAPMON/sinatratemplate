module Prueba
    class PruebaApi < Sinatra::Base
        get '/prueba' do 
            'hola'
        end
    end
end