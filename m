Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78927427019
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhJHSIP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:15 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:21216
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240993AbhJHSHq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8SlXYI2Hmxgd4QNU7cq1hX341OqJIHP45Oi8PvRwKLSyzOl5o2v0QqcZCEBWOt1Vh0eS8JaXFebRKW8QLDum72RYJdv29/IGBpapEVRDctjAXUnToFcFewEapfadsFbm6tHomMj2syPzK/EahhEzhn0hs4bwcvyqcTAwxmgs0n3LpTD4OIL52U3/z88Rbj30Q5JqSnl8ja643SU5tcEMVgxXLgJM8WkZAelILNkVYQwS0PTvngGZ7N5w4Kkse/tBgf5kzC6GxuBVoprOev+CnWVDTDXYQZ08zwUBESz21Rg4C7QArXWxZv2CGUl/UvigI48LuAoLrEXnlwCjv9rAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoUlO4AnE0odgH8OA10cXh7SU1dk1gaFhA4zvIXgf7I=;
 b=BLNLAzBVunNI4ePHL9mH+m4xXjpIdvNHSnLTJ/ocFuVuSyv9dMkDfxBvcXS0ypiu2oG98nQHZBNI/nRGqqz4uDGva+qFX+zsvzyzTb2FYYeUUBXsoK5XzepASewKqDUTjedJtcqQNxNMvWTcsJjyeFL/dgWWZWA5/rvnCT+a5uO+TIM9VyoHM+sMFLRijW0zSGwdGg9lgr5ejjDe3koSMRQvE9E7IkWk18yxwWWyxpxshNxeSER1CquDQZQyULQhVQxjdfU+Lp4XkezXHjOhmRQnLbV3BvesQqrAIoEYYAvXsS/3ldHsrUAbEo/HEwiSnqKjt+yq1VyLzMNBtges4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoUlO4AnE0odgH8OA10cXh7SU1dk1gaFhA4zvIXgf7I=;
 b=IBnr2qD6ryzFqoRKfRSYJpVacythkSdzWn+uwvBy39HBJId4FQRKxNOkOQ0ChaSav+K4EbhoB0QxJGAQDTl/imP64zpiJuoGRq9H1AskA6QRTAmWXiHxubtR+vJrkva5hjr3xEljdxOGpHg83beI1CTVmuG5yOVkZAU//reqPLE=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:44 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::38) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:44 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:40 -0500
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
Subject: [PATCH v6 18/42] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Fri, 8 Oct 2021 13:04:29 -0500
Message-ID: <20211008180453.462291-19-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f00308-1a13-4799-79a8-08d98a863f6f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3421:
X-Microsoft-Antispam-PRVS: <MN2PR12MB342152A7F516C42A9497EFF3E5B29@MN2PR12MB3421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lr7pVCE6AIGvmAIkREMxXFSVk/N2lYDiu1UdEmWG19xU+uKaaDqQNvh77ymTlIW+YNXVEcJhXxjtoLEsxyGCdEFyHeUdqeGYQsPEiVBv8OKte7d1nHFJfu4sCy+9wUf7+K/NOUj9+1S2bVp+Mnsme4zgR3y/VHEMYA/czFmdm/G9X85Ur++qa/e41LmotASOAFcPo4qpgavXovKoTRvlHkuj6eDu7e5eVULXsgTFwZapBzmzAlZ6NbDxjmhKj8AN+Ao3bYYUaktZt0KfBDzV4mb9/cDyGZPeJniaKo1LpDrR8rvIJ0Jwt2Ud5gCfCTaaHfivV1yYcX1uY/X+UwnmJHIBE9VFA6lHO6lSQfbxUDL4BoJAWgslurNKLoNmDOBYcI6CdNLf2OVOCrN9ACGuMmc1ZYzkXykNyEiE/CWAXbkMZKxFlJWtbKMXHyLj2i8pUzthEFJaR2exSf8bDrxLzfoB6abHlZEtfvIL3cZJhj/f34qhfOhD0baLiPjeylvZvb3sQK0lP1NJby2v39ZhtFyIWFW1taeJBxjDCkHukRYDnh/eiU9J60HZzS+ht9m5g4Deh/OOF9xYAF9hchRvHdJsCKKMU96olcwagm86SWoifhOFo/r1dhmWRR8p89lV732T3cgpLl6LYHOil87XThnBRKT30RvoBT5PesT7bltuGLIwOMUBAlWsHgCpoWLWNOK+NsXkELft459i3AsdXnwBhKv75El61CwiBuhgAtvO/NZ3W7R7L8QOiZrkcdpP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(1076003)(2906002)(356005)(8676002)(186003)(8936002)(81166007)(54906003)(82310400003)(70206006)(70586007)(5660300002)(316002)(110136005)(4326008)(336012)(426003)(16526019)(15650500001)(508600001)(6666004)(7696005)(26005)(7416002)(36756003)(36860700001)(44832011)(2616005)(47076005)(86362001)(83380400001)(7406005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:44.2507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f00308-1a13-4799-79a8-08d98a863f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
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

