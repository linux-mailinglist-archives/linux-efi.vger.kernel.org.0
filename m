Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D842705E
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbhJHSJo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:44 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:11104
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242993AbhJHSIX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmBQEysiC8L9FLkqRlMKzeI20H42P7bukmOCNoE43l1fjmyuXXg2zeZZtvIs9bCfQoTMgnQKm4xEMshhaXYfNv1HcFwps/Jaw6ymGVn8Q1gn791O5Qn6rOZkZhpRIOFExtS8oxgQhJxBxvJTptEKKwgw9J4shZ/g4qo9oQJYlC9QG7QrsgtdbhVOy+vhjPnE2EodBj1eQXPDTiPQtB6OpKGct5RFnj0TSBAtgKsMDFuAbIb5NAe7G1lkutmOZNS2C1y5MzxCinFsAVwTCR6r1d5YTdOc+zAYt990P01jdT21tIppGTZ2UUBjcfk+pZ9AOduxxkIiiWvCJNLLixoHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgv//ZLIILOSf7b5GeKSvJp1IMw4dXZrI9ZZsmQJ+Zw=;
 b=axM2kgbhx6soHDnlZGB8uZOGlAymyAILI5ciqYnq5siDZc49doC/3DWquefXM8X7PsWndKZbq+2Rs0oc2PdZSgpEfSY7rnnr0YBzopAwMyN88eCivtT/QCNXZ01cRhku35Keosi4l92PM+mawQ4qcRwpL3q9ngbXrcasaTQJXZ7EsDASg0qCugpNrSTfBoojHZJljqJbvyxgxQaAVptau28pbUstvS1QycrFfD000JRMW40WBco1g7cswVqJmfsxyicI75G8g3+HRec9/zfyxq4csge3v6ei0N+6HbFFfLgfLhWumLL1Db9txTuAMmFkui487mBlQXcpyi6Hn3DLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgv//ZLIILOSf7b5GeKSvJp1IMw4dXZrI9ZZsmQJ+Zw=;
 b=P0JpXPLQb2ncadAnQUh1X7TCuuWnRsl4RzvajS2v5qYEmTkwNj44vlv0v/ALR4pcmncdlwbfc+imLWcriTJK5NkoDwihbliutF8K7Jc/cc4pZZADkxjydzptjW3IqDw1rjQXmEWVSFFVfPQuXaBZOCEBSPFyqaqHP0Sth8FnHRg=
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by MWHPR12MB1197.namprd12.prod.outlook.com (2603:10b6:300:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:06:22 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f7) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:16 -0500
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
Subject: [PATCH v6 39/42] x86/sev: Register SNP guest request platform device
Date:   Fri, 8 Oct 2021 13:04:50 -0500
Message-ID: <20211008180453.462291-40-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db846a49-5ba8-4732-a59c-08d98a865613
X-MS-TrafficTypeDiagnostic: MWHPR12MB1197:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1197E8C2059CCE540A408A8AE5B29@MWHPR12MB1197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfjGfrwAlHyF1nWivcSu2kQKpsUzFvMaqbffjiBjfe6lVWbg+EyrWCYWSgFtxNc5ZJdgVI8AWS2IF2oBJtb4CmMu4Vc/XWUrXB6GweZ8dL+0r0pEenP5Qmw7t2cpwQtY6J8Sfhd1obJv8FgACOzoPm2EgE7Bo+yVS10UviVvzCSc6J2K7OA/b+32h2N5AWs2iawpr7I98QEyJ5zQLEpVzhJS0SEQ4WKnlrH6qPcaSYWjrXkjie+FQp7Fb6xluprwwgFpCN48nzFWd5MYgtl8zDHg0Hp1VPP1j5iNdpvy1xWvfJjxXuDTf8LKHxFfTlwaGXeGjmm8c3qjf2aaEJAUhWOAfP2rD3vTUZmIcsO5+IG3izXCGHtGnoduh06glOlFmuGuxiH0k6iUk5I2elUlqdZlcqMMy8xuKPO7n75JrHhTS1/M6KLrHbsCRgZ8r65+j/hUaZkGbOaaOqhYNqyziMp9r3bN1bC+N7wFSbHn2Zs86WN+P4uWIT4jYzuxRsLeqjinF/qFwj1nseQ1FlIyEh0gDvBaggac2txJJ17w2cCkLKlpuZY939f8SQ8qKlu+iI7Kq7IGRrtcZRpDJiLFYuGTvZPgQYbOE4PWjD56RFfLgGvi2Vtwj2lndTrFHLnxrZRS/pYH8suimsX2raNwKTQT5NI+QTdGp6xh5zv0JL39s8W3aa22RPFTSoz6Woywlv3BwhUxfjItUAlbIe4/Dhu10OdQhZF9zgGLbL7BX6kGLZC1e7EHtMNrcC7SnRma
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(81166007)(7406005)(7416002)(356005)(36756003)(44832011)(8676002)(2616005)(47076005)(83380400001)(36860700001)(4326008)(16526019)(26005)(82310400003)(7696005)(2906002)(70586007)(508600001)(5660300002)(316002)(70206006)(54906003)(336012)(426003)(1076003)(86362001)(6666004)(8936002)(186003)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:22.2405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db846a49-5ba8-4732-a59c-08d98a865613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1197
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides Non Automatic Exit (NAE) that can
be used by the SNP guest to communicate with the PSP without risk from a
malicious hypervisor who wishes to read, alter, drop or replay the messages
sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
the secrets page and the CPUID page. The PSP firmware populate the contents
of the secrets page. The secrets page contains encryption keys used by the
guest to interact with the firmware. Because the secrets page is encrypted
with the guest’s memory encryption key, the hypervisor cannot read the keys.
See SNP FW ABI spec for further details about the secrets page.

Create a platform device that the SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +++
 arch/x86/kernel/sev.c      | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4ea8e2f73d37..2a9e6ea11242 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -88,6 +88,10 @@ struct snp_req_data {
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
index c29a78f868ed..01505ac9c7b2 100644
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
 
@@ -2171,3 +2175,60 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
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
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
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

