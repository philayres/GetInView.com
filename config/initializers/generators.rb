
Rails.application.config.generators do |g|
g.stylesheets     false
g.javascripts     false
g.scaffold_stylesheet false
g.template_engine :giv
g.fallbacks[:giv] = :erb # or haml/slim etc 
end