Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400284D09FA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbiCGVju (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiCGVh5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180188B2D;
        Mon,  7 Mar 2022 13:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXOMFh845GLlGBol1pqImER+AnXAfFZ+XGDd5cw59z95e+7FYJzThBa8jxlK9FU+ciB+boZswH/Ul/0GMfGXFy1bd0dsaXK2WaEd9bxhn+sv1h4uFd2VZOViVDXxKGPidxpXQJcIUrNfA//U+/M9iQ1qy1JYInKkSSKSeEW3G4Fan9LUyinfV803n3qpMQ0MdYUJWmbi24qxdFMBYClDVRvukz/OVpfdN9ypwZBz5xSj+uUeF/qhWwf4BThUAGK2zeVVSHc6ha3AborvtAMDQdEBcNXNLQm0V/+R2QbNgxA9zYXMcs2eUhIWspoIoRIp3QDVXLEZVqqZb1JXQCYhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G66NGRXdXKgohObFhMOU5M+y0JCo9aTJaomphlm0EdI=;
 b=h3uo3cF47pOXENil8L0pupnEdcTr9hYsue6WdIRCYHhaIr8QIpDHEjH1C7M+cuZL9D2S5BpUvpQ4obeS/B0XddJgUW/VEqwtCmQGqTgVsmXkdx0bFXrtyyYGEkKA4d67hG+n8Kdnr5gK/c4uCLXxj/wRdxEiL76ugqsFpgGy/cW1LjXIJewUm7R9dQXy+S4z7gRwPQrVSHYar2d1QsYh50v89JX6N/4ZjK1CSJ7tcAvuMylMv+zSiC82MHUjL/ZpRoxKqBWTouFekgRju5dcOaHHNz5zf7bWYO1o4Z77E+pua5F3Ec6n8DWzKoAnD3PUBvR+j5IPwRg9GFhKc2ImGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G66NGRXdXKgohObFhMOU5M+y0JCo9aTJaomphlm0EdI=;
 b=WoIcqZ5EhY+SVQ2f+dkQDhq8mHnkz6Uwohjnzh24IAZco/IM8spnyb0dX5me4tmfta+Vatps/wzFNGQEZ1hgK9qw/e+ZHDR9s+CMNAuynrXlKA/rUjCD54e3/0fuL0ldWM3T5rNEzTrifty7I9FwhoDANUPEwmsh5We5SqDb1U4=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 21:35:35 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::15) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:35 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:30 -0600
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
Subject: [PATCH v12 42/46] x86/sev: Register SEV-SNP guest request platform device
Date:   Mon, 7 Mar 2022 15:33:52 -0600
Message-ID: <20220307213356.2797205-43-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d3f324-e561-4d6b-da8b-08da00826a50
X-MS-TrafficTypeDiagnostic: MN0PR12MB5931:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB59312A9FFCC19A336052BA90E5089@MN0PR12MB5931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Nagy763NCHgLyKtgtmGd4x7bpsf66/pK40UcTLjj3RMa/d3WsUFnWGMfP//+7CsEDZanhBYgiq5RyfHJULV5P7CLZ6LBjjPxh+oOPzLeOuNAmcNOIGYlhDLW7E0NJ5WPqUVUzHqoVPp6Wvxq5zr0zmuDTyxqLm6VvMjHrlGCADI84+rcoR1Tcdaka2BguRQYAL4kQniCYYKLkBTuKhRBXPHrqsiqM/Ya509D6NJagrv7JGC/QNiqm+Kt4hk8p+k82kjCA8e+gp0mCXi1nHiAIY5g/JPujmBAPZzjP0q/9+m6XXuhaSf9ukfvvcQbKL01kCBfqQNRKaWy0+K9bV24TSt9gZqjf7A0sfyS46oStTra2DOTEpd/ZGBpiLqjA5ooKhJBHHInHtxHZuqP9+Nm9jjOTW/xGz6cQOymm4bbfYNrCit2dToUNigu/cX74cXrEiJn9IMg+VtO00qAXxUbdNVy3fgaeLwaGObcjHbvoD1GqPah0OT14rCqOo0EzB950GeRnikY7vgwuTZWxayEzXvOrpXAtZWa1wvmVrgV7Uf0Ga6n4is6Mv/XZuJtVdkRfEOwT07a+2EkRi96A3SikahuGyzL4uegFYC5dF4hE09PQodNCG8cfIWiL3rX+wLJQb1R5hkBvc9EdJah7xXkeLEvyXni0r/QmyN0Uu5mi4nxxLLud8nCWT90yiwa14rgF7B5tO+CjxyqNdDug0hjzhC0YEAd/RBagsvJgDHthg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(83380400001)(8676002)(36756003)(81166007)(54906003)(70206006)(70586007)(508600001)(86362001)(36860700001)(6666004)(7696005)(110136005)(316002)(16526019)(336012)(186003)(2616005)(1076003)(426003)(26005)(82310400004)(2906002)(356005)(40460700003)(44832011)(7416002)(8936002)(7406005)(47076005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:35.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d3f324-e561-4d6b-da8b-08da00826a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification providesa  Non Automatic Exit (NAE)
event type that can be used by the SEV-SNP guest to communicate with the
PSP without risk from a malicious hypervisor who wishes to read, alter,
drop or replay the messages sent.

SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
the secrets page and the CPUID page. The PSP firmware populates the
contents of the secrets page. The secrets page contains encryption keys
used by the guest to interact with the firmware. Because the secrets
page is encrypted with the guest’s memory encryption key, the hypervisor
cannot read the keys. See SEV-SNP firmware spec for further details on
the secrets page format.

Create a platform device that the SEV-SNP guest driver can bind to get
the platform resources such as encryption key and message id to use to
communicate with the PSP. The SEV-SNP guest driver provides a userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +++
 arch/x86/kernel/sev.c      | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 97c86541b9c6..5f48263bff8a 100644
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
@@ -2180,3 +2183,56 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
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
+static int __init snp_init_platform_device(void)
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
+		return -ENODEV;
+
+	if (platform_device_register(&guest_req_device))
+		return -ENODEV;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+}
+device_initcall(snp_init_platform_device);
-- 
2.25.1

