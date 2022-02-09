Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727D4AF99B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbiBISOw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiBISN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456CC035415;
        Wed,  9 Feb 2022 10:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTwF2NidVrGU4g45JRTJqlVX5/ALIih/LwNw13ebtHERwOG5GtseOoXFzph3hn9PKrImdl9VHlpEQKN46PEMXXncGT9Cgypu4lbv+jGQnHo3QMJMY8qwnUVyYYaySx3+i841t+3il8hElh4GeiDGmF5zd1kpY+bQZs1iwNhqAT5mucmK3gJoE9H897DYqi4Dt6sule5mC6DF2I3zKPWssL0HYNYGx/vHFZI/2WZcUKDlgn5gqoHYBxpyg/AWc0RR5UZqENoK84qItYCbOY7BQnhtdyIlxBoB5hnfeqP8tRRVc7PUhAgbUs6yaB36XaodPKCTLwDivUcfVqLyt1VkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=gJd6A+FylgBtLgyeShqQXGTOji5jwUndnsLOmjRwovsWrs6hh0SNkIbbq6zwnVgLFqLv7sqUVpGT+tkuQEQg2hGqeJhz3M4m2NOH0r2sk7V0mOjQpr0QblwNwrFMPpFlj37PHyAV1rr9KhT/Mv0tbUbrDM5obUqIvPdph9AGVCZssd30hbAqMFYKpkz2Ng59myNymK5yRCIanZ60Q6sgiKBlxrXJ/8w2XpF2J8hvzt/8vPOMbd1nNoGxdsAdvOO8gEem4NskkDyuwPqV3N/LgFoO+kPCcB/SO2bFcxmMWBB8GMYx3cJrfsGs/LlrtFz2VBmJDMcxwajutE0NLdz33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=3kVdms7M244vEFZSbaOip5O1U19rt7qhuRT7ESvzpg9RPQqV80fNbnMZ1mVdrpWxTZjsZluVI5H6PxytChy/E9Yh/LuFuz2p6CwiRd0qJMMRbkvRLA07MiyVGqFbqXXm1y5r6Z+J/JrUgVottzyt2xsknyWJUkXjpA5okuocg0c=
Received: from BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::9)
 by MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:12:22 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::8a) by BN9P223CA0004.outlook.office365.com
 (2603:10b6:408:10b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:21 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:15 -0600
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
Subject: [PATCH v10 29/45] x86/boot: Add Confidential Computing type to setup_data
Date:   Wed, 9 Feb 2022 12:10:23 -0600
Message-ID: <20220209181039.1262882-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c9d190-7615-4b98-c8c5-08d9ebf7b78d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17285EC4EE9B0A993EA0A304E52E9@MWHPR12MB1728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvtfgufNcv5QLGE36ODvaNOYpumtyE2oqngSeBN2YyPMhP5YPShEjJwKvOCNobiQSdDzNi7rHssLjOqNXGVN7021pl9rxJ6wncC5fFwpLG1yE7axIcqqFQH7g9JsquS+RH8lSdY3aEGCOruxS/acoxKcSlmc9UVyGR8Jtpc2QfCagwYvWU3a8dTk50gl005KgWSqhh5tVBea9r1/Um8oQYBrd5TpBlasOKtCr3EpkaHjO7H/cSvGeAMpumq3cPjDmrsoLVF5M+hiE+ryi74+VE5m9IQBC+JtASHd7J8U5tByvE0iD+sJsJIOPF+5pU+llvlXvUsRrSHA5Gzn0v5WQD8Y9OgN8yJlhJph9dCr2JbQerFmnRIoDQdURLuTuizeieny99S0YAY8DoOOyPb34L54GDrovfzb8O/DDlaOfQEMLDxP8qjCN+yQAZKq8GyZdWAzEh/UXdcLejgsK6m2hE/GGWyae98DBlDIayfWe2c5mGFFx8OzXizBNNCzpJdW9bcW2Nbnt/+YS8Gix+Z//E9ajzoz/266oxCtoGig8ZYRYOjbO0Ys0yLkEWUrmTONxbsbMDrw6bGazKhKV0T4iRLgO4FuFHsavSeh9fIE8S/z5VEktWZ2MR0uT7WKfQ9AKEA5bp6kJPOR9TBw2kSSufnXlmFh7675b4irdCAmDuLnxfRXRULQqQeAkAUHN26r36FwyVdDSmk4iwcjUr1H5W4pDC+GtzhG2kR1LucmP/w7Y8co1u86HYFvsx8Aa5+CsCcxYaBdS1l5Q6g6C3bf5DCnMKxKIbMaUqaEeVgy//spz1W+aqhIkHmu2rTtCCJW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(36756003)(2906002)(70586007)(70206006)(4326008)(966005)(508600001)(8676002)(8936002)(86362001)(40460700003)(426003)(2616005)(44832011)(26005)(336012)(1076003)(16526019)(47076005)(7696005)(186003)(7406005)(6666004)(81166007)(356005)(5660300002)(54906003)(110136005)(7416002)(316002)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:21.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c9d190-7615-4b98-c8c5-08d9ebf7b78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

