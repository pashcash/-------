def count_points(candidates, options, votes):
    score = {candidate: 0 for candidate in candidates}
    for candidate in candidates:
        for i in range(len(options)):
            value = (len(candidates) - options[i].index(candidate) - 1)*votes[i]
            score[candidate] += value
    score = dict(sorted(score.items(), key=lambda item: item[1], reverse=True))
    return score