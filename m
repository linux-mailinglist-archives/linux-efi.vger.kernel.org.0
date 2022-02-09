Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA34AF95C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiBISNQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiBISMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE4C03FECA;
        Wed,  9 Feb 2022 10:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9L4f93W1Lr6t41eAHB6eeltgkIyN6jARUluK0rZvW2ymXX3ZdM/+5g/REkIrRVxma4U4UXkxwyEOPNAWadVvAw6ku0x1Wb5e/P81gJJwdW6kyIE5tXLtuUQD4bnLDMwbAQET8Y3WWzKgPeOMcTMf8tpfqXuXOaXhfe6X05yGbxilQT5p66mUIZnwxZasFx9pjtJo5/h3G2rNHZr5c7AO1tRZdxIS2XIudVkS49slLLjaIJ2DKJ5v7TaxR4RUghJumCnST67WvcGRy0deS1frZGLlPphoyyE6uHjCJCDtJ5GQKDIbh7U5ISx9FSVsyIZc8zccHNGgXX5x1v29iC4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=Y8CsYF+Eax0u2wek3OhgenyePE61X073kl7OegsJfqu8EDsp7M5e/65nrAQ5bHVy6s2HpyxbQF8/zv3id51DYPKZx7JB3KIqCEv/8LXINodrnwAgvH4EDmXMDOFj+sNWX515J18ND65Oi60s7dqgtsOvqS/EsSungbylSxmx7bfuj7TcCB2OQKtotdDchzyldjfP0DCmrhBnBlD+JSuajhEfzs7nhOJz65rBUmFyi2KKR2Sj2bMR6phP7xc9ouyvqGcUzxYL/SBD57kxALV8dU8hTH67LTOhKkvd75xsazIU5fjoC9+wsgmNmb8lLX+no8xxMRVayN1mChMvwDo+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=R+jVo3ALIn/L7dd5ZYvb+Uy3wRB1lkkJyvnwFzI9ZotMklSQ5zAj87cnG8gJhStJ8gCBUF0uu+3RJEltw+p/L87/mLAJR49G1cpq8cn3jheyupaF7OL0V3LNNaMrYnRAaat9M1B5pzti66vZAFlTyG791gIzASfp2I1spGzi5NI=
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:12:01 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f3) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:01 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:59 -0600
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
Subject: [PATCH v10 20/45] x86/kernel: Validate ROM memory before accessing when SEV-SNP is active
Date:   Wed, 9 Feb 2022 12:10:14 -0600
Message-ID: <20220209181039.1262882-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa8666a5-2d40-4025-f6ef-08d9ebf7ab9b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17141D82D66A85AA68697BA6E52E9@BN6PR12MB1714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFmNfXI+RYNFSi6ieWqt+YW+CVt5BPGoH45CoW09l8Ppm8WZN7SDvBZJHN4PJUL0+YZoSwtN3imMaxlaG7xsYCgGYRo0KlHPYDAfuz00TLVAmbiVljtyWfMAU5CrpZYOGIfudScN8jxw08fTOVDW+YdLpuq4nYPzJ+VJuzdqf9RatJ8Xapu+KhMgEjjszHTzcEBISCbTGzMoDWUZS7wjVHwmpfNUY6whlsN70023c8o/o72VE0XqlS4JeJRpqjoHZ1QZLNww/Jt1nhBIu4XTGBOA7LqFWSMS1fCDAJnOLBoivifqiUeZNIuCtzY7kOb2l3+jN7Us8pxseYqDA1fBzZwlwoFVhBJ7lcrPRRtl22zfFT1sKvUSVanztSfaI4zf+jQE+z1yU9FwkfwI7qjjjTBc4E7/nU/1DhGC1DKTjqiIAmYovJ5MytocOPpqwXswv48yn5T742iFuIdo73PJcUBMZcjh7qaO9hyYnLP9I7hugYqyew/PNdpa0K394ktR5YwJ0OwQtjU9oX1p15vevawl7mxdk7d4pMORs1QrN07qFR9SAaLhNvU2/wxtqL2o3UqG1QMKzWVosF+iIFsZarSuwEteJSxw9hYuG70jZryp213DNja8cAdcTXWIyiYqBLPP6pX7eZXCGlhLrzGU18gzhH4tLAKC4DQ7KluL9IV5Jt0OIPaPQ4Bagv2g3OLxobllzdLyBfo7wvZSecwgr3fUiQxlcm/9Tqt3e//K5Ok=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(36860700001)(426003)(1076003)(356005)(2616005)(16526019)(186003)(26005)(83380400001)(47076005)(40460700003)(336012)(82310400004)(110136005)(508600001)(70586007)(54906003)(8936002)(7696005)(6666004)(15650500001)(2906002)(7406005)(5660300002)(44832011)(36756003)(7416002)(8676002)(86362001)(70206006)(4326008)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:01.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8666a5-2d40-4025-f6ef-08d9ebf7ab9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
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

