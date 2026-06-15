import ollama
import json

def load_config():
    with open("config.json", "r", encoding="utf-8") as file:
        return json.load(file)

def launchChatbot():
    config = load_config()
    hours = config['godziny_otwarcia']
    meals = ""
    for dish in config['menu']:
        meals += f"- {dish['nazwa']} (cena: {dish['cena']} zł)\n"
        
    system_prompt = (
        "STRICT SYSTEM RULES - BEZWZGLĘDNE REGUŁY:\n"
        "1. Rozmawiasz tylko po polsku.\n"
        "2. Jesteś zwięzłym, surowym pomocnikiem. Odpowiadasz maksymalnie w 2 prostych zdaniach.\n"
        "3. ZASADA SUROWEGO TEKSTU: Masz absolutny zakaz używania jakichkolwiek przymiotników opisujących jedzenie. "
        "Do zachwalania dań możesz użyć wyłącznie słowa 'smaczne' lub 'tradycyjne'. Nie dodawaj od siebie żadnych innych słów.\n\n"
        
        "DANE Z PLIKU KONFIGURACYJNEGO (UŻYJ TYLKO ICH):\n"
        f"Godziny otwarcia: {hours}\n"
        f"Menu restauracji:\n{meals}\n"
        
        "SZABLONY ODPOWIEDZI:\n"
        "- Jeśli klient pyta o godziny otwarcia lub czy otwarte, przepisz dokładnie to zdanie:\n"
        f"Nasze godziny otwarcia to: {hours}.\n"
        "- Jeśli klient pyta o menu lub co polecasz, odpowiedz dokładnie tak:\n"
        f"W naszym menu znajdziesz:\n{meals}"
        "- Jeśli klient zamawia, powtórz nazwy dań z cenami i napisz: 'Zamówienie zostało przekazane do realizacji.'"
    )
    
    messages = [
        {
            'role': 'system',
            'content': system_prompt
        }
    ]
    
    print("====================================================")
    print(" Czatbot Restauracji uruchomiony")
    print(" Wpisz 'exit', aby zakończyć rozmowę.")
    print("====================================================\n")

    while True:
        user_input = input("\nKlient: ")
        if user_input.lower() == 'exit':
            print("Dziękujemy za skorzystanie z naszych usług i zapraszamy ponownie.")
            break
        
        messages.append({'role': 'user', 'content': user_input})
        response = ollama.chat(model='llama3', messages=messages)
        bot_response = response['message']['content']
        print(f"\nBot: {bot_response}")

        messages.append({'role': 'assistant', 'content': bot_response})

if __name__ == '__main__':
    launchChatbot()