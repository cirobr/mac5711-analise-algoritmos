# setup
include("./partition-quicksort-randomized.jl")


# CLRS page 157
# theta(n) average case
function randomized_select(A::Vector, p::Int, r::Int, k::Int)
    if p == r                           # base da recursão
        res = A[p]
        return(res)
    end
    
    q = randomized_partition(A, p, r)
    l = q-p+1

    if k == l                           # k == q
        res = A[q]
        return(res)
    elseif k < l                        # k entre p:q-1
        res = randomized_select(A, p, q-1, k)
        return(res)
    elseif k > l                        # k entre q+1:r
        res = randomized_select(A, q+1, r, k-l)
        return(res)
    end
end
