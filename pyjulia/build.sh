python -m pip install --no-deps --ignore-installed .

#python -c "import julia; julia.install()"

#rm -rf $PREFIX/share/julia/site/compiled/*
# var="const ROOTENV = \"${PREFIX}\""
# 
# unamestr=$(uname)
# if [[ "$unamestr" == "Linux" ]]; then
#     sed -i 's|bin/python|bin/python3|g' $(which python-jl) #use python3 rather than python so python-jl works after linking
#    for d in ${PREFIX}/share/julia/site/packages/Conda/*/ ; do
#        sed -i "1s/.*/$var/" ${d}/deps/deps.jl
#     done
# elif [[ "$unamestr" == "Darwin" ]]; then
#     sed -i ".bak" 's|bin/python|bin/python3|g' $(which python-jl) #use python3 rather than python so python-jl works after linking
#     for d in ${PREFIX}/share/julia/site/packages/Conda/*/ ; do
#        echo $d
#        sed -i ".bak" "1s|.*|$var|" ${d}/deps/deps.jl
#     done
# fi

#echo $(which python-jl)
#echo $(which python)
#ln -sfn $(which python-jl) $(which python)
#python-jl -c "from julia import Main"
#python -c "from julia import Main"
