Return-Path: <linux-efi+bounces-1768-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E779789CC
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF71F22540
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E71537DA;
	Fri, 13 Sep 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LzXwHAZL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9EB146D40;
	Fri, 13 Sep 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258553; cv=none; b=EvZqIZjoC8fa8TTmUqD7WxrxeKnMi9Rv0RUzqOvdhx4VRoOHIXdUHEXNKj13IoXDjkIJpTPIh0/gBsi68VRVhtwl1pkuiecEAp0vFHYRIAwlTuaKQECDDnINzwZcEnjcV/KSXkYJWQwBekCYXceDoy1SqULs6qcao4A1U357UUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258553; c=relaxed/simple;
	bh=dlD5R0ZHfATZ9lNvSE3itjT9zKMZp+JJn9XCLUafnbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaSinUBlxY1cBB0aUx04WjzPoJ09zs/B6Y52PaGbTBaQu59nefz/0bs5KdSNkDrI22zRqNktS9N3UzdC+3FsuNmlKkbo6hXjvMdBxSfTbPr4DJ6aKmwk6KxeL2Eudk1oooV2MeRMDbNLBBVQ0/WQgQKlL0cX/8ZyAdh4cIgfFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LzXwHAZL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0rLZ000669;
	Fri, 13 Sep 2024 20:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=sGip6WE5iNlkJJ
	78YSopcsybSPhsjhFd5feEC5jD26E=; b=LzXwHAZLA+Clr/lmyrWK/YtCFLQO5c
	YMrrvzNTCqWuWcjp9ttsevYDsCeaI1mWrlHrUexIwd8t6dq1chwd5xxh9Jx3kZJU
	AEMpWoEia9UmZMUZYO8Ah+Y29OqE7tdSut7blO3AV5A5YfoJK+jzVNjtWw5yj8jI
	AsMUDy2UHKNRhpT0KY5VhCzwkTG2iwxLNPhsdld0Kl30BaOL83c2WZUfCtNCDysr
	0tFfScmTbcZQcYl5OD5fq5L4CLl/mK879HzovWRDu9usDGaVcpu9Cwg96WO+lyNP
	wGZXivpSRe8E0zJDQ4p+cnR1lsy2OgUzIfWAjqMel/27eG/lK2Nq/+2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2xk1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:10:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DIGS1R033533;
	Fri, 13 Sep 2024 20:10:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3kyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:10:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKABrn019755;
	Fri, 13 Sep 2024 20:10:11 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3kva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:10:10 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Fri, 13 Sep 2024 13:04:57 -0700
Message-Id: <20240913200517.3085794-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130143
X-Proofpoint-GUID: dNotBkgwuSQw5gdAPyp_3YAqBQ54IUe7
X-Proofpoint-ORIG-GUID: dNotBkgwuSQw5gdAPyp_3YAqBQ54IUe7

The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

This patchset provides detailed documentation of DRTM, the approach used for
adding the capbility, and relevant API/ABI documentation. In addition to the
documentation the patch set introduces Intel TXT support as the first platform
for Linux Secure Launch.

A quick note on terminology. The larger open source project itself is called
TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
the use of Dynamic Launch technology is referred to as "Secure Launch" within
the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
in the code. The stub code discussed above is referred to as the SL stub.

Links:

The TrenchBoot project including documentation:

https://trenchboot.org

The TrenchBoot project on Github:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

The TrenchBoot project provides a quick start guide to help get a system
up and running with Secure Launch for Linux:

https://github.com/TrenchBoot/documentation/blob/master/QUICKSTART.md

Patch set based on commit:

torvalds/master/77f587896757708780a7e8792efe62939f25a5ab

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Changes in v5:
 - Comprehensive documentation rewrite.
 - Use boot param loadflags to communicate Secure Launch status to
   kernel proper.
 - Fix incorrect check of X86_FEATURE_BIT_SMX bit.
 - Rename the alternate details and authorities PCR support.
 - Refactor the securityfs directory and file setup in slmodule.c.
 - Misc. cleanup from internal code reviews.
 - Use reverse fir tree format for variables.

Changes in v6:
 - Support for the new Secure Launch Resourse Table that standardizes
   the information passed and forms the ABI between the pre and post
   launch code.
 - Support for booting Linux through the EFI stub entry point and
   then being able to do a Secure Launch once EFI stub is done and EBS
   is called.
 - Updates to the documentation to reflect the previous two items listed.

Changes in v7:
 - Switch to using MONITOR/MWAIT instead of NMIs to park the APs for
   later bringup by the SMP code.
 - Use static inline dummy functions instead of macros when the Secure
   Launch feature is disabled.
 - Move early SHA1 code to lib/crypto and pull it in from there.
 - Numerous formatting fixes from comments on LKML.
 - Remove efi-stub/DL stub patch temporarily for redesign/rework.

Changes in v8:
 - Reintroduce efi-stub Linux kernel booting through the dynamic launch
   stub (DL stub).
 - Add new approach to setting localities > 0 through kernel and sysfs
   interfaces in the TPM mainline driver.
 - General code cleanup from v7 post comments.

Changes in v9:
 - Updated DL stub support for recent changes to EFI stub in the kernel.
 - Added patches to fix locality changing support in the TPM driver
   (these patches originally were posted as a separate set).
 - Enhanced Secure Launch TPM locality 2 setting in the TPM driver.
 - Added locality setting support through sysfs for user land to access.
 - Split up SHA1 and SHA256 changes into separate patches and updated
   the commit messages to be more clear (per request from upstream
   review).
 - Fix Clang compile issues detected by kernel test robot.
 - Modifications to the Secure Launch Resource Table ABI:
   . Use flex arrays in table structures.
   . Update and move fields in tables to make everything 8b aligned.
   . Add 2 new DLME fields and a txt_heap address field.
   . Remove platform specific tables that are not defined yet (AMD/ARM).
 - Update Kconfig dependencies for Secure Launch with SHA1/SHA256/TPM.
 - Remove push/pop of rsi since boot params is now stored in r15.
 - Update outdated kernel documentation.
 - Misc. comment fixes for type-os and mispellings.

Changes in v10:
 - Removed patch #1 from previous set that forced the kernel_info
   section at a fixed offset.
 - Add changes from Ard Biesheuvel to use the link step to generate the
   proper relative offsets for the MLE header in the kernel_info
   section.
 - Fix sizes and alignment slightly in the SLR table. Add comments to
   the SLR header to indicate it is defined by the TrenchBoot project.
 - Remove incorrect extra pop instruction noted in the head_64.S
   changes.
 - Use the prefix tpm/tpm2 to distinguish between TPM versions as is
   done in the rest of the TPM related code.
 - Rework the TPM locality setting/reporting changes to use "default"
   locality as opposed to "preferred". Remove uneeded extra locality
   function in the TPM interface (call the chip function directly).
 - Adopt comment/documentation changes to code and commit message per
   requests from the community.
 - Use u64 for the boot params physical address to avoid truncating
   pointers during casts.
 - Split adding of new MSR registers into its own patch.
 - Attempt to further address justification for using SHA-1 algorithm.
   Pick up some code suggestions for the SHA-1 patch.
 - Introduct slaunch_is_txt_launch() function per Jarkko Sakkinen's
   suggestion.
 - Implement minor changes to the EFI stub code per suggestions.

Changes in v11:
 - Add section to user documents about SHA-1 usage with Secure
   Launch as requested.
 - General cleanup and grammar fixes to the Linux user documentation.
 - Fix use of CONFIG_SECURE_LAUNCH in the EFI stub code to prevent
   32b build failures.
 - Cleanup of early event log handling code.

Daniel P. Smith (7):
  Documentation/x86: Secure Launch kernel documentation
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  tpm: Protect against locality counter underflow
  tpm: Ensure tpm is in known state at startup
  tpm: Make locality requests return consistent values
  x86: Secure Launch late initcall platform module

Ross Philipson (13):
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86/msr: Add variable MTRR base/mask and x2apic ID registers
  x86/boot: Place TXT MLE header in the kernel_info section
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  x86/reboot: Secure Launch SEXIT support on reboot paths
  tpm: Add ability to set the default locality the TPM chip uses
  tpm: Add sysfs interface to allow setting and querying the default
    locality
  x86/efi: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 317 ++++++++
 .../secure_launch_details.rst                 | 588 ++++++++++++++
 .../secure_launch_overview.rst                | 252 ++++++
 arch/x86/Kconfig                              |  11 +
 arch/x86/boot/compressed/Makefile             |   3 +
 arch/x86/boot/compressed/head_64.S            |  29 +
 arch/x86/boot/compressed/kernel_info.S        |  50 +-
 arch/x86/boot/compressed/sha1.c               |   6 +
 arch/x86/boot/compressed/sha256.c             |   6 +
 arch/x86/boot/compressed/sl_main.c            | 584 ++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 726 ++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 596 ++++++++++++++
 arch/x86/kernel/slmodule.c                    | 508 ++++++++++++
 arch/x86/kernel/smpboot.c                     |  43 +-
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-chip.c                   |  24 +-
 drivers/char/tpm/tpm-sysfs.c                  |  30 +
 drivers/char/tpm/tpm_tis_core.c               |  27 +-
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |  99 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 548 +++++++++++++
 include/linux/slr_table.h                     | 276 +++++++
 include/linux/tpm.h                           |  10 +
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 40 files changed, 4940 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/sha1.c
 create mode 100644 arch/x86/boot/compressed/sha256.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h

-- 
2.39.3


