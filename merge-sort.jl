# CLRS page 22
# theta (n)
function merge(A::Vector{Float32}, p::Int, q::Int, r::Int)
    n1 = q - p + 1
    n2 = r - q                                 # r - (q+1) +1

    L = [ A[p + i-1] for i in 1:n1 ]
    R = [ A[q + j]   for j in 1:n2 ]           # (q+1) + (i-1)
    push!(L, Inf)                              # sentinel to avoid comparison
    push!(R, Inf)

    i = 1
    j = 1
    for k in p:r
        if L[i] <= R[j]
            A[k] = L[i]
            i += 1
        else
            A[k] = R[j]
            j += 1
        end
    end
end


# CLRS page 24
# T(n) = 2*T(n/2) + theta(n)
# theta(n lg(n))
function merge_sort(A::Vector{Float32}, p::Int, r::Int)
    if p < r   # == (r-p+1) > 1
        q = floor( Int, (p+r)/2 )   # mid point q = p + (r-p+1)/2 ~ (p+r)/2
        merge_sort(A, p, q)
        merge_sort(A, q+1, r)
        merge(A, p, q, r)
    end
end
