Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD649FF32
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350803AbiA1RUH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:07 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:15329
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350807AbiA1RTK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX88Fkaxqq5hDb4QAVwnf2TSe/qQVe42ly4iPr9GNjo25LmcBCqhn+Kg7a7AU17fId6QsvZBIoRpvd/WBWXz9rFPhct1qB+IUx1ZzAWuQS4N38H7OMnMDH7DTKYNeRucbNznY/kcuckQ7HiN2cW5om5WMUJ91P5OfYRyGV73JaNiZFIQ0NYmLi6LPWsmoCsSTAyRyMJSKUo3svp13BXq2JFRTnYNQW0NBRiNh0J+5WHjtDtk4gYOLvQZ1Dzqx7it9wZ90IUR0k3B76pu0GAlgEXhzlEfuTUCUhFham7PMSKdilRfoSAMhnWZCB9Qnb8fVnJE2f7rX3FqS1TBESE5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=gPgcemOE4fJva79dwE45FbNvOtTG9plXSi5WzaYupzkqH4LJwfws9hBmsQGO4OiQHj7pMGG1EnEZ4jOSRl21cGDyYjR7CCHXWkfwavqTh9Qgc1tATVuANAoS5ehpkfOug5pCWbm0l72d7MphsCWcxPW/K/bZr99H8uc+RSvV3HrJu7mRqoGM3fr5YQ1AqWIuhIA1oT1teS69WmoMVwLUBZroJhMUIen8r/fQLjXgO0GXmSqFIMpEZ0XbtI2fVPh+E/j/6NVXpJR/RPGBGPdeLQCjZ4Ls+Tpkbhte22Y+u9rG8rSew03KTBE60GmhcZRu8noLgXcwlp7w8FvT6t0Dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=fSDsM0re60VaXaHt5WMyLusetBdcLdKjAPaiu0Bi2lpLThGXacmIYH0za9SMdK4M52B1Y2V21T0yoQciF9piuPP9eRB5H3o42kZGPnN2lMk+5sPcBL0skBOwQfKgpG0X+WZUwrE+HJI/0ZGq+pvGfNgIu5qNPK2cwcbrIYE/eIA=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by MWHPR12MB1694.namprd12.prod.outlook.com (2603:10b6:301:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 17:19:08 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::11) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:07 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:04 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 29/43] x86/boot: Add Confidential Computing type to setup_data
Date:   Fri, 28 Jan 2022 11:17:50 -0600
Message-ID: <20220128171804.569796-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc4d8e24-a722-4389-f208-08d9e2824ac3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB169452ABD51A5D17D4E23EF9E5229@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKaqGs6i+r6XPQiDlY6PSLNwXErM90mhGAlrd9S2gaYgEuDvqqbxK5LMnnEZpbHFtYjF+S5uYpIBN9BdeIyvXNGM7QuFAXKv4uU92l0g0IS4wQYPQN4dEYxnli6gA7iAdH24m+w/JuC+k1wlyn9O66np9GzlJthJkOYW9HXV4lYyeRvFRi7oMhH42ViWFTQ9Rr/UWx+58pFjy8z1wiqLKHRYOy+4U0AmVBxJq8Awop+IjwkSSiABTJ5Posk1a45n3gJMFkDjFBr2d2r2YSfgwfQRsIMTEooIbY9VotPHOorVT5F+iwQnaQ4YVfUg1dUL9se4Sk+Jwo3XH3Tzq9A6/yAAynQy2JPYHbs0G7V72neoBXDVvTZpyfm8mZEqBImkk07eJaJHouPHFh1j2iwTwf8w54JvTEqmANj3G129lc075LoS9N1hBw3h3S5QV0jPSs03oSpe7SQAsltF1YpAahGP3ktU3dhC8h/FkGQF5cNOuWIYwd2HZABGuZrhXrVZrwuvXibJu6NM4BGLBGKtp5M+hC0r9zGn+w87PC5sycha1n1W+EZC5/aOthVHKpJ+g+L8yYq6AcnPBLW89e8nCJHI7QNVIub6grKFPh1Yq+dx4oAWEzgVW964rbxrJZrBgmDOhqW98I0GKMMhppcWRIkC6+rOyHSELsC/UUnC44b9aDJA4if24mhvZJs42VGsJ0STyrUmaOcmFmBh8MEBxkCKYp/xzCi93BXYiJns9ynGkFig+0I115sh/FMwOCRjfcx4txtjJPdVHVGy77iUz2PO4LjKUh6bIRSmOr8NNpLk9wY1psgpapMcuXLLtcwb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(6666004)(36860700001)(186003)(2616005)(966005)(1076003)(81166007)(47076005)(316002)(16526019)(110136005)(26005)(54906003)(508600001)(36756003)(82310400004)(426003)(7406005)(356005)(336012)(70586007)(70206006)(8676002)(4326008)(8936002)(7696005)(5660300002)(40460700003)(44832011)(7416002)(86362001)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:07.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4d8e24-a722-4389-f208-08d9e2824ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
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
 arch/x86/include/asm/sev.h            | 18 ++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 include/linux/efi.h                   |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a3203b2caaca..1a7e21bb6eea 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -42,6 +42,24 @@ struct es_em_ctxt {
 	struct es_fault_info fi;
 };
 
+/*
+ * AMD SEV Confidential computing blob structure. The structure is
+ * defined in OVMF UEFI firmware header:
+ * https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h
+ */
+#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
+struct cc_blob_sev_info {
+	u32 magic;
+	u16 version;
+	u16 reserved;
+	u64 secrets_phys;
+	u32 secrets_len;
+	u32 rsvd1;
+	u64 cpuid_phys;
+	u32 cpuid_len;
+	u32 rsvd2;
+};
+
 void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
 
 static inline u64 lower_bits(u64 val, unsigned int bits)
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
index ccd4d3f91c98..984aa688997a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -390,6 +390,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
+#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.25.1

