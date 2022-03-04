module Z3
  class BoolSort
    @@sort = LibZ3.mk_bool_sort(API::Context)
  end
end
