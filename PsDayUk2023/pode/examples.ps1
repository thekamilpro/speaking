$server = "localhost"
$port = 8080
$protocol = "http"
$serverPort = "$($protocol)://$($server):$($port)"

# Does server work?
Test-Connection $server -TcpPort $port

#Basic API call
Invoke-RestMethod -Uri "$serverPort/hello"

#Retrieve all users
Invoke-RestMethod -Uri "$serverPort/users"

#Retrieve user by query
Invoke-RestMethod -Uri "$serverPort/users?username=kamilpro"

#Retrieve user by url
Invoke-RestMethod -Uri "$serverPort/users/2"
