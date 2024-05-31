Return-Path: <linux-efi+bounces-1098-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BA8D57D6
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859E51F24E0D
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A93182B9;
	Fri, 31 May 2024 01:32:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8BA50;
	Fri, 31 May 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119138; cv=none; b=one/hxIHF8KM4tgGV+4OPj0qJYLFI2inXwcL5ECKtUD03SpNfiM+4dRxWq289gWn4lIa2g3r/EMga5fso32U68JIpQIRPX24CJkyAE0abzHTL1RwRJW1/HC4RQpzUgbO0IrzqJQ6yWqPcVWmXpZCB3mYb4SM5WkdLIdSy+asdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119138; c=relaxed/simple;
	bh=mpla0UXc3viMwjU8H/0lpqDG4xFB+X0xsJvlHcLgol0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PFx2mqgJXZBzT4WnhcBK4tKxfePahhMcdv65DXW+16R+gefKhA4yhnZHJdHNhRS6z+rxLje8hl08jvfg22MRFmc4kPPS76gcPvSfHDc5eZuScxvvOVqdCkQMD1rQU4BvTmyAMlAQkCJVNHseqH2rXrV4s4VoQMZo9Z3N4B+slY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFHOI1006321;
	Fri, 31 May 2024 01:30:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DqyH+bDJ/v0O1dmFLTpYo5a?=
 =?UTF-8?Q?pbWg9MOytu0JYpsM4yWws=3D;_b=3DagObQj/Kpm/lerGczBh6BeuzWu2b5hEjE?=
 =?UTF-8?Q?WvQCKZ2cocUNp8mgHg6bWfU8phmAoo/6gL0_3xqtjcWKQqiWWSvGKHDJzpAUyvm?=
 =?UTF-8?Q?F6oQgvGivb+8UpZoMtcW6uDUAoj7Mm+knx1Wlet6r_gxj3kC+0aR47aqdmVFrzd?=
 =?UTF-8?Q?OuB4EFhAyZH4CQko+YJVgdQfvVxip98SqbJM6Wp9+7BylCf_JZSjdSoUngF+ac3?=
 =?UTF-8?Q?nOHgBHk3b4sgveEBlu7lPn8M1oBgZRb9nm+oWxhQP9ji9GB0VRmrw_I4dU68cqE?=
 =?UTF-8?Q?/miweDsV2GIIRJ067LmYT/Tt9z43cYyf5AHCa+35YsFkrnfKLx2b378wcAT_EQ?=
 =?UTF-8?Q?=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7t3gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 01:30:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V0uRw1016376;
	Fri, 31 May 2024 01:30:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t973g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:30:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V1SKNE027418;
	Fri, 31 May 2024 01:30:27 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t96yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:30:26 +0000
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
Subject: [PATCH v9 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Thu, 30 May 2024 18:03:12 -0700
Message-Id: <20240531010331.134441-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310010
X-Proofpoint-ORIG-GUID: flZL183toSrZY36SPdpDyNYeOOf-3K-O
X-Proofpoint-GUID: flZL183toSrZY36SPdpDyNYeOOf-3K-O

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

The Secure Launch feature starts with patch #2. Patch #1 was authored by Arvind
Sankar. There is no further status on this patch at this point but
Secure Launch depends on it so it is included with the set.

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

torvalds/master/ea5f6ad9ad9645733b72ab53a98e719b460d36a6

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

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (6):
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  tpm: Protect against locality counter underflow
  tpm: Ensure tpm is in known state at startup
  tpm: Make locality requests return consistent values
  x86: Secure Launch late initcall platform module

Ross Philipson (12):
  Documentation/x86: Secure Launch kernel documentation
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Add ability to set the preferred locality the TPM chip uses
  tpm: Add sysfs interface to allow setting and querying the preferred
    locality
  x86: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 320 ++++++++
 .../secure_launch_details.rst                 | 587 ++++++++++++++
 .../secure_launch_overview.rst                | 227 ++++++
 arch/x86/Kconfig                              |  11 +
 arch/x86/boot/compressed/Makefile             |   3 +
 arch/x86/boot/compressed/early_sha1.c         |  12 +
 arch/x86/boot/compressed/early_sha256.c       |   6 +
 arch/x86/boot/compressed/head_64.S            |  30 +
 arch/x86/boot/compressed/kernel_info.S        |  53 +-
 arch/x86/boot/compressed/kernel_info.h        |  12 +
 arch/x86/boot/compressed/sl_main.c            | 577 ++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 725 ++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S        |   6 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 598 +++++++++++++++
 arch/x86/kernel/slmodule.c                    | 513 +++++++++++++
 arch/x86/kernel/smpboot.c                     |  58 +-
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-chip.c                   |  24 +-
 drivers/char/tpm/tpm-interface.c              |  15 +
 drivers/char/tpm/tpm-sysfs.c                  |  30 +
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_core.c               |  25 +-
 drivers/firmware/efi/libstub/x86-stub.c       |  98 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 542 +++++++++++++
 include/linux/slr_table.h                     | 271 +++++++
 include/linux/tpm.h                           |  10 +
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 42 files changed, 4946 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/kernel_info.h
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h

-- 
2.39.3


