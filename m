Return-Path: <linux-efi+bounces-31-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B57E85A2
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 23:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D940D1C20AF7
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862F3D978;
	Fri, 10 Nov 2023 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y4GlSKu3"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDB3D3A5;
	Fri, 10 Nov 2023 22:28:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865A44A4;
	Fri, 10 Nov 2023 14:28:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiSsT017445;
	Fri, 10 Nov 2023 22:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=QS3x0d16eIil938oZJp/MoGvYR9O+02BSiZaTRa9b9M=;
 b=y4GlSKu3n/ER17RSjy0+z18cLBUOFHRX1Ma+AReKtZs5VGeS1fZxDGorQhPLb2Kkjw+U
 XfHUw8GfUXSHFayLRVG6UkJ1ER866MfQ5BjnuPJomPEaIdjb5LIDxJNqX4x9qYIh8HLo
 qouusQygiS8XZa7dop8d1F1KyoRgOIqJYsKlPmUsnrHGPmXkireBf4jeOGVKorJM6DJq
 +7DPo0UVtWWOz9QAvWZtq60F1Jsiy15Yy8KNIUe46yZaWfljSztukDPceqYderIjibZO
 Zo5z58lx9PhspNkKpUHdZeF98E7n+uWYaelRIzhr/lnIUaEI1iPvMCxg0rMAtr+PqBbd Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26xx6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 22:27:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAK5Gco023867;
	Fri, 10 Nov 2023 22:27:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nayt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:27:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAMRsZw039112;
	Fri, 10 Nov 2023 22:27:54 GMT
Received: from ovs113.us.oracle.com (ovs113.us.oracle.com [10.149.224.213])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28nayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Nov 2023 22:27:54 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v7 00/13] x86: Trenchboot secure dynamic launch Linux kernel support
Date: Fri, 10 Nov 2023 17:27:38 -0500
Message-Id: <20231110222751.219836-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_20,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100187
X-Proofpoint-GUID: GWVoZQ2WdLxubQPPYqVpSVMFu8XeikNw
X-Proofpoint-ORIG-GUID: GWVoZQ2WdLxubQPPYqVpSVMFu8XeikNw

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

## NOTE: EFI-STUB CONFLICTS

The primary focus of the v7 patch set was to align with Thomas Gleixner's
changes to support parallel CPU bring-up on x86 platforms. In the process of
rebasing and testing v7, it was discovered that there were significant changes
to the efi-stub code. As a result, the efi-stub patch was dropped pending
maintainer feedback on an appropriate means to re-integrate Secure Launch. The
primary goal being to best align the DL stub functionality with efi-stub design.

It was discovered that the efi-stub now subsumes all the setup which head_64.S
was responsible. When attempting to rebase the DL stub patch on these changes,
it became apparent that it would not be a simple relocation of the Secure Launch
call. There are numerous things, such as efi-stub decompressing the main line
kernel, which make simple relocation challenging. There may also be additional
changes that should be considered when integrating Secure Launch support. It
would be beneficial, and much appreciated, to obtain guidance from maintainers.
Upon successful collaboration with the efi-stub maintainers, a Secure Launch v8
series will be produce to re-introduce the DL stub patch.

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

GRUB2 pre-launch support branch (WIP):

https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub

Patch set based on commit:

torvolds/master/6bc986ab839c844e78a2333a02e55f02c9e57935

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

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (10):
  Documentation/x86: Secure Launch kernel documentation
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 320 ++++++++
 .../secure_launch_details.rst                 | 584 +++++++++++++++
 .../secure_launch_overview.rst                | 226 ++++++
 arch/x86/Kconfig                              |  12 +
 arch/x86/boot/compressed/Makefile             |   3 +
 arch/x86/boot/compressed/early_sha1.c         |  12 +
 arch/x86/boot/compressed/early_sha256.c       |   6 +
 arch/x86/boot/compressed/head_64.S            |  34 +
 arch/x86/boot/compressed/kernel_info.S        |  53 +-
 arch/x86/boot/compressed/kernel_info.h        |  12 +
 arch/x86/boot/compressed/sl_main.c            | 582 +++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 705 ++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S        |   6 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  10 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 598 +++++++++++++++
 arch/x86/kernel/slmodule.c                    | 517 +++++++++++++
 arch/x86/kernel/smpboot.c                     |  56 +-
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-chip.c                   |   9 +-
 drivers/iommu/intel/dmar.c                    |   4 +
 include/crypto/sha1.h                         |   1 +
 include/linux/slaunch.h                       | 542 ++++++++++++++
 include/linux/slr_table.h                     | 270 +++++++
 kernel/kexec_core.c                           |   4 +
 lib/crypto/sha1.c                             |  81 ++
 36 files changed, 4746 insertions(+), 6 deletions(-)
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


