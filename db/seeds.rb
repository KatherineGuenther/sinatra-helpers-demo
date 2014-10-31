bob = User.find_or_create_by!(username: 'bob') do |user|
  user.password = 'BOB'
end

mary = User.find_or_create_by!(username: 'mary') do |user|
  user.password = 'MARY'
end


p User.all.to_a

