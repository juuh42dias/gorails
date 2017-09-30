# rake importar_emails:todos
namespace :importar_emails do


    desc "Importando lista de emails para mailchimp"
    task todos: :environment do
      gibbon = Gibbon::Request.new(api_key: ENV['GORAILS_MAILCHIMP_API_KEY'])
      list_id = ENV['GORAILS_MAILCHIMP_LIST_ID']
      User.all.each do |user|
        begin
          gibbon.lists(list_id).members.create(body: { email_address: user.email, status: "subscribed" })
          p "o usuario -->#{user.first_name}, com email #{user.email}, foi inserido"
        rescue Exception => e
          p "erro: #{e}"
        end
      end
    end
  end
