Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF2251B2D
	for <lists+linux-efi@lfdr.de>; Tue, 25 Aug 2020 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHYOr6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 10:47:58 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:14897
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbgHYOrt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Aug 2020 10:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLkt/EInMqve/DppfxbNHVJpKoov7SVzsCgBOMjmiLvJ2fA4stb+CYHWDUAdTpALfVgx39zDQE0QAAnEybHhO+gn1x7ip8vaMsrG6/ltReV0Pj2xuOHMqDg7nlbsLlM/HrzMlLfgNddncxAY5HWpLwoEk2/8M6zKNtv+fVWQylW9By9++el220tiCrr2+I5pT8sjk5L/JWVPTXkemcYKaG1a3i5b6jS6MV4ocDaGTXeEgyJSAJ08A2pzD8Sb7ZPvkDFAlo61bBz93BR7Ohdh9nUZT1Gy522o4eFtmEqXv2Jzl2oz+OtExUWDaZyd9aabLa/UqlzjS9O7ddQyVC1mnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEw/V/AO5hMnh324TwpMH8/BiZhFi9HtDLmQbBzQHM4=;
 b=DWXvV76f6AInvldnU0dDye1mbxXUSKaLfBe1QOs7e1I3LIXJ+mxhNBGtw/NHBrlGIUvLaBswq4StAejAwQRSUN4tEqUhbuNsJymNeDK8Sxk+g5xZ8i/AN5zqwIHILBarK0IH2quC/CUjkFzqcOiB9cxecf4VAzt31Zq2+JHA5+LhIElb1rxhUsmw8dEhX+ulsA3gQRHAIMWIiy44xAqcKU5jH+LWra5Z5htML2CyqEZi/KjnvSTTuIm4jLbDGu4izkC5A5tAz2mDjXWV7tIA77cCXxNM8H4zEtWSr6y5SD3HDL/GbCAnWLr22X5sLqeQyJKAC9FCCFFAYODF6paMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEw/V/AO5hMnh324TwpMH8/BiZhFi9HtDLmQbBzQHM4=;
 b=Wl2/Z133cZwa8CC+E/mbsAFcXwBt6ez8HuTxf+RTUabci6nyq5zDxyomvpm2dqo1av/prnGOZgAzWDkPA8yU6nsyAFLOEKn3zfWtuqcgY1LO7aR6zWdbBqFbzX5zb7/VAOoUPkLjnsr/WS3D/79w0Lb+ZXX77jEdDWxkfhjiq1g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 14:47:41 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3305.025; Tue, 25 Aug 2020
 14:47:41 +0000
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
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 1/2] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Tue, 25 Aug 2020 09:47:09 -0500
Message-Id: <20200825144710.23584-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 14:47:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37477c20-2ab7-428f-ed1a-08d84905d148
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2413FAE0B6D6260E8FFB08B190570@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBpEG6W/7TwnXK0/AwINW3nB98R6gBi26qbHVAVM4AaGefXGRNX9y6oxRZHwlAR65Eg+81KHor4jzztimC01ayZ5IyCGJk0sB7TDYrLustYda7H5CW1xRaNqBQlS7bhOXnAveoI5k+cer8LPBV5OHQ2JggWDUBNGWAzH4qSXDtyipjk3SgzFU23puuS3mKsb3cM9sh6ku40mBei6NxV5tdAknbVkqjUm4uiNOlzmixlO+RTcsOSDvqL4Jb1fFLhnmnM2/ryPmr1kKhPiQoIKhVRNWsb0k6y2SslJ4naX1PaAwJPNBJXMFcCAyEeVuH5FfAn+exCzh/2k8us1NtJdtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(7416002)(2616005)(6486002)(26005)(186003)(956004)(5660300002)(52116002)(54906003)(4326008)(83380400001)(1076003)(478600001)(316002)(36756003)(16576012)(86362001)(6666004)(66556008)(66946007)(8936002)(66476007)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Le8QxCX/g2PWgXwpce7dY4tUBiygSJ2w6h4ZO0aUPndUL9To8yQSpM2GVkaN0xzfU4bBOpcM3FZEgLiQUruc5oMTNV8Wex+rtPbDrM7tzzdhHep4IMy/uVi+Gy9roq5/2/29ujnBGNfYSsfvT1x0n8SGW7hmdsdsm2hpD76zJSMcmr3VhaCLTRookQYZ0yyYA/Fos4LgbTjVs+irc9f4VNnfL6WoBtI3RP8+HO9dIaC/xbMl1PYO31xVNGEZULR5TrMJkKN/kws4RTbMd/GFkRZax9FrSYRelC9083vYqqhfmKmo1wROLjE96asHjtteQrLCrvz6hRY1G/qfw69eZhvnt//SRCWPRMXk7EagIpIr4EgjltO66VZ56AWF3qOMPNl6dB3vu6BAy42HiGoERHt1PIxKabDqYV3cZUKptrMNtjebDfN+BS3cy+ABwUsBN9LSYdScj8osWhKhfXydAXulAHZMrsEaNEPVZJiNrJpzHw2I+oRDGtTSLX3i5AS6Q5+UisNvn7xvuNGPzRN/O/SnIHEyX31lu50UfWjPe7yF5Fys88hGPZck2sdSWddW8e7RVXlv4C2Cx3oPQ/B/cMQRmoasVz1eW2SFFXHQQ9TuQ2oK7BCd7GZU43Eu08mNDURCtCTjlMyc2MBNA9j2Hw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37477c20-2ab7-428f-ed1a-08d84905d148
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:47:40.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRLxxyqmlcnsfxgsHq39FdD/IkKbTnda22zpJgLt75/8bJNHCO0B01SLI5fa2VU4VW4RX6HaCS6soncwdi1WgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
Sender: linux-efi-owner@vger.kernel.org
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

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: devel@acpica.org
---
 arch/x86/include/asm/mce.h      |  5 +++++
 arch/x86/kernel/acpi/apei.c     | 10 +++++++++
 arch/x86/kernel/cpu/mce/apei.c  | 38 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 10 +++++----
 include/acpi/apei.h             |  2 ++
 5 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf503824529c..dbcb6bd80b7c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -291,6 +291,11 @@ struct cper_sec_mem_err;
 extern void apei_mce_report_mem_error(int corrected,
 				      struct cper_sec_mem_err *mem_err);
 
+struct cper_ia_proc_ctx;
+struct cper_sec_proc_ia;
+int apei_mce_report_x86_error(const struct cper_sec_proc_ia *proc,
+			      struct cper_ia_proc_ctx *ctx_info);
+
 /*
  * Enumerate new IP types and HWID values in AMD processors which support
  * Scalable MCA.
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index c22fb55abcfd..053d6e994e87 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -43,3 +43,13 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
+
+int arch_apei_report_x86_error(const struct cper_sec_proc_ia *proc,
+			       struct cper_ia_proc_ctx *ctx_info)
+{
+	int err = -EINVAL;
+#ifdef CONFIG_X86_MCE
+	err = apei_mce_report_x86_error(proc, ctx_info);
+#endif
+	return err;
+}
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d37962586..d7f405e55d31 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,44 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+int apei_mce_report_x86_error(const struct cper_sec_proc_ia *proc,
+			      struct cper_ia_proc_ctx *ctx_info)
+{
+	const u64 *i_mce = ((const void *) (ctx_info + 1));
+	unsigned int cpu;
+	struct mce m;
+
+	if (!boot_cpu_has(X86_FEATURE_SMCA))
+		return -EINVAL;
+
+	mce_setup(&m);
+
+	m.extcpu = -1;
+	m.socketid = -1;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_data(cpu).initial_apicid == proc->lapic_id) {
+			m.extcpu = cpu;
+			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			break;
+		}
+	}
+
+	m.apicid = proc->lapic_id;
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
+EXPORT_SYMBOL_GPL(apei_mce_report_x86_error);
+
 #define CPER_CREATOR_MCE						\
 	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
 		  0x64, 0x90, 0xb8, 0x9d)
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 2531de49f56c..6622e9824416 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
-#include <linux/cper.h>
+#include <acpi/apei.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +347,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (arch_apei_report_x86_error(proc, ctx_info)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 680f80960c3d..e8ab17395887 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -51,6 +51,8 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+int arch_apei_report_x86_error(const struct cper_sec_proc_ia *proc,
+			       struct cper_ia_proc_ctx *ctx_info);
 
 #endif
 #endif
-- 
2.17.1

