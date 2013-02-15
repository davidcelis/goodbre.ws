Factory.define :user do |f|
  f.username 'test_user_%d'
  f.email    '{username}@example.com'
  f.password f.password_confirmation('supersecret')
end

Factory.define :brewery do |f|
  f.name        'Test Brewery %d'
  f.description 'We brew the hoppiest beers around!'
end

Factory.define :beer do |f|
  f.name 'Hopocalypse'
  f.description "You'll never taste again."

  f.breweries { [Factory(:brewery)] }
  f.style     { Factory :style }
end

Factory.define :style do |f|
  f.name 'American India Pale Ale'
end
