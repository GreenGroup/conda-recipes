python -m pip install --no-deps --ignore-installed .

#set JULIA_DEPOT_PATH in conda env
export JULIA_DEPOT_PATH="${PREFIX}/share/julia/site:$JULIA_DEPOT_PATH"
ACTIVATE_ENV="${PREFIX}/etc/conda/activate.d/env_vars.sh"
DEACTIVATE_ENV="${PREFIX}/etc/conda/deactivate.d/env_vars.sh"
if [ -f "$ACTIVATE_ENV" ]; then
        echo "export JULIA_DEPOT_PATH=\"${PREFIX}/share/julia/site:\$JULIA_DEPOT_PATH\"" >> "$ACTIVATE_ENV"
else
        mkdir -p ${PREFIX}/etc/conda/activate.d
        touch ${PREFIX}/etc/conda/activate.d/env_vars.sh
        echo '#!/bin/sh' >> $ACTIVATE_ENV
        echo "export JULIA_DEPOT_PATH=\"${PREFIX}/share/julia/site:\$JULIA_DEPOT_PATH\"" >> "$ACTIVATE_ENV"
fi
if [ -f "$DEACTIVATE_ENV" ]; then
        echo "unset JULIA_DEPOT_PATH" >> "$DEACTIVATE_ENV"
else
        mkdir -p ${PREFIX}/etc/conda/deactivate.d
        touch ${PREFIX}/etc/conda/deactivate.d/env_vars.sh
        echo '#!/bin/sh' >> "$DEACTIVATE_ENV"
        echo "unset JULIA_DEPOT_PATH" >> "$DEACTIVATE_ENV"
fi

mkdir $PREFIX/share/julia/site
mkdir $PREFIX/share/julia/site/registries 
mkdir $PREFIX/share/julia/site/registries/General
git clone https://github.com/JuliaRegistries/General.git $PREFIX/share/julia/site/registries/General

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
