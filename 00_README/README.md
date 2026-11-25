# GEI1084 Mini-project 1 - TeamXX

## Project objective
L'objectif du projet était d'améliorer le processeur ARM construit depuis le début de la session. À la fin du laboratoire 4, Le processeur permettait les opérations de data processing,
d'écriture ou de lecture vers la mémoire et de branchement vers une autre instruction. Au courant du mini projet 1, il sera question d'ajouter 3 fonctionnalités au processeur : le CMP,
le BL et le SHIFT.

## Supported instruction subset
Avant l'ajout des modules du mini projet 1, le processeur est déjà en mesure d'effectuer les opérations suivantes : 
- ADD
- ADDS
- SUB
- SUBS
- AND
- ANDS
- ORR
- ORRS
- B
- STR
- LDR

## Known limitations
À notre connaissance, il n'y a pas de bug fonctionnel ou de limitations vis-à-vis l'objectif du projet.

## Repository structure
La structure choisie pour le dépôt est celle imposée par l'énoncé.

```text
GEI1084_MP1_Team03/
│
├── 00_README/
│   ├── README.md
│   ├── PROJECT_SCOPE.md
│   ├── SUBMISSION_INDEX.md
│   └── AI_USE_DECLARATION.md
│
├── 01_REPORT/
│   └── TeamXX_GE1084_MP1_FinalReport.pdf
│
├── 02_HDL/
│   ├── baseline_lab4/
│   ├── final_design/
│   └── optional_extensions/
│
├── 03_TESTBENCH/
│   ├── testbench/
│   ├── instructions/
│   ├── expected_results/
│   │   └── ExpectedResults.csv
│   └── regression/
│       └── RegressionSummary.csv
│
├── 04_RESULTS/
│   ├── CMP/
│   ├── SHIFT/
│   ├── BL/
│   ├── REGRESSION/
│   └── DEBUG_CASE/
│
├── 05_ARCHITECTURE/
│   ├── baseline_lab4/
│   ├── CMP/
│   ├── SHIFT/
│   ├── BL/
│   └── final_integrated/
│
├── 06_ENGINEERING_PRACTICE/
│   ├── E2_Team_Contribution/
│   ├── E3_Released_Defect/
│   ├── E4_Provenance_License/
│   ├── E5_FPGA_Risk/
│   ├── E6_Engineering_Economics/
│   └── E7_Autonomous_Research/
│
├── 07_PRESENTATION/
│   └── TeamXX_GE1084_MP1_Presentation.pdf
│
└── 08_GRADING_EVIDENCE/
    └── TeamXX_GE1084_MP1_EvidenceMap.pdf
```

## Tool environment
Les outils logiciels utilisés sont les suivants :
- Vivado 2022.2
- Github
- Git
- Word
- VS Code

## Compilation/build
Il n'était pas nécessaire d'effectuer la synthèse et l'implémentation pour monter notre projet sur FPGA.

## Simulation
La simulation est effectuée directement dans Vivado via l'onglet simulation. Des testbenches sont créés pour permettre les tests des différents modules implémentés.
Afin de tester un module isolé, il faut simplement choisir le fichier hdl et le testbench choisis et les sélectionner en tant que top.

## Regression
Chaque test s'assure que ce qui fonctionnait avant fonctionne encore. Les testbenches s'assurent de tester les fonctionnalités qui pourraient être affectées en plus de celles ajoutées.

## Expected success criterion
Des vecteurs de tests étaient fournis avec les laboratoires 1 à 4. D'autres vecteurs ont été ajoutés pour tester les nouveaux modules. Chaque testbench comprend une vérification entre la valeur obtenue et la valeur attendue, qui témoigne du fonctionnement du module. Des assert sont aussi implémentés pour écrire dans la console le résultat des comparaisons.

## References and provenance
Le projet original jusqu'au laboratoire 4 appartient à Alexandre Bourque. Les modifications effectuées au projet de base proviennent toutes des membres de l'équipe.

## Submission mode / Mode de remise
La soumission du projet sera faite via le repository github https://github.com/PhasePat/GEI1084_MP1_Team03. 

Submit both the complete `GEI1084_MP1_TeamXX.zip` archive and an accessible Git repository URL. Both must correspond to the same final commit/tag recorded in `SUBMISSION_INDEX.md`.

Remettre à la fois l'archive complète `GEI1084_MP1_TeamXX.zip` et une URL Git accessible. Les deux doivent correspondre au même commit/tag final consigné dans `SUBMISSION_INDEX.md`.

## Generative AI / IAg - UQTR Level 1

Complete `AI_USE_DECLARATION.md`. AI may be used before production for understanding, retention, or the research process. AI-generated or AI-revised submitted production is not permitted.

Compléter `AI_USE_DECLARATION.md`. L'IAg peut être utilisée avant la production pour la compréhension, la rétention ou la démarche de recherche. La génération ou la révision par IAg de la production remise n'est pas permise.
