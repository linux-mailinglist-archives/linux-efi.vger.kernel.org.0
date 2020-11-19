Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FF2B9AAE
	for <lists+linux-efi@lfdr.de>; Thu, 19 Nov 2020 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgKSSaG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Nov 2020 13:30:06 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:27392
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728578AbgKSSaG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Nov 2020 13:30:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPd7unqxdXZBv4PzWmvWJdEnFxU9oQRl7KWMpBJH6DMbaVSDSkJKso+VdhIJSaCacy8ltIktC3BFJGiW5NbJ20evvxU4aVwtHHFqJiTBPvGK3hNC0r4gIkscFv3JXHfB0sCQqKycAuXl3k6rdgl+zozik43xscPlDnRdDuITL6l0c4KR/nV5AOizWZCZokE+6tajYHoy5aptKGM97UmQSZXvieg9P5i2bjeDqyT/HFujcXPrYcM6sHe+NMAUK7FkHIOGes/Cg54Y72neibWlulUUPYJdhZ+vwsU7+mvk9vSjCRFjeuptwkR73tjVwR+cXf/ojjWSqrlonhvGJ+tsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Pe1ZLPvscS/B7ra+jLEW0RffUcHT2bKYVL0SYakPY=;
 b=h94cBcJtuBYvdD2mqQ2hT5OkO/hgorYEMfUGildYK2IVr8h8M86cRGoRD5VRLbvftASgDKmG3hJcAoVVzKn9TE4wtp5AY9qilpw6mxdC0yPm0QKubxHKYRDEedQu85PoBxSkUGYH6kylQt/EDCSiqjPAxTUF+TenFwjkp5f0xHZ7lK9bMxZyeBz+9Ep4RcGnN7yeImUJNiQY/sgmTHEbcpjc6bZYFXF8/w+XwJbKSIsIbZywik042BYTAPLSIm6E5ZyEuwJPydWajYq+kJKVG/vcWV2Xpkm8uwNkt4PzlVgzHm7D0k/27RfFXQqmrBmJIzP/KVff28SZNVKxb7WRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Pe1ZLPvscS/B7ra+jLEW0RffUcHT2bKYVL0SYakPY=;
 b=QBqgFnRcniuIf/wqor75TMtdXuRZwJ2b5OP13eRzR8OBLqlLMd5Pkj5BfSP5tZcDZuNvqJ7tBh81jraHhnMMtHrf54jEiAFzgFKCQQZufrJf7wPYclf7fXFEiemFZxmEKvh/v2dpfv39fqACJZXJBPcPxW+Iz5mesfgWmhKEatM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 18:30:01 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a%3]) with mapi id 15.20.3564.030; Thu, 19 Nov 2020
 18:30:01 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Thu, 19 Nov 2020 12:29:38 -0600
Message-Id: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:3:ae::25) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.78.2) by DM5PR15CA0063.namprd15.prod.outlook.com (2603:10b6:3:ae::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 18:30:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf1eaad8-e8af-4b35-a5b7-08d88cb92067
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44309E71214ECE67214E9D9790E00@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv5lboVqJnn2DP/tBPoRlELF2K6oZynMFRceGhAERxyGf59X/lQ9ERLT28ga8Ynt/36j755q3IV9+IPh0tIcrt55NLGcHa8r+tx3v1x3LCD+x4jzGPuhyI3LmYjqMuo6X0zxaoMrtmjd2gzp1rSQWtF0bl0JHrID4aZk61zZtyeYuZJsN1fwHy5IQ1zHmBX9bSbIo9R+lH26CEDu+dR8V2Lgw29m1bidmWYiX/wqZLnIQaeQmE26n6vDQvWRbRkOAA2+9BGNUzXa7EUl1EWBKoxguAe5rkVw58hGGzgIb/MMl34RBQHAg8b6Qv+eJ+Vjjldg9MWw+Xn1ATBdUmju4EjBqWcd2iI6gV8T0vHtsF49qgy1KHxndPEHIQ9TUHAy5aqJ21e/Fgs3Oj0EmzjI3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(66476007)(7696005)(66556008)(52116002)(5660300002)(83380400001)(66946007)(6486002)(7416002)(956004)(316002)(36756003)(4326008)(54906003)(2616005)(6666004)(86362001)(26005)(186003)(16526019)(966005)(1076003)(478600001)(8676002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G71z+mXy2s1tT1amnqAaBFUtdDI9mYBztgju2HMozQSfWan45tHyeO8LrFXcc6ZNOT3w5H09Q0+l8aVLS1qFBsyGDoUoQktAuyRJw/3QNWJ+8r0zcNkpgTO5w5W2j7/usj8AXW8fer06LgskETfKM9oMZHLvc/yURyJMnrI3AD/uavQ7z+yr64ZO9rkRDJR8B4EfEE/p+OSkCDpXz4kD32KJSv/QXQcJasW7WNhCh0c5uS4E41Q7u+9zkZfrgEZSZaLqUqFWjAoOuifQrzHNWo9YV53dliYfbQZcVOw4Fxsx5Bnvg04DDcYfBzdZUGs47jEqsATwsDNlit2JBp4J6uDFtWYq7iybnxBy4t9gba/nKN+XrQcmKj0IBYYKWBJ4i9OdBs/N1fvs01iHuPhM3hdMpPwxAbb1uv1nEXmWVE5QJBP2CVicsnyGxHeON2gT9eMGXbaVW5X6p3xo8vRQ3pPdkOG0/R17E7Z0aAyexeB+pny+091YdsVOwqvlG7EWjaN8EdKrrn2O6vh0jaG4L870u3TQb8HLpPy8fcquUBrX1tAYMMxvkuHiFw+G/4VwpUQJUQoipqfLG4X0TsqaIK73s1iLk1hvWKngVWMDsYnS8PqxyrDe4PfgFC7XlWUpI4WQLcUDarM4oLx9S/TBPjXN/3Ama+tg0EF8JZetfNtTL+Sie2iwZCo3ny6Pv+KERE5iL+NfyO0FHgXFYDKgXXnkkn4/5YS5sj4JPvD/WMw9kYbLpi2T168CxJvdWgZb1i/nio/p46a+r8ZMi9OvkSzTUzn+wAqqAq14VFghCMYoR94oSTHCUgRlGW4ub2j8Ccuim/buIim0BE39N0z5OGKMs+Yv3QQ94KTVGzca3rpoAI2VkzYf693PLuiHssCy7ZFgl9QeHhixLabXhDYojw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1eaad8-e8af-4b35-a5b7-08d88cb92067
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 18:30:01.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eYaRe7VwXLgE3R+kT8WUM0D/JIntZigr3mvgjmnhcN5gWt2WhIkzreeLGzT6LOgqA32m06u4I8NJraJ7EWagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
given in the register offset order of the SMCA address space.

[ Fix a build breakage in patch v1. ]
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com

v6:
	Separated out the checks for register array size and first register
	in register layout into two if-statements.
	Replaced MCAX->SMCA for uniformity.
	Rearranged comments and added comment for ignoring check of all
	MCi_STATUS MSRs.
v5:
	Included check to determine if register array size is large
	enough to hold all the registers which we want to extract.
	Used already defined MSR_AMD64_SMCA_MC0_STATUS.
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
 arch/x86/include/asm/acpi.h     | 11 ++++++
 arch/x86/include/asm/mce.h      |  6 ++++
 arch/x86/kernel/acpi/apei.c     |  5 +++
 arch/x86/kernel/cpu/mce/apei.c  | 64 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 11 ++++--
 5 files changed, 94 insertions(+), 3 deletions(-)

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
index fc25c88c7ff2..56cdeaac76a0 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -199,16 +199,22 @@ static inline void enable_copy_mc_fragile(void)
 }
 #endif
 
+struct cper_ia_proc_ctx;
+
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
index af8d37962586..a6c104f237bd 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,70 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu;
+	struct mce m;
+
+	if (!boot_cpu_has(X86_FEATURE_SMCA))
+		return -EINVAL;
+
+	/*
+	 * The starting address of the Register Array extracted from BERT must
+	 * match with the first expected register in the register layout of
+	 * SMCA address space. This address corresponds to banks's MCA_STATUS
+	 * register.
+	 *
+	 * Checking for all MCi_STATUS MSRs is redundant and can be ignored by
+	 * turning off the bits corresponding to bank number.
+	 */
+
+	if ((ctx_info->msr_addr & MSR_AMD64_SMCA_MC0_STATUS) !=
+	    MSR_AMD64_SMCA_MC0_STATUS)
+		return -EINVAL;
+
+	/*
+	 * The Register array size must be large enough to include all the
+	 * SMCA registers which we want to extract.
+	 *
+	 * The number of registers in the Register Array is determined by
+	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
+	 * The register layout is fixed and currently the raw data in the
+	 * register array includes 6 SMCA registers which the kernel can
+	 * extract.
+	 */
+
+	if (ctx_info->reg_arr_size < 48)
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
index 2531de49f56c..438ed9eff6d0 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
 #include <linux/cper.h>
+#include <linux/acpi.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +348,13 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
+		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16,
+				       groupsize, (ctx_info + 1),
+				       ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
-- 
2.17.1

