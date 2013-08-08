

person1= Hash[first: "Robin" , last: "Healey"]
person2= Hash[first: "Bilbo" , last: "Baggins"]
person3= Hash[first: "Sam" , last: "Adams"]
 
params= Hash[father: person1 , mother: person2 , child: person3]


puts params[:father][:first]

puts params[:mother][:last]

puts params