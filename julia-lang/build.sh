#!/bin/sh

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

julia -e "println(Base.DEPOT_PATH)"
