Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6714849FF10
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiA1RTb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:31 -0500
Received: from mail-bn8nam08on2061.outbound.protection.outlook.com ([40.107.100.61]:9728
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343682AbiA1RSy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6W5NtUtdfpAKKUDLWlt0G+kQyg48J0+43SRxueqJb6J6kvWJ61wtaPyx1FsYZ74e2TLu8bQEQmGVPefutNKk/M2P+kDPKNv71nqe0b+1sZSFQgJ66rDFwIF+bpF7PREv9F5SILEmL+bdqAl5zV5IFAnAxXxptSnTEHUu+Bc+H131U8x7M9TFf6GbLw6mwYgXuetC9yA0XEtpxIdgiV6Y8kH4JP/SittIgdqtBaqfiQ3Pt7F5ODjtCSH8j+YF2DfeX3KwAQCUfNmK8XbOttZqViYNNGXVY3x7OW8OUVDJy7zHBhqlbSUYp3/KlG6SxBDMep+SSknzVo0+JUZEVpb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbJncPlKDWbeOLf2145nsGt0NUxGQ+ePIoDqNgBwiIQ=;
 b=Cj/3FkfSQqFybPBDcJ0PmfMmMLQQn6vCEgp/lElcW5+64nWrWBFf66By+CCZxkxqd7JEqcapA9FUJzQRBQLrvr7t2Ru/KqVVPUG64QdL6KH4OvwX6sf12Uh5ceNa0f8l7V5yvtw+r5XmZ4mb/0qOWoTDI/I1V1CZDIHoMeu6tI/O2WoWzBNG5E2Wb6yz16vTd8REIcBG7MA4vzQoPoFajDTNKpts5CO6AoDb4o8DuAm8jL+l+NwNOIihLvRxPoEZHnoXMltTM9AoFP6y48WMbKUMR7HDa6zheVavF69/3UApCX9OfnPqFnFs/Fwp3Qff3y1w/Zu3nhxQqkbYszN4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJncPlKDWbeOLf2145nsGt0NUxGQ+ePIoDqNgBwiIQ=;
 b=fgCYeQLRO+PCHk7nlSJDcCsQqonSAjJh0Fpjqr3Qkt/Lhi9pZsvrRJ1xo/wvG9tq5UlhcY5ra05wFJoeI7qBfp90T2q0Vzc4Lycy7tLOpZh69apIISQvaTEuNb4I/TIx5bg6nOF0LMv08FEvxjGP3FsUPMG9qtVzpZLbySqO16c=
Received: from DM5PR19CA0064.namprd19.prod.outlook.com (2603:10b6:3:116::26)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:18:52 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::89) by DM5PR19CA0064.outlook.office365.com
 (2603:10b6:3:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:52 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:46 -0600
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
Subject: [PATCH v9 18/43] x86/kernel: Validate ROM memory before accessing when SEV-SNP is active
Date:   Fri, 28 Jan 2022 11:17:39 -0600
Message-ID: <20220128171804.569796-19-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd9a8c89-f465-4ebf-679a-08d9e2824175
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51373FCBB53FD9210002451BE5229@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlO4zVrh436rd0moGcCJ3IulOivBt0SVtrLXCvNjNuCy9rC4ikWKnu6FCs4Xryv3hlLxZORKqdshRj+GnyRELbJ4ubnhWoS9Yy8SGQZ3mN0fsOjiPf7SPNpdW2zpd8b8dzzryoQabHKlgdHKBjv0YhuNW3OH+pk7dlZRiORon+zVn6xPtqSLWG6Q41eiLH1N4LylR4+Q3I1ZlYA5V9PV/03rJjvIjzgjAocfSzCX4b1uatdXftSXp3hfx/WQVgDI77AxJtQurqm25tdbOs131zQ7bqmOXfmVBhlf2AJCcDuMkF6FMz4somoRU089ca2KNpzAJ3WxHA8m/kcEKMwz/sz/bf0H1arHh7n691Tin/Hf8R7XakF/klJPyoOaCiaGnk0fsHIqZHterUK0Ypla0GMO37XyetKS05R/Pjjrof+yYR9JWrIW6WhCM9mE5bfGjljRH8qTXI4tW/HguCEWmI2QxzvkZgODwqnbBfID/I1m56LweQD4pCHyhLL/+9925Uwrdk+74gkZdiSBZWkdCxIVD9po9yxkBrcmE4ucqEsxJ+2uun3oGsFEMIvK6SyPezDewfGeJcSTfdRK0mE+lTFU/yTfb9SRYM5YsHeq3Hn/4tqyCsnmFrs1KhAmVwdvw8e2vtkQqE85eXFr58VC+LF/NKWi2FJty2auwvd5npCSNflf73kZN7k20xlaEwmPCiYPSAfgmpxVLIThhJKNJE3HnkoZvHYWf91OJwQJJgs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(7416002)(7406005)(2616005)(47076005)(316002)(186003)(1076003)(7696005)(15650500001)(16526019)(426003)(36756003)(336012)(83380400001)(5660300002)(44832011)(26005)(2906002)(8936002)(110136005)(82310400004)(6666004)(86362001)(81166007)(8676002)(70586007)(70206006)(356005)(54906003)(508600001)(40460700003)(4326008)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:52.0381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9a8c89-f465-4ebf-679a-08d9e2824175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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
index 36e84d904260..d19a80565252 100644
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
+	 * The ROM memory is not part of the E820 system RAM and is not pre-validated
+	 * by the BIOS. The kernel page table maps the ROM region as encrypted memory,
+	 * the SEV-SNP requires the encrypted memory must be validated before the
+	 * access. Validate the ROM before accessing it.
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

