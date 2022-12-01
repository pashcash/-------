import itertools
    
def count_pairs(candidates, options, votes):
    pairs = list(itertools.permutations(candidates, 2))
    points = [0 for _ in pairs]
    for i in range(len(pairs)):
        for j in range(len(options)):
            if (options[j].index(pairs[i][0]) < options[j].index(pairs[i][1])):
                points[i] += votes[j]
    for i in range(len(points)):
        print(f"{pairs[i]} : {points[i]}")
    return (pairs, points)

def calculate_score(candidates, pairs, points):
    candidate_score = {}
    for candidate in candidates:
        match_pairs = list(filter(lambda pair: pair[0]==candidate, pairs))
        match_indexes = [pairs.index(i) for i in match_pairs]
        match_points = [points[i] for i in match_indexes]
        value = min(match_points)
        candidate_score[candidate] = value
    return candidate_score