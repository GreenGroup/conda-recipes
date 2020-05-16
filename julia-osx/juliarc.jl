JULIA_PREFIX = abspath(joinpath(Base.source_path(), "..", "..", ".."))

if !("JULIA_DEPOT_PATH" in keys(ENV))
    ENV["JULIA_DEPOT_PATH"] = [joinpath(JULIA_PREFIX, "share", "julia", "site")]
end
