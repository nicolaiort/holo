pkgwhich() {
   local cmd="$1"
   local path
   path=$(which "$cmd" 2>/dev/null)
   
   if [ -z "$path" ]; then
     echo "Command not found: $cmd"
     return 1
   fi
   
   if yay -Qo "$path" &>/dev/null; then
     local pkg
     pkg=$(yay -Qo "$path" | awk '{print $5}')
     echo "Yay: $pkg"
     echo "Install/Update: yay -S $pkg"
   elif [[ "$path" == *"homebrew"* ]] || brew list --versions "${cmd##*/}" &>/dev/null; then
     echo "Homebrew: ${cmd##*/}"
     echo "Install/Update: brew install $cmd"
   elif [[ "$path" == *".bun"* ]] || [[ "$path" == *"bun"* ]]; then
     local bun_pkg
     bun_pkg=$(echo "$path" | awk -F'/' '{for(i=1;i<=NF;i++) if($i=="global" && $(i+1)=="node_modules") print $(i+2)}')
     if [ -n "$bun_pkg" ]; then
       echo "Bun: $bun_pkg"
     else
       echo "Bun (built-in)"
     fi
     echo "Install/Update: bun add -g $bun_pkg"
   else
     echo "Unknown/Not installed via package manager"
   fi
 }
