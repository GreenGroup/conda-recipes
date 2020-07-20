export LDFLAGS="-headerpad_max_install_names"
python -m pip install --no-deps --ignore-installed .
#julia -e "using Pkg; Pkg.add(\"SpecialFunctions\"); Pkg.build(\"SpecialFunctions\")"
#python -c "import diffeqpy; diffeqpy.install();"
