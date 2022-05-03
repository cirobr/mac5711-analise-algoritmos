# CLRS page 12
# O(n^2), Omega(n), 
function insertion_sort(A::Vector)
    n = size(A)[1]                   # vector size
    for j in 2 : n                   # scan from 2nd:last element
        key = A[j]                   # store element in key
        i = j-1                      # reference to previous element
        while i >=1 && A[i] > key    # scan all previous
            A[i+1] = A[i]            # shift right if greater than key
            i -= 1
        end
        A[i+1] = key                 # insert key
    end
    return(A)
end
