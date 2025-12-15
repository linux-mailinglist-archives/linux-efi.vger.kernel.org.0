Return-Path: <linux-efi+bounces-5850-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FBECC0325
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5F9302D932
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74C32B98A;
	Mon, 15 Dec 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g4z01K43"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FB32AAC4;
	Mon, 15 Dec 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842047; cv=none; b=DmIv3EbY8b2WYOqSMzwOoH17L8sHU2K0NE8gHtCqmrd1eF1/jUvMrIClsmZOF7PSxrT9yFr1rxZOLP5+twO886agK/9DRtF7YZAYksMecgEf3FMUEcVh9vxOiCw/dIWlnVrSJLr2VPqYQA2jEkLWDEsLbbQBaCjCKjAhLWgg2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842047; c=relaxed/simple;
	bh=rCcFoUN77VYAWp9h7HKXtL/Qq4gkXAvhhvKevszduts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k681j9c5qa4m8EI9w2Cv08dHujkzZZ42XB3Dzy32vTH2i08EyvIqmNHLN6tV5QUbUJ3qle/HSk+GnqA2febmN4zbnKOSjq0omDxqLMqoCtNxRPdrmlqcGNx6hHWMYwTbPKDTe0URnLwO5eWnsBj3Vcmoxld/exwCvBIUIL3+ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g4z01K43; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCNhn2886214;
	Mon, 15 Dec 2025 23:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1aDAWnpglHlTmAYME09TSd6vTy9Zh
	cE6yHNh8PepkOM=; b=g4z01K43dyop9WWWP2Q08dTheOWlJgImc0KzOEVuJnLrp
	43SOSUGYWNkCHqxOEcAvfV0ZpwpaHfXrObpI8XULSApgTNF/J1HG27SZRlgszCmx
	xTovNG+5Ld9SFI7Oj0VBHhCXbGSNNXE0siFqLZrQ1KKGzU9GqRTTgb2Y0vUkSMAM
	orl1WWZVN0mQJFaA2Mr9ollt0xDMggyzpqcqhkn7GVb9PuyfGFXMLlVfivWBMOyG
	KmvudDnIOJsKAwWD4yd0ARvCZLJrXn3HiHVNcKGDM2izmsfFm6+slzzRsgtfsmQs
	RfsYjF7s0lNz5BXvzeamW/Vt/1Tn9WmFd9QsWanjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u17j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:39:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMLLAc025849;
	Mon, 15 Dec 2025 23:39:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tpjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNdjaA032200;
	Mon, 15 Dec 2025 23:39:45 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:45 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
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
Subject: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Date: Mon, 15 Dec 2025 15:32:48 -0800
Message-ID: <20251215233316.1076248-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: 4FhHdJi6T6vATHKJJ7jROPih8qlOdfgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX2b2dOp31KcwQ
 ehD+y6RORFYwj6r9M8/N/pnG6+Uo6oKjhOHSWzaTSE9Eekmc7IdqPOvmIm0Rie7au8aHpKHqy3U
 Vmj8q59yeYSVYPUb20CFZ0mq1Zhw4DRIaJVSWLYwtxGWI7UlxWiqqLF+N7mpKZzsRLM+kTW8+WO
 HZGX0ab0k2IVLaaPDIj+cka9TqR/tLhncscE0dnVMKtNGq54lH2EI6FSOHMTqKRnf3HuYJBrrtg
 2PnwC88I8CQ6potLLwb0+M+rJ6JdOwpsnnmiZlne5cDWQ974fcCDXf0Ht0Wby7hNTjYTKYmvKit
 Vh/5vBTF3NaxzPcllO9P7vhQ48OID5p5GLZQvIlUVmSYt6QG9M6g5DkNSYkHIrIsDFYpKhoSH/z
 0qYmQZRorea/2fPkHZ1EJerZK4Z9Uw==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409c43 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=nwmgzXUKAAAA:8 a=VwQbUJbxAAAA:8
 a=TN4aJMRXFS8IVmGCrUIA:9 a=8YVojpJ189lmoD23kkcf:22
X-Proofpoint-ORIG-GUID: 4FhHdJi6T6vATHKJJ7jROPih8qlOdfgR

Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
Root of Trust (DRTM) support in the kernel. This is complementary to
better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.

This series provides the common infrastructure along with Intel TXT
support, without needing the tboot exokernel. Support for AMD SKINIT is
pending the common infrastructure getting nailed down, and ARM are
looking to build on it too.

Originally, tboot were approached to see if they'd take support for
other vendors, but they elected not to. Hence this approach instead.

Work is being coordinated by the Trenchboot project, https://trenchboot.org/,
organising Secure Launch support for upstream open source projects including
Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM easy
to use.  e.g. for Grub, it's simply adding "slaunch" as a command in the boot
stanza.  See https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
for more details

Patch set based on commit:
torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd

Depends on v3 of the following TPM patch set (note this patch
set is being actively worked on separately):
[PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
Message ID: 20250929194832.2913286-1-jarkko@kernel.org

Finally we would like to thank everyone for their input and
assistance. It has all been very helpful in improving the quality of
our solution and in reviewing/strengthening our security posture.

Thanks
Ross Philipson and Daniel P. Smith

Changes in v15:

 - Rewriting and reformatting of the cover letter, commit message and
   code comments per requests from maintainers.
 - Introduction of a early TPM driver in the x86 setup kernel to allow
   TPM extend command very early in the boot.
 - Remove previous TPM extending architecture that attempted to update
   the TPM PCRs later in the boot process.
 - Split slaunch.h into 2 files, with a new txt.h. The former contains
   platform agnostic definitions for the SL feature. The new txt.h file
   contains Intel TXT definitions from the public specs.
 - Split TPM headers up following the specifications where the
   technologies are defined.
 - Include set of split up TPM header files to allow TPM driver reuse
   in other environments (e.g. early kernel, x86).
 - Fix code formatting and type-os.


Alec Brown (1):
  tpm: Remove main TPM header from TPM event log header

Daniel P. Smith (6):
  tpm/tpm_tis: Close all localities
  tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
  Documentation/x86: Secure Launch kernel documentation
  x86: Add early SHA-1 support for Secure Launch early measurements
  x86: Add early SHA-256 support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (21):
  tpm: Initial step to reorganize TPM public headers
  tpm: Move TPM1 specific definitions and functions to new headers
  tpm: Move TPM2 specific definitions and functions to new headers
  tpm: Move TPM common base definitions to new public common header
  tpm: Move platform specific definitions to the new PTP header
  tpm: Add TPM buffer support header for standalone reuse
  tpm/tpm_tis: Allow locality to be set to a different value
  tpm/sysfs: Show locality used by kernel
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86/txt: Intel Trusted eXecution Technology (TXT) definitions
  x86/tpm: Early TPM PCR extending driver
  x86/msr: Add variable MTRR base/mask and x2apic ID registers
  x86/boot: Place TXT MLE header in the kernel_info section
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  x86/reboot: Secure Launch SEXIT support on reboot paths
  x86/efi: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst               |  21 +
 Documentation/security/index.rst              |   1 +
 .../security/launch-integrity/index.rst       |  11 +
 .../security/launch-integrity/principles.rst  | 308 +++++++
 .../secure_launch_details.rst                 | 587 +++++++++++++
 .../secure_launch_overview.rst                | 240 ++++++
 arch/x86/Kconfig                              |  14 +
 arch/x86/boot/compressed/Makefile             |   8 +
 arch/x86/boot/compressed/early_tpm_extend.c   | 601 ++++++++++++++
 arch/x86/boot/compressed/head_64.S            |  29 +
 arch/x86/boot/compressed/kernel_info.S        |  50 +-
 arch/x86/boot/compressed/sha1.c               |   7 +
 arch/x86/boot/compressed/sha256.c             |   6 +
 arch/x86/boot/compressed/sl_main.c            | 638 +++++++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 770 ++++++++++++++++++
 arch/x86/boot/compressed/tpm.h                |  42 +
 arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/asm/txt.h                    | 330 ++++++++
 arch/x86/include/uapi/asm/bootparam.h         |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/asm-offsets.c                 |  20 +
 arch/x86/kernel/reboot.c                      |  14 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 615 ++++++++++++++
 arch/x86/kernel/slmodule.c                    | 348 ++++++++
 arch/x86/kernel/smpboot.c                     |  47 +-
 arch/x86/realmode/init.c                      |   8 +
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  32 +
 drivers/char/tpm/tpm-buf.c                    |  10 +-
 drivers/char/tpm/tpm-chip.c                   |  34 +-
 drivers/char/tpm/tpm-sysfs.c                  |  10 +
 drivers/char/tpm/tpm.h                        | 180 +---
 drivers/char/tpm/tpm1-cmd.c                   |  18 +-
 drivers/char/tpm/tpm1_structs.h               |  97 +++
 drivers/char/tpm/tpm2-cmd.c                   |  32 +-
 drivers/char/tpm/tpm2-space.c                 |  13 -
 drivers/char/tpm/tpm2_structs.h               |  58 ++
 drivers/char/tpm/tpm_tis_core.c               |  21 +-
 drivers/char/tpm/tpm_tis_core.h               |  64 +-
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       | 100 +++
 drivers/iommu/intel/dmar.c                    |   4 +
 include/keys/trusted_tpm.h                    |   1 -
 include/linux/slaunch.h                       | 251 ++++++
 include/linux/slr_table.h                     | 308 +++++++
 include/linux/tpm.h                           | 240 +-----
 include/linux/tpm1.h                          |  87 ++
 include/linux/tpm2.h                          | 247 ++++++
 include/linux/tpm_buf.h                       |  57 ++
 include/linux/tpm_command.h                   |  30 -
 include/linux/tpm_common.h                    |  99 +++
 include/linux/tpm_eventlog.h                  |   4 +-
 include/linux/tpm_ptp.h                       | 139 ++++
 kernel/kexec_core.c                           |   8 +
 security/keys/trusted-keys/trusted_tpm1.c     |   1 -
 security/keys/trusted-keys/trusted_tpm2.c     |   1 -
 59 files changed, 6319 insertions(+), 574 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/early_tpm_extend.c
 create mode 100644 arch/x86/boot/compressed/sha1.c
 create mode 100644 arch/x86/boot/compressed/sha256.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/boot/compressed/tpm.h
 create mode 100644 arch/x86/include/asm/txt.h
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 drivers/char/tpm/tpm1_structs.h
 create mode 100644 drivers/char/tpm/tpm2_structs.h
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h
 create mode 100644 include/linux/tpm1.h
 create mode 100644 include/linux/tpm2.h
 create mode 100644 include/linux/tpm_buf.h
 delete mode 100644 include/linux/tpm_command.h
 create mode 100644 include/linux/tpm_common.h
 create mode 100644 include/linux/tpm_ptp.h

-- 
2.43.7


