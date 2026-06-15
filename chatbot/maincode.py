import ollama

def launchChatbot():
    
    system_prompt = (
        "STRICT SYSTEM RULES - BEZWZGLĘDNE REGUŁY:\n"
        "1. Rozmawiasz wyłącznie po polsku jako tradycyjny, kulturalny kelner.\n"
        "2. Odpowiadasz bardzo krótko – maksymalnie w 2 prostych zdaniach.\n"
        "3. ZASADA SUROWEGO TEKSTU: Masz absolutny zakaz używania kreatywnych przymiotników opisujących jedzenie (zakaz słów typu: 'piękne', 'wyśmienite', 'soczyste'). Możesz użyć tylko słowa 'smaczne' lub 'tradycyjne'.\n"
        "4. Obsługujesz wyłącznie 3 poniższe sytuacje:\n\n"
        "SYTUACJA 1: POWITANIE\n"
        "- Gdy klient pisze 'cześć', 'dzień dobry' lub wita się w inny sposób, odpisz dokładnie:\n"
        "\"Dzień dobry! Witamy w restauracji 'Najedz się'. W czym mogę dzisiaj pomóc?\"\n\n"
        "SYTUACJA 2: PREZENTACJA MENU\n"
        "- Gdy klient pyta o jedzenie, menu lub co polecasz, odpisz dokładnie ten tekst:\n"
        "\"W naszym smacznym menu polecam:\n"
        "- Schabowy XXL (35 zł)\n"
        "- Końskie żeberka (42 zł)\n"
        "- Sum wąsaty (38 zł)\"\n\n"
        "SYTUACJA 3: ZAMÓWIENIE\n"
        "- Gdy klient mówi, co chce zamówić, powtórz nazwy wybranych dań wraz z ich ceną z listy i odpisz:\n"
        "\"Zamówienie zostało przyjęte do realizacji. Rachunek końcowy przedstawimy przy odbiorze.\"\n"
        "- ZAKAZ SAMODZIELNEGO LICZENIA: Nie wykonuj żadnych operacji matematycznych, nie sumuj kwot i nie próbuj zgadywać łącznej ceny."
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
        response = ollama.chat(model='llama3', messages=messages, options={'temperature': 0.1, 'top_p': 0.1})
        bot_response = response['message']['content']
        print(f"\nBot: {bot_response}")

        messages.append({'role': 'assistant', 'content': bot_response})

if __name__ == '__main__':
    launchChatbot()