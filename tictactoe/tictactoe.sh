#!/bin/bash

board=(" " " " " " " " " " " " " " " " " ")
player="X"
save="tictactoe_save.txt"


draw_board() {
    clear
    echo "3 takie same znaki w jednej linii = WYGRANA"
    echo " ---------------------"
    echo "  ${board[0]} | ${board[1]} | ${board[2]} "
    echo " ---+---+---"
    echo "  ${board[3]} | ${board[4]} | ${board[5]} "
    echo " ---+---+---"
    echo "  ${board[6]} | ${board[7]} | ${board[8]} "
    echo " ---------------------"
    echo "Ruch: $player"
}

if_win() {
    local win_patterns=("012" "036" "048" "147" "246" "258" "345" "678")
    for p in "${win_patterns[@]}" 
        do
            if [[ ${board[${p:0:1}]} != " " && \
                ${board[${p:0:1}]} == ${board[${p:1:1}]} && \
                ${board[${p:1:1}]} == ${board[${p:2:1}]} ]] 
            then
                return 0
            fi
    done
    return 1
}

save_game(){
    local data=""
    for (( i=0; i<9; i++ ))
    do
        if [[ "${board[$i]}" == " " || "${board[$i]}" == "" ]]
        then
            data="${data}."
        else
            data="${data}${board[$i]}"
        fi
    done

    echo "$data" > "$save"
    echo "$player" >> "$save"
    echo "Zapisano grę"
    exit 0
}

load_game(){
    if [[ -f "$save" ]]
    then
        local start_board=$(head -n 1 "$save")

        for (( i=0; i<9; i++ ))
        do
            char="${start_board:$i:1}"
            if [[ "$char" == "." ]]
            then
                board[$i]=" "
            else
                board[$i]="$char"
            fi
        done

        player=$(sed -n '2p' "$save")

        echo "Wczytano poprzednią grę."
    else
        echo "Brak zapisanych rozgrywek."
        sleep 1
    fi
}

echo "Czy wczytać zapisana grę? (t/n)"
read -r choice
[[ "$choice" == "t" ]] && load_game

while true; 
    do
        draw_board
        read -p "Gracz $player wybiera pole (1-9) lub, s, by zapisać i wyjść: " input
        if [[ "$input" == "s" || "$input" == "S" ]]
        then
            save_game
        fi

        idx=$((input-1))
        if [[ ! "$input" =~ ^[1-9]$ ]] || [[ "${board[$idx]}" != " " ]] 
        then
            echo "Nieprawidłowy ruch! Spróbuj ponownie"
            sleep 1
            continue
        fi

        board[$idx]="$player"
    
        if if_win 
        then
            draw_board
            echo "Gracz $player wygrywa!"
            rm -f "$save"
            break
        fi

        occupied=0
        for field in "${board[@]}"
        do
            if [[ "$field" != " " ]]
            then
                ((occupied++))
            fi
        done

        if [[ $occupied -eq 9 ]]
        then
            draw_board
            echo "REMIS!"
            rm -f "$save"
            break
        fi

        if [[ "$player" == "X" ]]
        then
            player="O"
        else
            player="X"
        fi
    done