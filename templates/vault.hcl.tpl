ui = ${ui}

listener "tcp" {
  address     = "${address}"
  cluster_address     = "${cluster_address}"
  tls_disable = %{ if tls }false%{ else }true%{ endif }
}

%{ if storage == "raft" }
storage "raft" {
  path    = "${raft_path}"
  node_id = "${raft_node_id}"
}
%{ endif }

%{ if storage == "file" }
storage "file" {
  path = "${file_path}"
}
%{ endif }

%{ if storage == "inmem" }
storage "inmem" {}
%{ endif }