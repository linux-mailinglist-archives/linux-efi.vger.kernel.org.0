Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D94D09B9
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbiCGVgv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiCGVgZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E9887B4;
        Mon,  7 Mar 2022 13:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8TmT6vJBRcFCk8eUb8GnxaQ6mkV6ftIiyQ9OQW6H105RaCpczJDf9PDL/yZzfRWLW+W+2Ju5O+q9CYzXRj35GA5eehGUW9p0bkhBEos+Wc+Bb1Bp/SoAZSJgxzOnF6b45VAYKJaxP0vAOV1z7oSq8fWC23DP0DiWuEGZ/pNZJmeAMMY4TjtRSz6IuVQQgKwZT2R+BFQiDF1ilW24wS8la9a/N6cspNGVgE8D+f4IqJ1Q1xwzsqycEJYiX2YePzYYwkZJZt9WKdfpNM1NZr3yDLQkpCSBWStSfNey4QOHP9JBzuxJpPsw1BJ9AKX+ftsoeS4B5193daOZVj+HbbAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=jfIZtdxdPrrKCAxhTLRsA9hA+R/p2zPfkR/iUPfrZOGDAX2ItCyVhyLjolgtYxu7C4c8OzLI3A48WmZoFl1o/XPrx4NlkhZxdKG+rsoOkpsNThM1S1sY0LTPM7/ZkMAQ2agRSFottCmmAAudOPzkk+oNGfQBaTuWR5Mcr7mbQS4kSeFwL1Jx6ZnhJ9D/XTdstBs1ajk8JKms5iANFlMOclhYKms6Y15P2D2jMvqTei4O4klb9AoZcto9v3eygEnbJsaakwZHsHqsQRCFJIXTPG04WIgcojN6nXFKqjzIgAN6ZIlDrRKB0K6EUWDyZWhLpDJnbESehRc5ehOd5Fi0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=qpNcV8eVO4439doWBiIaOtnDv23M/CqT3cJNOfPQVi7GezS3pavEBxCjmNmJbmCa+lUxCO6uJ7HXKdLkZp+6UH0bkatcwW1j/jjoVme4alT59y85Ww0Rn/JjFOUUhE2+eAm1xcHWF+HhB0gPxzaL0y1EwPB9CqPLXlzZOCIr5E8=
Received: from BN0PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:143::34)
 by BN8PR12MB3588.namprd12.prod.outlook.com (2603:10b6:408:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 21:34:59 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cb) by BN0PR10CA0028.outlook.office365.com
 (2603:10b6:408:143::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:52 -0600
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
Subject: [PATCH v12 20/46] x86/kernel: Validate ROM memory before accessing when SEV-SNP is active
Date:   Mon, 7 Mar 2022 15:33:30 -0600
Message-ID: <20220307213356.2797205-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87a244a1-ead2-4e45-fe75-08da008254a6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35888B8D936627BF53961C38E5089@BN8PR12MB3588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJgrx4pSorpnmacgz78GSOz94TjiQCqnsaiE8FaZtD6DFLGmisHxiVAAP+VGozuuUJEazneqKpjnTIJzU30vzwPfuQdJTxwcHx+M8Bcew/X3px6w40msUR1H86kFAlZ9g+kHUC5jBY/ROvlfE95mU47BxEo7k6GgBeph56bNCDzw9Z9q1itWCB68nRjla7Kw+9YxxuSoVaHcFdRw352YrqxzbP4fQZohHceJWz2JV3uJepheT+X8ppJ4S4nv/0bpyiEOdusxNc5t28w/LK7zdPZ4JVqhyHKeAO546YE9Svm2yMg85IGTvDvC0ULb4o7q14ERHyUS0/C1dLuz2o0LzRSkj57EHxWAO78z1y2CiAE2XUyguoMTAltfaEzMDuRlSykCplJV1y1+lrBzNDvq57ivIDDcmQw1B874m0X60moLnFhVeV4v29dXu2dew1PL/i1qLLyf+N8bwP9Aw5mimLRvuv1YV2Eo1Yj67W8QCRDB79lKc/4gxcYH1BxmNn7oWZtmsCJ3ihZXol4SJzhJcSiCYsUMHa0DWvkQBXG4rRpxWtMbPX25PiAkImwRnnmtceFyW11a38dB/MBaqXDiZfCHqceAh5v5ZtafVNFqRwsB7ATPA/AvLzPQuPX45p/X1LwUjxFmMBCvHaPf8D58uAP1CIe/fqztao/Rbk2g6C2T4HlmtczQTi8GDYitgeFZUAWqtrrLiKQujjLiD1oF4nuK/JCnouXY1f+EfCm4JKg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(336012)(426003)(54906003)(36860700001)(5660300002)(2906002)(26005)(2616005)(44832011)(15650500001)(86362001)(8676002)(7416002)(7406005)(110136005)(508600001)(40460700003)(16526019)(186003)(8936002)(6666004)(47076005)(83380400001)(316002)(36756003)(356005)(81166007)(70586007)(70206006)(7696005)(82310400004)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:59.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a244a1-ead2-4e45-fe75-08da008254a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

probe_roms() accesses the memory range (0xc0000 - 0x10000) to probe
various ROMs. The memory range is not part of the E820 system RAM
range. The memory range is mapped as private (i.e encrypted) in page
table.

When SEV-SNP is active, all the private memory must be validated before
the access. The ROM range was not part of E820 map, so the guest BIOS
did not validate it. An access to invalidated memory will cause a VC
exception. The guest does not support handling not-validated VC exception
yet, so validate the ROM memory regions before it is accessed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/probe_roms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 36e84d904260..319fef37d9dc 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/setup_arch.h>
+#include <asm/sev.h>
 
 static struct resource system_rom_resource = {
 	.name	= "System ROM",
@@ -197,11 +198,21 @@ static int __init romchecksum(const unsigned char *rom, unsigned long length)
 
 void __init probe_roms(void)
 {
-	const unsigned char *rom;
 	unsigned long start, length, upper;
+	const unsigned char *rom;
 	unsigned char c;
 	int i;
 
+	/*
+	 * The ROM memory range is not part of the e820 table and is therefore not
+	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
+	 * memory, and SNP requires encrypted memory to be validated before access.
+	 * Do that here.
+	 */
+	snp_prep_memory(video_rom_resource.start,
+			((system_rom_resource.end + 1) - video_rom_resource.start),
+			SNP_PAGE_STATE_PRIVATE);
+
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
-- 
2.25.1

