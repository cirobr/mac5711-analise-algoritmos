# CLRS page 141
# stable algorithm
# O(n)
function counting_sort(A::Vector{Int}, k::Int)
    n = size(A)[1]
    B = zeros(Int, n)
    C = zeros(Int, k)
    for j in 1:n   C[A[j]] += 1   end
    for i in 2:k   C[i] = C[i] + C[i-1]   end
    for j in n : -1 : 1
        B[ C[ A[j] ] ] = A[j]
        C[ A[j] ]      = C[ A[j] ] - 1
    end
    
    return B
end
