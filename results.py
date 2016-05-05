from collections import defaultdict, Counter
import json, re


shown = defaultdict(int)
approved = defaultdict(int)
tlds = set()

with open('results.csv', 'r') as csvfile:
    for row in csvfile:
        if row[0:3] == 'qid':
            continue

        qid, iri, extract, enrich, approval, percent, responses = row.split(',')

        percent = float(percent) / 100.0
        approval = int(approval)
        responses = int(responses)

        approach = '{}-{}'.format(extract, enrich)
        match = re.match(
            'http://www\.bbc\.(co\.uk|com)/([^/]+)/.+', iri)
        tld = match.group(2)
        tlds.add(tld)
        approach = tld

        shown[approach] += responses
        approved[approach] += approval


results = []

#for extract in range(7):
#    for enrich in range(2):
#        approach = '{}-{}'.format(extract, enrich)

for approach in tlds:
    approval = float(approved[approach]) / float(shown[approach])
    t = (approval * 100, approach)
    results.append(t)


results.sort(reverse=True)

for score, name in results:
    print '{} | {} \\'.format(name, score)


#print json.dumps(results, indent=2)

#for score, name in result:
#    print '{} [label="{}%",color="{} 1.000 1.000"];'.format(name.replace('-', '_'), score, (score / 300.0 / 0.5))

