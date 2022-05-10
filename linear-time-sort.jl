# CLRS page 141
# stable algorithm
# theta(k + n)
function counting_sort(A::Vector{Int}, n::Int, k::Int)  # k = max(A)
    B = zeros(Int, n)                                   # vetor ordenado
    C = zeros(Int, k)                                   # vetor auxiliar de contagem
    for j in 1:n   C[ A[j] ] += 1   end                 # vetor ordenado instável sai daqui

    # etapa de estabilidade
    for i in 2:k   C[i] = C[i] + C[i-1]   end
    for j in n : -1 : 1
        B[ C[ A[j] ] ] = A[j]                           # popular vetor ordenado estável
        C[ A[j] ]      = C[ A[j] ] - 1
    end
    
    return B
end


# counting sort com saída adicional do vetor de ranking R
function rank_counting_sort(A::Vector{Int}, n::Int, k::Int)  # k = max(A)
    B = zeros(Int, n)                                        # vetor ordenado
    C = zeros(Int, k)                                        # vetor auxiliar de contagem
    R = zeros(Int, n)                                        # (add) vetor de ranking de ordenação
    for j in 1:n   C[ A[j] ] += 1   end                      # vetor ordenado instável sai daqui

    # etapa de estabilidade
    for i in 2:k   C[i] = C[i] + C[i-1]   end
    for j in n : -1 : 1
        R[j]           = C[ A[j] ]                           # (add) popular vetor de ranking
        B[ C[ A[j] ] ] = A[j]                                # popular vetor ordenado estável
        C[ A[j] ]      = C[ A[j] ] - 1
    end
    
    return (B, R)                                             # saída adicional vetor R
end


# aux radix_sort
# extrai o i-ésimo dígito de cada elemento de A
function extractDigit(A::Vector{Int}, n::Int, i::Int)
    L = digits.(A)              # elementos de A decompostos (1, 10, 100...)
    S = size.(L)                # qtd de dígitos de cada elemento de A
    D = zeros(Int, n)           # vetor dos i-ésimos dígitos

    for j in 1:n
        if i <= S[j][1]
            D[j] = L[j][i]
        else
            D[j] = 0
        end
    end

    return D
end


# aux radix_sort
function ordene(A::Vector{Int}, n::Int, i::Int)
    B = zeros(Int, n)                  # vetor de saída
    D = extractDigit(A, n, i)
    D = D .+ 1                         # ajustar range de 0:9 para 1:10

    _, R = rank_counting_sort(D, 10)

    for j in 1:n
        B[ R[j] ] = A[j]
    end

    return B
end


function radix_sort(A::Vector{Int}, n::Int, d::Int)
    B = copy(A)
    for i in 1:d
        B = ordene(B, n, i)
    end

    return B
end