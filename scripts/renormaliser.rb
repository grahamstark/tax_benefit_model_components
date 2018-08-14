class RenormTable
        
        
end

def renormalise( fields, pkfields, pattern )
        outArrays = []
        maxNum = {}
        baseTable = []
        matchingBaseNames = {}
        p = 0
        fields.each{
                |field|
                if field =~ /#{pattern}/
                        m = $1
                        c = $2.to_i
                        if maxNum.key?(m) 
                                maxNum[m] = [c, maxNum[m]].max
                        else
                                maxNum[m] = c
                        end
                        if not matchingBaseNames.key?(m)
                                matchingBaseNames[m] = []
                        end
                        matchingBaseNames[m] << [field,p]
                                                        

                else
                        baseTable << [field,p]     
                end
                p += 1
        }
        groupedCount = {}
        maxNum.each{
                |name,count|
                groupedCount[count] = [] if groupedCount[count].nil?
                groupedCount[count] << name
        }
        groupedCount.each{
                |n,v|
                v.insert( 0, ['count',-1] ) 
                pkfields.each{
                        |i|
                        v.insert( 0, [fields[i],i] )
                }
        }
        groupedCount.sort
        [ baseTable, maxNum, matchingBaseNames, groupedCount ]
        
        # contigious
        
        
end

fields = ['id', 'age','sex','inc_1','inc_2','cons_1','cons_2', 'cons_3']

pkfields = [0]

pattern = '([a-z]+)_([0-9]+)'

out = renormalise( fields, pkfields, pattern )

p out