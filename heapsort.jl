# nó pai de um dado nó i
parentNode(i) = floor(Int, i/2)


# CLRS page 112 (desce_heap)
# assegura a propriedade de heap a partir do nó i inclusive
# T(h) <= T(h-1) + theta(1)
# T(h) = O(h) ~ O( lg(n) )
function max_heapify(A::Vector, n::Int, i::Int)
    # println(A)
    e = 2i
    d = 2i+1
    maior = ( ( e <= n && A[e] > A[i] ) ? e : i )
    if ( d <= n ) && ( A[d] > A[maior] )   maior = d   end
    if maior != i
        swap(A, i, maior)
        max_heapify(A, n, maior)
    end
end


# CLRS page 114
# constrói heap a partir de entrada não ordenada
# O(n)
function build_max_heap(A::Vector, n::Int)
    med = medians(1, n)[1]   # floor n/2
    for i in med : -1 : 1
        max_heapify(A, n, i)
    end
end


# Algoritmo de ordenação por heap, CLRS pag 116
# ordenação crescente
# O(n lg(n))
function heapsort(A::Vector, n::Int)
    build_max_heap(A, n)              # pré-processamento: cria um max heap
    heapsize = copy(n)                # controle de processamento dos elementos do heap
    for i in n : -1 : 2    
        swap(A, 1, i)                 # max_heap = último elemento da lista
        heapsize -= 1
        max_heapify(A, heapsize, 1)   # heap desfeito pelo swap, então refaz o heap entre 1 : heapSize
    end
end


# informa o maior valor dentre os elementos do heap
# theta(1)
heap_maximum(A::Vector) = A[1]


# extrai o valor max e refaz o heap
# O(lg n)
function heap_extract_max(A::Vector, heapsize::Int)
    if heapsize < 1   return("heap underflow")   end
    max = A[1]
    A[1] = A[heapsize]            # último elemento ocupa o topo do heap
    heapsize -= 1
    max_heapify(A, heapsize, 1)   # refaz o heap desde o topo até heapsize
    
    return(max, heapsize)
end


# Substitui o valor de A[i] por k, desde que k seja > A[i]
# O(lg n)
function heap_increase_key(A::Vector, i::Int, k::Int)
    if k < A[i]   return("new key smaller than current key")   end
    A[i] = k
    while i > 1 && A[parentNode(i)] < A[i]   # refaz o heap recolocando k para um local acima na árvore
        swap( A, i, parentNode(i) )
        i = copy( parentNode(i) )
    end
end


# insere o valor k no heap A
# O(lg n)
function max_heap_insert(A::Vector{Float32}, heapsize::Int, k::Int)
    heapsize += 1
    if heapsize <= size(A)[1]
        A[heapsize] = -Inf   # necessário A::Float32
    else
        push!(A, -Inf)
    end
    heap_increase_key(A, heapsize, k)
    
    return(heapsize)
end