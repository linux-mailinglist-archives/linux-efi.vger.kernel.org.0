Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE64C32FC
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBXRC1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiBXRBn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C073B7C75;
        Thu, 24 Feb 2022 08:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzpbCkSh7g8rHGyS+2O+kCpSda+O+Ich5rgYVpJQyu7BJ29ym86OVoZmerrmRCI8xqC4OFvBzjxJCnx1Wvm8WHuC0LaX13FSA6bW3u5/IKrd5efmrmsn8zYynCB5QOFh9suec2eYHqd/pF0pfjIcBeyGm+ZzjEp5WQX0XDRSSwrk5v3Sy5eohuzSreMqQ7Z1hUEuf8pb3jTka8px0Dks19N0WgVwc77FQf1sQ1fq+1hnLK5G4iBGxLscyByGPwAt38jul1sDtxxMDRrETErwX2/Jvw6snWB6swIr6V3X/Y88pbR1kP+Ik4kiw3vcXKiwth7yMW5wKPMtR4AXOPssYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=ilnrwpcGIKZVlThvwh/v1oKwuXaousE6zZLKJvL9kgPjBlvqWc0Y3RAHuBXM0IEEVHtgdMi4uzoP0UktrYLCvoVVqU/pQKLqEf3f8ZnDU9Fgdx9I5kKbKLK/FmVYNieYQUhDxUkuD/+igRKd0krkIOVR0cevnH21Vmexj3QP9Fd0SQ29TfAq+XsXZ5dSHzo6p8CCMpqC0ko2bmp7apSIqORTocrVdf0jJHql7zcx5brOt6+mlYAdUBNSgxlYCK5bvaa2OrsdvUY9QpZ6zxok11gQl6Rrc52RPOaZHpU8p8XXa6HMaroSDoCL4jMFyIXkCsQUYkGccvrTY22l3lBwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=lp6+pYrycnGT3EnfGtVYwjSm3noek/jswEo3XhX7HrmXtgpab5MxTm3g/87ptpeCptzG8z21VklK02K/ZIadCCbhgSQeDwpf+MyJdqaDDd0FP2uNgH66moDsvpvGHiAxl1vAisUHeHt1x1Lo89nZ/n96yNkNOrJD4KpZY0v8w0E=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 16:59:08 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b8) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:07 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:57 -0600
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
Subject: [PATCH v11 37/45] x86/compressed/64: Add identity mapping for Confidential Computing blob
Date:   Thu, 24 Feb 2022 10:56:17 -0600
Message-ID: <20220224165625.2175020-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49e7d43f-3ab9-4d3f-d2b1-08d9f7b6f8a1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0252:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02528B195AB1DD882A7FAD43E53D9@DM5PR1201MB0252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jY4C0lsJjMfoe/BKVFAaKceDkU9sA4aOlzzVVbRRTbLMDAP4B9Iq4lqYscc8TyfRLV8YJ6AAkbdt7OwcoeZIwktBnauXP5dEJCo/J7tjnnid+0QwuGLa6YreLBbJkzHXr5/VT04dF1iGBAg+6RY8TurBqctQahnvoVu9ZrBuwbHy+Vd6ul5Z1/i2zRgZNey9lJFLmOC+KGhx7XZ4snbYZPX6e3doxtiRoRD1ZMreUTBX0ZOJH1DeR7iy4KTEH/lJa4/60+CQSxAqqcTnYNCpB9/d0Dd2yDSVLVMUua2UVWcDrX74C3yO8TGWMql8sfAa/z4BD1GnBEjEB3TMnE8ks9MWYVKH7zyB1AVeiokuMFWXDYUT/7eAh5ThVESkFdv5ZH5zqrPS5cmsNo63VtUDTpxEsuBcHGM0V+m9XoSFsmfUTGqiYaCaUOvOqiPc6F83itPW/gofNS/aHCZmv//ax+y9pAgWsh9pubVaeFCN9KYk1g+jl5qyIjMTvE1y/WcjN8rexkWfe+iFR32YIp4wQVrWwsWfOd2cyycs1QFIobmgF5SYEDgRTaFjtbnckmrOuRgK6so6/TiEgx180+4PyBXLWyKnAnTOUxQR+1SSCKgxdffyJLrmhlomXEt6SYlWQgwNdLh9TRYL91ksFGVsqJ4kqS5zdJvnLIQ0eKVEoGELQsDfzvU9S5QagNmddzpfmeinSikNbUpjGuLClKUJHO6ChYNN222Z3n1lVGXh4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(508600001)(47076005)(36756003)(86362001)(8936002)(54906003)(40460700003)(1076003)(70586007)(70206006)(4326008)(8676002)(316002)(7696005)(82310400004)(5660300002)(16526019)(26005)(356005)(186003)(81166007)(6666004)(2616005)(110136005)(426003)(83380400001)(7416002)(336012)(7406005)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:07.6005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e7d43f-3ab9-4d3f-d2b1-08d9f7b6f8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
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

