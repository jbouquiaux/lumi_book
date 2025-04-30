---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.10.3
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

# IFCs embedding, theory


In the computation of the partial Huang-Rhys factors, one would like to obtain the phonons in very large supercells at wave vector $\mathbf{q}\rightarrow(0,0,0)$ ($\Gamma$ point), so that the coupling with long-wavelength phonons is correctly captured. One would also like to include the coupling with (localized) phonons modes introduced by the defect.
A direct approach, either with DFPT or finite difference, is not computationally attractive. Indeed, DFPT is best used for small pristine primitive cells at dense $\mathbf{q}$-mesh (which corresponds to large pristine supercells after a folding procedure), while finite difference, for which the introduction of defect does not cause problem,  remains costly for large supercells. One way to include both the defect effect (local modes) while converging long-wavelength phonons is to employ the IFCs embedding approach {cite}`shi2012ab,alkauskas2014,razinkovas2021vibrational,londero2018vibrational,jin2021photoluminescence`.


```{figure} images/emb_approach.pdf
---
height: 300px
name: emb_approach
---
Schematic view of the interatomic force constants (IFC) embedding approach to obtain defect phonons in large supercells. Each arrow represents an IFC between a pair of two atoms. See text for details.
```

The procedure, illustrated in figure {numref}`emb_approach`, is as follows:

First, the real-space interatomic force constants (IFCs) of the defect system, denoted as $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{defect}}$, are computed within a relatively small supercell (typically with a few hundred atoms). This is often done using a finite difference approach on the supercell at the $\Gamma$ point, though Density Functional Perturbation Theory (DFPT) could also be employed if the memory requirements are manageable and/or if the level of theory required to describe the defect (e.g., DFT+U) is supported by the DFPT code.

Second, the IFCs of the pristine system, $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{pristine}}$, are obtained within a much larger supercell (typically with a few thousand atoms). A practical approach is to use DFPT on the unit cell to calculate the dynamical matrix on a $\mathbf{q}$-mesh, potentially followed by Fourier interpolation to obtain the matrix on a denser [$N_x,N_y,N_z$] $\mathbf{q}$-mesh. The information in the dynamical matrix, computed on a unit cell for a dense [$N_x,N_y,N_z$] $\mathbf{q}$-mesh, is equivalent to that in a dynamical matrix for a [$N_x,N_y,N_z$] supercell at $\mathbf{q} = [0,0,0]$ (the $\Gamma$ point). Mapping a $\mathbf{q}$-mesh to $\mathbf{q} = [0,0,0]$ is referred to a folding procedure, and yields the pristine IFCs $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{pristine}}$.

Third, an embedded IFC matrix $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{emb}}$ is constructed using the following rules: If both atoms $\kappa$ and $\kappa’$ are within a sphere centered around the defect, with a cut-off radius $R_c$, then $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{emb}}$ is set to $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{defect}}$. For all other atomic pairs, the embedded IFC is set to the pristine value: $C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{emb}} = C_{\kappa\alpha,\kappa’\alpha}^{\mathrm{pristine}}$. The cut-off radius $R_c$ is typically determined by the size of the initial supercell used to compute the defect IFCs. Additionally, one could use a second cut-off radii $R_b$. If two atoms are not within a sphere of radii $R_b$, the IFC is set to zero. The use of this second cut-off has been used in some studies {cite}`razinkovas2021vibrational,jin2021photoluminescence` in order to obtain large sparse matrices, for which dedicated techniques allows faster diagonalization, see for instance reference {cite}`razinkovas2021vibrational`. In this work, we do not use this second cut-off. 

Overall, the whole procedure can break the acoustic sum rule

$$
C_{\kappa\alpha,\kappa\beta} = - \sum_{\kappa'\ne\kappa}C_{\kappa\alpha,\kappa'\beta}.
$$

To correct for this, we follow the approach proposed in reference~\cite{razinkovas2021vibrational} and we set:

$$
C_{\kappa\alpha,\kappa\alpha}^{\mathrm{emb}}=-\sum_{\kappa'\ne\kappa}C_{\kappa\alpha,\kappa'\alpha}^{\mathrm{emb}}.
$$

For the treatment of the Born effective charges (BECs), if the BEC of the substituted atom was computed in the defect phonon calculation, it is replaced by the BEC of the dopant atom. If not, one can choose to use the most common oxidation state of the dopant atom as its new BEC. The same approach applies to interstitials, but in this case, the dopant atom and its corresponding BEC are simply added. For vacancies, the atom and its BEC are removed.

Diagonalizing this embedded IFCs provides the phonon modes of a defectuous [$N_x,N_y,N_z$] supercell, where the defect effect on the IFCs was included through the embedding procedure.

The localization of the phonon modes can be characterized by computing the inverse participation ratio (IPR) defined as {cite}`alkauskas2014,jin2021photoluminescence,wang2022role`

$$	
\mathrm{IPR}_{\nu}=\frac{1}{\sum_{\kappa}|\langle \mathbf{e}_{\nu,\kappa}| \mathbf{e}_{\nu,\kappa} \rangle|^2},
$$
which indicates, roughly speaking, the number of atoms that participate to a phonon mode $\nu$. 
For example, $\mathrm{IPR}_{\nu}=1$ means that only one atom vibrates and therefore the phonon mode is maximally localized, while $\mathrm{IPR}_{\nu}=N$ means that N atoms vibrates in the supercell with the same amplitude. 

The localization ratio $\beta_{\nu}$ is defined by taking the ratio of the total number of atoms in the supercell $N$ and the $\rm{IPR}$, $\beta_{\nu} =N/\mathrm{IPR}_{\nu}$ where $\beta_{\nu} \approx 1$ represents a bulk-like delocalized mode while $\beta_{\nu} \gg 1$ corresponds to a quasi-local or local mode.


```{bibliography}
:style: unsrt
```