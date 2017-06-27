RAILS_ENV=production
source ~/.getinview_www_env
cd ~/getinview_www
git pull
bundle
rake db:migrate
sudo service thin_www_giv restart
