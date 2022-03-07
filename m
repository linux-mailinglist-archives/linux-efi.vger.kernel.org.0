Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB414D09DF
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiCGVjy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiCGVgn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89F89CF2;
        Mon,  7 Mar 2022 13:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3+T0HO331tXtospWRNOUL2GerWM7MfJ2r+SvXyQSRzjl4+d7GPumLMyYf9JQy8ncudUI+CiDgUB+gy/N8pZbIZM91ZhROmTsRr5aBZb1hoknC8L6V/dp7IgnrgnG7citTSAbSOkqK/VCxdBKgVQ15vIfFR5ncszBTIu4Rr8WtGMiEQt/Dl5tnO37Qox9eTrM2EWoWq8PDaBGiKEnh68sk8ZerokKWzHiFcKNdZxrf9j/yLCu+48nDekyg3RI/BNkn8qXLnUNE1ZYqEyE4wVk8m7uNx1NTve7PuBgVp54c1tbnmDxtiAgIB3vgh0Er69E/zn+TJb09eT5PEBDcCkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82tNm+8Tx+PnIHHFDenjFYqFFkT2IX/RBdpzTYYTSmc=;
 b=Gq4rZlFhCouKJwnyerIe1drCyfs+uLokR9QKtzpiADImqYJ5z5vOsp2FCPuUmFSDBkcAS5wWId9sfPbzEpF+BDaJXfi+/xAmdHU0xBZP1vD6dRuMnp7a1blouSkqDEfk3iJgA9gDbF+sCKympBfR5LJ2QKmKkrOhgQhM8zKALps5HfcigLSGx/VKvULZ0EjIyDBkHs2mm0chARLmmLXhpwzAr6wAULxpZqstq72yUF7Y0Vyu4JHHgM8f+zEY33Tt5aVKnB4TZHoNSaDCQEnORtJW+MI9HZbnuoyc7TyP9kxHwfK3+XFNsM35FqS4rFeCm6nXJcSgnDPfwFNNZBgKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82tNm+8Tx+PnIHHFDenjFYqFFkT2IX/RBdpzTYYTSmc=;
 b=jhNaeuBKqtpIWOIpn1rdoNO+mlzxBhmVCI891lOyxGfKdleILar0B2YycxaLwlbyd5UvC99Mhsf3vGfHb5oHnFPwlTabuY2GYGaPzmH7ReiTxWsKC0cOqNWfQJ2wYnr0/q26tUmrKwSnh/sj6Rs1e5RAZeGin2lnYIrFENTxJdA=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 21:35:14 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::16) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:13 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:08 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 29/46] x86/boot: Add Confidential Computing type to setup_data
Date:   Mon, 7 Mar 2022 15:33:39 -0600
Message-ID: <20220307213356.2797205-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c847dd7-e1a8-4f33-0865-08da00825d4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3488F6729B11F28DE7BB5BA9E5089@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8zkv4LSOgwmvlw2xlJTUBhedhiuFCBpcwmJ3j0OPyBRJ65P9iQhVtbyFH2gxF4ievFFIO/LVl+8lhV8csq2B1SWN9wOQLQtFM/e1cJucZRWRani3UvCSmNCyDtdP0ky2Lip0+5HzvmJ1W8PZNs73QWb+XUw59bSDG8V9Mi6HTPvLgYRRJiYFs2TsphAzWDjkqMHQSjWJHm8XhIsKUsLWgg88c+9CBPDFx0TNim9Rex8qERT4WMjryywZN50N3AsRVA9tdBYcwOWqhS5i/omrgOOraioPjqcgGJV2KFW5sChuckafFWFAQnfv0RlRVHN0EobvRNMOeNVXKayOeCYLdUzMGnAEmLVGmeDplCI7C+Z/kBef3oAnM7hKgepFj8AcMo8c2ZkJRbAOm2Dmu/POuXvmJS+ZEIA3FB8OXNvduw5nntyWI4ymiIEIGyA12Fll7J7Kyb4ly9zCrNG9MxZQl4u8gHs82NEmhlJeFAkhG74iwPmZmNfOf6fI8DzDa0kmfWT28yLaeZDFkV/3znv4gNstLkumCanYfGpRKg7kEjKhqEtNmH65ut8AAj7pFYfrrh4iG+dBLzv6Kvt+KxqDsO/hp+sMSnGOjSQDak5ptEebtWnEYtOpJhMrlPENaYoKtI33uX/fU7cVWrtLdRG64gSxIYeNS3oR2RblZ2EsxEasPeBUNX6pmBVy3XtIGuAmYUdsZ+wDqHUEhOLohHGr0lSlXAWcgUKwY86qH1cq7qKUtDln4+pGh5tGzSsrJETIFypX3NyrPgln9TAgvuJWl6g6bcLQa2m8OBwJDuiYNwix4QCecdqwzEbUM9X9kYt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(2906002)(7416002)(36756003)(508600001)(7406005)(426003)(336012)(966005)(70206006)(70586007)(82310400004)(110136005)(54906003)(44832011)(2616005)(40460700003)(316002)(6666004)(5660300002)(36860700001)(86362001)(186003)(7696005)(81166007)(16526019)(26005)(1076003)(8936002)(8676002)(356005)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:13.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c847dd7-e1a8-4f33-0865-08da00825d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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

Acked-by: Ard Biesheuvel <ardb@kernel.org>
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

