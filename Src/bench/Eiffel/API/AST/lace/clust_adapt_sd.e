-- Cluster_adapt_clause    : /* empty */
--                         | Cluster_ignore
--                         | Cluster_rename_clause

deferred class CLUST_ADAPT_SD

inherit

	AST_LACE

feature

	cluster_name: ID_SD;
			-- Name of the cluster to adapt

	good_cluster: BOOLEAN is
			--- Check existence of cluster named `cluster_name'.
		local
			vd03: VD03;
			vd05: VD05;
			cluster: CLUSTER_I;
		do
			cluster := Universe.cluster_of_name (cluster_name);
			Result := True;
				-- Existence of cluster
			if cluster = Void then
				!!vd03;
				vd03.set_cluster_name (cluster_name);
				Error_handler.insert_error (vd03);
				Result := False;
			elseif cluster = context.current_cluster then
					-- Check if `cluster' is not the current analyzed one
				!!vd05;
				vd05.set_cluster_name (cluster_name);
				Error_handler.insert_error (vd05);
				Result := False;
			end;
		end;

end
