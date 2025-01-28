namespace :histories do
  desc 'Get currency data to the day, save to database and send email to users'
  task currency_date: :environment do

    #Get data from scraping
    # EUR
    response = Faraday.get('https://wise.com/gb/currency-converter/eur-to-cop-rate')
    html_doc = Nokogiri::HTML(response.body)

    
    euro = 0.0
    html_doc.css('.text-success').each do |value|
      euro = value.text.strip
    end
    euro = euro.delete(',').to_f
    #convert to lukas
    euro = euro/1000.0
    euro = format('%.2f', euro)
    puts "These is euro #{euro}"

    
    #USD

    response2 = Faraday.get('https://wise.com/gb/currency-converter/usd-to-cop-rate')
    html_doc2 = Nokogiri::HTML(response2.body)

    dolar = 0.0
    html_doc2.css('.text-success').each do |value2|
      dolar = value2.text.strip
    end

    dolar = dolar.delete(',').to_f
    #convert to lukas
    dolar = dolar/1000.0
    dolar = format('%.2f', dolar)
    puts "This is dollar #{dolar}"


    #bitcoin
    response3 = Faraday.get('https://www.google.com/finance/quote/BTC-COP')
    html_doc3 = Nokogiri::HTML(response3.body)

    value3 = html_doc3.css('.fxKbKc')
    bitcoin = value3.text.strip
    bitcoin = bitcoin.delete(',').to_f
    #convert to lukas
    bitcoin = bitcoin/1000.0
    bitcoin = format('%.2f', bitcoin)
    puts "this is bitcoin #{bitcoin}"


    #etherium
    response4 = Faraday.get('https://www.google.com/finance/quote/ETH-COP')
    html_doc4 = Nokogiri::HTML(response4.body)

    value4 = html_doc4.css('.fxKbKc')
    ethereum = value4.text.strip
    ethereum = ethereum.delete(",").to_f
    #convert to lukas
    ethereum = ethereum/1000.0
    ethereum = format('%.2f', ethereum)
    puts "this is etherium #{ethereum}"

    money = [{"Dolar" => dolar},
             {"Euro" => euro},
             {"Bitcoin" => bitcoin},
             {"Ethereum" => ethereum}
    ]

    # Currency
    currencies = %w[USD EUR BTC ETH]
    
    
    currencies.each_with_index do |currency, index|

      # Get the current date
      date = Date.today

      # Format the date as YYYY-MM_DD
      formatted_date = date.strftime("%Y-%m_%d")

      currency_model = Currency.find_by(symbol: currency)
      History.create!(currency_id: currency_model.id, date: formatted_date, lukas_value: money[index].values.first)

    end

    users = User.all

    users.each do |user|
      UserMailer.welcome_email(user, money).deliver_now
    end
    puts "Esto es Users #{User.all.inspect}"
    
  end
end
