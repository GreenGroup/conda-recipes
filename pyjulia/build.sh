julia -e "using Pkg; Pkg.add(\"PyCall\"); pypath =\"`which python`\"; ENV[\"CONDA_JL_HOME\"] = join(split(pypath,\"/\")[1:end-2],\"/\"); ENV[\"PYTHON\"] = pypath; Pkg.build(\"PyCall\"); using PyCall"
python -m pip install --no-deps --ignore-installed .
