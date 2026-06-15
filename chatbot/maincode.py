import ollama
import json
import requests

def calculate_delivery_time(conversation_history):
    full_text = "".join([m['content'].lower() for m in conversation_history])
    time = 0
    
    if "schab" in full_text: time += 20
    if "żeber" in full_text: time += 25
    if "sum" in full_text: time += 15
    if time == 0: time = 15
    return time

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
        ""
    system_prompt = (
        "STRICT SYSTEM RULES - BEZWZGLĘDNE REGUŁY:\n"
        "1. Rozmawiasz wyłącznie po polsku jako tradycyjny, kulturalny kelner.\n"
        "2. Odpowiadasz bardzo krótko – maksymalnie w 2 prostych zdaniach.\n"
        "3. ZASADA SUROWEGO TEKSTU: Masz absolutny zakaz używania kreatywnych przymiotników opisujących jedzenie (zakaz słów typu: 'piękne', 'wyśmienite', 'soczyste'). Możesz użyć tylko słowa 'smaczne' lub 'tradycyjne'.\n"
        f"4. DANE Z PLIKU: Nasze godziny otwarcia to: {hours}.\n\n"
        "5. ZAKAZ PISANIA O CZASIE: Nigdy, pod żadnym pozorem nie pisz słów takich jak 'minut', 'godzin', 'czas' ani żadnych cyfr oznaczających czas.\n"
        "6. ZNACZNIK STRUKTURALNY: Znacznik [OBLICZ_CZAS] dopisujesz na samym końcu wypowiedzi WYŁĄCZNIE I TYLKO WTEDY, gdy klient deklaruje chęć zakupu i wymienia potrawę z menu. Jeśli klient wita się lub pyta o godziny / menu, MASZ ABSOLUTNY ZAKAZ dodawania znacznika [OBLICZ_CZAS].\n\n"
        "OBSŁUGA SYTUACJI:\n"
        f"- Gdy klient pyta o menu lub jedzenie, odpisz dokładnie: \"W naszym menu znajdziesz:\n{meals}\"\n"
        f"- Gdy klient pyta o godziny otwarcia, odpisz dokładnie: \"Nasze godziny otwarcia to: {hours}.\"\n"
        "- Gdy klient składa zamówienie, powtórz wybrane dania, potwierdź je i dopisz na samym końcu wypowiedzi dokładnie ten znacznik: [OBLICZ_CZAS]\n"
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
        
        full_user_message = user_input + hidden_context
        messages.append({'role': 'user', 'content': full_user_message})
        response = ollama.chat(model='llama3', messages=messages, options={'temperature': 0.3, 'top_p': 0.1})
        bot_response = response['message']['content']
        
        if "[OBLICZ_CZAS]" in bot_response:
            estimated_minutes = calculate_delivery_time(messages)
            time_message = f"\nPosiłek będzie gotowy do odbioru za około {estimated_minutes} minut."
            bot_response = bot_response.replace("[OBLICZ_CZAS]", "").strip() + time_message
        
        print(f"\nBot: {bot_response}")
        clean_history_response = bot_response.split("\nPosiłek będzie gotowy")[0] + " [OBLICZ_CZAS]"
        messages.append({'role': 'assistant', 'content': clean_history_response})

if __name__ == '__main__':
    launchChatbot()
