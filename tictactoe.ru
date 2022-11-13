
class Player 
    @@arr = Array.new(3) {Array.new(3, ' ')}
    attr_accessor :name, :symbol

    def initialize(name, symbol)
        @name= name
        @symbol = symbol
    end

    def get_input
        puts ("Enter row between 0 and 2")
        x = gets.to_i
        puts ("Enter column between 0 and 2")
        y = gets.to_i
        if x.between?(0,2) && y.between?(0,2)
            self.play(x,y)
        else
            puts "Wrong input player #{self.name}, choose between 0, 1 and 2"
            self.get_input
        end
    end

    def play(x, y)
        puts "Player #{self.name} played using #{self.symbol}"
        if @@arr[x][y] != "o" && @@arr[x][y] != "x"
            @@arr[x][y] = self.symbol
        else
            print "Wrong input player #{self.name}"
            self.get_input
        end
        @@arr.each do |arr|
            p arr
        end
    end 

    def  check_horizontal(arr)
        for i in arr    
            if i.all? do |y| y == 'x' end
                puts "Player 1 won"
                game_over()
            elsif i.all? do |y| y == 'o' end
                puts "Player 2 won"
                game_over()
            end
        end
    end
    
    def check_vertical(arr)
        niz = Array.new(3) {Array.new} 
            for i in 0..arr.size-1
                for j in 0..arr.size-1
                    niz[i].push(arr[j][i])
                end
            end
            check_horizontal(niz)        
    end
    
    def check_diagonal_right(arr)
        niz = []
        for i in 0..arr.size-1
            niz.push(arr[i][i])
        end
        niz = niz.join('')
        if niz == 'xxx'
            p "Player 1 won"
            game_over()
        
        elsif niz == 'ooo'
            p "Player 2 won"
            game_over()
        end
    end
    
    def check_diagonal_left(arr)
        niz = []
        i = arr.size-1
        j = 0
        while i >= 0 && j <= 2 
            niz.push(arr[j][i])
            i = i - 1
            j += 1            
        end
        niz = niz.join('')
        if niz == 'xxx'
            p "Player 1 won"
            game_over()
        
        elsif niz == 'ooo'
            p "Player 2 won"
            game_over()
        end
    end

    def check_winner
        check_horizontal(@@arr)
        check_vertical(@@arr)
        check_diagonal_right(@@arr)
        check_diagonal_left(@@arr)
    end

    def game_over
        exit
    end
end

player1 = Player.new("Crazy", "x")
player2 = Player.new("Coder", "o")

i = 0
while i < 9
    if i % 2 == 0
        player2.get_input
        player2.check_winner
    else
        player1.get_input
        player1.check_winner
    end
    i += 1    
end
