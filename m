Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B212A4BF4
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKCQuW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 11:50:22 -0500
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:65409
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgKCQuV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Nov 2020 11:50:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOouscY+pjfzw5xEZ0pweaZibXOcJL70Mzvby+hUtWVuwKkX3vUsNgGNUJU8zu5aDRvWq8Q+O3OpJW3iIW/LmBhGs2IP+U8ClPf76Gm9zhXfWlJy8hzxg1yMQv+djYDQMUoKNUMks3AYfP2y/tdo7jGqb4krklb0uAwLAmuFpZ8GAabjwkCGUBAfZmtmWMpCYa/VqcHbz9yaumCgbRWihZHAgEj4bHXjZAZinTvxdwjIIZrKNc+S4Yjy42jhySfCIzgQvFe0moRIlTgtStXzr9DgEKjPcmLhf3tO9lqFQrX68JAnASmsUSloFgBwHgw6WzxSTmLnQpsByUvENzLndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mELxmdT19qZnIlROXuKKaCnwwdwsikED+QyiVqvW18=;
 b=VmeVfv+GXFB9h3kIQAciLc1SuwFlEA/wDirP+NLrO1Qrp7+7rC+27khxTmN7BzEoDgvBOM/UX69Y6/aumHegUnyrGLxpqjjrpOL/PiNR7d44XwdVjyDNr0sTWjju3Gr1fiUIqU/kC/TooTeAZvzOh9Nn5+zeilUoSwgd/KSytCBffEYgKc7twlQzOU7Iyadg4q4WMRnpvwcChUJb3asfnpiPl1jiiPqdOGEqSEflm80DsurCq+eAd+MPbvDiyrte6e7U2BD/EE9oNIrIHGQAkXnSOWtOTFlIx4IWLw61mBqBHLdAFsTyFQ7bd80+ajjnynwxFuFzVFJibaPIy1tzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mELxmdT19qZnIlROXuKKaCnwwdwsikED+QyiVqvW18=;
 b=VAAdQrtx4w8PycthfUdIPFtkOBOx7UMdDRkfSd53p5NHCaO8AiXNSIRJ0VWC+w7ARzJINd/UVl6dgbcGAajsQZeWbtULkMDDymF3zNb4adpePV2aN1jV8456OK5XXwahOWXZdiAeWLOu7kQQwRkEcEFfPsj9068jYGVTlA3Nw/4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 16:50:18 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 16:50:18 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Tue,  3 Nov 2020 10:49:52 -0600
Message-Id: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:d3::33) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA0PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:d3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 16:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f330c0b-e748-4ddb-3976-08d880188bb6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4413B1593B0C4070BF57F8EC90110@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJtnAho1AXUvboqRziC4lhVhgufmLBzyhz9ZtnDXynelRGnay3Fswcj+ay2wzWRkXLslD66BX3dMg12RzXFCAThVquDA5DfHkz1X85CWRZdRNf+jWaAc10PIXjPjpqSU0hIi6x2o7MjKPH4dLqD1ZYKMefh49xlLeo58VqO70Jy68DwiJLgfoZJA/1r+N+KmTMzUryWutTqJfYtsfw+u1uOTVbhUKlr1Hcv7wi+sY3aq6Ykclu0MDAXtzu0tNyx2rnkEoFck1FHIRTvg7aShNtpA8rVDL85j/dESWILoWXTIfrhr97Adau2CVvO0MsfzrJGPObwT/b1tX9LI8/kznuLuylg93cpAYR3UAE1WJ3sOvnS8v2si0gqIWRL/PQAUgvAdB87KBKrr87lehSx/hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(2616005)(54906003)(8676002)(66946007)(956004)(7416002)(4326008)(83380400001)(86362001)(26005)(5660300002)(316002)(52116002)(7696005)(966005)(16526019)(66476007)(36756003)(66556008)(186003)(6486002)(8936002)(1076003)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5JVW8r2pnrNDav4BpLMfrBxnVUctZ0UxyJnZf7zh7hekl0qK721hnXBipBpghMuA9OEtW/e/D3C5Vh1HMCfJgLjLVBdPK5RLPUK9sKqmcWPjBUyGtLYqaZtaf6bcTZuISkU8PdwUgtCx5e6sKLIit2KlWIPVEvb5CM15lnhhVTNkecp4unr/lQAg9xaasO3wDiU8j6HpNQJ34xLBV6tTt0angTwW+I+1J+eOQpg6JFV+BrgilR7wzhN/JmG62s1lExlZf2iKESASYycCwWw7ubmDsOLKZIzFaLbWWaQNGDMCUiP7l2Y9iTZTt75o+cBFX1M1JUomdDTGT3xjPQeL8f9irDcIbVCPedRiElBelNU4Sb2XYZpe9mtV7A+/wM2YaGBy3QX8htqCfJipAF/3cZQEam0+WMquJX37kY64AhliEAOShLEkRfDNi7oCMvY1OmKxLIXfpqzz1em11LKZz+AZHiT7tziZOgqrbTEGH3cF7QjfVyehnxgJf8xNUiCP3zoW54q5NbnCLr///sO0pHQPM7r2lwHe+3mlVrH2nGoESP8zTRymnmQOZyTHYooq8lNjsY+SY913C0hoABc8in9BobSQK7f6O7qG5iNwu/StT69YS/md+b79SRiybY2Bq5TNQ7LV7RGqjQGlHn9VtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f330c0b-e748-4ddb-3976-08d880188bb6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 16:50:18.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqp/VJn3WwbV1VPkYwakEbN4mvK6s9DOJjA5tUVKS4m7qpxXspbTcFoGbIkvmM1jOqyWaj+y1D/hGUEXRFNngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

[ Fix a build breakage in patch v1. ]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com

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
 arch/x86/include/asm/acpi.h     | 11 +++++++
 arch/x86/include/asm/mce.h      |  6 ++++
 arch/x86/kernel/acpi/apei.c     |  5 +++
 arch/x86/kernel/cpu/mce/apei.c  | 56 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 11 +++++--
 5 files changed, 86 insertions(+), 3 deletions(-)

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
index a0f147893a04..07eedfd6ec38 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -198,16 +198,22 @@ static inline void enable_copy_mc_fragile(void)
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
index af8d37962586..f56f0bc147e2 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,62 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
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
+	 * The starting address of the Register Array extracted from BERT
+	 * must match with the first expected register in the register
+	 * layout of MCAX address space. In SMCA systems this address
+	 * corresponds to banks's MCA_STATUS register.
+	 *
+	 * The Register array size must be large enough to include all
+	 * the SMCA registers which we want to extract.
+	 *
+	 * The number of registers in the Register Array is determined
+	 * by Register Array Size/8 as defined in UEFI spec v2.8, sec
+	 * N.2.4.2.2. The register layout is fixed and currently the raw
+	 * data in the register array includes 6 SMCA registers which the
+	 * kernel can extract.
+	 */
+
+	if ((ctx_info->msr_addr & MSR_AMD64_SMCA_MC0_STATUS) !=
+	    MSR_AMD64_SMCA_MC0_STATUS || ctx_info->reg_arr_size < 48)
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

