Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4727002F
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIROtS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 10:49:18 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:20967
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgIROtS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 10:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeT6jUPby05E8XLU42DZPSEcdnoGAdN6ywGhpvhfAchdCFSqAMBzadmmg1gRIyvN8cpfOCVtgaclWPIph+5L5zw1e2PrJowPABvWtCmUB62C3m2wcqG6ySG5s5TUqWI41Uf6XBy4vLVKZKZAuauMuR46oTmUnY0gCOwv1G20l1zWVvc9VIumCqXRlU5b2qr1jOI4Sjs/zbWuXh7Or7WtMbCPDuzZoFeB9WACtcLrEFIRTwTCITSNE8KRstYmx5ZMGtjiM9FR3PenASaOV9peOLNKybGC9R7UY1a/9fLvKDm83ADeVvfoHyM5V1z0f6LNYHDaHdJC2nctnww7iTZv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09A6sRsgRHY7bMHDNZrt8tKZ1wLV706KIkTiTa79h1M=;
 b=VTuzM6w1zdaGvH35byPvvvgMLqIpGpPAk2UwsUPMtHbeProsQIFdmTz7ahVhYP9ttqMAtEz8aT3KYtozHf5ySWJt+Fhrh4+IQ+KhfXrDEnn/aNBtEK8EX9GtmlBTwXaC9XLSH2XHEQNiS/lc1aZnn/ywcgHpcWwOzTIyKr/caduVI3TTI+vCruJ/5L6N/M9F+X+l4CotT8IirgqCHnsyXYtn7Uwb8Cf/5doIwd3y7sj36lMzw7pZDkceMQMPn3n0jncFKfghUs8z10BdsvwTiXFCLUy38URSihiXTC4gkH/AV61Mg3MZRcyVo9gA99DfVA/nZXsdLDIv9iT5XtoVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09A6sRsgRHY7bMHDNZrt8tKZ1wLV706KIkTiTa79h1M=;
 b=SYvJZcLodWOQtanE1RYVv3j5HGCNV4quRvJYeteoJvon3B2Vg11DUG/2+bEqW4slaqjtbfEMSNfYEZO1BbOqhTZ6RYp5e3Z7yTT4fdmxQX0gAd6YQlhM9puepvnYY4kYaqTxHTg15uVM95tuRfqhIOA66kPDHK3iJSzFTV1qt6w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 14:49:12 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 14:49:12 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Fri,  4 Sep 2020 09:04:44 -0500
Message-Id: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx024ehost.amd.com (165.204.78.2) by SN6PR16CA0067.namprd16.prod.outlook.com (2603:10b6:805:ca::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 14:49:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73688174-1ca6-4948-82ba-08d85be2018b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2368D5A49B77E75024B61300903F0@SN1PR12MB2368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlWb5EF47diCyT6TBI++1qQqfizcJwqtaS7zLDWPD/rLh+V6I6J9csyzZHxgOhAJuju18cs9IyfUebB+c8dau7M6gUP7iO+7DVJJ6up8GVllD/PFd60arnPu/z1aOGw2vBqB9Oa0eri1pQ0eMRNAsWYMjpbppXBYfMZDzt3tZ1zbeC8lrZooYzWuTvqaIgplQKWgEoW12vs3a0Fv+3wbphsFi6HDBIJ+U59eBaEh7R7lQxz7TakEcGQnlElBUtKePlzgBfBx/gH65vtve+XYERY9KW2rTZrZ6157T1zjRGNRJE/HpBOHkYpBTm7fZqQgbn7m6851OJZBE6FtbI9PFebgp8pB8gHJkKQAflpuCcAXO8eTvv6IdNg8LI/nA8/v39OXq4tHBOLMubuV5Kj66w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(26005)(5660300002)(478600001)(52116002)(7696005)(2616005)(956004)(83380400001)(36756003)(86362001)(1076003)(7416002)(8676002)(6486002)(966005)(2906002)(6666004)(54906003)(4326008)(16526019)(186003)(66476007)(316002)(66556008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Plf0OTrnKkvpJ7qsNvdhfb3UXuXqj3cRheUwn6wcO0NRmAZV5exOjUWpAam8ETLsxSv4RudmuOZmNzLrfdvpMawYwjKjWKjFrPinZ7+ENRgrHZmaax2qwyvsllksgT1zPVR+NfNT0qCaXNk/WoUTpRPZGaOE5Eul9dU8bRBakoTtR6IfyEpHIg1LG8nd0/KWpLH/H44h9Cb1TYvxaUngAbSWQ8omX38hVHlRyoYDA8JE58VjWmjAsL0PE0GJqi2/dhcw+Z4XEUyL48byMR7A6E47VVoRTBNstQv8FL854t1ur6szvjs0wq95HuTQ6RI4SVkgnN4BM4EcX5mSw1W73gaWVtLQp2Jpf5wF59FJXkxEDWgD2NI/Uaf2nI7XWwSwgShOKQtdNVnnbsGC+MzRuptnyRUAHXYdztUpqX22ByVOsBv5i9IPwdOjbCxxpkcLkA5MqOJauPjJLJ9NUX8NCXFmFO8XEt0cKXPRbGCUwpdCjQPFQzrlXstiC6BrYox7BAfZdSyUmpi2Ss1l2SBZGYVUc9S5W9u6aEAsxgcobfxhemmBU1rHmoPhWgmUKdv1fzBSLdma5TFvKtLdwgr5b4C7+Gqyo9k710i0e7wrM8441yOZUdnmh68L9AHdRgyGCQ5q4RNZ4sPyqJX8FQsFjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73688174-1ca6-4948-82ba-08d85be2018b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:49:12.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jfXcpwFfATqB1Y4NEFtCHaB/3KTj9maxMaF/9Vdv/eTiROWgd0RIKEwC+N3Zt35ylS1hfIqKFgQzLRY6QokcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linux Kernel uses ACPI Boot Error Record Table (BERT) to report fatal
errors that occurred in a previous boot. The MCA errors in the BERT are
reported using the x86 Processor Error Common Platform Error Record (CPER)
format. Currently, the record prints out the raw MSR values and AMD relies
on the raw record to provide MCA information.

Extract the raw MSR values of MCA registers from the BERT and feed it into
the standard mce_log() function through the existing x86/MCA RAS
infrastructure. This will result in better decoding from the EDAC MCE
decoder or the default notifier.

The implementation is SMCA specific as the raw MCA register values are
given in the register offset order of the MCAX address space.

[ Build error in patch v1. ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com

v4:
	Included what kernel test robot reported.
	Changed function name from apei_mce_report_x86_error ->
	apei_smca_report_x86_error.
	Added comment for MASK_MCA_STATUS definition.
	Wrapped apei_smca_report_x86_error() with CONFIG_X86_MCE in
	arch/x86/include/asm/mce.h
v3:
	Moved arch specific declarations from generic headers to arch
	specific headers.
	Cleaned additional declarations which are unnecessary.
	Included the check for context type.
	Added additional check to verify for appropriate MSR address in
	the register layout.
v2:
	Fixed build error reported by kernel test robot.
	Passed struct variable as function argument instead of entire struct.
---
 arch/x86/include/asm/acpi.h     | 11 ++++++++
 arch/x86/include/asm/mce.h      |  5 ++++
 arch/x86/kernel/acpi/apei.c     |  5 ++++
 arch/x86/kernel/cpu/mce/apei.c  | 49 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 10 +++++--
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6d2df1ee427b..65064d9f7fa6 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -159,6 +159,8 @@ static inline u64 x86_default_get_root_pointer(void)
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
+struct cper_ia_proc_ctx;
+
 #ifdef CONFIG_ACPI_APEI
 static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
@@ -177,6 +179,15 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 	 */
 	return PAGE_KERNEL_NOENC;
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
+#else
+static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id)
+{
+	return -EINVAL;
+}
 #endif
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 109af5c7f515..d07bd635acfd 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -173,17 +173,22 @@ extern void mce_unregister_decode_chain(struct notifier_block *nb);
 #include <linux/atomic.h>
 
 extern int mce_p5_enabled;
+struct cper_ia_proc_ctx;
 
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 void mcheck_vendor_init_severity(void);
+int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline void mcheck_vendor_init_severity(void) {}
+static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index c22fb55abcfd..0916f00a992e 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -43,3 +43,8 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	return apei_smca_report_x86_error(ctx_info, lapic_id);
+}
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d37962586..d4b3a2053eef 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,55 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+/*
+ * The first expected register in the register layout of MCAX address space.
+ * The address defined must match with the first MSR address extracted from
+ * BERT which in SMCA systems is the bank's MCA_STATUS register.
+ *
+ * Note that the decoding of the raw MSR values in BERT is implementation
+ * specific and follows register offset order of MCAX address space.
+ */
+#define MASK_MCA_STATUS 0xC0002001
+
+int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	const u64 *i_mce = ((const void *) (ctx_info + 1));
+	unsigned int cpu;
+	struct mce m;
+
+	if (!boot_cpu_has(X86_FEATURE_SMCA))
+		return -EINVAL;
+
+	if ((ctx_info->msr_addr & MASK_MCA_STATUS) != MASK_MCA_STATUS)
+		return -EINVAL;
+
+	mce_setup(&m);
+
+	m.extcpu = -1;
+	m.socketid = -1;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_data(cpu).initial_apicid == lapic_id) {
+			m.extcpu = cpu;
+			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			break;
+		}
+	}
+
+	m.apicid = lapic_id;
+	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
+	m.status = *i_mce;
+	m.addr = *(i_mce + 1);
+	m.misc = *(i_mce + 2);
+	/* Skipping MCA_CONFIG */
+	m.ipid = *(i_mce + 4);
+	m.synd = *(i_mce + 5);
+
+	mce_log(&m);
+
+	return 0;
+}
+
 #define CPER_CREATOR_MCE						\
 	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
 		  0x64, 0x90, 0xb8, 0x9d)
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 2531de49f56c..2f2b0c431c18 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
 #include <linux/cper.h>
+#include <linux/acpi.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +348,12 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
+		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
-- 
2.17.1

