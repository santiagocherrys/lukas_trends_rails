History.destroy_all
Currency.destroy_all
User.destroy_all

#create the admin user for application
User.create!(full_name: "Lukas Palos", email: "laslukas@hotmail.com", password: "admin1234", password_confirmation: "admin1234", role: :ADMIN, subscription_type: :PREMIUM)

currencies = [
  { name: 'COP', description: 'Peso Colombiano', symbol: 'COP' },
  { name: 'BTC', description: 'Bitcoin', symbol: 'BTC' },
  { name: 'ETH', description: 'Ethereum', symbol: 'ETH' },
  { name: 'EUR', description: 'Euro', symbol: 'EUR' }
]

currencies.each do |currency|
  Currency.create!(currency)
  today = Date.today
  if currency[:name] == 'COP'
    conn = Faraday.new(
      url: 'http://apilayer.net/api'
    )
    for i in 5.downto(1)
      start_date = today - i.years
      end_date = today - (i - 1).years
      puts "start_date: #{start_date} end_date: #{end_date}"

      response = conn.get('/timeframe',
                          {
                            access_key: ENV.fetch('CURRENCY_LAYER_API_KEY'),
                            start_date: start_date,
                            end_date: end_date,
                            currencies: 'COP'
                          },
                          {
                            'Content-Type' => 'application/json'
                          })
      lukas = JSON.parse(response.body)
      puts lukas['quotes']
      lukas['quotes'].each do |date, value|
        cop_value = value['USDCOP'] / 1000.0
        puts "day: #{date} value #{cop_value}"
        History.create!(currency_id: Currency.find_by(name: 'COP').id, date: date, lukas_value: cop_value)
      end
    end
    next
  end

  five_years_ago = today - 5.years
  conn = Faraday.new(
    url: 'https://rest.coinapi.io'
  )
  response = conn.get(
    "/v1/ohlcv/BITSTAMP_SPOT_#{currency[:name]}_USD/history?period_id=1DAY&time_start=#{five_years_ago}T00%3A00%3A00&time_end=#{today - 1}T23%3A59%3A59&limit=2000", {}, {
      'Content-Type' => 'application/json', 'X-CoinAPI-Key' => ENV.fetch('COIN_API_KEY')
    }
  )
  puts "ejecutando para #{currency[:name]}"
  history = JSON.parse(response.body)
  history.each do |data|
    date = Date.parse(data['time_period_start'])
    cop_value = History.find_by(currency_id: Currency.find_by(name: 'COP').id, date: date).lukas_value
    lukas_value = data['price_close'] * cop_value
    puts "date: #{data['time_period_start']} value: #{lukas_value}"
    History.create!(currency_id: Currency.find_by(name: currency[:name]).id, date: data['time_period_start'],
                    lukas_value: lukas_value)
  end
end

puts "Seeding completed! Added #{Currency.count} currencies "


Advertisement.create([
                       {
                         title: 'Aprende todo sobre criptomonedas y a como invertir en ellas',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738267382/Invierte_e_criptomonedas_nvxmtx.jpg',
                         link: 'https://www.finect.com/usuario/Josetrecet/articulos/invertir-criptodivisas'
                       },
                       {
                         title: 'Curso Gratis: Potencia tu negocio en Finanzas e Inversión con "MinTIC" e "iNNpulsa"',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738270266/Curso_Finanzas_e_inversion_MinTIC_r9jbev.jpg',
                         link: 'https://mintic.gov.co/portal/inicio/Sala-de-prensa/Noticias/196459:Nuevo-curso-gratuito-sobre-finanzas-basicas-para-startups-lanzan-el-MinTIC-e-iNNpulsa'
                       },
                       {
                         title: 'Señales de Trading en Vivo - ¡Gana con Expertos!',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738273197/Analisis_de_MercadoTrading_bnvnbl.png',
                         link: 'https://www.youtube.com/playlist?list=PLyq82Z3FM4WZqvGRkpp887GBpFp_Zr9HR'
                       },
                       {
                         title: '¿Cuánto Ganarás con tu Inversión? Usa esta Calculadora',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738274140/Calculadora_financiera_frid9r.png',
                         link: 'https://apps.microsoft.com/detail/9p30wmb4x45x?hl=es-ES&gl=CO'
                       },
                       {
                         title: 'Descubre los Mejores Fondos de Inversión para este Año',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738274405/Inversion_rhy3ue.png',
                         link: 'https://www.finect.com/usuario/maitelpz/articulos/claves-encontrar-mejores-fondos-inversion'
                       }
                     ])
