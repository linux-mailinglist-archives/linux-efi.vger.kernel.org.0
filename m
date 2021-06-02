Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D9398BB0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFBOIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:08:32 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:5601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230188AbhFBOHj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhV6rVv8+KL/eBXIEaudCVJyzSRRtISf9ccDyYJyNR1XPXfgcxyYyLj5ZsRbT9fY0q2b8fIwo/V6epvV5wyzKWJUJJo9QgB9JNKTMX9+yRYCk2s0Yx0Dw4MMryMT8yBgGyN0rKVWAGBcL2x5h3qurX9r/lmzQ2R+nLuJM9JVZtztYM6qIuGJCN8IhbBP0jHhKzXM+tzqI9zS/dWOuTGyShXTcf16drYyna/kHFW/ITzoIKKBiVySCBY8QZJanryXkOFgnxEKH2rsyR5hizxjBdsOs6oioPEdonpTRZiiUKdRVcISxbN6oyd2V7JR+bnLd9RqV942YYsT/Kzy24UtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unjJClw95OHFf0v1GyfbPhBEzoPqZ3guwOG+KUs0V9s=;
 b=n26iXGR8ol07NMG1YwsBJ4VLQfbSJtaOOcPM9w+mJRZL6f1OnCAaGti/ppMigHd6CCqv1LRsRo1ZVCeZHMGWcIbMUYG2Bs5p7ergRwiga9TmDt8/XRNVlwAefepc5gN/YItLsMpfXFhYhazSIfEabH0taju9D7logHWls2cbHX3M2TnL3FnfUaKX1NTCIDP5tmWn33AA+I9xMqkAXGt9DTjMSWWjyMvc4ooS523iBlPvvUgqc7AFQViJMYZE4Ji/xrIs7bYrmFUfSj0NgD1BLZWvjzBivYMBiQTlitc+9cluZeO60lRMF5+i9Oud0bXxJ8v2oEd8jpgMypbulT+y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unjJClw95OHFf0v1GyfbPhBEzoPqZ3guwOG+KUs0V9s=;
 b=EHGuimWvMK0ZP9powK0IB2TgGMVUzRgVHnvO8yzwDhcqS5SYMtlzkc5cHZfXZYR2b+pupWJObkioN3J9RsC8zRaOQ0ZDw83gWnf/XLT+caAs4A6yv27WilurJn01cTvKWeCIgkUrKwkxRirEK1QiJNmnXiFxMkwKlN3KI0AvIcE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 14:05:23 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:23 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request platform device
Date:   Wed,  2 Jun 2021 09:04:15 -0500
Message-Id: <20210602140416.23573-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dad9815-d945-485a-c637-08d925cf7641
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592FB3F2915E2080CC485F1E53D9@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2FG9AG7OsZShHxm2j1bdoSxdLEqtO2SzB31x1rnFjftQ9NZidjggAIvB+uwEM8lDDh73Gxc6R3C163IgVmKzzkvA1/ZYzJqmuySy4a814vw5JISUgsGkkwOiMWi5vQrGgVyDkHWugEm7NK10Pqodx+SlwboZTLVr/Pe9kpmipHjazyJ70iab1YWMEtQa83iyN3jWlWJ0jF0qDQdbwmfgmP9kHDxjQxKYXjJr1QbZ+ysc0dTqxOTAbrsyURCm861xLvhfqaCenDs3a8dGKsmvjUiXvNQ9Jh96YYOXdTcPJ+k2nCnmLa2G2chJjoAoJkExeEAfAgSHffNzjpu9VfwhKy6V7DLHSx/Y0hEIGSVku4a6x9UC5K90ME5NWdpJXiMGS4/SUh4FvSDnbzMf/p/8P/+L3dlsOaN6S8Zh2tYdZ2jCHaE8O07Q1hgOCTf0tCpM4vzFjIOtOksXA3gbUCnC6j0IVb+LsI3BE/9geLMQ4Yxtte86yjc/fmPGmCOoKSWROMn79qiblIs0JND2ZQxMZr6WqeBgJy11MP3ZTNtDv081zycIgT1Zgr5Z5kKq6co5FKJZpcZUMQBJjpnXUqkOdWHPYCxou8RgY5DSZX3kFi9EB7vxXZkOEBrK/bnthu5VrluElCPvQq1nyQVfFpE6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(30864003)(956004)(8936002)(8676002)(36756003)(478600001)(54906003)(83380400001)(1076003)(44832011)(2616005)(6666004)(38350700002)(38100700002)(5660300002)(66476007)(66556008)(2906002)(66946007)(4326008)(26005)(86362001)(186003)(7696005)(52116002)(16526019)(6486002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V2cIUWYknR0t4JTrFpV3cNwx0HEXJktJx7b9Vub5V/3kWQa02BMnJvJ9hfMA?=
 =?us-ascii?Q?GPp+CdJH9UJFu8+pBEM6vvqXM0xNMWwMfrcoZz7jJtj73O50xTs7O0YTFjt3?=
 =?us-ascii?Q?oNz8On9QHz4wNnTpUC0n1nU/BXFgwfVBhY3rZLI+G/re3iEnkDQ3ExWe3hkd?=
 =?us-ascii?Q?qEYiecFEOxvRTXKF/FOuG9klJLAJl/QkM+7PIXepPD/lTuB+cR2Me91wLPlU?=
 =?us-ascii?Q?L0x3ryPwatbsU0TmFaQwdU57Pt61rAUJPoenbg57EHu0n+Q0rBbEFFkdn4Mz?=
 =?us-ascii?Q?Vu88XEHEotaMHhO0vrDUtGBop6vm7WWdB7CDCwe4nP+zaxj3kA41C/IfPKwQ?=
 =?us-ascii?Q?RDH4ihfavd1MAyyQd3LZEQL5G7p9Kkuafs7zj5LtHMz4QJDKFJrn2YQSNRwA?=
 =?us-ascii?Q?hUJtzPtbxpMPJC3c2mZ4kc/eHb6f+Kb9vjJBCgFVELqpmtjLHPz+6iMHhJAC?=
 =?us-ascii?Q?0S67itAukwEafKTZQ/KAFxp2AIfvJLO1hsqa6aRy9dVoOEGNksFwpfJEIorg?=
 =?us-ascii?Q?DdxJs58JuMDCQ5AOuQFPhFnOIO8AuQSrrZWT+cWCYyPV1Kz7qn6eUBoGT/6z?=
 =?us-ascii?Q?EDG4QUkcZSATHXenCzNUG0JaOxnkSqfBb0bkto+F9ZyniGAoLTHVuo9Pa/4n?=
 =?us-ascii?Q?hYbHR1xWI+yWz50LzZg34RYjXIAUaVaXnUDKb+kbbngduqMoVodp7OmfvF/E?=
 =?us-ascii?Q?0uNT9c/PCote22IiRSLfFoSVoKwpOUslcg4Qfj09KfrNYhQlA+xFNZ+R68lk?=
 =?us-ascii?Q?yf+Cu/SvLuuhTq24MXoYdcpZFzJiP5srb48BVNv83Z+wfFDLLluQx9q7W33x?=
 =?us-ascii?Q?cd/CPALFOFnCOWNpO8kYp9OkC8YmCFyN2YMn2B31acMabXW1DwKt47Nn2Qw5?=
 =?us-ascii?Q?glW9kHKBv/Z5tUW7KZO9FFrDnzLWuxHrSYrzGH2Ri3/jssXh3dIRb0C5HKKp?=
 =?us-ascii?Q?NtUonj0xFI2Mp3+2eT/FfzUFytgSfdBFECTno7lQU3B4TtfusFxuAY6XQQRn?=
 =?us-ascii?Q?DHCqay+9ssEaGl4rB5kHvkt4oN3HaIYUB9onsKA9qqb+SgBXjwolzxOUr7FQ?=
 =?us-ascii?Q?Mtd91KFsJ/L4uEpaGhyzpBmit/rPghY4DTedEsTwhMRxfV7X048y7H8JhFY4?=
 =?us-ascii?Q?NzT7T+yQ2oK00oOz4iYr/LemHhrGa3pphFmSVD0HZTnmFTlsu4lMJexkl1Y/?=
 =?us-ascii?Q?gMq7EEmPK/RejNV9b7wSMDsIT5ajrVCkSWZDZtJVbnGi3byMZz1twx/p7cU3?=
 =?us-ascii?Q?pPtFxNiiqeYKolf3zQYtG99QKWPhkAjTn4ExAJ6gH48l7T9LShaiQpY9u3AD?=
 =?us-ascii?Q?sU5ub0LfKJXeVjapYrGETwCi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad9815-d945-485a-c637-08d925cf7641
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:23.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCKfiQ+v6Tzmp+KAkUjLb1KRrQtegUDOv245yVBM0aP+9qF0HhG9C+E2NaE+YY1vndTnzXszV5XQG6QiHzB7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides NAEs that can be used by the SNP
guest to communicate with the PSP without risk from a malicious hypervisor
who wishes to read, alter, drop or replay the messages sent.

The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
the SEV-SNP firmware to forward the guest messages to the PSP.

In order to communicate with the PSP, the guest need to locate the secrets
page inserted by the hypervisor during the SEV-SNP guest launch. The
secrets page contains the communication keys used to send and receive the
encrypted messages between the guest and the PSP.

The secrets page is located either through the setup_data cc_blob_address
or EFI configuration table.

Create a platform device that the SNP guest driver can bind to get the
platform resources. The SNP guest driver can provide userspace interface
to get the attestation report, key derivation etc.

The helper snp_issue_guest_request() will be used by the drivers to
send the guest message request to the hypervisor. The guest message header
contains a message count. The message count is used in the IV. The
firmware increments the message count by 1, and expects that next message
will be using the incremented count.

The helper snp_msg_seqno() will be used by driver to get and message
sequence counter, and it will be automatically incremented by the
snp_issue_guest_request(). The incremented value is be saved in the
secrets page so that the kexec'ed kernel knows from where to begin.

See SEV-SNP and GHCB spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h      |  12 +++
 arch/x86/include/uapi/asm/svm.h |   2 +
 arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
 arch/x86/platform/efi/efi.c     |   2 +
 include/linux/efi.h             |   1 +
 include/linux/sev-guest.h       |  76 ++++++++++++++
 6 files changed, 269 insertions(+)
 create mode 100644 include/linux/sev-guest.h

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 640108402ae9..da2f757cd9bc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -59,6 +59,18 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* AMD SEV Confidential computing blob structure */
+#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
+struct cc_blob_sev_info {
+	u32 magic;
+	u16 version;
+	u16 reserved;
+	u64 secrets_phys;
+	u32 secrets_len;
+	u64 cpuid_phys;
+	u32 cpuid_len;
+};
+
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index c0152186a008..bd64f2b98ac7 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,7 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
 #define SVM_VMGEXIT_AP_CREATION			0x80000013
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
@@ -222,6 +223,7 @@
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
+	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8f7ef35a25ef..8aae1166f52e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"SEV-ES: " fmt
 
+#include <linux/platform_device.h>
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/mem_encrypt.h>
@@ -16,10 +17,13 @@
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
+#include <linux/sev-guest.h>
 #include <linux/memblock.h>
 #include <linux/kernel.h>
+#include <linux/efi.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -33,6 +37,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
+#include <asm/setup.h>		/* For struct boot_params */
 
 #include "sev-internal.h"
 
@@ -47,6 +52,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+static unsigned long snp_secrets_phys;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -105,6 +112,10 @@ struct ghcb_state {
 	struct ghcb *ghcb;
 };
 
+#ifdef CONFIG_EFI
+extern unsigned long cc_blob_phys;
+#endif
+
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
@@ -1909,3 +1920,168 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+static struct resource guest_req_res[0];
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+	.resource	= guest_req_res,
+	.num_resources	= 1,
+};
+
+static struct snp_secrets_page_layout *snp_map_secrets_page(void)
+{
+	u16 __iomem *secrets;
+
+	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
+		return NULL;
+
+	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
+	if (!secrets)
+		return NULL;
+
+	return (struct snp_secrets_page_layout *)secrets;
+}
+
+u64 snp_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (layout == NULL)
+		return 0;
+
+	/* Read the current message sequence counter from secrets pages */
+	count = readl(&layout->os_area.msg_seqno_0);
+
+	iounmap(layout);
+
+	/*
+	 * The message sequence counter for the SNP guest request is a 64-bit value
+	 * but the version 2 of GHCB specification defines the 32-bit storage for the
+	 * it.
+	 */
+	if ((count + 1) >= INT_MAX)
+		return 0;
+
+	return count + 1;
+}
+EXPORT_SYMBOL_GPL(snp_msg_seqno);
+
+static void snp_gen_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (layout == NULL)
+		return;
+
+	/* Increment the sequence counter by 2 and save in secrets page. */
+	count = readl(&layout->os_area.msg_seqno_0);
+	count += 2;
+
+	writel(count, &layout->os_area.msg_seqno_0);
+	iounmap(layout);
+}
+
+static int get_snp_secrets_resource(struct resource *res)
+{
+	struct setup_header *hdr = &boot_params.hdr;
+	struct cc_blob_sev_info *info;
+	unsigned long paddr;
+	int ret = -ENODEV;
+
+	/*
+	 * The secret page contains the VM encryption key used for encrypting the
+	 * messages between the guest and the PSP. The secrets page location is
+	 * available either through the setup_data or EFI configuration table.
+	 */
+	if (hdr->cc_blob_address) {
+		paddr = hdr->cc_blob_address;
+	} else if (efi_enabled(EFI_CONFIG_TABLES)) {
+#ifdef CONFIG_EFI
+		paddr = cc_blob_phys;
+#else
+		return -ENODEV;
+#endif
+	} else {
+		return -ENODEV;
+	}
+
+	info = memremap(paddr, sizeof(*info), MEMREMAP_WB);
+	if (!info)
+		return -ENOMEM;
+
+	/* Verify the header that its a valid SEV_SNP CC header */
+	if ((info->magic == CC_BLOB_SEV_HDR_MAGIC) &&
+	    info->secrets_phys &&
+	    (info->secrets_len == PAGE_SIZE)) {
+		res->start = info->secrets_phys;
+		res->end = info->secrets_phys + info->secrets_len;
+		res->flags = IORESOURCE_MEM;
+		snp_secrets_phys = info->secrets_phys;
+		ret = 0;
+	}
+
+	memunmap(info);
+	return ret;
+}
+
+static int __init add_snp_guest_request(void)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return -ENODEV;
+
+	if (get_snp_secrets_resource(&guest_req_res[0]))
+		return -ENODEV;
+
+	platform_device_register(&guest_req_device);
+	dev_info(&guest_req_device.dev, "registered [secret 0x%llx - 0x%llx]\n",
+		guest_req_res[0].start, guest_req_res[0].end);
+
+	return 0;
+}
+device_initcall(add_snp_guest_request);
+
+unsigned long snp_issue_guest_request(int type, struct snp_guest_request_data *input)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+	unsigned long id;
+	int ret;
+
+	if (!sev_feature_enabled(SEV_SNP))
+		return -ENODEV;
+
+	if (type == GUEST_REQUEST)
+		id = SVM_VMGEXIT_GUEST_REQUEST;
+	else
+		return -EINVAL;
+
+	ghcb = sev_es_get_ghcb(&state);
+	if (!ghcb)
+		return -ENODEV;
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, input->data_gpa);
+	ghcb_set_rbx(ghcb, input->data_npages);
+
+	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	if (ghcb->save.sw_exit_info_2) {
+		ret = ghcb->save.sw_exit_info_2;
+		goto e_put;
+	}
+
+	/* Command was successful, increment the message sequence counter. */
+	snp_gen_msg_seqno();
+
+e_put:
+	sev_es_put_ghcb(&state);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_guest_request);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e705cb06..2cca9ee6e1d4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -57,6 +57,7 @@ static unsigned long efi_systab_phys __initdata;
 static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long efi_runtime, efi_nr_tables;
+unsigned long cc_blob_phys;
 
 unsigned long efi_fw_vendor, efi_config_table;
 
@@ -66,6 +67,7 @@ static const efi_config_table_type_t arch_tables[] __initconst = {
 #ifdef CONFIG_X86_UV
 	{UV_SYSTEM_TABLE_GUID,		&uv_systab_phys,	"UVsystab"	},
 #endif
+	{EFI_CC_BLOB_GUID,		&cc_blob_phys,		"CC blob"	},
 	{},
 };
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..75aeb2a56888 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -344,6 +344,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
+#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
new file mode 100644
index 000000000000..51277448a108
--- /dev/null
+++ b/include/linux/sev-guest.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Secure Encrypted Virtualization (SEV) guest driver interface
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ */
+
+#ifndef __LINUX_SEV_GUEST_H_
+#define __LINUX_SEV_GUEST_H_
+
+#include <linux/types.h>
+
+enum vmgexit_type {
+	GUEST_REQUEST,
+
+	GUEST_REQUEST_MAX
+};
+
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPL level.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec secrets page layout section for the structure */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imiEn	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
+struct snp_guest_request_data {
+	unsigned long req_gpa;
+	unsigned long resp_gpa;
+	unsigned long data_gpa;
+	unsigned int data_npages;
+};
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+unsigned long snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input);
+u64 snp_msg_seqno(void);
+#else
+
+static inline unsigned long snp_issue_guest_request(int type,
+						    struct snp_guest_request_data *input)
+{
+	return -ENODEV;
+}
+static inline u64 snp_msg_seqno(void) { return 0; }
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+#endif /* __LINUX_SEV_GUEST_H__ */
-- 
2.17.1

