Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB41B44CC25
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhKJWNf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:35 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:34946
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234058AbhKJWLx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcIAeZp4oCWK0s7lClqPey4IEkvYy3JDMlvr84Fl/qyqjR0R2zPod6V7OQw3kV2cMDGImkBl0Vg5/bzD7xwPZPvKLWuixgLR523NTbtyoKIGhBd2YPry8eKKcbWWcGR7bXho7Yp+ifG/LONa/ihtU8PuxAowvuo7JZRlujldN5oFIE6ZnCtmGYFVFYixYOoBvakZBvn36c6w9s15kySRaxJgoo+qJkavFhbZh/Bug+u6n1AbRHO3IN3WMr5/YlomdlftLLcLwNQTBFNjZfByke6k8pEEF+pfFKZartTs50akXN5azslSypMhQiMAzk6cuQoOuMg9HMkVJ0JyQtPeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WueWBmTAtMHtDHMg6fFnOxMY6UWbtzXmw2so3VcZXjs=;
 b=dCARRZUCS2miH/ofOHNGw846RL3ykta+t9w5S1TJwMtKT121mFcewT9oZcakdxTQ92+uRVRep4NkDeU4LiKRuumJFTpQ64cLCSgETrr6H46MlOAJwF2pY7uwNp/lIPGYjIMpCYcs5pZcHiRsHcPCO0s6mZoyPZNvIt0SYX5rruBk5/qSVLuvYeJllAjgc6ASWvgovKJ+U1qcNU3BdoqDbnw4EGE0BR80+SOpDroKYm8gR62obLsyefl2eeew4ylQs1DGKwoFJ+x+uiQ+U4TDVfir+vTxVDHM3FdI2gOSKtTmXR9PgaPRMbWluKir7AkCMgjOK2mA0p4Tg5cOHnmmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WueWBmTAtMHtDHMg6fFnOxMY6UWbtzXmw2so3VcZXjs=;
 b=S4/BGklrBjDx/kQ9gOJtjIYaHiIBF+WxUaHjwmh65b71vpOl2/CjEC79931O/DFngWJK0LA3NINUFdoqhCLQPWru9/IHsf3wdFaCemMkDEbF4IGA2OchHJfDvM4zr731AtZFCUJSCimQUra7Uupvf7FTyJ15BzqOzF3ILRyqq9s=
Received: from DM5PR04CA0068.namprd04.prod.outlook.com (2603:10b6:3:ef::30) by
 MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:09:03 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::a0) by DM5PR04CA0068.outlook.office365.com
 (2603:10b6:3:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Wed, 10 Nov 2021 22:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:09:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:09:00 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 42/45] x86/sev: Register SNP guest request platform device
Date:   Wed, 10 Nov 2021 16:07:28 -0600
Message-ID: <20211110220731.2396491-43-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a23354b-e6c9-4ef9-6b64-08d9a496b4bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501A9F1FB0F2EAAA765913FE5939@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcRA4myX7AKEfuv4/n/kqHkO6hYyd1CinHn+S+jk+gBFRYuvPjL/ik7qv7RQbQm6DBPjQ9YzCVjhR8FMwO6kXFgtkrw0l1D2ZA8xINgycz68PUwULOSCyGkbYnnLqmAGPWGaYvFOsgtv/8jXa88rMt/glbSzxzCPFv0tpBEf7IQ1k2vU86UAJsctZzU1BmhNOmiU1BLatnTmWW4YAorZiqba+a58PX9FKOWuLyDGPysX88AYVDZOv86VfGe5KHZz5keQriz2j4QSbk+ku7BWbwTh+342VN6M0TDCpCBGt54G7cr/pLcqASZpwpV4ktCc18Le3WdYWTPfqH/qm3PPVR7K30zJk7ugW0+Xge+Wa2uHDWUWeHNFwNdoJFr6NTgbVEm1zOzCP6vbMOan+Fv9FFPA+1xxebcd1e6yL+1q48J3Sb/Cuu4AiAbGVDoDd1EhTxhdpn7oO1HotIdp2nSywxTycHcq5vrV+wdtXaKrCTKOw0IXztqlpbRGJp3AD3POykKGp1EikutnE+323Rr3OdGvRFbj7+edcPJcij/VKUPr8hqDlpv3aoeTz95hSQOriyMMjl5S5+OdyVTMbNMylhMbLDGSWt3HqfJMs7fpIBJKXAZww+iDRHXnWaR2Pu+0bE1xyRhaxP384MorLckQ8NT6tCfhymI3/13mkHUqBA67Kva6s+3UQSJD+LQaC961NkJJ7EokoiQsr2Tb4mbNbrqmqWlrF0/Uh5rSxr2Eb2H0NCH8X1ziooni1/CfQaU8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(16526019)(2616005)(6666004)(44832011)(82310400003)(1076003)(86362001)(316002)(356005)(36860700001)(336012)(186003)(5660300002)(7696005)(81166007)(7406005)(508600001)(110136005)(7416002)(83380400001)(36756003)(54906003)(4326008)(426003)(70206006)(70586007)(47076005)(8676002)(8936002)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:09:03.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a23354b-e6c9-4ef9-6b64-08d9a496b4bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides Non Automatic Exit (NAE) that can
be used by the SNP guest to communicate with the PSP without risk from a
malicious hypervisor who wishes to read, alter, drop or replay the messages
sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
the secrets page and the CPUID page. The PSP firmware populate the contents
of the secrets page. The secrets page contains encryption keys used by the
guest to interact with the firmware. Because the secrets page is encrypted
with the guest’s memory encryption key, the hypervisor cannot read the keys.
See SNP FW ABI spec for further details about the secrets page.

Create a platform device that the SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +++
 arch/x86/kernel/sev.c      | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a47fa0f2547e..7a5934af9d47 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -89,6 +89,10 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
 
+struct snp_guest_platform_data {
+	u64 secrets_gpa;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0faf8d749d48..3568b3303314 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -34,6 +37,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/setup.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2163,3 +2167,60 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+};
+
+static u64 get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static int __init init_snp_platform_device(void)
+{
+	struct snp_guest_platform_data data;
+	u64 gpa;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return -ENODEV;
+
+	gpa = get_secrets_page();
+	if (!gpa)
+		return -ENODEV;
+
+	data.secrets_gpa = gpa;
+	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+		goto e_fail;
+
+	if (platform_device_register(&guest_req_device))
+		goto e_fail;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+
+e_fail:
+	pr_err("Failed to initialize SNP guest device\n");
+	return -ENODEV;
+}
+device_initcall(init_snp_platform_device);
-- 
2.25.1

