#!/bin/bash

board=(" " " " " " " " " " " " " " " " " ")
player="X"


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

while true; 
    do
        draw_board
        read -p "Gracz $player wybiera pole (1-9): " input

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
            break
        fi

        if [[ "$player" == "X" ]]
        then
            player="O"
        else
            player="X"
        fi
    done