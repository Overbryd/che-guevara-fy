require 'rubygems'
require 'haml'
require 'sinatra'

get '/' do
  haml :index
end

post '/che-guevara-fy' do
  tempfile = params[:picture][:tempfile]
  `convert #{tempfile.path} -colorspace Gray #{tempfile.path}.bw`
  `convert #{tempfile.path}.bw -black-threshold 50% -white-threshold 50% #{tempfile.path}.guevara.png`
  send_file "#{tempfile.path}.guevara.png", :type => 'image/png'
end

__END__

@@ layout
%html{:xmlns => "http://www.w3.org/1999/xhtml", :lang => "en", "xml:lang" => "en"}
  %head
    %title Che-Guevara-Fy
    %meta{"http-equiv" => "Content-Type", :content => "text/html; charset=utf-8"}
  %body
    = yield

@@ index
%form{:action => '/che-guevara-fy', :method => 'POST', :enctype => 'multipart/form-data'}
  %input{:type => 'file', :name => 'picture', :size => 'chars'}
  %input{:type => 'submit', :value => 'Hasta la victoria siempè!'}
