Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F594C32B8
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiBXRA0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiBXQ7e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A975627;
        Thu, 24 Feb 2022 08:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHbXUtySlq+jLCNjpXcULcDwx0gbccmtcCEdccmyhs3Yn9VsOk7ouiUgc51jXG7w7sgv8ZBFPokuSdT+tukvc2gDYEg5s2s8ZMuJd81LJtNLzbQJv2+VW6PASBZIMvRz34kpFeBEePrUhcaGUhgIBrLvrkbSxMCp82kcvb8Kbjb7yTf+tPeTYoCJ2erYeEYNYffNpaYeSlUDBJMUiRsed23iVyrjAr6CJveEefW+WNPJLSgiTfTfhzXQ4fA6FG7O7YOEIoSZxRLpPhqAvW+oAJzNhobw9ZIsoQTMwY+8pqFRy/Rw7qhDtB8zwwL0NyGLS0B+4GkDrdP8/2uYzVmwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=k03wzFzseB/wx9Bb5unErkvl5fodovJFkHszUPBvhQVbnKowdN5El4onqwnvbuYs2DaWiHMDQIDZCJqsZKwRqnfcIGey2hLxmW567eXKlczIGEb14g3mfDDw6+VLHwshVNud43BZNVr9SllXCN6pauY+Q9rJQRIbpHUFWR2+34A/EUsOfZsvF6FC/eAvh8hIoBL3ppkCRhO9/236inUO516pxBd7/OJ4vapbetYDhZiB1j46Ow1Gw8UAar2LLMZH2yxXpYJofaLU7c+ypyN7URBEqW9zqTo6Fys8Ih6uzBMm8FolyBLEOKJHNmOSx7Veo3gf5eExBeSedxrNwAVkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIl7FGcVVCCTXlpIwuSotWlAhVTgllnaxmtLpaZNBXA=;
 b=Dm5BRJY1hV6zU4btJT88Oj3OUHCIQq0dM/T6ifJePAY06CPGt5DJJg8IfohI30fVrspvfd5EtzjlPnSG+TsuxiZFBw7BfSxh1O5PjtarSYFLnXaQsqrm9OrGXbox2A2JBCVYPKUUTmxUzE6ByzmbaKzwvytCV2vEYVp9uJL1T8k=
Received: from DM5PR2001CA0020.namprd20.prod.outlook.com (2603:10b6:4:16::30)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 16:58:37 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::e4) by DM5PR2001CA0020.outlook.office365.com
 (2603:10b6:4:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:27 -0600
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
Subject: [PATCH v11 20/45] x86/kernel: Validate ROM memory before accessing when SEV-SNP is active
Date:   Thu, 24 Feb 2022 10:56:00 -0600
Message-ID: <20220224165625.2175020-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10aaa157-44d8-4150-98f9-08d9f7b6e69d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4214:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB421422031F55B4A7E6FBB6B0E53D9@CH2PR12MB4214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvCdWxujpT6ZAtRlaNQaOk3g40okldY56oIhlLl2fAmp7UiL/ZDpDHhmXMPMfI3ihX+lhquFtSJ/RYrK4DqI3HdHkuGXRmwH6tlK+XK3b3Wg5+t7msCmwoqDdCPLgkMF/Hy8rLqqksC3tdi8LnU0oMcxnNhvViJEJXCupyk5QIZKTeH16YiKpzeh47C+yC3Qgx7u5912tPBUW7D3Jm8xsy0r7HoRknC5spgcUOQGs6rvqwjb4l6y6OzSVM+4KX4ba64G5agyxLbvTwBfPZpMTmdddc7kZoZXVNWWlw2C6WjVCTe55o+esx3J81achAT7ZNm6/xgIjtyjWYET9pukeXlySoF0hwAXOouSNzoa9CRAbRjadSxcA9hm1gSyusxcd7JhxbzjPbVMjn+9G1FFlSD6H1io7rkQmo3FhS/c3mOkXlzgigQ/oYzeyxYhDDG9Gb1dmGKq8lEqRnh1VZHhAZX4DVy3iBYPs2jezxYW4Ufdvqnvrk2E5J/92n/NKQS3onHQNY/ylIqle9qGSdtCeJQPNsfQPVNJNbU3RzhAIuNgnhQn1F3EQr0D842ak0fKOqLAgIHBzymxbcRreVY7IJy4Yx7JArGu7oOT0LSXpSIDja8AIKiWnwznA4VCyaHfOIPArVFjckw9Hmo54NK+xBc07o+wg5wKsP+APwqhpsO3yeBsjgRcRdavcPC7RA/e2U600as+RbNZ8mjR1cYKbyUvcZGBObXRFLFI9qW4SUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(40460700003)(81166007)(2906002)(36756003)(15650500001)(7406005)(36860700001)(5660300002)(47076005)(44832011)(7416002)(8936002)(4326008)(16526019)(2616005)(7696005)(336012)(1076003)(110136005)(426003)(186003)(54906003)(26005)(508600001)(316002)(70206006)(70586007)(86362001)(83380400001)(6666004)(8676002)(82310400004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:37.3738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aaa157-44d8-4150-98f9-08d9f7b6e69d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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

