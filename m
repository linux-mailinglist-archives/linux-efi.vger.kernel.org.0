Return-Path: <linux-efi+bounces-5879-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D2CC0BBE
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 04:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61179301EC63
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B68274658;
	Tue, 16 Dec 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLGHz6t0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D1487BE;
	Tue, 16 Dec 2025 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856771; cv=none; b=QG8hwENmNtG9toQOzpdouLKlyYezqUQngSEKAodzYHMPTJlpUtSjOS4Tz4SAS4oCKYzdu+s9qfIGmMpS8ouAAWIJEB5Vrrs0SP0jzhH36o7ZmTJheZlwZtZ36kr3sZa2dnFGgVyia8l83rNQHCWpSI+alu8b1gJo68+X8dy1gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856771; c=relaxed/simple;
	bh=pSGYuRMvBKPFBLH+IHHROcdygnUFsHEmbW+bkqAwZac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoSa+WkH+wKmqn48ytaXSNwOaatBuglSb3wqNeGkHOgpH6sj2Gc83YCcVev7K12cAGMuNM+X//LUMbB8urOq0hSuLhc9x/mAjerf+EcYrD/sJ2C/t4JFX4eO/xQe2rhorA+d2UOrRtcy7IDCOjMa/Fx83cINymc5sJrT++rdiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLGHz6t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46499C4CEF1;
	Tue, 16 Dec 2025 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765856769;
	bh=pSGYuRMvBKPFBLH+IHHROcdygnUFsHEmbW+bkqAwZac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLGHz6t0zQTXBXbPM0LT9pPAlum1Ynru9rHis8eTow9FOLRjJNOL2XsKLj/IdQQ/A
	 vLGRarqJkBymWN5hyRWg3BMkcM8+rgV6LC0AJeKpe9jRonn3wl0Rf8fWupn0CGVomq
	 aEUIPpdeELEeZK46Xd0sv0BG/HqWVrSQOv9rfNs1vv9qrZ0uuKoNY534+fxTe6DPxV
	 0a9APA3VMNhpt/cq+4o9BZGubGxbyR11tXitIWpWmNLQFd0QcNCm986DIt99QRUbpe
	 GKV16JI36iTLR7jEwcM07WFcWVIuQexiIIgaySSJuPykDm0onC5UBC56LaNtKsy3Yf
	 YbLBvYKEIjnhA==
Date: Tue, 16 Dec 2025 05:46:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Message-ID: <aUDV_e19I0I3GIzN@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:32:48PM -0800, Ross Philipson wrote:
> Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
> Root of Trust (DRTM) support in the kernel. This is complementary to
> better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.
> 
> This series provides the common infrastructure along with Intel TXT
> support, without needing the tboot exokernel. Support for AMD SKINIT is
> pending the common infrastructure getting nailed down, and ARM are
> looking to build on it too.
> 
> Originally, tboot were approached to see if they'd take support for
> other vendors, but they elected not to. Hence this approach instead.
> 
> Work is being coordinated by the Trenchboot project, https://trenchboot.org/,
> organising Secure Launch support for upstream open source projects including
> Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM easy
> to use.  e.g. for Grub, it's simply adding "slaunch" as a command in the boot
> stanza.  See https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
> for more details
> 
> Patch set based on commit:
> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
> 
> Depends on v3 of the following TPM patch set (note this patch
> set is being actively worked on separately):
> [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
> Message ID: 20250929194832.2913286-1-jarkko@kernel.org
> 
> Finally we would like to thank everyone for their input and
> assistance. It has all been very helpful in improving the quality of
> our solution and in reviewing/strengthening our security posture.
> 
> Thanks
> Ross Philipson and Daniel P. Smith
> 
> Changes in v15:
> 
>  - Rewriting and reformatting of the cover letter, commit message and
>    code comments per requests from maintainers.
>  - Introduction of a early TPM driver in the x86 setup kernel to allow
>    TPM extend command very early in the boot.
>  - Remove previous TPM extending architecture that attempted to update
>    the TPM PCRs later in the boot process.
>  - Split slaunch.h into 2 files, with a new txt.h. The former contains
>    platform agnostic definitions for the SL feature. The new txt.h file
>    contains Intel TXT definitions from the public specs.
>  - Split TPM headers up following the specifications where the
>    technologies are defined.
>  - Include set of split up TPM header files to allow TPM driver reuse
>    in other environments (e.g. early kernel, x86).
>  - Fix code formatting and type-os.
> 
> 
> Alec Brown (1):
>   tpm: Remove main TPM header from TPM event log header
> 
> Daniel P. Smith (6):
>   tpm/tpm_tis: Close all localities
>   tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
>   Documentation/x86: Secure Launch kernel documentation
>   x86: Add early SHA-1 support for Secure Launch early measurements
>   x86: Add early SHA-256 support for Secure Launch early measurements
>   x86: Secure Launch late initcall platform module
> 
> Ross Philipson (21):
>   tpm: Initial step to reorganize TPM public headers
>   tpm: Move TPM1 specific definitions and functions to new headers
>   tpm: Move TPM2 specific definitions and functions to new headers
>   tpm: Move TPM common base definitions to new public common header
>   tpm: Move platform specific definitions to the new PTP header
>   tpm: Add TPM buffer support header for standalone reuse
>   tpm/tpm_tis: Allow locality to be set to a different value
>   tpm/sysfs: Show locality used by kernel
>   x86: Secure Launch Kconfig
>   x86: Secure Launch Resource Table header file
>   x86: Secure Launch main header file
>   x86/txt: Intel Trusted eXecution Technology (TXT) definitions
>   x86/tpm: Early TPM PCR extending driver
>   x86/msr: Add variable MTRR base/mask and x2apic ID registers
>   x86/boot: Place TXT MLE header in the kernel_info section
>   x86: Secure Launch kernel early boot stub
>   x86: Secure Launch kernel late boot stub
>   x86: Secure Launch SMP bringup support
>   kexec: Secure Launch kexec SEXIT support
>   x86/reboot: Secure Launch SEXIT support on reboot paths
>   x86/efi: EFI stub DRTM launch support for Secure Launch
> 
>  Documentation/arch/x86/boot.rst               |  21 +
>  Documentation/security/index.rst              |   1 +
>  .../security/launch-integrity/index.rst       |  11 +
>  .../security/launch-integrity/principles.rst  | 308 +++++++
>  .../secure_launch_details.rst                 | 587 +++++++++++++
>  .../secure_launch_overview.rst                | 240 ++++++
>  arch/x86/Kconfig                              |  14 +
>  arch/x86/boot/compressed/Makefile             |   8 +
>  arch/x86/boot/compressed/early_tpm_extend.c   | 601 ++++++++++++++
>  arch/x86/boot/compressed/head_64.S            |  29 +
>  arch/x86/boot/compressed/kernel_info.S        |  50 +-
>  arch/x86/boot/compressed/sha1.c               |   7 +
>  arch/x86/boot/compressed/sha256.c             |   6 +
>  arch/x86/boot/compressed/sl_main.c            | 638 +++++++++++++++
>  arch/x86/boot/compressed/sl_stub.S            | 770 ++++++++++++++++++
>  arch/x86/boot/compressed/tpm.h                |  42 +
>  arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
>  arch/x86/include/asm/msr-index.h              |   5 +
>  arch/x86/include/asm/realmode.h               |   3 +
>  arch/x86/include/asm/txt.h                    | 330 ++++++++
>  arch/x86/include/uapi/asm/bootparam.h         |   1 +
>  arch/x86/kernel/Makefile                      |   2 +
>  arch/x86/kernel/asm-offsets.c                 |  20 +
>  arch/x86/kernel/reboot.c                      |  14 +
>  arch/x86/kernel/setup.c                       |   3 +
>  arch/x86/kernel/slaunch.c                     | 615 ++++++++++++++
>  arch/x86/kernel/slmodule.c                    | 348 ++++++++
>  arch/x86/kernel/smpboot.c                     |  47 +-
>  arch/x86/realmode/init.c                      |   8 +
>  arch/x86/realmode/rm/header.S                 |   3 +
>  arch/x86/realmode/rm/trampoline_64.S          |  32 +
>  drivers/char/tpm/tpm-buf.c                    |  10 +-
>  drivers/char/tpm/tpm-chip.c                   |  34 +-
>  drivers/char/tpm/tpm-sysfs.c                  |  10 +
>  drivers/char/tpm/tpm.h                        | 180 +---
>  drivers/char/tpm/tpm1-cmd.c                   |  18 +-
>  drivers/char/tpm/tpm1_structs.h               |  97 +++
>  drivers/char/tpm/tpm2-cmd.c                   |  32 +-
>  drivers/char/tpm/tpm2-space.c                 |  13 -
>  drivers/char/tpm/tpm2_structs.h               |  58 ++
>  drivers/char/tpm/tpm_tis_core.c               |  21 +-
>  drivers/char/tpm/tpm_tis_core.h               |  64 +-
>  drivers/firmware/efi/libstub/efistub.h        |   8 +
>  drivers/firmware/efi/libstub/x86-stub.c       | 100 +++
>  drivers/iommu/intel/dmar.c                    |   4 +
>  include/keys/trusted_tpm.h                    |   1 -
>  include/linux/slaunch.h                       | 251 ++++++
>  include/linux/slr_table.h                     | 308 +++++++
>  include/linux/tpm.h                           | 240 +-----
>  include/linux/tpm1.h                          |  87 ++
>  include/linux/tpm2.h                          | 247 ++++++
>  include/linux/tpm_buf.h                       |  57 ++
>  include/linux/tpm_command.h                   |  30 -
>  include/linux/tpm_common.h                    |  99 +++
>  include/linux/tpm_eventlog.h                  |   4 +-
>  include/linux/tpm_ptp.h                       | 139 ++++
>  kernel/kexec_core.c                           |   8 +
>  security/keys/trusted-keys/trusted_tpm1.c     |   1 -
>  security/keys/trusted-keys/trusted_tpm2.c     |   1 -
>  59 files changed, 6319 insertions(+), 574 deletions(-)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/principles.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
>  create mode 100644 arch/x86/boot/compressed/early_tpm_extend.c
>  create mode 100644 arch/x86/boot/compressed/sha1.c
>  create mode 100644 arch/x86/boot/compressed/sha256.c
>  create mode 100644 arch/x86/boot/compressed/sl_main.c
>  create mode 100644 arch/x86/boot/compressed/sl_stub.S
>  create mode 100644 arch/x86/boot/compressed/tpm.h
>  create mode 100644 arch/x86/include/asm/txt.h
>  create mode 100644 arch/x86/kernel/slaunch.c
>  create mode 100644 arch/x86/kernel/slmodule.c
>  create mode 100644 drivers/char/tpm/tpm1_structs.h
>  create mode 100644 drivers/char/tpm/tpm2_structs.h
>  create mode 100644 include/linux/slaunch.h
>  create mode 100644 include/linux/slr_table.h
>  create mode 100644 include/linux/tpm1.h
>  create mode 100644 include/linux/tpm2.h
>  create mode 100644 include/linux/tpm_buf.h
>  delete mode 100644 include/linux/tpm_command.h
>  create mode 100644 include/linux/tpm_common.h
>  create mode 100644 include/linux/tpm_ptp.h
> 
> -- 
> 2.43.7
> 

Most likely I'll review this after the holidays (for heads up).

BR, Jarkko

