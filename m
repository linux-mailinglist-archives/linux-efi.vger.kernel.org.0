Return-Path: <linux-efi+bounces-590-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A430585B073
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 02:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60381C2156B
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6411CA1;
	Tue, 20 Feb 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f2qHSqxX"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9821107;
	Tue, 20 Feb 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391946; cv=fail; b=qT2BcgVb/8pDbAuwcd71y4NUPci382MvMfJzYnXQAtUEIcdNiF2LqolY/7Yw1XjKSc/dDKEyzpLuP27G+L7XXLxyidwdIXJpQ6CXGDC19byM+NlWMJ4xgtkV0bVCwkQZtkHNFzG0Asmm6o3KaTzS1cWSWUh8MozjYRKog0yn4hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391946; c=relaxed/simple;
	bh=aDqD4no0TEj3zB+7EgDRbC7L5qrN1jcsrI9FDrfvSYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnTX8H46stv0teuQCLFmA4cx66PE3mLhVTiLT0S9YxAlyHmXEvRq83sVe/7TA0N+06jc/DprCUCb8LOJe8cq+W++MI4qYpcedHQNIBL2w7/CiOF0q22Iflxnu784N4mhw2UenBEoApaVib1R97FIJWklDoZTWJ2WrYNPCgxvFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2qHSqxX; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEDQ1k4X/Zsxc2N77NkqUI2nRiGRPePeF1XPmOqjSrgy+PYr0henzyY6RALpkUio8uFz2KSbKP91/DFlc8+OybbrkpxYxqfnJ6RXcMBCPcT0BnbdK6wO7MXBlkxnNYF2OOM3lnyQ73qBUFRp6zF9R6tvUwRSlj1h0XbL3a89TsH5cwONhIi8dMJg7bPAsXijlerlJCE1GDuYdeInIDxlBxJQjcdWpXH59uQyNcLBEqm1v3pUdJutVk8eXm5axDpF0aAp7k4O2GJBxFP0bDb8lr0MfyILQ4I4l+6vVjEL6DhV/zUv7MK/VpxqfO/lpN6zlnOdxIsljUNeVaEy044L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB4Nx3rwK/uKgFuYwWZG1OClyg+bRhRdDPqDCLZHR34=;
 b=a1Z6JresquvoRO2YfOtAdJWcxb2aK3h8ddpatJZcoM+AW45IeTPA+j7jOhqyxMblfZoVR1lQdV9RdNuNbn7zomR2aTYsE87Bb+Q/GrlKjF9zaAFVBqseMP63v0YDwiYYTtiLsxh8LvLlptJd5BdsLssKThsmk2nw3VVV43eBG6GYUZ+OKC9ig4P2gbPVlNcj5QEt6p5ZC/6WXcIREuUGU7uSK9Hid7VTG6xn5BSQ7PCRf5XkrXHZyRY6PaIFYkxX25ZJ8DKdHFkCSpzUAIo6ExyHJhdqwBW/ekoO/Z0JKOg3frZ6+ljbfDb4Fn0M7bdBSMeROyg3IGKYMNKnqKX8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB4Nx3rwK/uKgFuYwWZG1OClyg+bRhRdDPqDCLZHR34=;
 b=f2qHSqxXIaahzO2u7xhNYAMerg4GoW54YCeK1iBPrZwkAq0eLu2r6B5NPF02omeyw1Kd0mbgPEX8Zeeu8k5m6odhUHn+g8N2errCCPZyszloS4oPIb9ozrOqNYK9P6aTjDp4n0HOO8udUrlq9+MwoN50+UU7pkMR6wmptoW3JjU=
Received: from MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) by BL1PR12MB5288.namprd12.prod.outlook.com
 (2603:10b6:208:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 01:19:00 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D11.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.5 via Frontend
 Transport; Tue, 20 Feb 2024 01:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Tue, 20 Feb 2024 01:19:00 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:18:58 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <jroedel@suse.de>,
	<ashwin.kamat@broadcom.com>
Subject: [PATCH 2/2] x86/snp: Convert shared memory back to private on kexec
Date: Tue, 20 Feb 2024 01:18:48 +0000
Message-ID: <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708390906.git.ashish.kalra@amd.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com> <cover.1708390906.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ade043-d54d-45b1-0637-08dc31b1eb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U1XM5z/jNuIQmuXneSORjRuMmg7bkoyPuvRSbjrtj9AptpmaKjQeo+nC4KNHWScEjhQhMTkAw8JQhxJ7wJXxIfCUebbOEKE1g3y/XksLcbO3Myi05KmJwKZNZa3qTOPgKEwHO26hpQQBAdXdgVYUuwpFjWCkCQcrs0BXKA+9Ek2sRugLA7Env98VPb6TbOM68RGWigytR3/KAibPM4XyUx6Y/wBVxFjDPlh9O8DMXRt3OobDIq3PU3wBpA+JyiRMoF3k+l3Jj41Qdf6SDymTmo9dPCtvYne42YnbXnc3kg9pvho1qcpFAZU2UYRgEYtsPuMgO8VVr6ttQUL1CPoy1HllTPt23R33c3Api8nelZ3WU7FZQuyz5Ab0KABpzO46tDZv53uqqQ1wXTdNX1izIWS9h0yczou0xPj3qQs2lKjDw7W1DUfn2I7y/9+RCcArmmNN7Bu5R4GUIfNuhl4azlWU6bwTVePAbjGRPEZclK63QGWQYMZ6fOdudm2nrU9qFzD45dSStsTa21Ll7xfjhMNdihNmUgKrVmD7XJt+uXTdBijdOUzcG+cCFJ+4c0iBOeYOrEoShD68/WWEF+ESnAFYVCn10bbrDvjY07JvCNUqUd7MyVEKuu6D75YwAwgQm0RtH+9FNwXDvZd7aWpU6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:19:00.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ade043-d54d-45b1-0637-08dc31b1eb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288

From: Ashish Kalra <ashish.kalra@amd.com>

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping will cause unrecoverable RMP
page-faults.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally. Additionally for SNP guests convert all bss decrypted section
pages back to private and switch back ROM regions to shared so that
their revalidation does not fail during kexec kernel boot.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   8 ++
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 211 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c     |  18 ++-
 5 files changed, 253 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/probe_roms.h b/arch/x86/include/asm/probe_roms.h
index 1c7f3815bbd6..d50b67dbff33 100644
--- a/arch/x86/include/asm/probe_roms.h
+++ b/arch/x86/include/asm/probe_roms.h
@@ -6,4 +6,5 @@ struct pci_dev;
 extern void __iomem *pci_map_biosrom(struct pci_dev *pdev);
 extern void pci_unmap_biosrom(void __iomem *rom);
 extern size_t pci_biosrom_size(struct pci_dev *pdev);
+extern void snp_kexec_unprep_rom_memory(void);
 #endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..dd236d7e9407 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -81,6 +81,10 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+extern atomic_t conversions_in_progress;
+extern bool conversion_allowed;
+extern unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot);
+
 /* PVALIDATE return codes */
 #define PVALIDATE_FAIL_SIZEMISMATCH	6
 
@@ -213,6 +217,8 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
+void snp_kexec_unshare_mem(void);
+void snp_kexec_stop_conversion(bool crash);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -241,6 +247,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
+void snp_kexec_unshare_mem(void) {}
+static void snp_kexec_stop_conversion(bool crash) {}
 #endif
 
 #endif
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..457f1e5c8d00 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -177,6 +177,22 @@ size_t pci_biosrom_size(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pci_biosrom_size);
 
+void snp_kexec_unprep_rom_memory(void)
+{
+	unsigned long vaddr, npages, sz;
+
+	/*
+	 * Switch back ROM regions to shared so that their validation
+	 * does not fail during kexec kernel boot.
+	 */
+	vaddr = (unsigned long)__va(video_rom_resource.start);
+	sz = (system_rom_resource.end + 1) - video_rom_resource.start;
+	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	snp_set_memory_shared(vaddr, npages);
+}
+EXPORT_SYMBOL(snp_kexec_unprep_rom_memory);
+
 #define ROMSIGNATURE 0xaa55
 
 static int __init romsignature(const unsigned char *rom)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..765ab83129eb 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,9 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/pagewalk.h>
+#include <linux/cacheflush.h>
+#include <linux/delay.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
@@ -40,6 +43,7 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/probe_roms.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -71,6 +75,13 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Last address to be switched to private during kexec */
+static unsigned long last_address_shd_kexec;
+
+static bool crash_requested;
+atomic_t conversions_in_progress;
+bool conversion_allowed = true;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -906,6 +917,206 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
+static int set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	pgprot_t old_prot, new_prot;
+	unsigned long pfn, pa, size;
+	pte_t new_pte;
+
+	pfn = pg_level_to_pfn(level, kpte, &old_prot);
+	if (!pfn)
+		return 0;
+
+	new_prot = old_prot;
+	pgprot_val(new_prot) |= _PAGE_ENC;
+	pa = pfn << PAGE_SHIFT;
+	size = page_level_size(level);
+
+	/*
+	 * Change the physical page attribute from C=0 to C=1. Flush the
+	 * caches to ensure that data gets accessed with the correct C-bit.
+	 */
+	clflush_cache_range(va, size);
+
+	/* Change the page encryption mask. */
+	new_pte = pfn_pte(pfn, new_prot);
+	set_pte_atomic(kpte, new_pte);
+
+	return 1;
+}
+
+static int unshare_pte(pte_t *pte, unsigned long addr, int pages, int level)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	/*
+	 * check for GHCB for being part of a PMD range.
+	 */
+	if ((unsigned long)ghcb >= addr &&
+	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
+		/*
+		 * setup last address to be made private so that this GHCB
+		 * is made private at the end of unshared loop so that RMP
+		 * does not possibly getting PSMASHed from using the
+		 * MSR protocol.
+		 */
+		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
+		last_address_shd_kexec = addr;
+		return 1;
+	}
+	if (!set_pte_enc(pte, level, (void *)addr))
+		return 0;
+	snp_set_memory_private(addr, pages);
+
+	return 1;
+}
+
+static void unshare_all_memory(bool unmap)
+{
+	unsigned long addr, end;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		/*
+		 * pte_none() check is required to skip physical memory holes in direct mapped.
+		 */
+		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			if (!unshare_pte(pte, addr, pages, level)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+		}
+
+		addr += size;
+	}
+	__flush_tlb_all();
+
+}
+
+static void unshare_all_bss_decrypted_memory(void)
+{
+	unsigned long vaddr, vaddr_end;
+	unsigned long size;
+	unsigned int level;
+	unsigned int npages;
+	pte_t *pte;
+
+	vaddr = (unsigned long)__start_bss_decrypted;
+	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+		pte = lookup_address(vaddr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)vaddr);
+	}
+	vaddr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(vaddr, npages);
+}
+
+void snp_kexec_stop_conversion(bool crash)
+{
+	/* Stop new private<->shared conversions */
+	conversion_allowed = false;
+	crash_requested = crash;
+
+	/*
+	 * Make sure conversion_allowed is cleared before checking
+	 * conversions_in_progress.
+	 */
+	barrier();
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!crash) {
+		unsigned long timeout;
+
+		/*
+		 * Wait for in-flight conversions to complete.
+		 *
+		 * Do not wait more than 30 seconds.
+		 */
+		timeout = 30 * USEC_PER_SEC;
+		while (atomic_read(&conversions_in_progress) && timeout--)
+			udelay(1);
+	}
+
+	if (atomic_read(&conversions_in_progress))
+		pr_warn("Failed to finish shared<->private conversions\n");
+}
+
+void snp_kexec_unshare_mem(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	/*
+	 * Switch back any specific memory regions such as option
+	 * ROM regions back to shared so that (re)validation does
+	 * not fail when kexec kernel boots.
+	 */
+	snp_kexec_unprep_rom_memory();
+
+	unshare_all_memory(true);
+
+	unshare_all_bss_decrypted_memory();
+
+	if (last_address_shd_kexec) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		/*
+		 * Switch to using the MSR protocol to change this cpu's
+		 * GHCB to private.
+		 */
+		boot_ghcb = NULL;
+		/*
+		 * All the per-cpu GHCBs have been switched back to private,
+		 * so can't do any more GHCB calls to the hypervisor beyond
+		 * this point till the kexec kernel starts running.
+		 */
+		sev_cfg.ghcbs_initialized = false;
+
+		pr_debug("boot ghcb 0x%lx\n", last_address_shd_kexec);
+		pte = lookup_address(last_address_shd_kexec, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)last_address_shd_kexec);
+		snp_set_memory_private(last_address_shd_kexec, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index d314e577836d..87b6475358ad 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -214,7 +214,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
 }
 
-static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
+unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 {
 	unsigned long pfn = 0;
 	pgprot_t prot;
@@ -285,6 +285,17 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 
 static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
+	atomic_inc(&conversions_in_progress);
+
+	/*
+	 * Check after bumping conversions_in_progress to serialize
+	 * against snp_kexec_stop_conversion().
+	 */
+	if (!conversion_allowed) {
+		atomic_dec(&conversions_in_progress);
+		return -EBUSY;
+	}
+
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
 	 * to invalidate the memory before encryption attribute is cleared.
@@ -308,6 +319,8 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
+	atomic_dec(&conversions_in_progress);
+
 	return 0;
 }
 
@@ -468,6 +481,9 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
+	x86_platform.guest.enc_kexec_stop_conversion = snp_kexec_stop_conversion;
+	x86_platform.guest.enc_kexec_unshare_mem     = snp_kexec_unshare_mem;
+
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
 	 * parallel bringup low level code. That raises #VC which cannot be
-- 
2.34.1


