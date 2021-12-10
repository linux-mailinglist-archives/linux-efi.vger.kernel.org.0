Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52EF4704B9
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbhLJPuG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:06 -0500
Received: from mail-dm6nam08on2053.outbound.protection.outlook.com ([40.107.102.53]:43905
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243586AbhLJPsX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaKZDmWUcXvHquJQTyOuQ6LMMl+k1GYXNI3Wn23/rgGVgHpCvUA+p2NQVBTqz9T8qdjeZCbs6yAUTFqUKvsU92K4IlWWq5cxp8/sHSzKUjmveSeHMhckSMdwM+zHaGfdnMxxYWs6YHAFeXh3qakF7w4jzYrWFlMD3WDRY/LyI/mPYubs4SCotz9YL0mK2CiADH6HrS5l4aCja9w9oiRVx2nn58tKMd3fPF/E8V4YsU+4xYLy06yzYwOYesAnYl20YVCHLvNmPO1kuwPZjJDet7odp+h5+z3WqtVrSk7HCrAqZ0JvR9nsRaTS0pB3bYaOT2rxIJQ2lC6RfSgvvBbnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGHkXN6ugGo9T+UegGwcR/SUbY9oG5EYhEhy4jA8Avk=;
 b=CeLyfC7AmbTOzRAOQ/s22DGvSZD69DQp7ldGjyNiaWCygX9g2MiA2rWm7YjeDB2xzemo1Dzd8Xo0wF2LpED2pEzvEx80uVOAygzvOBUy1P8vBGEo0ogljTbvmkMAeuZd8JZhC6lVMLKiIO6/QinmA5qW5VkZ+YHFZDGtSR+t1ebeb6z5PT7LhoO2fRmNZg3SD/HeGGwKvmzmJVOg8rdL+n6VXoReiLyGX19n/ZFeJ88O60PFDmQlmMqzHrW8ZNKXTBGU0zLLz845JpbmATTEOouJRqyPi8hCnxzme5wBybOh2PItRQ4VXPa0YG8+NCoeds/6Kc47HptH8WubfmpDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGHkXN6ugGo9T+UegGwcR/SUbY9oG5EYhEhy4jA8Avk=;
 b=chT4vh/Gai5xBLa3StbGYbsY4HZTozp1Xi4h9W4B8DZrrCleRk8pQQUT9He5vX54YfNNmkF1LkHK1U4TYp+aaIpddiRvCTQxpuhkeUmaVP2dW/xw+ClK8GYHOdrmU4nf3yRhZRZoDe+a8SKLf2Y5SbtLTGlLjA2G0ldPFSsWTaw=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by BY5PR12MB3793.namprd12.prod.outlook.com (2603:10b6:a03:1ad::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:44:46 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::21) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:45 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:43 -0600
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
Subject: [PATCH v8 35/40] x86/sev: use firmware-validated CPUID for SEV-SNP guests
Date:   Fri, 10 Dec 2021 09:43:27 -0600
Message-ID: <20211210154332.11526-36-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06398cd6-a5a2-41dc-c345-08d9bbf3fdd9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3793:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37937B5D2BB7938DA637265BE5719@BY5PR12MB3793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VWfguCfawvtYhu/zvBTjxKLsjuE2u8rum9fpDcyQPxxVk/ugk5QpJlmdtENYjI+4ArsdSMxqytGV6OMywOjDz32RTBX6bNGEmc1chcGdsvvD0Yy+zZcU9z2SEW61H6L6l5sh2Vmm226MgRC/6O8kSpD0sOcS5xbENJX4yXW5G3TTa22V4tMr8MMeXqgGh50DjJ151nLmYyFLGGgLVL9pNPXFppxsSsI48aQ5paSwLc1HfMKbv1/JEmkeB5GYVTElDQhWrv6OWLXK39A04ub3xbbhRFAdXR5W5/OXb+KhalTDED33Uypl/Ft82TMx2WlRdoecs8po7bJdYEmr1sbj+Wl8wscIQsQ4+xmJsmOb0wgFrPS9pAfxd2WOoSnKOkhaASkqY8AJM4d//Ii1JVhPAdX/4IVYPP40ZRLbVkXWLkSM1cB+N2yKzMy7QPOX28iC6OY+gq9ngdldClscFYAYI/OuD+aaE0zK70YmxBeu4CnWqriXV7cSsUo2XGtURNj/JQJlHIUTOdQYyTowsQMaazMIOxarMVRZF006WnQXhGkYFEKk9rZxd0jlqTlUhmOpeX2r1dWOGga6gDiSeiQe3oHRqlZnzjhImU0f3JdwqOi9p3JmSG3h6V8frpdrZtuJHNrGTMc4XHtDg3StzgqpP/UEl1fIuVd1Ds5nIJeip85CU8fqOOks9tsXb/b53wv2KfpXoN61B9gSuaTua5AJdaB0waWu8dTqmyqWSgXTNbjDUVRBPL8gXf5i9fNmk/jp7Z7P76luD0p+auiSPbgW/5WhbkSUVWRHSykvm5Erd984Icyd3UK76QfRA0nu6Bg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(110136005)(86362001)(7696005)(316002)(36756003)(8676002)(54906003)(8936002)(7406005)(2616005)(16526019)(186003)(26005)(4326008)(81166007)(44832011)(15650500001)(426003)(82310400004)(356005)(83380400001)(336012)(508600001)(7416002)(2906002)(40460700001)(70206006)(5660300002)(70586007)(47076005)(1076003)(6666004)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:45.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06398cd6-a5a2-41dc-c345-08d9bbf3fdd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3793
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through bootparams field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing cpuid instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   | 10 ----------
 arch/x86/kernel/sev-shared.c |  2 +-
 arch/x86/kernel/sev.c        | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4d32af1348ed..76a208fd451b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -148,16 +148,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
-/*
- * TODO: These are exported only temporarily while boot/compressed/sev.c is
- * the only user. This is to avoid unused function warnings for kernel/sev.c
- * during the build of kernel proper.
- *
- * Once the code is added to consume these in kernel proper these functions
- * can be moved back to being statically-scoped to units that pull in
- * sev-shared.c via #include and these declarations can be dropped.
- */
-void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 72836abcdbe2..7bc7e297f88c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -995,7 +995,7 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
+static void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0e5c45eacc77..70e18b98bb68 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2001,6 +2001,12 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	snp_cpuid_info_create(cc_info);
+
+	/* SEV-SNP CPUID table is set up now. Do some sanity checks. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2014,3 +2020,34 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
 }
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it. So
+ * do it here, and while at it, go ahead and re-verify that nothing strange has
+ * happened between early boot and now.
+ */
+static int __init snp_cpuid_check_status(void)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP)) {
+		/* Firmware should not have advertised the feature. */
+		if (snp_cpuid_active())
+			panic("Invalid use of SEV-SNP CPUID table.");
+		return 0;
+	}
+
+	/* CPUID table should always be available when SEV-SNP is enabled. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	pr_info("Using SEV-SNP CPUID table, %d entries present.\n",
+		cpuid_info->count);
+
+	return 0;
+}
+
+arch_initcall(snp_cpuid_check_status);
-- 
2.25.1

