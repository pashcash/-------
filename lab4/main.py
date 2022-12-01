import itertools
import Simpson
import Borda

def main():
    method = input("Введите метод: ")
    if method == "Simpson":
        candidates, options, votes = read_candidates_votes()
        pairs, points = Simpson.count_pairs(candidates, options, votes)
        score = Simpson.calculate_score(candidates, pairs, points)
    elif method == "Borda":
        candidates, options, votes = read_candidates_votes()
        score = Borda.count_points(candidates, options, votes)
    else:
        print("Выход из программы...")
    print_final_answer(score)

def read_candidates_votes():
    user_input = input("Введите кандиднатов через запятую: ")
    candidates = [candidate for candidate in user_input.split(', ')]
    kolvo_candidates = len(candidates)
    options = list(itertools.permutations(candidates))
    votes = []
    for option in options:
        text = f"Сколько человек выбрали данный вариант {option}?: "
        votes.append(int(input(text)))
    return (candidates, options, votes)

def print_final_answer(score):
    score = dict(sorted(score.items(), key=lambda item: item[1], reverse=True))
    for i in range(len(score)):
        record = list(score.items())[i]
        print(f"{(i+1)}. {record[0]} с количеством баллов {record[1]}")

if __name__=='__main__':
    main()