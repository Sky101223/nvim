_G.Sky = _G.Sky or {}

Sky.snippets = {
  cpp = {
    cmaina = [[int main(int argc, char* argv[]) {
  ${1:// do something...}
}]],

    cmain = [[int main() {
  ${1:// do something...}
}]],

    cfori = [[for (${1:init-statement}; ${2:condition }; ${3:expression }) {
  ${4:statement};
}]],

    cforr = [[for (${1:init-statement} : ${2:range-initializer}) {
  ${3:statement};
}]],

    cif = [[if (${1:condition}) {
  ${2:statement}
}]],

    cife = [[if (${1:condition}) {
  ${2:statement}
} else {
  ${3:statement}
}]],

    celif = [[if (${1:condition}) {
  ${2:statement}
} else if (${2:condition}) {
  ${4:statement}
}]],

    cwhile = [[while (${1:condition}) {
  ${2:statement}
}]],

    cdowhile = [[do {
  ${2:statement}
} while (${1:condition})]],

    cswitch = [[switch (${1:condition}) {
  case ${2:constant-expression}:
    ${3:statement}
  default:
    ${4:statement}
}]],

    ccase = [[case ${1:condition-expression}:
  ${2:statement}]],

    cstruct = [[struct ${1:name} {
  ${2:statement}
};]],

    cclass = [[class ${1:name} {
public:
private:
};]],

    clambda = [[[${1: }](${2:init-statement}) {
  ${3:statement}
};]],

    cpragma = [[#pragma ${1:pragma-params}]],

    cdefine = [[#define ${1:identifier} ${2:replacement-list}]],

    ccout = [[std::cout << ${1:message} << '\n';]],
  },
}
