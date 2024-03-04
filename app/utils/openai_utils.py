import openai

def generate_text(prompt):
    openai.api_key = 'your-api-key-here'
    response = openai.Completion.create(engine='text-davinci-003', prompt=prompt, max_tokens=50)
    return response.choices[0].text.strip()
