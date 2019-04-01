require 'httparty'
def main
    entry = false
    while !entry
    puts "Welcome to the XKCD comic reader. Press (1) to open the latest comic. Press (2) to select a specific comic, or (3) to choose a random comic. (4) to quit."
    choice = gets.chomp.to_i
    
        if choice == 1
            open_latest_comic
            entry = true
        elsif choice == 2
            open_selection
            entry = true
        elsif choice == 3
            open_random_comic
            entry = true
        elsif choice == 4
            puts "Bye!"
            system("exit")
        else
            puts "Invalid, please try again."
    
        end
    end

    
    
end



def open_latest_comic
    response = HTTParty.get("http://xkcd.com/info.0.json")
    response = JSON.parse(response.body)
    system("open #{response["img"]}")
    main
end

def open_selection
    puts "Please type the number of the comic you'd like to access."
    comic_number = gets.chomp.to_i
    latest_comic = HTTParty.get("http://xkcd.com/info.0.json")
    if comic_number < latest_comic["num"] && comic_number > 0
        response = HTTParty.get("http://xkcd.com/#{comic_number}/info.0.json")
        response = JSON.parse(response.body)
        system("open #{response["img"]}")
    else
        puts "Invalid entry, there are not that many comics!"

    end
    
    main
end

def open_random_comic
    random = Random.new
    
    #make randoms maximum the latest comic
    #find the current comic #    
    response = HTTParty.get("http://xkcd.com/info.0.json")
    response = JSON.parse(response.body)

    random_comic = HTTParty.get("http://xkcd.com/#{random.rand(response["num"])}/info.0.json")

    system("open #{random_comic["img"]}")
    main
end


main