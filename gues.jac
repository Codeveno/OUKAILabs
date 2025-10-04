

import random;

obj Game {
    has attempts: int, won: bool = False;

    def play;
}

obj GuessTheNumberGame (Game) {
    has attempts: int = 5, correct_number: int = random.randint(1, 5);

    def play {
        while self.attempts > 0 {
            guess = input("Guess a number between 1 and 5: ");
            if guess.isdigit() {
                self.process_guess(int(guess));
                if self.won {
                    break;
                }
            } else {
                print("That's not a valid number! Try again.");
            }
        }
        if not self.won {
            print("Sorry, you didn't guess the number. Better luck next time!");
        }
    }

    def process_guess(guess: int) {
        if guess > self.correct_number {
            print("Too high!");
        } elif guess < self.correct_number {
            print("Too low!");
        } else {
            print("Congratulations! You guessed correctly.");
            self.won = True;
            return;
        }
        self.attempts -= 1;
        print(f"You have {self.attempts} attempts left.");
    }
}

# Run the game
with entry {
    game = GuessTheNumberGame();
    game.play();
}