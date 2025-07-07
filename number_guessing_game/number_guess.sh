#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]; then
 echo "Welcome, $USERNAME! It looks like this is your first time here."
 INSERT_USER_INFO=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
#  IFS='|' read GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
 echo "$USER_INFO" | while IFS='|' read GAMES_PLAYED BEST_GAME
 do
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
 done
fi

SECRET=$(( RANDOM % 1000 + 1 ))
 echo  "\nGuess the secret number between 1 and 1000:"
GUESS_COUNT=0


while true; do
 read GUESS
 ((GUESS_COUNT++))

 if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
  echo "That is not an integer, guess again:"
 elif (( GUESS < SECRET )); then
  echo "It's higher than that, guess again:"
 elif (( GUESS > SECRET )); then
  echo "It's lower than that, guess again:"
 else
  echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET. Nice job!"
  USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")
  IFS='|' read GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  NEW_GAMES_PLAYED=$((GAMES_PLAYED + 1))
  if [[ -z $BEST_GAME || $GUESS_COUNT -lt $BEST_GAME ]]; then
    UPDATE_USERS_BEST_GAME=$($PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED, best_game=$GUESS_COUNT WHERE username='$USERNAME'")
  else
    UPDATE_USERS_GAME=$($PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED WHERE username='$USERNAME'")
  fi
  break
fi
done