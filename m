Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D444CBED
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhKJWMU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:20 -0500
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:61633
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233823AbhKJWLP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3kLoXL90yi/kK7u2oMIqFyIFaB96EKS6TxsHs3OlMWSX8JfWdqob+C/SiVU73qtG9yWudLzIEJ+nkpHRKLG3IroFkBFCRG3uj776kcaW58RDpurRGz/hkbxVwg82/8XMR1sHPVvUi3KN+/cm4sGZ5peSN1vDYwLyNV3ES563FCeEFyGZp2amiAIocytgxzct7WXRgecMpbPCjscns72iDMBVR7IVVpn+OpL9yqEKr17zXphk3ca+gYjdJfJgSxb0WVi1STLj0IVqrUdE+5sQJC3Z17icUxcj2K80AxeT69hkd6WdcwzL4OQ0GyHSUn8dW1NCPK6R7QwjBxB9eRDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoUlO4AnE0odgH8OA10cXh7SU1dk1gaFhA4zvIXgf7I=;
 b=kn57mHiGoUCztRyTgtojTVVn6jxOC33QWS3g251ffMc/cr+XsF7H4S3f7VrZ3sBgTXeOCkkg5FyrL86QBlbqLPRQme2lgOXqVI6lt2AH2zasNBu392VldNUQxicJlrSuQN4yi8sPKRrJil1NA8uArS64tD2I9j2NkuNzr4u8MhLaVlOL0Woerv5ds8rQaOOcsqiPURXVlt1mXcHTTLqDOj2RVJMjztKIEE8BD29EZvrU5m3enC7TegMvUcm2M5bWUih0x1wQ/fPrMODgvcjTmmdizeyiPw5KLMz3lfR1ildmI4YWczEa3PL66VPTtHOlRO2lAHm8+FVGyEZEm+4I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoUlO4AnE0odgH8OA10cXh7SU1dk1gaFhA4zvIXgf7I=;
 b=JRVL3ckgLK85Jdh9dS2aLLb87aRkMKqbUNosq+NUtAXGPGyZXuJLhx2VFpYuN6Y+gqiStkHHwVlo4laoLZqqNYY8ZAtkTIQC5jq13bXJ6I+xZr1aHjQZXmwkeG+IVkIMdyY22fek0bdoxOA3oZlSWsFJUZivWlZD+BMyJfSkq0I=
Received: from DM5PR07CA0141.namprd07.prod.outlook.com (2603:10b6:3:13e::31)
 by BN6PR12MB1313.namprd12.prod.outlook.com (2603:10b6:404:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 10 Nov
 2021 22:08:25 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::1a) by DM5PR07CA0141.outlook.office365.com
 (2603:10b6:3:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:22 -0600
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
Subject: [PATCH v7 19/45] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Wed, 10 Nov 2021 16:07:05 -0600
Message-ID: <20211110220731.2396491-20-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e6d5d7-7782-459b-1915-08d9a4969dc6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1313:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1313045ACA4F20CC7D3765C8E5939@BN6PR12MB1313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfHjIuXojCbiztNVR+AZHd2XKc+P9uTobjSfi8U6mmuL2EFG5QlFtAQror0h0x6567r6XYWWkLiysToNOfXiVLiE4SZEQh1kOqY+YCHQD9mDXmc8+qH0H26VPfIQ3STLi0eaje4WKHFYZ7xg7X5QNzrlevQrnVk6LpDJkMpdog0vv2hPr8s0z9ERSUV2H0esv52xfnI/SEBTdjk3GapzityL0AiKkdZ66iIgu8bhm0OYUODOiklRCB7PgWA+rh6YIOf3xp4lepyOLF1jz/+Yvs0FJjyp/ED296hO4GGDolh6j3eQIJTgpnZGZ/qJXZ9L3t4Cip1sI/KTjrj95VEZMQlpAWgpRMFp/oQdJ02kNboztygt0ilfxwsovVV351gW9GsHB9Yf/IuDpAxQKxPCz8kwH8b/fYfHSjEs4VJvf2TYKbe948qCTs/eCP6rqHnXOoeCZUWtNRPnDCkELyCS2sbU/l73mw50PY88M0Nhp6Mj3ShxeXgEveMnFVumhsA/17T0moNqHGko3Bka+rHaX19/ey29QZCuQl5w0JCftVOelcwa1BG+k58vd1+C1jmGXIuvbTXhNhrPLH2jj3XgUaBEsOPaA9oE2dJK++dy0e9dpLMKhcPYuUbACI3naJYKiP7srl+v2/JtIzYOH4ZZdGr7oWIBNjNia4JDhsfCAtphNcN0/QHGsw4lIaofVXByQZ9T4ledX3F5xtTrwP2h/8dJLjYML0RXnQIMeAJRkcEZzNIEb2THdmlghoSw8Onj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(70206006)(1076003)(82310400003)(316002)(70586007)(2616005)(6666004)(508600001)(86362001)(426003)(336012)(186003)(8676002)(83380400001)(16526019)(44832011)(5660300002)(36860700001)(2906002)(7696005)(4326008)(36756003)(81166007)(8936002)(54906003)(47076005)(110136005)(7406005)(7416002)(15650500001)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:24.7871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e6d5d7-7782-459b-1915-08d9a4969dc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1313
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The probe_roms() access the memory range (0xc0000 - 0x10000) to probe
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
index 9e1def3744f2..9c09df86d167 100644
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

