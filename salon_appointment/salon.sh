#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\nWelcome to Salon Appointment App\n"

MAIN_MENU() {
  if [[ $1 ]] 
  then
    echo -e "\n$1"
  fi

  echo "Select an option"
  # Get salon services list
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id");
  # If no services available
  if [[ -z $AVAILABLE_SERVICES ]] 
  then
    # Send to main menu
    MAIN_MENU "\nSorry we don't have any services available\n"
  else
    # Display available services
    echo -e "\nHere are the available services\n"

    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME 
    do 
      echo "$SERVICE_ID) $SERVICE_NAME"
    done

    # Ask for service
    echo -e "\nWhich service you want to get\n"
    read SERVICE_ID_SELECTED
    # If input is not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then 
      # Send to main menu
      MAIN_MENU  "\Please enter a valid service id\n"
    else 
      # Check if the service_id exists in table
      SERVICE_ID_AVAILABLE=$($PSQL "SELECT service_id, name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

      # If not availabe 
      if [[ -z $SERVICE_ID_AVAILABLE ]]
      then
        # Send to main menu
        MAIN_MENU "service_id not available, please try provided service_id\n"
      else 
        # Get customer info
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
        # If customer not exists
        if [[ -z $CUSTOMER_NAME ]]
        then
          # get new customer name
          echo -e "\nI don't have a record for that phone number, what's your name?"
          read CUSTOMER_NAME
          # insert new customer
          INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        fi
        # get the service name
        SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

        # get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

        # get the appointment time from customer
        echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
        read SERVICE_TIME
        INSERT_NEW_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, time, service_id) VALUES ($CUSTOMER_ID, '$SERVICE_TIME', $SERVICE_ID_SELECTED)")

        echo -e "\n I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
      fi
    fi


  fi
}

MAIN_MENU