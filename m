Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8F47047A
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhLJPst (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:49 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:20064
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239791AbhLJPsK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpdJHWOI4XUZDh02Sf4s38PZJS9LFWcwqpo3knI/V4HT62MapF6ZxS9MC5+xpkCvZbskePfAV6yHYuSQ9CI7lEPLPBC5yiNcEFnwOEf89ZFWaK9bRp/Ssn7I6TVQMWXk5eztgwo5fRIxcAGFbQ++eE/aZy4F19SklrS0MWvqlx4pBTZ5iCCbjfjt8wtk7MOt7BFsADAkWBtYWL/u5FWJP7IJ35kMeTskybuAwnXO0CSIRgn++eQnWyFAZENl0fdOHmNm5o7Y1uVnSphBn61wBGsDtWXK9ZdD0jjhfVvtLkiiIsF5QbgVtI8QFVj/8WL3prg6qFfqf3aC5tOx70dlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYQZLiM17n4joiyR7TyYmdOmQRDqRaVye4M2NVZX/L0=;
 b=TyIni9GcZtAhdmoJz20DmkM3+HB7Us99IYtfoAk8VVe6YrU5KaVwq4QLGoJYeFrCP9LFg8fnM2k+2qCwjc09OwEnfpS8Oh6r5HlLsztn/rtBP0Pxxhf7DYxs09hT/1Yex6RQMtO60TGgakj7KyECidwqkvx7mFJtu387lzo9d08WZTqpM8dtpKihxaYCJeRuAfqbHwMSbp4WueJp5ZfnPBGCUn1DemVKk/3bvwziDDNgFh4719O/6ittWYv2IMQ7bskDV2lzwdD4umkzdsTBfHgG5N0nDaYSIYRn9pyOfpMk/JRBmLwXvP6yS1mvlYpkVXPs9pEDg+iYAGkBi16SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYQZLiM17n4joiyR7TyYmdOmQRDqRaVye4M2NVZX/L0=;
 b=FvmJkcRVeKXqXb0RAcUFSGcQp8LndpH4/PoiWYll4Tvl3qUzRk2OdWZQwePMGfrhzBhS/T2vOCDQnjWjI20PW0Dh4t2DaG8IvzL+xLYR1vSZQ7gSAFbsvw0V8wBa5gKdYuxxINXL9P4jJzkSL4+Qwlze9ZzkN97mE+BnAAnS9+s=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by BN6PR12MB1924.namprd12.prod.outlook.com (2603:10b6:404:108::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 15:44:32 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::a0) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:32 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:30 -0600
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
Subject: [PATCH v8 27/40] x86/boot: Add Confidential Computing type to setup_data
Date:   Fri, 10 Dec 2021 09:43:19 -0600
Message-ID: <20211210154332.11526-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03948068-c269-45d9-4171-08d9bbf3f5f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1924:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1924D955F03831C81BF004FDE5719@BN6PR12MB1924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAi/9EiWzcmgjeGQgMbmwUiQjb22AbaDA3OPVBJ4GK/atpgLlZNtYmn5Kr5ayF6KD1sw3P4igVU/50HmHQ4tLqYqpRtvs8bST92ZDfhtBimNlEmULH7Ut7+DFxF/ZRnhYzjElLiMKgg89JweXMJjIlq0V8ykRClPs7YF0zeFbFGw1Wj2Mx40m5oEdZansdYdbP8YUvLvIVUglG2HmbddPtOCmRflCMA/eSZjGrseo72eG7JAbDAeHy/6q1ZWudiuHGEK73g+bS7tkJw05m14ha5yaXITLms4z4W1uO6EVtPSM/PX49kAHVEGMsExjsomUo9C4DvgDEdUni6apNNGj5xFtnpc31Pa6Y+5blBngI9/vNwxO4VBWffozOs9EE6sSinYuasVi3YOo3mtTvsscwtTe4XPe4jYT1Vt0Ey8sPz3ugOzWFSvYte1oSIJPxpVtfW5LMR/cPgYctT0TWrJwKoJOG9NkiUs9HPLcpOyqBzhEw1pYciQDaauR3tdKercuxtst/oOT+0/kVSXPApqRa3IMPAXzOisGN1eNFrwCCm0jnssl1mqq8bu+2kt250XTbfrs6Kvqi6w9dkH/5Jv7QW3F5TpoQnlzH46pF0crSXgdTrbKluYNMI36MqNR5v8xcK7zG9bwsN81hhE7bfXkfuYXzj4/qQP9wK/WZKZBBQNzKOgMCuMTblgPiGm6nFDFBpuuNbkO+N7DMpVyT+M/btPCIsu9nX/IvMiIUtl7SpvpK7kIJqXKYVY7RM4Lfhy4k0u9+eJxS89H9BO3U9hsl/emVT4SaccicdsDeEWyFiUuN0oyTip+RZkZPinkI+0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(8936002)(426003)(2616005)(44832011)(4326008)(316002)(54906003)(336012)(8676002)(7696005)(110136005)(2906002)(6666004)(356005)(7406005)(86362001)(5660300002)(7416002)(47076005)(70586007)(26005)(36756003)(36860700001)(186003)(16526019)(82310400004)(1076003)(81166007)(40460700001)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:32.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03948068-c269-45d9-4171-08d9bbf3f5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1924
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
index dbd39b20e034..a022aed7adb3 100644
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

