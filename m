Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EB427056
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhJHSJd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:33 -0400
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:65510
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242591AbhJHSIM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/raCCvkuGi6neFxO2xR0TuI3nkrTHLc4eH1Om9V+6PJ1fCg6tKMJ0+VeFR4zKjaJusrAnbTmXx9W579U9Zwkos7a4rnK/QH6Cts1Uamv9Sxfj3PJCX5SLbhgK3aSPW1O8RmUmk2WO5MknAaMg5oelWToGuepJdeo3TQ1eQviK6Z/k76uXtcdoktPaKpASBXI99uK1wYSsmyq8gj6TXsCWFPeFZDW4M8WlFF9IjYHyeH815dupr10BKU26ylITKTF8PgYTjiVpDsYbkuUwlTNtCkfhSjwIJA0GoR8WAZDGx3sKeafOyIt+JAwzqAo0D8lPDrKVPLFVCGmmdZp0UNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebpmqObJivQAn5GDGUkjbgK96KOqnKlH2DVPNVZaufY=;
 b=kD7X5i31Dgfz/cZIXGaFhlfMGr2r98JRT6dllyVC0wKFSi3oQkZrAqH/ms7DvIzY348SJeFFJV/c26xME3x3UbHdzSZYVsK+sfLunh1x0IK1MNIeSz8ZnaUHsSbuxLKDJM4l4QpyklB7S35Ags6iI6ynLCVGvZ+84O4ik6b3Esoy/WC/Sxr9Sj8WLZHHHmVsuM10u9XmCmkEyGDUZpykZ+wGPCQsxvmXcofEjfkEGxZK1L6SuKc0CF/Rkqi9nWJunA/AGok0+ojI0/lHKZnBapx20bOR9UW4n4e8oD9UmTTWhf61lyX0/BczNHsKQoonDJjzx16t42bpw98OyWjQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebpmqObJivQAn5GDGUkjbgK96KOqnKlH2DVPNVZaufY=;
 b=iHOQ9qIpD/EMkFEPqDh5b4IxkfuCAzluBR5pBmHRwE0P90C6kA/hEi1VQ4OVckK6tlIWv36FDalsQ6hdnMbCiJhMWTiZxmQnKjmfiK7oKnnGlL4lyi7RQb9OYqTTUK/R2WxonszmKS45dyJLYIN3cnmf8aowBZEFekuHI+HxDOA=
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 8 Oct
 2021 18:06:13 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f7) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:12 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:03 -0500
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
Subject: [PATCH v6 31/42] x86/boot: Add Confidential Computing type to setup_data
Date:   Fri, 8 Oct 2021 13:04:42 -0500
Message-ID: <20211008180453.462291-32-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee19d9e3-5332-487d-1547-08d98a865079
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4437EE1C838923ADEC6BED30E5B29@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSEhMNQdc4pmoE9yprLbyJhdczDZwhH8Wa4jCpsV9BK3zV6e9qG6WVKesfgK3GqBNiON940p1Fg3pD52hXG/S3TkOHDbSk8hjkxFD7oJlaIlZR9w2Ym9apnDPP4Rs0yitWmTEm/s3Kn8CgSMF2Mcz4JfrpYILsN+aTUVZJta2R1eorIpGb4m6S5Yb74ZxXmkxSoqo/UvHaSz9kEsp5U+bjRNWXgOQrppQ0r4TUDEff+E2fOQJ6Yg5aeiP49piSYSOSACy95vfkFCfhL5YNhe9QFg80PrcBbrzgNVfpJ+thxKACvco8OjKnJnDMZx6GGhDlFoQgRk6XGD7c4jWGtps2J70l/FtTY3aIjkVHDa7/vFxaRuZ1siAn8tcgKX5IAYDRm+deO5xDD/bd8Crb6WHcVCK3DKGDIkL3hTRNSFEWavK1O1Xew+Q/OBuHCJsHScSl9x6BqhOREpS5daBW9nvaLpbuAhiGBp2IOEm2RRY5UipaJ/FhYQptWx/FOhrbr7BtDhIfCOK7a0KztiaX276piKZtGPDuvDsSYCVgoZ8KHRsd8vq4yyyGtBK3bw3qnB501ZTUDMjAkvv9zRsVh7wyzsNAqqVkya/cjAyzTzBRAqlggjrhHEUFSPZB5hSSFlrmEx7Liq8gIEY4N/sXrKjDfdxWzysvEZ7uhEUubZ0dSDgi0Vfj6D8oJYIcOuDNLFGBsmc7VpDxpikNQQdkaRjvN/tGYXCO3D/Cq7Z7EwVeqXUPzaQ1lBLLQAksAYsJhA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(110136005)(426003)(316002)(2906002)(7406005)(54906003)(4326008)(8676002)(7416002)(356005)(8936002)(26005)(16526019)(508600001)(1076003)(5660300002)(6666004)(70206006)(70586007)(44832011)(81166007)(7696005)(186003)(86362001)(82310400003)(36860700001)(36756003)(2616005)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:12.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee19d9e3-5332-487d-1547-08d98a865079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
index 7f063127aa66..534fa1c4c881 100644
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

