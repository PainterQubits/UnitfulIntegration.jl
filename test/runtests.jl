using UnitfulIntegration, Test, QuadGK, Unitful


@testset "quad" begin
    f(x) = x^2
    res = quadgk(f, 1u"m", 2u"m")[1]
    @test isapprox(res, 7//3 *u"m^3")
end

