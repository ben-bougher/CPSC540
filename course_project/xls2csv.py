import xlrd
import csv
import os


wb = xlrd.open_workbook('unit_labels.xlsx')
output = 'unit_labels'

###############################################

if not os.path.exists(output):
    os.makedirs(output)


# Go through each sheet
for s in wb.sheets():

    api = str(s.name)
    csv_file = os.path.join(output, api + '.csv')
    with open(csv_file, 'wb') as io:
        wr = csv.writer(io)

        for row in xrange(s.nrows):

            wr.writerow(s.row_values(row))

