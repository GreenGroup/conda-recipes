python -m pip install --no-deps --ignore-installed .
python -c "import julia; julia.install();"
var=$(awk 'FNR==1{print $0 "3";}' $(which python-jl))
sed -i ".bak" "1s|.*|$var|" $(which python-jl) #append 3 so python-jl works after linking
