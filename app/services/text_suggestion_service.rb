# app/services/text_suggestion_service.rb
class TextSuggestionService
  include HTTParty
  base_uri "https://api.together.xyz/v1/chat/completions"

  def initialize(prompt_text)
    @prompt_text = prompt_text
  end

  def generate_suggestion
    headers = {
      "Authorization" => "Bearer #{ENV['TOGETHER_API_KEY']}",
      "Content-Type" => "application/json"
    }

    body = {
      model: "mistralai/Mixtral-8x7B-Instruct-v0.1",
      messages: [
        { role: "system", content: "You are an AI that only outputs direct text content without any introductions, explanations, greetings, or apologies. Provide only the main content. Make sure the response is properly completed, not abruptly cut. The content should be complete and ideally not exceed 500 words in total." },
        { role: "user", content: @prompt_text }
      ],
      temperature: 0.8,
      top_p: 0.95
      # max_tokens: 500
    }.to_json

    response = self.class.post("", headers: headers, body: body)

    if response.success?
      parsed = response.parsed_response

      if parsed["choices"] && parsed["choices"][0]["message"]["content"]
        parsed["choices"][0]["message"]["content"].strip
      else
        Rails.logger.error("TogetherAI API Unexpected Response: #{parsed.inspect}")
        nil
      end
    else
      Rails.logger.error("TogetherAI API Error: #{response.code} #{response.body}")
      nil
    end
  rescue StandardError => e
    Rails.logger.error("Error in TextSuggestionService: #{e.message}")
    nil
  end
end
