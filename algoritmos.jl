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
function minVec(A::Vector)   # Float necessário para comparação com Inf
    m = Inf
    n = size(A)[1]

    for i in 1:n
        if A[i] < m
            m = A[i]
        end
    end
    return( Int(m) )
end


# theta(n)
function maxVec(A::Vector)
    m = 0
    n = size(A)[1]

    for i in 1:n
        if A[i] > m
            m = A[i]
        end
    end
    return( m )
end


# theta(n), se for uma varredura com for
function findInVector(A::Vector, p::Int, r::Int, x::Int)
    x = findfirst(y -> y==x, A[p:r])
    x = x+p-1
end


function medians(p::Int, r::Int)
    (floor(Int, (p+r)/2), ceil(Int, (p+r)/2))
end


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


# CLRS page 124
# theta(n)
function partition(A::Vector, p::Int, r::Int)
    x = A[r]                # x é o pivô, último elemento entre p:r
    i = p-1                 # i inicializa como imediatemente anterior a p
    for j in p : r-1        # varredura entre p até antes do pivô
        if A[j] <= x        # compara A[j] com o pivô
            i += 1          # avança i, evita problema com inicialização i=0 (quando p=1)
            swap(A, i, j)   # A[i] <-> A[j]
        end
    end
    swap(A, i+1, r)         # A[i+1] <-> A[r]   swap do pivô, que não entrou no loop for

    return(i+1)
end


# CLRS page 123
# T(n) = T(k) + T(n-k+1) + theta(n);   n = r-p+1
# pior caso theta(n^2)           k=0 ou k=n em todas as recursões;   pior caso, árvore desbalanceada
# melhor caso theta(n lg(n))     k=n/2;                              melhor caso, árvore balanceada
function quicksort(A::Vector, p::Int, r::Int)
    if p < r
        q = partition(A, p, r)   # divide o vetor, elementos à esquerda são menores que A[q], à direita são maiores
        quicksort(A, p, q-1)     # processa a parte esquerda, sem o pivô
        quicksort(A, q+1, r)     # processa a parte direita, sem o pivô
    end
end


# CLRS page 130
function randomized_partition(A::Vector, p::Int, r::Int)
    i = rand(p:r)            # sorteia elemento i entre p:r
    swap(A, r, i)            # A[r] <-> A[i]
    partition(A, p, r)       # retorna o pivô q
end


# CLRS page 130
function randomized_quicksort(A::Vector, p::Int, r::Int)
    if p < r
        q = randomized_partition(A, p, r)   # versão randomizada
        randomized_quicksort(A, p, q-1)     # recursão antes do pivô
        randomized_quicksort(A, q+1, r)     # recursão após o pivô
    end
end


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
