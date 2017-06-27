RAILS_ENV=development
bundle
rake assets:precompile
git add --all
git commit --all
git push
