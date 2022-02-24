Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7874C32DE
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiBXRBb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiBXRA3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:00:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245569285;
        Thu, 24 Feb 2022 08:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GajfwV4iurDP6XXRcCl3Ox4DLfgiJuV1HgBIMLDOSDSpXEHlRd2KFdC6t4h2UX2VXvucQmZC8RkpZaY1H3Yx+MpvAkVD7CEQBFH4fxV2lpmi+2IoN5oFcJY0tqEaoIgKS1GlBXeaJg18pdeHk2Av6kJsNrPMmFgtEMaYLLF+wq5g9XnW5OgKXP2kcDXtor7VC42yeX25WJUJRHavUU7iSs1PvF21PVgFBkyoSl7VL2R8UrOHs3yhfqaRM4p1qat0iMpzVhKbQQEU+BAZckoO7pzHrEQL1t+sAdE5/JK48bfHLI1wKNZikaakTXnIsk0x0Q7BLvpk7OJyeLDCx5uVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=hRQ8gcUPqmMikQvhiz2ayy54ik2XEMHVRsnTchtTw2vEu75xM5SyTy3LxBpmdRmGdZ/Zm9WRUIsHKfOvQkXibX0m2mBGpkNNCwB0fQbZedpinCOP0IN7TssREnwuZafrFTfvLTeuyTpLpSUhyOZxoguVHOKrm+Xn4523DM1BXA/iNzH3wrAF37Oswn6DUpv0BWv5U6Rc35m8hkTV83WEnsdKuD6966IFVCuC4p31oEWwla9N9b0ytk4FuehLg1hJETMXqfBK5Uc2tt1GfdCSDeVL1Hde7jv2CoMMzTq2DYdnxx2jNfkN1nBg8ST8vOV0N4L70+bOZK7w1O8OCCznPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE7KuVzfFI5R1vwTNmES3gFR4WL/CD09XCRR4WaEui0=;
 b=HpK7R9iXTcaq+w7W/tuuZHXQFXX2SNe2UcMoB2LUNIYdayZjj3qVSy6SEf3KtCQia2ccn1YFbLUXl93WslOmE6NS2LZHWuyxWQyFmWPuBICLdaII90hrPHW/YG+w9N0NJLR8vKMLhpzHQLnp9O14yxm5BG1NIv7R1/6ka3e+WEE=
Received: from DM3PR14CA0144.namprd14.prod.outlook.com (2603:10b6:0:53::28) by
 MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 24 Feb 2022 16:58:48 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::37) by DM3PR14CA0144.outlook.office365.com
 (2603:10b6:0:53::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:47 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:43 -0600
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
Subject: [PATCH v11 29/45] x86/boot: Add Confidential Computing type to setup_data
Date:   Thu, 24 Feb 2022 10:56:09 -0600
Message-ID: <20220224165625.2175020-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866e3fb8-a947-4e12-6647-08d9f7b6ecb9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1487941AF1CDB55A435BE78AE53D9@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nVWXC1fgzvyKJm9AlBiIzapbKKdprndpAQLRsNJz086a77ZtrLq3tSn+Xwz5xx/sdYcHYsRicaPc7A8K7QDPLIzXBhoMZWyNxXHH466SuD2t5J3uzG3ehx5uyC4s/tXeuCMJGNBEWhaEM+1s6m+aDQbBilEh3SI86ieQSGeJYYlhjvJNmOrI6nrq1nGdPdAkLm63iLbf7UDcIeMeN4xiOkryhejn1DryFTvpd+2oGXEFnU1fpcXpCeItyRwOsPcsLMeooaCRZnuMQE0J3udxk+bLE3IdUoFKRgOuYzMkjCsF7rFsgSd+gxnu/HZ/fxJF6XTqcytN/5N6vhg6FXaVKuLB2nmVeeKKUNpc4q6YOm93bL9Cwxk6p90qsLKXwciS9Oittx9h4nRot9kp7n99QGrbxoVE9htqYjTymwBX0iB9yF69lxtmtuCQebxxkZn6auzGGVufJT8/DYUxg5yQTjqNSRB3YHV5SMMFzUQtcYras56nMTq+uAlGPHvpZYz8P5gsd/JELm6iSklQLuJcNxHHpyMHIUS/ku2mKs2mR2rZvNcVr9J+FpFTgRihBGNY6AAsNh3nu4CeanhZLwEbfDwJF61+qrWou36a6avLoFk1gANE5v3A4X2dXBrZRLLL7cOPNTWtvQOagV76M37je0zf/oV71ct8Qrea3+ilLj8+w/RGTpLocl5RYTKQ8TLnsug5rAKECZf3HuTq692vsOWnq26ICzbIbIZ5LD0/Pwe2KtXDGUA9JBlarGzyeOyB4b6ZLqj+ZzoLjDM5OCbpR34sxrFo1eFApo9BUp2S7ZKP2C9o2jdbesJkwJmhxHa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(26005)(2616005)(186003)(7406005)(7416002)(426003)(82310400004)(110136005)(81166007)(16526019)(44832011)(7696005)(54906003)(336012)(1076003)(5660300002)(356005)(508600001)(70206006)(6666004)(70586007)(4326008)(2906002)(8676002)(47076005)(36860700001)(966005)(40460700003)(86362001)(36756003)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:47.6223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e3fb8-a947-4e12-6647-08d9f7b6ecb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
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

