# setup
include("./misc.jl")


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
    if p < r                     # r-p+1 > 1
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
