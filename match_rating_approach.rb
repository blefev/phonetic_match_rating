Vowels = 'AEIOU'

def rate lengthSum
    if lengthSum <= 4
        5
    elsif lengthSum.between?(5, 7)
        4
    elsif lengthSum.between?(8, 11)
        3
    elsif lengthSum == 12
        2
    end
end

def encode string

    modified = 
        string
        .upcase
        .gsub(/(?!^.)([#{Vowels}])/, '') #remove vowels other than first
        .gsub(/(.)\1/,'\1') #remove second of double consonants

    l = modified.length

    if l > 6
        modified[0..2] + modified[l-3..l-1]
    else 
        modified
    end
end

def removeDups a, b
    a, b = [a, b].sort { |c,d| d.length <=> c.length }
    a.zip(b).delete_if {|el| el[0] == el[1]}
end

def compare a, b
    enca, encb = [a, b].map {|s| encode s}
    lena, lenb = [enca, encb].map {|s| s.length}

    return nil if (lena - lenb).abs > 3

    minRating = rate(lena + lenb)

    enca, encb = removeDups(enca.chars, encb.chars).transpose
    [enca, encb].each { |arr| arr.delete(nil) }

    if (enca and encb)
        enca, encb = removeDups(enca.reverse, encb.reverse).transpose
    else # no differing characters, it's a match
        return true
    end

    [enca, encb].each { |arr| arr.delete(nil) }

    longer = enca.length > encb.length ? enca : encb
    simRating = 6 - longer.length

    simRating >= minRating
end
