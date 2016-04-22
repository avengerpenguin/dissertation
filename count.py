from collections import Counter


coverage = Counter()
qs = Counter()


with open('results.csv', 'r') as csv:
    for line in csv:
        if 'qid,IRI,Extract,Enrich,Approval' in line:
            continue
        qid,iri,extract,enrich,approval = line.strip().split(',')
        key = '{}-{}'.format(extract, enrich)
        coverage.update([key])
        qs.update([qid])

print coverage.most_common()
print qs.most_common()
