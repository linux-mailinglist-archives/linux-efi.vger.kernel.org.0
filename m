Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411844CC12
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhKJWNX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:23 -0500
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:28448
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233997AbhKJWLq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll9e3NTV8lzejwYJoMAvhfckbaGbwWSL9t63LgiS+YI8YUvns4AbyatDDr9LbuQWPF3579SFjyxL+aPHwc3xaOxXV5EqIs7h99l0Y07bQ28HC3kLrSTEnFjvKDyVtAcMGGxAzbltCW+onMa7Hpq+uClBK5jWEV+vPXOgg3pDiLj/RYC6TCEZziKzoYG+r8AzKfvJE768JwZjB84GIbgK5mVM3ktmXsd0DDw+ChzAlRmIy4FouGu1Rl84n5/R320QP1mUrt9CyysmnCvjYmDMzmEIDn4bRYih5MBxN7uW2yoh7dLWm3nK/6LwgnZ4Q5mlaL02HHNJbw3b9eBvktZbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQtde6P+h0Ehkv2FdMpiwb5XTeW4/8AyqMOnv95qV3Q=;
 b=QgaqXCDjgfOyVUF3BvEyDVziABAVBqaKr86e70FvQkO8N0PA9PKJ8IzS13LAnJiu4MLVwogC92KtLK17unrPnhYVv+899knF7w56Ia3L6yLrmqxyc29sJwCH6i8q5ll2IyHjLFUVA5J+jFzVndXN9nV17xQMW94HF/EkYGaNvyQ4F/HGy9ERuIjwZIO5SqlBHC5IN8CsBzy/OvmZESBSauXQE0JSN2J9oQljSUDjVixsjh9K2zBtybcXmk2xYaq7o741yVIQqOJSXVA8l2xhNRMOydu9r0rBts0OZ79L8Eq58sljAvoMwAFFnGtV4SpVSYWGuc2mhIwUr7bag0avYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQtde6P+h0Ehkv2FdMpiwb5XTeW4/8AyqMOnv95qV3Q=;
 b=y+LMCuOd7vVT3BOPIfDzNBuReEMfADv+BRROfctx3iMLY23aRjC3B8BpDDmIcvilZu/U6e4uGp/QgRsZ301sjWZE5KBxIDEAgu7zMWjGkrcwdpyC4U9XGXihrDjK0A774W7i+XkAxc1Z9mi44LGTY6RHy9j096cOmUYXnl91GBQ=
Received: from DM5PR21CA0002.namprd21.prod.outlook.com (2603:10b6:3:ac::12) by
 BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:08:56 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::8b) by DM5PR21CA0002.outlook.office365.com
 (2603:10b6:3:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.4 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:55 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:44 -0600
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
Subject: [PATCH v7 32/45] x86/boot: Add Confidential Computing type to setup_data
Date:   Wed, 10 Nov 2021 16:07:18 -0600
Message-ID: <20211110220731.2396491-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317f1f5b-c826-4725-23a9-08d9a496b04f
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:
X-Microsoft-Antispam-PRVS: <BY5PR12MB55446EAEDADBEFC75589E2F8E5939@BY5PR12MB5544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N96a6Qf3sXrOtowBUnroQm/vN8eG7IlUpeSkcku4u4ZNmWA3teZis0Ht5Vjhw6DC3DQlaziDsEyQTyQg7vFnKFtn9IjmWHm7mfFFH9RkQd41tAApzvKWHFv3puiCTnHoDlYTBgT57559vxVayX4s38f5BwBIdCHjhXlI2NCOP9EpTTGfYh/ZzgrCXNV6lYfwo4f5jx3junHnB4hef6fC2/iEBCUvkuJbppezmDu175WqlBLPd3v0BcGKcnOdQnSzxJjurFG3/DTlRezeu2aPsO0q2Yyh8TILrE1AO4bTO089MKGv8f4GX+Pfdc93/xf6fgXOHg8SoQWROJ9EoBgX+ORatv67V+UDatxPUWSAcixx6+7JzgmPuNvZHYFfhUyTQHQA3Xoc6RQHki58DClWwwn5aJm+g3OLMT32pin/aUD5yHQYsmXMvOz9dUc97BkulctcXx8QrsJ4sXj4WLjWmbn01i0CJOUSCmjVfxfXgHqwCaoXDbbVYgysoCaqEPzfhqJF9j7ArnqjCUoKX76J7pwqGx3/NfDbWhGutoFmVgQy3zMbDTNohh7hxNM3vi++ItwHX8/e+9VDAyrVT8ZZ6PPZOEgumoAFI/MburfolatawMFOJ2gvWZcvIIwJQmqj9vkg64CTqml2cn0gFISRz2VOYNyLRkm5tYg1SXp4BWBQYjP0nKO3/PELUvKuvj4O0J63bRQHDntxU2Ds/k45xr44SB8CyVI4ga6EYZiNfES2W7QHq2fWOvkODDdNH3Y8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(2906002)(5660300002)(70206006)(336012)(16526019)(26005)(4326008)(36756003)(47076005)(70586007)(6666004)(186003)(54906003)(8676002)(110136005)(356005)(82310400003)(7696005)(44832011)(8936002)(508600001)(316002)(2616005)(426003)(81166007)(86362001)(1076003)(7406005)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:55.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317f1f5b-c826-4725-23a9-08d9a496b04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While launching the encrypted guests, the hypervisor may need to provide
some additional information during the guest boot. When booting under the
EFI based BIOS, the EFI configuration table contains an entry for the
confidential computing blob that contains the required information.

To support booting encrypted guests on non-EFI VM, the hypervisor needs to
pass this additional information to the kernel with a different method.

For this purpose, introduce SETUP_CC_BLOB type in setup_data to hold the
physical address of the confidential computing blob location. The boot
loader or hypervisor may choose to use this method instead of EFI
configuration table. The CC blob location scanning should give preference
to setup_data data over the EFI configuration table.

In AMD SEV-SNP, the CC blob contains the address of the secrets and CPUID
pages. The secrets page includes information such as a VM to PSP
communication key and CPUID page contains PSP filtered CPUID values.
Define the AMD SEV confidential computing blob structure.

While at it, define the EFI GUID for the confidential computing blob.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h            | 12 ++++++++++++
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 include/linux/efi.h                   |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f7cbd5164136..f42fbe3c332f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -44,6 +44,18 @@ struct es_em_ctxt {
 
 void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
 
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
 static inline u64 lower_bits(u64 val, unsigned int bits)
 {
 	u64 mask = (1ULL << bits) - 1;
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..1ac5acca72ce 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -10,6 +10,7 @@
 #define SETUP_EFI			4
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
+#define SETUP_CC_BLOB			7
 
 #define SETUP_INDIRECT			(1<<31)
 
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
-- 
2.25.1

