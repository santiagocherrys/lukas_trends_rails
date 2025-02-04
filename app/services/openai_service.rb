require 'openai'

class OpenAIService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
    @predefined_prompt = 'eres un analista de divisas y criptomonedas, tu función es predecir los valores que estas van a tener en un momento especifico, de acuerdo a un periodo de tiempo dado. Devuelve los valores en el mismo formato solicitado, y basa tus predicciones en los valores ingresados.'
  end

  def generate_text(user_input)
    prompt = "#{@predefined_prompt} #{user_input}"

    response = @client.chat(
      parameters: {
        model: 'gpt-4-turbo', # O usa "gpt-3.5-turbo"
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
