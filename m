Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99F049FF07
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350619AbiA1RTU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:20 -0500
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:21504
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350554AbiA1RSq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv4cc2se8ms3odx5Mpuk14vD0WNXgPH6xd2XPhgD73GPFVnvFl4qvUhVdV40i7cEIG975j8RtdWaFKcT2eHk1s51sIkmu13Dl7L81dKC2JRld7R8tgAKyGilRbGf54hucAuOwx+ha4d2Itnryr0W/itPQ/8rrIhfMu5eUApvF9XJ2uvk5jokSUf4eEl7oluYYzfyyZlvu4PsVRpwiCavBnBnrwJ8yDHcJzxul0p/vNy44YwQAJCfnebXJ6Vqdf3dKQ+gW+ZSOy8vipiaDk/mSqPgTlihM2RPdofBvPSdBfh/CSu8JmIJewgWrVK/1hWv+sZCbygAF3BKLsNzYc1zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWpimHM09uRIFZDdh0YN8AubXURa1ciCcIXyBnkStf0=;
 b=ad83fZbHW2Mmf5ZcC+rED6bZHJlgLYIBcBJvHilP+iSxGWX52KGjRN5TOlbc8/PYfB0koKjxun3RHknDJzfpTDmwHZmhAJd+Ihpj7X+9Xx2ed7Fp04ySQyErFB3O/X69xuIO4meRTOg1X5qU92r/8xj7zwoNpFiuBEm2YKi4EdmvB9oWv4sdreWf3BFCC8zSUhQLg5CjglHdWEFtgBEsBgesa5kDLMIA9hisb1mP0fbA46En69VQb+r+PWP6imGWPDqwfsb+KAJp93EsVfaVpQSinSoXdhNo1EkL48FBHVw/cHfrMAwbm6qrrm+R4Pzv6TVBxM7L+rPdHFWk9hHpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWpimHM09uRIFZDdh0YN8AubXURa1ciCcIXyBnkStf0=;
 b=sbsYhnLxzM7oymIDoSUVpWRe0CtaSklTSaXq4SthzEk5Jy7r+RXZ3FZm1+MMmovBeaqbGRVR/XdhxcunFzsFkKzV91Bqee9IYf5KQBGboZNuDDuWAI4jkQgXpAqfL12hr+7I99hQIJw5xI5UD5cRGb6IslGnEyqcwCMIYVlesWE=
Received: from DM5PR04CA0032.namprd04.prod.outlook.com (2603:10b6:3:12b::18)
 by SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:18:42 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::35) by DM5PR04CA0032.outlook.office365.com
 (2603:10b6:3:12b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:42 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:40 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v9 14/43] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Fri, 28 Jan 2022 11:17:35 -0600
Message-ID: <20220128171804.569796-15-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59fe2b2b-0f59-4a21-8abb-08d9e2823bb0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26728454DA81C1BFEB25BF24E5229@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by9pRAx1ACEsfpcSQHND56pDgiovMjGoLUf2f6lgFdx9D3M8ounXOuuN7Uz97+mTHtjhloF+BWdv+iBytL9vUpgJfzJvcsy+xQe3NKsrvEOtG4bNzoMgr4JLC/mhTU1qYA//4U9B8m7enGxWunHNsS4dPk93+LDggubtEo2U0VEY6d2XWS/tMeNXPC9+NTQKliOKLHAmpezsuK/MUgioVsKtE+MQ2tGl10QMhcP+1yr3qT9/Et5x5wFBpbJq/HQIvsFugXcLYmx/YY3wGn4Ovz9u25/m1c8gRmJ/JrrSisRt37S8Bl2CPvdyXilFGOwFEKwbSqvuVD6fcrqrFmIPSGARQetJ3VX+asY+XsJqK3fSyiDZPUbK6J2mlJjdjcLq8LLmmfGEPFogSUznK9qTrjKVtz7e6CNLACg80SL/VXrmcUL1OK/pJjjpgcW7l/p4t2OfImXHxlJDw9Stdh+yw7EPgZpid00Cn9PIkHk3m97iMDar+Xa/wg/8KSWXBj5Zdfq4oPUM7pSkoQBvlvkF9jPNx6+7KFzUavgNgRQHeVeTjYUbpvVMB3mZbwG/CnpjxyNgD2jmL65Fr1HZGoRILDcx5cunVK1NNerDBJXqGwBmaZzQcBsNSJ03cRdJZMHqAbxjGrv5oGhy6Ctke4wNC80GMAecniRCGACU9ZbRr45bhA19Kd5FOsArIPYQFa7NRazNpzb8w0EL2RjZ6Oh+gQuYKrigvMk0ukZKlOCRZGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(54906003)(44832011)(82310400004)(110136005)(316002)(6666004)(7696005)(7406005)(8936002)(7416002)(356005)(81166007)(8676002)(508600001)(40460700003)(4326008)(86362001)(2906002)(70206006)(70586007)(36756003)(16526019)(47076005)(186003)(26005)(426003)(336012)(2616005)(36860700001)(1076003)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:42.3593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fe2b2b-0f59-4a21-8abb-08d9e2823bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest use a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1305267372d1..1e5aa6b65025 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -178,6 +178,10 @@ static bool early_setup_ghcb(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index dbb4635f2bb5..891d03408f93 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,19 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* GHCB GPA Register */
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
 /*
  * SNP Page State Change Operation
  *
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 4a876e684f67..e9ff13cd90b0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,6 +68,22 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
+static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.25.1

