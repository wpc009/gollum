require '/usr/local/src/omnigollum/lib/omnigollum'

# Providers now need to be loaded manually
require 'omniauth-github'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-openid'
OmniAuth.config.full_host = 'http://wiki.freeradius.org'

# Configure omniauth/omnigollum providers
Precious::App.set(:omnigollum, {
  :providers => Proc.new do
    provider :github, "7546e9ab60d5acbf7743", "cf666a3b79a8661103eedb650266e8ade5f8017c", {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
    provider :open_id
  end,
  :dummy_auth => false
})


# Register omnigollum extension in sinatra
Precious::App.register Omnigollum::Sinatra

# Other settings for gollum...
Precious::App.set(:wiki_options, {
  :universal_toc => true,
  :live_preview  => false,
  :repo_is_bare  => true
})

# Seems to break requests from caching proxies if left on...
Precious::App.set :protection, false
Precious::App.set :environment, :production
Precious::App.set :show_exceptions, false

# Set the default internal and external encodings, seems to fix encoding issues loading in pages containing UTF8 chars
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
