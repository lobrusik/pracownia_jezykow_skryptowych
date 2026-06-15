import ollama
import json
import requests

def download_details_from_api(dish):
    dish_lower = dish.lower()
    key = ""
    
    if "schab" in dish_lower: key = "schabowy"
    elif "żeber" in dish_lower: key = "żeberka"
    elif "sum" in dish_lower: key = "sum"
    
    if key:
        try:
            res = requests.get(f"http://127.0.0.1:5000/api/details/{key}")
            if res.status_code == 200:
                return res.json()
        except requests.exceptions.ConnectionError:
            return {"error": "Brak połączenia z API Flaska"}
    return None

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
        "1. Rozmawiasz wyłącznie po polsku jako tradycyjny, kulturalny kelner.\n"
        "2. Odpowiadasz bardzo krótko – maksymalnie w 2 prostych zdaniach.\n"
        "3. ZASADA SUROWEGO TEKSTU: Masz absolutny zakaz używania kreatywnych przymiotników opisujących jedzenie (zakaz słów typu: 'piękne', 'wyśmienite', 'soczyste'). Możesz użyć tylko słowa 'smaczne' lub 'tradycyjne'.\n"
        f"4. DANE Z PLIKU: Nasze godziny otwarcia to: {hours}.\n\n"
        "OBSŁUGA SYTUACJI:\n"
        f"- Gdy klient pyta o menu lub jedzenie, odpisz dokładnie: \"W naszym menu znajdziesz:\n{meals}\"\n"
        f"- Gdy klient pyta o godziny otwarcia, odpisz dokładnie: \"Nasze godziny otwarcia to: {hours}.\"\n"
        "- Gdy klient składa zamówienie, powtórz wybrane dania i potwierdź je.\n"
        "- ALERGIE I MODYFIKACJE: Jeśli system przekaże Ci poniżej [KONTEKST API], przeczytaj uważnie skład i alergeny dania. Na ich podstawie odpowiedz klientowi, czy modyfikacja potrawy jest możliwa (np. czy da się usunąć dany składnik)."
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
    
        hidden_context = ""
        if any(word in user_input.lower() for word in ["alergi", "skład", "bez", "modyfik"]):
            for dish_test in ["schab", "żeber", "sum"]:
                if dish_test in user_input.lower():
                    details = download_details_from_api(dish_test)
                    if details and "error" not in details:
                        hidden_context += f"\n[KONTEKST API dla {dish_test}: Skład: {details['sklad']}, Alergeny: {details['alergeny']}]"
        
        
        messages.append({'role': 'user', 'content': user_input})
        response = ollama.chat(model='llama3', messages=messages, options={'temperature': 0.1, 'top_p': 0.1})
        bot_response = response['message']['content']
        print(f"\nBot: {bot_response}")

        messages.append({'role': 'assistant', 'content': bot_response})

if __name__ == '__main__':
    launchChatbot()