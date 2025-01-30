# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Advertisement.create([
                       {
                         title: 'Aprende todo sobre criptomonedas y a como invertir en ellas',
                         image_url: 'https://res.cloudinary.com/dlxtquqy5/image/upload/v1738267382/Invierte_e_criptomonedas_nvxmtx.jpg',
                         link: 'https://www.finect.com/usuario/Josetrecet/articulos/invertir-criptodivisass'
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
