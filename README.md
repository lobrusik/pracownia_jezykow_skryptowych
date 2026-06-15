# Pracownia języków skryptowych w grach wideo 2025-2026
## Zadanie 1 - Bash
W ramach pierwszego zadania proszę wykonać grę kółko i krzyżyk w
Bashu, który:<br>
* ✅ 3.0 - działa w trybie gry turowej, [2dc9c60](https://github.com/lobrusik/skryptowe/commit/2dc9c60e41f31348153cfff153aeb97eb077521f)
* ✅ 4.0 - pozwala na zapis i odtwarzanie przerwanej gry (save game), [8ae1e20](https://github.com/lobrusik/skryptowe/commit/8ae1e202f0ba50c0f0489bd82b74c63b226f82c7)
* ✅ 5.0 - pozwala na grę z komputerem. [43dcc95](https://github.com/lobrusik/skryptowe/commit/43dcc95c7302261885053268436e8972f5e28998)
<br>[Kod do zadania](https://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/tictactoe/tictactoe.sh)
<br>[Folder z nagraniami](tictactoe/nagrania)

## Zadanie 2 - JavaScript
Zamek należy stworzyć za pomocą skryptu napisanego w JS.
* ✅ 3.0 Prosty zamek wykorzystując minimum 5 różnych rodzajów bloków, [c93c71d](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/c93c71dd98edc070d18659439fe583c30f6895fc#diff-23c8d65c23629fb2d038f5752dabdfd948959974d9386fc062fa8434eecc2941R1-R47)
* ✅ 3.5 Posiada mimum 4 okna, [d64a0f8](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/d64a0f8a0d025c9fbc275088517e4a8475d8a16b)
* ✅ 4.0 Posiada fosę oraz most, [bb6defc](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/bb6defc611d6923117d3ca5cf883ce06a7f133be)
* ✅ 4.5 Posiada bramę oraz minimum 2 wieże, [5ff8794](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/5ff8794042928efcd95f484151d0040119f07bcc)
* ✅ 5.0 Zamek ma minimum dwa poziomy (piętra) na które można wejść [477e7b6](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/477e7b6ea88df4ea2787176836a0b2eb784ea4d3)
<br>[Kod do zadania](https://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/minecraft/kod_zamek_minecraft.js)
<br>[Folder z nagraniami](minecraft/nagrania)

## Zadanie 3 - Ruby
Należy stworzyć crawler produktów na Amazonie lub Allegro w Ruby wykorzystują bibliotekę Nokogiri. Ja zrobiłam crawler dla X-Kom, ponieważ w żaden sposób nie mogłam przebić się przez kod bęłdu 403.
* ✅ 3.0 Należy pobrać podstawowe dane o produktach (tytuł, cena), dowolna kategoria, [0ef1495](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/0ef1495a6651da3a1baf99d94cc4b52e5445b710)
* ✅ 3.5 Należy pobrać podstawowe dane o produktach wg słów kluczowych, [6049133](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/6049133564f35f5e1dc4812fa0741668092e3bf8)
* ✅ 4.0 Należy rozszerzyć dane o produktach o dane szczegółowe widoczne tylko na podstronie o produkcie,
  [f91fb03](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/f91fb03e203fe4a3a992abdc641258ce33bb17a2)
* ✅ 4.5 Należy zapisać linki do produktów, [ff732a0](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/ff732a0b09ae6ed52b86dc204a2bb513add45b78)
* ✅ 5.0 Dane należy zapisać w bazie danych np. SQLite via Sequel. [c12734a](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/c12734aa83ed474909f6d35fe8e8c7e0545ee6d9)
<br>[Kod do zadania](https://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/chatbot/maincode.py)
<br>[Folder z nagraniami]([crawler/nagrania](https://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/crawler/crawler-xkom.rb))

## Zadanie 4 - Lua
Należy stworzyć grę Tetris w Lua na frameworku Löve (https://love2d.org/).
* ✅ 3.0 Postawowa wersja dekstopowa z obsługą na klawiaturze - minimum 4 rodzaje klocków, [62ee552](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/62ee552d895178abf934ab387c989783bbec4284)
* ✅ 3.5 Zapis i odczyt gier, [0db5dfd](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/0db5dfd76cacf75127f3b95a2794eb9755a4b264)
* ✅ 4.0 Dodanie efektów dźwiękowych przy akcjach, [1f68e4e](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/1f68e4e60b33d53f4520af428c02a3e2408621aa)
* ✅ 4.5 Dodanie animacji przy zbijaniu klocków, [2dfa43e](https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/2dfa43e42e58b0552e79f2de6c74d3bb3f0ac9df)
* ✅ 5.0 Wersja na iOS lub Android z implementacją touch zamiast klawiatury. [63718b0]
<br>[Folder z nagraniami](tetris/nagrania)
<br>[Kod główny do zadania] (hhttps://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/tetris/na5.lua)


## Zadanie 5 - Python LLM
Należy stworzyć czatbota wraz z filtrem z wykorzystaniem lokalnego modelu językowego (np. Llama 3, Mistral, Gemma przez Ollama lub llama-cpp-python).
* ✅ 3.0 Czatbot z wytrenowaną umiejętnością (poprzez prompt) obsługi co najmniej 3 sposobów sformułowania intencji (powitanie, menu, zamówienie). [f303e9a
] (https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/f303e9a737cd4834c58700332f8806cffed3cb93)
* ✅ 3.5 Informacje o godzinach otwarcia i pozycjach w menu powinny być pobierane z pliku konfiguracyjnego (JSON/YAML) i przekazywane do modelu. [4f3242d] (https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/4f3242dccc7df6fc2bdec594a930c4090479465d)
* ✅ 4.0 Czatbot musi przetworzyć zamówienie i potwierdzić zakupione posiłki, a także obsłużyć dodatkowe prośby (np. alergie, modyfikacje dań). Dane o alergiach, składzie, daniach ładowy z api aplikacji webowej napisanej we Flasku (https://flask.palletsprojects.com/en/stable/). [8bbef59] (https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/8bbef59ee3b42900e79633ebcb892b5afeb88710)
* ✅ 4.5 Czatbot musi potwierdzić, kiedy posiłek będzie dostępny do odbioru w restauracji (estymacja czasu na podstawie zamówienia). [81a8d6f] {https://github.com/lobrusik/pracownia_jezykow_skryptowych/commit/81a8d6fcf37a245639de5273a57523af7dc6fd69)
* ❌ 5.0 Czatbot powinien zapytać o adres dostawy i potwierdzić go, zamiast opcji odbioru osobistego, weryfikując kompletność danych adresowych. Zapisać zamówienie przez wywołanie api aplikacji we Flasku. We Flasku zapisujemy dane zamówienia w bazie.
<br>[Kod do zadania](https://github.com/lobrusik/pracownia_jezykow_skryptowych/blob/main/chatbot/maincode.py)
<br>[Folder z nagraniami](chatbot/nagrania)
