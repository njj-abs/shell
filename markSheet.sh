#! /bin/bash

while IFS="," read -r Name Language Maths Science
do
    echo "Name: $Name"
    echo "Total: $((Language + Maths + Science))"
    echo ""
done < <(cut -d "," -f1,2,3,4 markSheet.csv | tail -n +2)