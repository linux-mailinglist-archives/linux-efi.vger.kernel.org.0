Return-Path: <linux-efi+bounces-5869-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48239CC0410
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5645C30456D5
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BC3370EE;
	Mon, 15 Dec 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oz45xJQN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E413358BC;
	Mon, 15 Dec 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842135; cv=none; b=SNOSvnYzd0tJS7l73UEd4utgow32UIA17wsEyINA+Gt63SpdK1UxdtTWaBDfEEwOxSQs8vQTORbjESUwuiP/n4Hif2hgmGEVEQF4P2ZM6tpxP4X9glpai6uTopEKbzD+4xdJr6PEuFisMPYZo259mdVt+2LLkNdH9vmPDSYMsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842135; c=relaxed/simple;
	bh=2F9nargAeKUloP4O08ftxToWq10BNGxPWdkEobufy40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgdsT+Nmbi1bRcu1UEkfqwABzmCpkH+M9qbFl/h2g15l0207NCp7MaHjW6m2WzSuHTcHzZL+ahtKlWHrw+66ilxi0YHOmkVBTP4STELr1246evRmITImeKj5SrfJPj4T7NSQuXPxkQGLcjRroDW0QnYKoMd3nhFp5Cx1JWcq26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oz45xJQN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCOo92886298;
	Mon, 15 Dec 2025 23:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XX/RC
	hBzEgqpen52DAr+3zyix/13IrmSUcDpx3gE+E8=; b=oz45xJQN1JR5z2fWonzZS
	T+BGFFkxKsu9HzP8knK8GjjnEhdl8bth8Xh+pr9pZb3l8R1QjjbSPASOqgjOXAsQ
	ikF1ArXBVkliMjPnkn7vyugPgUEy7o96qgFlXfYVnOhtzggf0ZO8/DSgaEkYhfQA
	gpBhEtqPYrr4fsNVc7TbNmaoiHCjGB45QVLxJp67TLH+dYM9ssj5kLcdk6vHMRcj
	3qjN6UnDQwWPgtgGNpBLd5FPitplUdDem++NAB9JTilfeBwLnfWNeYqk2mfmFLAv
	+O6D7Vk2i0r/hElVhUdWjYkW2k0wnhHusM9nk7V50LNfZAxZLZlvkJRLaOZd8HYx
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u18u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMcQcL024769;
	Mon, 15 Dec 2025 23:41:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNfUEd030405;
	Mon, 15 Dec 2025 23:41:30 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t8w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:30 +0000
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
Subject: [PATCH v15 24/28] x86: Secure Launch SMP bringup support
Date: Mon, 15 Dec 2025 15:33:12 -0800
Message-ID: <20251215233316.1076248-25-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: OU4B4wV6-TD0n2OG8Fy_T_0vAZbBJcFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX5PXeZsIXgn+o
 N7xLYEJNW3CKiLg/Y1vWZZqaDuYjXak634S6cws4RiTvruYz6GtoYk6mCLT/yCqFs8RnTNf3DZj
 ZfKw4gx2Tt2+qOhF7Rk8HKMfgOYM9/LqbEpwy+ntxI72i/WkU//si1v9+S3eRl3w/mMTz+LenoD
 BS10QG4zGFyZ8Ttk99S+nRLU6KFMpDEuU1Ijd31Gpq7VSqcifZFFz1M7oNXQC0uckmhZ2iDhLRQ
 IOp6fzORYUcs4dkchmQkhjsBf2CeeZ9XH28SvbeE3b93qBksPmaiFXWwiCzD5xaWJh+DTuInh5E
 qHkc7xU6pqhAnP1XgSpYhVO2WhS7eVxLldd1sqCsRJR06YJXipZvlRxUmPKwSRmqN+iAsU+U+eB
 WqvuLXDpTeBiN9WFlFY5s6KTzgmx3A==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409cac cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=76OG6UFZL8xl0KCKHTYA:9
X-Proofpoint-ORIG-GUID: OU4B4wV6-TD0n2OG8Fy_T_0vAZbBJcFU

On Intel, the APs are left in a well documented state after TXT performs
the late launch. Specifically they cannot have #INIT asserted on them so
a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
early SL stub code uses MONITOR and MWAIT to park the APs. The realmode/init.c
code updates the jump address for the waiting APs with the location of the
Secure Launch entry point in the rmpiggy image.

The rmpiggy image is a payload contained in the kernel used to start the
APs (in 16b or 32b modes). It is loaded at runtime so its location and entry point
must be updated in the long jump for the waiting APs by the running
kernel.

As the APs are woken up by writing the monitor, the APs jump to the Secure
Launch entry point in the rmpiggy which mimics what the real mode code would
do then jumps to the standard rmpiggy protected mode entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/slaunch.c            | 26 +++++++++++++++
 arch/x86/kernel/smpboot.c            | 47 ++++++++++++++++++++++++++--
 arch/x86/realmode/init.c             |  8 +++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++++++
 6 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index e406a1e92c63..e3336c49d26b 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -38,6 +38,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 6958734fe5e9..0699cbf41753 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -507,3 +507,29 @@ void __init slaunch_setup(void)
 	if (boot_cpu_has(X86_FEATURE_SMX))
 		slaunch_setup_txt();
 }
+
+/*
+ * After a launch, the APs are woken up, enter the DRTM and are left to
+ * wait for a wakeup call on a MONITOR address. The block where they are
+ * idle has a long jump to the AP startup code in the mainline kernel.
+ * This address has to be calculated at runtime and "fixed up" to point
+ * to the SL startup location in the rmpiggy SMP startup image. This image
+ * is loaded into separate  memory at kernel start time.
+ */
+void __init slaunch_fixup_ap_wake_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_info("TXT AP startup vector address updated\n");
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289abece23..c351280b1cbc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -61,6 +61,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -833,6 +834,45 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs using MONITOR/MWAIT in the safe AP wake block area (details in
+ * sl_stub.S). The SMP boot will wake the APs by writing the MONITOR associated
+ * with the AP and have them jump to the protected mode code in the rmpiggy where
+ * the rest of the SMP boot of the AP will proceed normally.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Section 2.3 -  MLE Initialization
+ */
+static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	struct sl_ap_stack_and_monitor *stack_monitor;
+	struct sl_ap_wake_info *ap_wake_info;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
+							       ap_wake_info->ap_stacks_offset);
+
+	for (unsigned int i = SL_MAX_CPUS - 1; i >= 0; i--) {
+		if (stack_monitor[i].apicid == apicid) {
+			stack_monitor[i].monitor = 1;
+			break;
+		}
+	}
+}
+
+#else
+
+static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+}
+
+#endif  /* IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -842,7 +882,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
-	int ret;
+	int ret = 0;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -887,12 +927,15 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 
 	/*
 	 * Wake up a CPU in difference cases:
+	 * - Intel TXT DRTM launch uses its own method to wake the APs
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
 	 * - Use an INIT boot APIC message
 	 */
-	if (apic->wakeup_secondary_cpu_64)
+	if (slaunch_is_txt_launch())
+		slaunch_wakeup_cpu_from_txt(cpu, apicid);
+	else if (apic->wakeup_secondary_cpu_64)
 		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
 	else if (apic->wakeup_secondary_cpu)
 		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768..ded4dafc6a0a 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 
 #include <asm/set_memory.h>
 #include <asm/realmode.h>
@@ -213,6 +214,13 @@ void __init init_real_mode(void)
 
 	setup_real_mode();
 	set_real_mode_permissions();
+
+	/*
+	 * If Secure Launch is active, it will use the rmpiggy to do the TXT AP
+	 * startup. Secure Launch has its own entry stub in the rmpiggy and this prepares
+	 * it for SMP boot.
+	 */
+	slaunch_fixup_ap_wake_vector();
 }
 
 static int __init do_init_real_mode(void)
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be6d256..3b5cbcbbfc90 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 14d9c7daf90f..b0ce6205d7ea 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
2.43.7


