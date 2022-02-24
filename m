Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF994C330C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiBXRDv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiBXRC1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:02:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2012CA0E9;
        Thu, 24 Feb 2022 08:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKdKFu1PeZi/lzGRp8rGVO4YZ129XIGbF77UFA3awwHTrDRlK7D59LDJTLq0Kbd2BnRkIj/pElHMSRysQXlyh6Pou/v+G6LT5amTIR+hBVXw1KlXIitjm0coinzV0o61xjiyvegq+pfw1hl9VzYKNlJxjefMyp1cC8GOIqo7HfXBG2rJFNxNgHnZaCM2WQC0Jy528hIzJ4BkwBCzIll2owmZcm6KNVQx9EyvmVspbO9YMmwg7+lSo69rth5KyBGgyZiulGuaxlwNPp3Q2z0HwXpOJDlnjZwGmvVrfyc6te0j2ShXNfyBanlEktdY4s3IVuvwmAtz7SWdFBiSkMykSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJTocnhKOp+K4CopHK+WzJCTU8rJlZFjYl1tpOvoZ8w=;
 b=VeXwgVzJmyZZ+BzSEt2r/BeBux/DM89+WFM6U8t7QxdQq8micv4nSYL4Y1HFdBqqbzt/UduyL1Cj34I+i0Z38H1KbJpSZbe1vInOpx9UcufsrtG+HtTkQ3bzQTNE3OQvcDsiKYDJRM9nKIMg06oYTDHYBOE6nnpWlOjUlllGdLJQDqKOmlMt6TN+F/1kD4jGv9YsJOH7prkQjQmIRlDiI+rX/dZGo0H3wdyY+JFU586ls8Mtt27ExY5tMG3nTMwToqpcTz2IBd2iN9TFMpyTN7JL0JFC9wsBPkCfuaA8tIUMytcF6lX3dQfEC6gTW4Mguk3TOgiTNc54S55btQO55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJTocnhKOp+K4CopHK+WzJCTU8rJlZFjYl1tpOvoZ8w=;
 b=2genpiNJVu4OKIHA18PbkSEy/01opFcG4NgxabqMq6kRbT5Tp2NE2dbmb3QQvWBiizAsZ64Jj+P9I9fC1ghDuT3W7aAcy82jhpMlc2chbqrXc8KG4Sra1bB2v9O0+fKtqP2RDViUbYdckexWjlieRX1Ee3t0oNvCCel+MytlvKg=
Received: from DM3PR14CA0138.namprd14.prod.outlook.com (2603:10b6:0:53::22) by
 BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 24 Feb 2022 16:59:12 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::d7) by DM3PR14CA0138.outlook.office365.com
 (2603:10b6:0:53::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:12 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:59:04 -0600
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
Subject: [PATCH v11 41/45] x86/sev: Register SEV-SNP guest request platform device
Date:   Thu, 24 Feb 2022 10:56:21 -0600
Message-ID: <20220224165625.2175020-42-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6060f8e-fa33-48f6-bea3-08d9f7b6fb53
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34425BFA34D09F219C108DB8E53D9@BN8PR12MB3442.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XebzrOAsrOJmm1vC6dJDMhmlwCbBaFhix6eBkrvV9pV4ORloglcC8V6Rcr5vPINpi0ZB5rrJ2IUnCwPG3kY1F3TlbUMAcfJYHF/Ma5bzfAYAVzg3JhZhDrJDW2e+qThKeuiu6uSOZd1nv2b+mHOs8GGyltPE7ReOZQyv7EqkZ+pNVZoX8Z8lCY0j8p2O0C2Trdo4fkH3d0VvKlqyEpt2Q0wubV7AS0FNZ9i69+P4ckCMSgB5y0gt5JMPSVg6UUNHd9FqGHs1skINRNeWkLGmer++mMAwL35tVjO5PfLIoRDjpBcYGQz+PWeo+3+cdjWvdR3LAokZtBBqWjaIcwB4gPVRRmFSzN0RqiozQEUoVCT2u3ihcx5XS0dlfVaOsB6GS1QsCQcM1VNjmS4cENM9iu6Czg2IHpXFCeqRHpFzSKApU1NnvmpBnM52Ikf/t1+BaVB1VtH0K9c7HSe4L9F4p8HQI9Txtd+onil1Dc2kt4aOMel9ta/A7K++jn+0wPBNCbAEKHYciJO24KphYO653kuuFDzjKNaL1WDEEkkZAjfp5k+S5X3S09LrkT3jFmDUBZcOsGa7IdMLKzv6vWtM2xAGdqvQToIJv86wsVmijXW9k+D2lWIfLk7fLpTzvmP876nS942OvIOpK6EIPOJ3kGSnZRnIt6IFPn/XucgQO+dxuV2RBrGvpLJ/luoLeTgk/rbwdoP4SWo5wRIFLnJZkgASvyvETqNxXDLKNQc+jDQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(186003)(40460700003)(83380400001)(47076005)(16526019)(1076003)(2616005)(426003)(336012)(7406005)(2906002)(36756003)(44832011)(86362001)(36860700001)(7416002)(8936002)(316002)(54906003)(81166007)(110136005)(356005)(70586007)(70206006)(8676002)(82310400004)(4326008)(5660300002)(508600001)(7696005)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:12.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6060f8e-fa33-48f6-bea3-08d9f7b6fb53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
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
index cafced2237f3..7784067df7fa 100644
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
@@ -2148,3 +2151,56 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
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

