project(
  'fooname',
  'c', 'cpp',
  version : run_command('cat', meson.project_source_root() / 'VERSION', check: true).stdout().strip(),
  # license: 'MIT',
  default_options : [
    'warning_level=3',
  ],
)

cc = meson.get_compiler('c')
cpp = meson.get_compiler('cpp')

common_opts = ['-Wconversion', '-Wsign-conversion', '-Wpedantic']
c_opts      = ['-std=c23']
cpp_opts    = ['-std=c++23', '-Wshadow', '-Wnon-virtual-dtor']

if get_option('buildtype').startswith('debug')
  if cc.get_id() == 'clang-cl'
    add_project_arguments(['/clang:-Og', '-DDEBUG'], language: ['c', 'cpp'])
  else
    add_project_arguments(['-Og', '-DDEBUG'], language: ['c', 'cpp'])
  endif
endif

add_project_arguments('-DPROG_VERSION="' + meson.project_version() + '"', language: ['c', 'cpp'])

add_project_arguments(['-Wconversion', '-Wsign-conversion', '-Wpedantic'], language: ['c', 'cpp'])
add_project_arguments(['-Wshadow', '-Wnon-virtual-dtor'], language: 'cpp')

if cc.get_id() == 'clang-cl'
  clang_cl_common = []
  clang_cl_c = []
  clang_cl_cpp = []
  foreach w : common_opts
    clang_cl_common += '/clang:' + w
  endforeach
  foreach w : c_opts
    clang_cl_c += '/clang:' + w
  endforeach
  foreach w : cpp_opts
    clang_cl_cpp += '/clang:' + w
  endforeach
  add_project_arguments(cc.get_supported_arguments(clang_cl_common), language: ['c', 'cpp'])
  add_project_arguments(cc.get_supported_arguments(clang_cl_c), language: ['c'])
  add_project_arguments(cpp.get_supported_arguments(clang_cl_cpp), language: 'cpp')
else
  add_project_arguments(cc.get_supported_arguments(common_opts), language: ['c', 'cpp'])
  add_project_arguments(cc.get_supported_arguments(c_opts), language: ['c'])
  add_project_arguments(cpp.get_supported_arguments(cpp_opts), language: 'cpp')
endif

src = [ ]
includes = [ ]
dependencies = [ ]

subdir('src')

executable(
  'fooname',
  src,
  include_directories : includes,
  dependencies : dependencies,
  install : true,
)
