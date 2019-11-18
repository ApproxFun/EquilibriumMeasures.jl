using OrthogonalPolynomialsQuasi, ContinuumArrays, IntervalSets, FillArrays

using ForwardDiff
Base.floatmin(::Type{<:ForwardDiff.Dual}) = floatmin(Float64)

a = ForwardDiff.Dual(sqrt(2),1)
Ta = (V,a) -> begin
    w, U = UltrasphericalWeight{typeof(a)}(1), Ultraspherical{typeof(a)}(1)
    x = Inclusion(-a..a)
    H = inv.(x .- x')
    # basis on -a..a
    T = Chebyshev{typeof(a)}()[x/a,:]
    wU = (w .* U)[x/a,:] 
    # Hilbert
    Hd = (T \ (H*wU))[2:end,:]
    Vf = T*(T\V.(x))
    Vp = diff(Vf)
    w = wU * (Hd \ (T \ Vp)[2:end])
end

V = x -> x^2
@time ForwardDiff.partials(sum(Ta(V, ForwardDiff.Dual(2.0,1)))/2)[1]
Sx = x -> sum(Ta(V,x))/2
@time ForwardDiff.derivative(Sx, 2.0)
sum(w)/2

equilibriummeasure(x -> log.(abs.(x .- x')))
equilibriummeasure(x -> abs.(x .- x').^α)

using ForwardDiff


T = Chebyshev()
U = Ultraspherical(1) 
x = axes(T,1)
V = x.^2
H = inv.(x .- x')
wU = UltrasphericalWeight(1) .* Ultraspherical(1)



sum(w)







Ta = a -> begin
    x = Inclusion(-a..a)
    H = inv.(x .- x')
    T = Chebyshev{typeof(a)}()[x/a,:]
    Tn = Chebyshev{typeof(a)}()[x/a,2:5]
    wU = (w .* U)[x/a,:]
    (T \ (H*wU))[2,1] \ (Tn \ x)[1]
end

N = a -> Ta(a)[1] - sqrt(2)/π


ForwardDiff.derivative(N,1.4)

N(1.4+0.00001)-N(1.4)


Tn = Chebyshev()[x/sqrt(2),2:5]



using Plots
g = range(-1.4,1.4; length = 100)
plot(g, Ta(1.4)[g])






Vp = T * [Tn \ (2x); zeros(∞)]





(Tn * (Tn \ x))[0.1]


T = Chebyshev()
x = axes(T,1)
T[:,1:2] \ x



# need to add transforms to OrthogonalPolynomialsQuasi
g = range(-sqrt(2),sqrt(2); length=3)
Vf = x -> x^2
V = T * [T[g,1:3] \ Vf.(g); zeros(∞)]
D = Derivative(x)
(U[x/sqrt(2),:] \ T) \  (U[x/sqrt(2),:] \ (D*V))

grid(Chebyshev())

x.^2
findfirst(isequal(0.1),2x)
2x

x = axes(U,1)


(H*wU)


using EquilibriumMeasures, ApproxFun, Plots




μ = equilibriummeasure(x -> x^2)
equilibriummeasure(x -> x, 0..1; bounded=:right)
plot(μ)
