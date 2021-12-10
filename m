Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B671470457
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhLJPsM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:12 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:19169
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243269AbhLJPrs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clfQsC+j21YC071vWRSry0xvoD2JdsP+KFU5mWXkOMKiEqjfYNCxo0DRYL+4ZDwuCDQvxEqnFwWQBnAmaoAm6aM4QYLM360oG4G4nykZrWMDUtcAfx0APkjb+ywu2Ggfw2vi5t/FIpOspe5vO+uCXtE9uWNjXdAHn8wIDcVsL74uILVGokLRxulWSsXiKgVtKZdlD6UffBU6uyIXh4oOsmhc0VkEyWxkJSuodYt7IpoHj96XGGP+xWBJPvFoE093E7ViEcEmHc2C9MQ40OguGjw3zNzFeGosDCL0T8f/WQ0d7WroILKPVF0t4pXpYWGk4qW00dLlA7p+qryeejv4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9qkDL0jQbWkyJtlUNI5YnTU3a8nQtpo5XmoFULdacc=;
 b=MMYjjYvpZ5vqMosY0jF8VxWjf1C6cSF6bN9sWRJwq3f7PRQXK7TeeiyqRR48ZAZmHEVEhh061F47tNVLfGqnl3jf2sSaLpiAMEAl5jmcfeBF8v0SN8KUPceOxnaiJAHB0YeaLHX/j+YVEZCY3/BE4dy/XuRosHRgkpZXUyE07Zap0Yuecwl07MaFwgBbz8+HJzYyy6ZdY6uUuogarLGtWYCuonzz/2DrseONaXOnxCAIt1H20/Gt+U8JwQXFQEY2JA4MjG172g2xZugMY7qx7JmuOTN2Il4TmucqAyF239kWZdtvRKpEVSwLvI0ISJTP2wvVWRyXCnvOCyWCVGZ7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9qkDL0jQbWkyJtlUNI5YnTU3a8nQtpo5XmoFULdacc=;
 b=PchwCzsz1dc++TDwMWXouCrjqofZ3Nbp7LTIqBJN2kTdBI48mQ1XVnaBbsbk88/C6887XGxr6onxccyV5JdMrkZ5ZDPkCU/hqUMtcxRMk2m5G+M5/WrGrKn/wgYgZiS/zoLKaLlVlPopvx50bfkGgrKkfFdi/F8lQggKFV6e7C4=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:44:11 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::df) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:11 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:09 -0600
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
Subject: [PATCH v8 14/40] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Fri, 10 Dec 2021 09:43:06 -0600
Message-ID: <20211210154332.11526-15-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17618043-88ee-43ae-588e-08d9bbf3e952
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB501623E80F62CE484CA8815CE5719@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaRY82HeU5QeEJ6LQ8dkgSSgcb0LWz/uMzQsZWSKf8xd8Y8HrDww4AVXI418R/tqhv/V9qGhvq0ypr3Rs/tzU1j/9X2NqJ20EuOt8MiKMe29Rf0yewSgEiItOynksfOcMAuvHAIEymGsdIQBNnYSd/Y8WuLfn1vanphgC/50XIJa87El5mNcjA8x3GlhoQFXu7Zj5hfeKFMEom+IrRA+mcOvK+SNDnHaB74BZv44jroQFGiGOFwH8lwyT6GiuhDRrFzHE3WsaRsIahpZYd0Nd2Z0MEN0eiSZg3nm7OF6AgajHj1doLQ52bSL5OBP12y5tkVdqFcJIKacFiDJ+a43nxoCi1wJiLkBgCr43ehO2/8Tg4k0RrJ2WwMvX4l6CjgUl/9MDxMtxmE/DqTBqweM+bpUGMUTe0J5P/CWqrqrhzoOcgdy26HvIVduEKrz7/6uZBANE6MPx/bpwaqd/gXGhuNo44l8tda75xShedcvyMEtmvEjzw8KjFmsWaGyJThvhf8zGK2RO4oqxJKrmnnuBNLmtYSYRtKkUc+aODsvYPRMIdvvNcQgi+ADKqpYBh7TOiDTdXvgElaKA9yfoXzkKM3i46EoXJcmMV8UQBLppTzbTjryTW9YwdP1Lrnb0yyZjyq6d4uGct9foSkI0D+N1YLUwhGrM1r+kVAiaO4wTAKb5joCv6riNe6II1rdgYulw+Z64j7qtmcg746ycWNGp6QFltoJpUU9rI31vngmKcghNQRiJZ7qiDW9NBKmyRFi1p8MRR+flJNLSMoKlMe75hLvIoCYywQUk1/j9Ch/IdTsQtKlGMn1xpmH6QT8GxeG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(70206006)(86362001)(15650500001)(6666004)(5660300002)(47076005)(4326008)(36756003)(7696005)(110136005)(54906003)(316002)(2616005)(36860700001)(16526019)(8676002)(356005)(83380400001)(82310400004)(44832011)(26005)(186003)(426003)(336012)(1076003)(40460700001)(70586007)(81166007)(2906002)(7406005)(7416002)(8936002)(508600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:11.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17618043-88ee-43ae-588e-08d9bbf3e952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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

