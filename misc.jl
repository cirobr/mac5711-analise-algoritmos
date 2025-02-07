# A[i] <-> A[j]
# theta(3)
function swap(A::Vector, i::Int, j::Int)
    temp = A[i]
    A[i] = A[j]
    A[j] = temp
end


# mínimo entre a e b
function min2(a::Int, b::Int)
    a < b ? a : b
end


# máximo entre a e b
function max2(a::Int, b::Int)
    a > b ? a : b
end


# theta(n)
# retorna o índice do menor valor de A
function minVec(A::Vector{Float32}, n)   # Float necessário para comparação com Inf
    m = Inf
    for i in 1:n
        if A[i] < m
            m = A[i]
        end
    end
    return( Int(m) )
end


# theta(n)
# retorna o índice do maior valor de A
function maxVec(A::Vector, n::Int)
    m = 0
    for i in 1:n
        if A[i] > m
            m = A[i]
        end
    end
    return( m )
end


# theta(n)
function findInVector(A::Vector, p::Int, r::Int, x::Int)
    ind = -1
    for i in p:r
        if x == A[i]
            ind = i
            break
        end
    end
    return(ind)
end


function medians(p::Int, r::Int)
    (floor(Int, (p+r)/2), ceil(Int, (p+r)/2))
end
