
#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  # Try to find by atomic_number, symbol, or name
  ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p USING(atomic_number) JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number::TEXT='$1' OR e.symbol='$1' OR e.name='$1'")
  
  if [[ -z $ELEMENT_INFO ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read -r ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELT BOIL <<< "$ELEMENT_INFO"
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
fi


 