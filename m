Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99D4D0A13
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiCGVj6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiCGVh4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265175E4E;
        Mon,  7 Mar 2022 13:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNmtcd/wc1kVYSvNM6iMRRZvpCDNdTqshmPk6X2++eZP/BIzOQvcZj1PVFGegbH5xF0BNr0u20dveeR5OON/Fvl5ye1iwa0HM9I/PLK/7cFkpxlvS3jL0dxCBLaKHPHAph7flpSqho87sWpg11wVEQeGROtVXSMFswWoV2E1xM9KMdWYHwf8WaWNtEeb0tBPYSnB6JL7UdhDILI24TUxICvY9ihdXnPVsQIcUxYPKEVoa5kAXDdHH5WN7qPfZ6IQgnawoSFVBc1xlLS4dSvjQyLjKrHGWoonp3WoCf5lVPEViYZ9JqGcZlsR0ytvjkX6cLOqNqbrBzFRj6z/YC1s3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWobb2aiOG2Wk/2j/o4EOfKRABBsz/YlVzD0P5q7RJg=;
 b=LJRL8lDqX8JKPALtgGZUi5ieWV+TJs1QyHQNo6Zn1l8S08OcgXmmGlsdhk1gKD5cAXWqidGBrnNUnBIYmWKPIAR2J/DzfWOtQLVfX9fh0rzb/arj8YCEi/1a69dAujzzXmqpaWoyLp83t+pc8Mkgy9jly4TWaOAsc/mwG4yhzr2AImaAiK7OwNxg0/UnccsAwvFH90AUkY6GBDjKpvZJdA0Tjw8anHTKRiYtvZMkdl/rM95IPgAJ/64n9T6kHczwT0HJcFsgTWW5DVPCfg4xvLJHNYmbCqXZJ05GIYF6mKoMT/AMxDXtBo+vrNqYVM0qA5iplHwcFyK+PVmFA1N55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWobb2aiOG2Wk/2j/o4EOfKRABBsz/YlVzD0P5q7RJg=;
 b=36Sbjgwf2yxVRjnizh4xt3mQft2XvaOVwMUVytBP9CMa8HrjHBkpLeFwmgO+vCy/BNa6WEHSaOMfPZOZjHecxYSVKVDJlJYkbLMvMVaaZSW662DL1mrKZBUKN7tb1cpMYEb1XInRSulmG9z7oZ4gl3ntxQvByw5n1dflDnNYsvg=
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Mon, 7 Mar
 2022 21:35:34 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::6c) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:34 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:27 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 40/46] x86/sev: add sev=debug cmdline option to dump SNP CPUID table
Date:   Mon, 7 Mar 2022 15:33:50 -0600
Message-ID: <20220307213356.2797205-41-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195064d7-d6e7-4cb3-c9fa-08da008269a5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13364996282E26A37B6D8957E5089@CY4PR12MB1336.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg17bm2oRggRCeIy8edPGWl1sK8gj9ubIPJOlg3pEHc9tdE7MSy61V3jxv3X5+Q6sE4rMNBvGfwer7xaYjPGDs03d+PYrGrGszsITTutqSqqYZJtTePaDLruemrlwVFu0KSGOFxfm1f8KZmVd49VBtkdBSJ6leVUgl3bjZ/poAY9PcQSH8nzwFaycMIIr9QO2swMRgZYYZBVf4TpynJo8KxxN9Rl6RXseA71F1760gL6Vk+9XLb22KALT7hzt2O9zWujexJAVxO1vEKHE7TCbT9R5rXbR5Ijv8KFKIr8FXzSowLQME3hIpga+B5whmm2nC1zMoxE1Uj7wT2cS3bPiG3mRrDMi0PRiiLNAvtNXy35cwtyCPSMhtBHVkmIerdZ/Fi3ZJN5Jn8dPi8jMId2hCJzoxrcCsZUQX5eGNjVN2blKzcMBi6jhait0Ke3x/Hj6UWwNRkIn5wt8e3hXMvXidrUT7rkUG7eYMTjsWN/iJYmWkahrCZkhaJFnRtklrEqsiK5cpdhHSDUm1hAZM0mTezVFLJGblN/0S5gl3yOMJceCr9OvLPW8fllM3AMOaK1+A66aKe4VkzDntmkZfMUYOKhIin1a6S6qcsPBcQZChekw4Xk/taqACOjKJ2Qvwq/KzNnavLSnciDUau1lEgKFnHmhVQuAP5EQnwY+6V5Z0S1kf58gqumTHjei35WROzXWRYjy3Sk3IcMG3+wiaVe/yg1Z8zvGZryNnaj/T7AjYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(508600001)(5660300002)(81166007)(86362001)(6666004)(36860700001)(7416002)(7406005)(7696005)(44832011)(336012)(47076005)(82310400004)(83380400001)(426003)(356005)(8676002)(36756003)(70586007)(70206006)(1076003)(40460700003)(26005)(2616005)(186003)(16526019)(316002)(54906003)(8936002)(110136005)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:34.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195064d7-d6e7-4cb3-c9fa-08da008269a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

For debugging purposes it is very useful to have a way to see the full
contents of the SNP CPUID table provided to a guest. Add an sev=debug
kernel command-line option to do so.

Also introduce some infrastructure so that additional options can be
specified via sev=option1[,option2] over time in a consistent manner.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +
 Documentation/x86/x86_64/boot-options.rst     | 14 +++++
 arch/x86/kernel/sev.c                         | 58 +++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..809e8adc9bb2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5229,6 +5229,8 @@
 
 	serialnumber	[BUGS=X86-32]
 
+	sev=option[,option...] [X86-64] See Documentation/x86/x86_64/boot-options.rst
+
 	shapers=	[NET]
 			Maximal number of shapers.
 
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 07aa0007f346..66c970117f0e 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -310,3 +310,17 @@ Miscellaneous
     Do not use GB pages for kernel direct mappings.
   gbpages
     Use GB pages for kernel direct mappings.
+
+
+AMD SEV (Secure Encrypted Virtualization)
+=========================================
+Options relating to AMD SEV, specified via the following format:
+
+::
+
+   sev=option1[,option2]
+
+The available options are:
+
+   debug
+     Enable verbose debug messages.
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c6b2e0c58255..0b70ebb6df1d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -112,6 +112,13 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
+struct sev_config {
+	__u64 debug		: 1,
+	      __reserved	: 63;
+};
+
+static struct sev_config sev_cfg __read_mostly;
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -2045,6 +2052,23 @@ void __init snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+static void dump_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
 /*
  * It is useful from an auditing/testing perspective to provide an easy way
  * for the guest owner to know that the CPUID table has been initialized as
@@ -2062,6 +2086,40 @@ static int __init report_cpuid_table(void)
 	pr_info("Using SNP CPUID table, %d entries present.\n",
 		cpuid_table->count);
 
+	if (sev_cfg.debug)
+		dump_cpuid_table();
+
 	return 0;
 }
 arch_initcall(report_cpuid_table);
+
+static bool matches_option(const char *option, const char *arg, int arg_len)
+{
+	return strncmp(option, arg, max(arg_len, (int)strlen(option))) == 0;
+}
+
+static int __init init_sev_config(char *str)
+{
+	if ((*str) == '=')
+		str++;
+
+	while (*str) {
+		char *arg = str;
+		int arg_len;
+
+		while (*str && *str != ',')
+			str++;
+
+		arg_len = str - arg;
+		if (*str == ',')
+			str++;
+
+		if (matches_option("debug", arg, arg_len))
+			sev_cfg.debug = true;
+		else
+			pr_info("SEV command-line option '%.*s' was not recognized\n", arg_len, arg);
+	}
+
+	return 1;
+}
+__setup("sev", init_sev_config);
-- 
2.25.1

