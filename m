Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DFB4D0A02
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiCGVkA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbiCGVh4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A795888D2;
        Mon,  7 Mar 2022 13:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbD58Ck6JZR0Tak5aQMOSFuLhAXQU4Tni6h1lmwt+vapxTpsKchblOdN7x5KuQYh5/fj/VYoQlZKSR9RxH6o2hPHtkYiND9A9IwKj0q6OrWYGxgVY29gXDXsyW/HmCZdZvNkTna+MNUVyT9bs2gMVUTb7l/4OmYInbspVCtfAFkdlwQNTVV9gSzfACpc2cUDdFGnWaLmcqSDh/I9ILsbTme6TNb2q++yVjQzySaFiMJsSXcvR7gYIaHVRPNMdUwc8IjzT9U45yF+wNoHRCt7njMn1twTSrE5rqFMUXAudsDanIlcWYKReiHFnE1ejRO+mhkoZKmRO/3Skkz2e95zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=KVSkmXrJcHwdoOwQbGyh97PoB57LHJxFYVW98Aq4mearwaScT2XKGe0+LoSCafOeYn0N0uisKtZs2BRQEG57ehGdCmR1+qjfK0WC4ShkIpoUgfcWjOzGtNLYOREGz/DFJzAOgUQft1iPWuCySzZAEAK6ysmm8cGnDgC+rC184U6Z+TWQFYiLyerEsZeNxo9rnhYPK/wRYYw0EuMMMYJjyjcygwX++sNeya9tx35aG/cbVsCEdWjDDme6YPwerPkKVregYuh7nEyZ1wy83Ub0UATmoJnZjksAjsXpi2muiNNWojz59jSdXYQwS3aAR4sTNDZw8FVB4Jxonz4sSYI/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=HArzrnjBbzlE+dW9VFKpbaQ3LwrdHQnKdMjr+EpKjef8SCExMIYDgrGi0ky4iVe6F0Jv9SB8jRvNx3FkKux62ZUq/R9ME8epgBGubPQIgP9HqzuJCe/SwyiJBXGiFAvbRBiwdI9Ql/E4qvPIXVIOgNIXZW5h7GLkeQHGHWpeHkk=
Received: from BN9PR03CA0130.namprd03.prod.outlook.com (2603:10b6:408:fe::15)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 21:35:33 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::5d) by BN9PR03CA0130.outlook.office365.com
 (2603:10b6:408:fe::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:33 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:22 -0600
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
Subject: [PATCH v12 37/46] x86/compressed/64: Add identity mapping for Confidential Computing blob
Date:   Mon, 7 Mar 2022 15:33:47 -0600
Message-ID: <20220307213356.2797205-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf703fee-49c1-4d27-8f0b-08da008268f9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6006:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6006F2E4713D64654D9447A8E5089@DS7PR12MB6006.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buI3zJjD1rzqAw7fA0IjAKK4s0ZGvc1h3RbLV9RNoL0z2+VWxDaaMCYFHKytFtWXpXZOApiXIdjPOVTcbm4FlMitSiNSa4yoKgnGxySzDcXGJHVKxpJqTebFcfvKV2CzRSd5gRbvJfSxHVz9Kvu+bStcBlxYhDhbJM+jW8sUZkSpK9Ghf2tUqLY545/6MVuMMihLQNI+Mo3VBkGnOgMpHxfQc+wWTpnw6WlofxgxVKT+TnK4GRj1vm29dCVKTEdY7sNQCN1nQqwnJ9d0GqZIHhpXTReWGGLVu/ama9wPxj6MosABmhiX+DuAZ3gmnILXOwZLVTttjpideXQp7w+LPce356o1BF05prGyP/QOYS7UheEXxFvAuFxXm/NauggS0G7q60i3tyRu2eEi7wLZq8Jo3tEovkqkSar9LFTuyY5KsvKSpHkNaq9MCijdTHQZsEBJSNKUSekyvsDaZcL3ZNqO6ON1EFXTLODwcUlYfzqhX+0h495jIz49QgNn34ym9TPegWHbYj9RnfUmfW8SGmrdxvV3CfLhAgzx5KvT0t3/PqFhA8nMbH0iskWpdT4bAFk3wVbedFkBsG1Xc676Lzomd6mnmfr0YUpmYiGnsjX+bou7V6dspyiXOip9IDShEAeWjt7fqDDmC6prxMT+6I+8sGCrk1Mu1iyupZqcDhEvWXR3LVezvrwbEDWjFRNkAzLfcJGZ9h3skqiUuT4fGrOy6Uq2fsGEhlrJhqHKuSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(86362001)(4326008)(40460700003)(508600001)(8936002)(54906003)(44832011)(83380400001)(7406005)(110136005)(82310400004)(2906002)(7416002)(6666004)(7696005)(186003)(26005)(336012)(36860700001)(36756003)(70206006)(426003)(8676002)(70586007)(47076005)(16526019)(1076003)(5660300002)(81166007)(356005)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:33.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf703fee-49c1-4d27-8f0b-08da008268f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At
that stage of boot it will be relying on the identity-mapped page table
set up by boot/compressed kernel, so make sure the blob and the CPUID
table it points to are mapped in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c |  3 ++-
 arch/x86/boot/compressed/misc.h         |  2 ++
 arch/x86/boot/compressed/sev.c          | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 7975680f521f..e4b093a0862d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -163,8 +163,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps(top_level_pgt);
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index aae2722c6e9a..75d284ec763f 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -127,6 +127,7 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+void sev_prep_identity_maps(unsigned long top_level_pgt);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -136,6 +137,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline void sev_prep_identity_maps(unsigned long top_level_pgt) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 42cc41c9cd86..2a48f3a3f372 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -478,3 +478,24 @@ bool snp_init(struct boot_params *bp)
 
 	return true;
 }
+
+void sev_prep_identity_maps(unsigned long top_level_pgt)
+{
+	/*
+	 * The Confidential Computing blob is used very early in uncompressed
+	 * kernel to find the in-memory cpuid table to handle cpuid
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		struct cc_blob_sev_info *cc_info;
+
+		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
+
+		cc_info = (struct cc_blob_sev_info *)cc_info_pa;
+		kernel_add_identity_map(cc_info->cpuid_phys, cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
+	sev_verify_cbit(top_level_pgt);
+}
-- 
2.25.1

