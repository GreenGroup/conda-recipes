python -m pip install --no-deps --ignore-installed .
julia -e "using Pkg; ENV[\"PYTHON\"]=string(ENV[\"PREFIX\"],\"/bin/python\"); println(ENV[\"PYTHON\"]); Pkg.build(\"PyCall\");"
python -c "import julia; julia.install()"

var=$(awk 'FNR==1{print $0 "3";}' $(which python-jl))
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then
    sed -i 's|bin/python|bin/python3|g' $(which python-jl)
    #sed -i "1s|.*|$var|" $(which python-jl) #append 3 so python-jl works after linking
elif [[ "$unamestr" == "Darwin" ]]; then
    sed -i ".bak" 's|bin/python|bin/python3|g' $(which python-jl)
    #sed -i ".bak" "1s|.*|$var|" $(which python-jl) #append 3 so python-jl works after linking
fi
