# Commands to add assembly
jbrowse add-assembly "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/Bar2_p4/Bar2_p4.fa" -a "Bar2_p4" -n "Bar2_p4" -t indexedFasta \
    --faiLocation "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/Bar2_p4/Bar2_p4.fa.fai" --displayName "Oikopleura dioica Barcelona (Bar2_p4)"

jbrowse add-assembly "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OKI.I69/OKI.I69.fa" -a "OKI.I69" -n "OKI.I69" -t indexedFasta \
    --faiLocation "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OKI.I69/OKI.I69.fa.fai" --displayName "Oikopleura dioica Okinawa (OKI2018_I69)"

jbrowse add-assembly "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/OSKA2016v1.9.fa" -a "OSKA2016v1.9" -n "OSKA2016v1.9" -t indexedFasta \
    --faiLocation "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/OSKA2016v1.9.fa.fai" --displayName "Oikopleura dioica Osaka (OSKA2016v1.9)"

jbrowse add-assembly "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OdB3/Oidioi_genome.fasta" -a "OdB3" -n "OdB3" -t indexedFasta \
    --faiLocation "https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OdB3/Oidioi_genome.fasta.fai" --displayName "Oikopleura dioica Norway (OdB3)"

# Add only the newest gene models
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/Bar2_p4/v4.2/Bar2_p4_v4.2.gff3 -a Bar2_p4 -n Bar2_p4_v4.2.gff3 --category "annotation" -d "AUGUSTUS annotation + liftoff + CAGE UTR + eggnog gene names"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OKI.I69/v2.2/OKI.I69_v2.2.gff3 -a OKI.I69 -n OKI.I69_v2.2.gff3 --category "annotation" -d "AUGUSTUS annotation + CAGE UTR + eggnog gene names"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/v2.2/OSKA2016v1.9_v2.2.gff3 -a OSKA2016v1.9 -n OSKA2016v1.9_v2.2.gff3 --category "annotation" -d "AUGUSTUS annotation + CAGE UTR + eggnog gene names"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OdB3/Oidioi_genome.gff3 -a OdB3 -n Oidioi_genome.gff3 --category "annotation" -d "Taken from oikobase"

# liftoff from Norway
jbrowse add-track https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/Bar2_p4/resources/liftoff/norway_to_bar_gene_models_polished.gff3 -a Bar2_p4 --category "liftoff" -d "Liftoff from norway"
jbrowse add-track https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OKI.I69/resources/liftoff/norway_to_oki_gene_models_polished.gff3 -a OKI.I69 --category "liftoff" -d "Liftoff from norway"
jbrowse add-track https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/resources/liftoff/norway_to_osa_gene_models_polished.gff3 -a OSKA2016v1.9 --category "liftoff" -d "Liftoff from norway"

# conservation track
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/resources/conservation_track/oiko_4_sp.bw -a OSKA2016v1.9 --trackId "phylop4sp_osa" --category "PhyloP Scores" -d "PhyloP score computed from the multiple alignment of 4 O. dioica species (Norway, Barcelona, Osaka, Okinawa) using cactus"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OKI.I69/resources/conservation_track/oiko_4_sp.bw -a OKI.I69 --trackId "phylop4sp_oki" --category "PhyloP Scores" -d "PhyloP score computed from the multiple alignment of 4 O. dioica species (Norway, Barcelona, Osaka, Okinawa) using cactus"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/Bar2_p4/resources/conservation_track/oiko_4_sp.bw -a Bar2_p4 --trackId "phylop4sp_bar" --category "PhyloP Scores" -d "PhyloP score computed from the multiple alignment of 4 O. dioica species (Norway, Barcelona, Osaka, Okinawa) using cactus"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OdB3/resources/conservation_track/oiko_4_sp.bw -a OdB3 --trackId "phylop4sp_nor" --category "PhyloP Scores" -d "PhyloP score computed from the multiple alignment of 4 O. dioica species (Norway, Barcelona, Osaka, Okinawa) using cactus"

# synteny tracks
jbrowse add-track https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/resources/synteny/Bar2_p4.chain -t SyntenyTrack -a OSKA2016v1.9,Bar2_p4 --trackId="OSA_BAR_synteny" --category "Synteny" -d "Synteny track of Bar2_p4 mapped to OSKA2016v1.9"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/Bar2_p4/resources/synteny/OSKA2016v1.9.chain -t SyntenyTrack -a Bar2_p4,OSKA2016v1.9 --trackId="BAR_OSA_synteny" --category "Synteny" -d "Synteny track of OSKA2016v1.9 mapped to Bar2_p4"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OKI.I69/resources/synteny/OSKA2016v1.9.chain -t SyntenyTrack -a OKI.I69,OSKA2016v1.9 --trackId="OKI_OSA_synteny" --category "Synteny" -d "Synteny track of OSKA2016v1.9 mapped to OKI.I69"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/resources/synteny/OKI2018_I69_1.0.chain -t SyntenyTrack -a OSKA2016v1.9,OKI.I69 --trackId="OSA_OKI_synteny" --category "Synteny" -d "Synteny track of OKI.I69 mapped to OSKA2016v1.9"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/Bar2_p4/resources/synteny/OKI2018_I69_1.0.chain -t SyntenyTrack -a Bar2_p4,OKI.I69 --trackId="BAR_OKI_synteny" --category "Synteny" -d "Synteny track of OKI.I69 mapped to Bar2_p4"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OKI.I69/resources/synteny/Bar2_p4.chain -t SyntenyTrack -a OKI.I69,Bar2_p4 --trackId="OKI_BAR_synteny" --category "Synteny" -d "Synteny track of Bar2_p4 mapped to OKI.I69"
jbrowse add-track https://raw.githubusercontent.com/oist//Oikopleuradioica_genomeannotation/main/OSKA2016v1.9/resources/synteny/OdB3.chain -t SyntenyTrack -a OdB3,Bar2_p4 --trackId="NOR_BAR_synteny" --category "Synteny" -d "Synteny track of OdB3 mapped to OSKA2016v1.9"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/Bar2_p4/resources/synteny/OdB3.chain -t SyntenyTrack -a OdB3,OSKA2016v1.9 --trackId="NOR_OSA_synteny" --category "Synteny" -d "Synteny track of OdB3 mapped to Bar2_p4"
jbrowse add-track https://raw.githubusercontent.com/oist/Oikopleuradioica_genomeannotation/main/OKI.I69/resources/synteny/OdB3.chain -t SyntenyTrack -a OdB3,OSKA2016v1.9 --trackId="NOR_OSA_synteny" --category "Synteny" -d "Synteny track of OdB3 mapped to OKI.I69"


# CAGE data
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2021-12-17_Okinawa_Oik/CrossAlignments/consensus_clusters_no_OKItoOKI.bed -a OKI.I69 -d "Consensus promoter CAGE peaks" --category "CAGE peaks"
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2021-12-17_Okinawa_Oik/CrossAlignments/consensus_clusters_sl_OKItoOKI.bed -a OKI.I69 -d "Consensus trans-splicing CAGE peaks" --category "CAGE peaks"
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2022-11-09_Barcelona_Oik/CrossAlignments/consensus_clusters_no_BARtoBAR.bed -a Bar2_p4 -d "Consensus promoter CAGE peaks" --category "CAGE peaks"
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2022-11-09_Barcelona_Oik/CrossAlignments/consensus_clusters_sl_BARtoBAR.bed -a Bar2_p4 -d "Consensus trans-splicing CAGE peaks" --category "CAGE peaks"
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2022-02-09_Osaka_Oik/CrossAlignments/consensus_clusters_no_OSAtoOSA.bed -a OSKA2016v1.9 -d "Consensus promoter CAGE peaks" --category "CAGE peaks"
jbrowse add-track https://raw.githubusercontent.com/oist/LuscombeU-CAGE_libraries/main/2022-02-09_Osaka_Oik/CrossAlignments/consensus_clusters_sl_OSAtoOSA.bed -a OSKA2016v1.9 -d "Consensus trans-splicing CAGE peaks" --category "CAGE peaks"

# index text
jbrowse text-index --attributes="Name,ID,gene_name" --force