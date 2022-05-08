# CLRS page 141
# stable algorithm
# theta(k + n)
function counting_sort(A::Vector{Int}, k::Int)  # k = max(A)
    n = size(A)[1]
    B = zeros(Int, n)                           # vetor ordenado
    C = zeros(Int, k)                           # vetor auxiliar de contagem
    for j in 1:n   C[ A[j] ] += 1   end         # vetor ordenado instável sai daqui

    # etapa de estabilidade
    for i in 2:k   C[i] = C[i] + C[i-1]   end
    for j in n : -1 : 1
        B[ C[ A[j] ] ] = A[j]                   # popular vetor ordenado estável
        C[ A[j] ]      = C[ A[j] ] - 1
    end
    
    return B
end


# counting sort com saída adicional do vetor de ranking R
function rank_counting_sort(A::Vector{Int}, k::Int)  # k = max(A)
    n = size(A)[1]
    B = zeros(Int, n)                           # vetor ordenado
    C = zeros(Int, k)                           # vetor auxiliar de contagem
    R = zeros(Int, n)                           # (add) vetor de ranking de ordenação
    for j in 1:n   C[ A[j] ] += 1   end         # vetor ordenado instável sai daqui

    # etapa de estabilidade
    for i in 2:k   C[i] = C[i] + C[i-1]   end
    for j in n : -1 : 1
        R[j]           = C[ A[j] ]              # (add) popular vetor de ranking
        B[ C[ A[j] ] ] = A[j]                   # popular vetor ordenado estável
        C[ A[j] ]      = C[ A[j] ] - 1
    end
    
    return (B, R)   # saída adicional vetor R
end