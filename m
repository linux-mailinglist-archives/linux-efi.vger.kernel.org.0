Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C549FF6C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350912AbiA1RVZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:25 -0500
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com ([40.107.244.47]:48257
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350901AbiA1RTb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I57EapeOZQV5MBySn9/mnwWkkP2/lWEhMNotKnNoOP7aE6jLNnjINstBYSpfV4q3OkcEjYD+/Z9KToCUJwvSeNrXWQX0oFz/N3v8/WYH8DKhlMz5p8YLdu9mXgYn73XsyDwo7uwxr43TlvHg9zDC1xFtLN845Akkw9tQ+UBiq9Hcf05OWKpmcHhWtiQ4yAVdR4lFrisnQsBTUaIAxTQCzmYoyudPnK8ZfUixUCTFoXIMK2kQr5BRBKweA359V1tVu23gn89aQr3UpFHF0eSS5+lKuWdl8U7jgVnKJc/yH4FDMP+pWtyrUOobr5pk76bGEPnanun+P1/CcZC51Tg+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kgtzTGpasa7a/MeZaFvukiAboLomxYM5Fmofz8ns/0=;
 b=DtTKW7mG5QIPwMUAjLExBAFeUOvrMkJEszxvll6O/hfSuLC4wKtiZb/QPINZUzgzrew30CEjNU/nGpXqP96NpMa5zuQjB7IuJaAKhGONkUqIqQxpprb2BnfyPAOwOpI61Qsm7g8tqQ1lhhCp0rlUEEpybYoZ2vHYZ2cZqFALXMDWZF6cT0Dzi+q51CxJldVG3dRhfMrOOeGR3A6VrvBWLw1epCOt7O83HhN9plmg/paOqJSm/kT/A/lPPL3PdGADgz8BGmCXHzO61J6IZpRMmAFCQAQ60mRRHp7izdnw3pEoj12NSIecYQq4saAj/77cIDUA90l+tHEMWQfsUyFtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kgtzTGpasa7a/MeZaFvukiAboLomxYM5Fmofz8ns/0=;
 b=vF3vN/TWEezCEjn6ATnNGYJf2fNWeCwcCJjJV/03nM9fUzfVjrqp9uUPMjRrNojRmg9NtfwbZ4I3hMv0HJxgylkmn95T+NwEf/GBUf2iZRdpZuyYFCOQ/AeHCd3AbkjXMLNuDW5nzq4QTHoJMOmyMicGy6ocLITZfALcM+GPUzE=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 17:19:29 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c4) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:29 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:23 -0600
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
Subject: [PATCH v9 40/43] x86/sev: Register SEV-SNP guest request platform device
Date:   Fri, 28 Jan 2022 11:18:01 -0600
Message-ID: <20220128171804.569796-41-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85e822b-26f6-44a9-cd3b-08d9e28257c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4562:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4562CE1F08D0BE364A5AAEF5E5229@DM6PR12MB4562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCup863hpeWBiS81p7l31lHTUvvzSxgo/i0W8KqpgcUg6BfA0REA8AbiTzCdmizJRUKe07EsQo9Uk0wbI/qU8tdS8Gp7Mf7q0HVcwcB3mrQpsXNgEWSkr+cxg4hBRUoCcc0EMuihV97PQTcEfXMJeAryVDY3wKSCcdtAGsofpZfRe2iKr7eN9teIo/K2v5smpLxn7vm7nJfm63Xgo6BWG8aIN2DISnQvKt5MxFSipLTAJOH0dZHXyNKyQ9yWi5Os30GapsaCkiu+wkgT2pIR3Oy9tb8MmC8DHutQMYnN+WOjpWVL2OYXORQjBr8Gh5i2unjfq7ONtx9acLVhUGoc2kOhoSbJGJ784dnZMnFluSxigHBh2gBlSr6N60cjkE5Eg7sADxOO6BfKh+DHvt4POPpoR28D1YfxqMzy1iy4Gg67m2qK/JLdsHjNeweblftzwZxqbl8DCY8ZDWWYJxaunYqa1EJazaVPGQZ6GJbbgnJe96ObsQiWqtUuVaz88wzftwEk+8IAFuyyrTAgJddjoqDg7+lyAliriq16CJQTN2ZlJbJqOhpojy2zrD4mZI3ouRcG3nTlObEm4R+dTIhjO9Nt2DJ2GDKkHJEusjpAN+P09MVyQcIzstXzcT54rSwDyOf89WMLGC7kZ08RBQElie3jqZyrOoqoU1gV02L9oQiaT0T1dtS+CGAL22ofEFydkAjxY96vM00/xn3yyp5e5bKsOqQXlmaoNOk4kbqvcEg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(186003)(426003)(44832011)(26005)(70586007)(70206006)(356005)(8676002)(7416002)(7406005)(81166007)(8936002)(5660300002)(4326008)(7696005)(82310400004)(2906002)(6666004)(1076003)(36860700001)(2616005)(508600001)(47076005)(110136005)(54906003)(316002)(83380400001)(40460700003)(36756003)(16526019)(86362001)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:29.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85e822b-26f6-44a9-cd3b-08d9e28257c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides Non Automatic Exit (NAE) that can
be used by the SEV-SNP guest to communicate with the PSP without risk from
a malicious hypervisor who wishes to read, alter, drop or replay the
messages sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
the secrets page and the CPUID page. The PSP firmware populate the contents
of the secrets page. The secrets page contains encryption keys used by the
guest to interact with the firmware. Because the secrets page is encrypted
with the guest’s memory encryption key, the hypervisor cannot read the
keys. See SEV-SNP firmware spec for further details on the secrets page
format.

Create a platform device that the SEV-SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SEV-SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +++
 arch/x86/kernel/sev.c      | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9830ee1d6ef0..ca977493eb72 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -95,6 +95,10 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
 
+struct snp_guest_platform_data {
+	u64 secrets_gpa;
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1d3ac83226fc..1e56ab00d1f4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -34,6 +37,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/setup.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2177,3 +2181,60 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+};
+
+static u64 get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static int __init init_snp_platform_device(void)
+{
+	struct snp_guest_platform_data data;
+	u64 gpa;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	gpa = get_secrets_page();
+	if (!gpa)
+		return -ENODEV;
+
+	data.secrets_gpa = gpa;
+	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+		goto e_fail;
+
+	if (platform_device_register(&guest_req_device))
+		goto e_fail;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+
+e_fail:
+	pr_err("Failed to initialize SNP guest device\n");
+	return -ENODEV;
+}
+device_initcall(init_snp_platform_device);
-- 
2.25.1

