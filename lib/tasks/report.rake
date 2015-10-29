namespace :report do
  desc "TODO"
  task week: :environment do
      #puts User.all.map(&:email)
      #puts User.count
      puts User.where(:current_sign_in_at => (Time.zone.now.beginning_of_week..Time.zone.now)).map(&:email)
  end

end
