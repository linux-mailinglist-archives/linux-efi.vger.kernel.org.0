Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A964AF9AC
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiBISPj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiBISOv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC12C094C94;
        Wed,  9 Feb 2022 10:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDhfJLYo68yiQNOvIGGpOYrS3bxYq1tKZ6Tg2kh88m3DMlahFqDFedy/9dWZz8DwHlGq+BJcl9APCVhdkjey/vMNl883gMMuDKGflQ7N5SZD36K4GAxuk5kdxlCduhwjSDkY1WBbGv6N10uNkP01VQq9N5CrfS7lQN0HkkW8z9QQsTFyqqBf3PFdH2RplDP/W3kfiY2/Ym6XmviqYTbRqJ0ulHn2yACLRFlt/gksrUt3MWtp3/a2b4pRw8onUNn84ItMQyEUce3ZNO0jgBDUn9WDyH9R0V1c2xZGUJhiQO+hNqKNzRbTLUmUoK2Rfedvphq+d6BEuUSaoR3p0UaGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJTocnhKOp+K4CopHK+WzJCTU8rJlZFjYl1tpOvoZ8w=;
 b=P0M58OSgCmDX4+ePdbPD4QfXmu+h0hACKQ0xh8FNtoCJVMfRzU5gchM9WCruSIiUDZH9a4USkibWPaH+cwW1Hp8J0DY2e13BcLuKEd1wP1bgDKtDTPYjmfjV/bjHFaFxvgm8GtQMOyenzDml/zrv6A0k1OTdRBmEYUFcDU5Gxg9P/QsbTXApVudsUKoyhaSukDH2zFwPgbMFRyd4Zw1IqObURcjTiQiNq0LLsvZQ6k14cIOJ7G6XKwxhe6C1gbJcMy/wm/Lqm2CoHaOM2UsyqVyPedWbw3WMjPyMBC/urXC3TTCzZTblm8P3Hk23c2H6FTwWJNkh0Xe3dXO41sRjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJTocnhKOp+K4CopHK+WzJCTU8rJlZFjYl1tpOvoZ8w=;
 b=APJyZ5veEYL2o1LPqS8Ngu0GybmLdozig61OIj0uDo7Dz+DHEpms5IpwGhfqqz6jHqUjmf/6f0cEuoNkAED5EcXuXNQNvGAlIAYcQP2IBTRRjM0mPKeYNrnNymeD7vgZ78YkLe7l8ACD3K4d9nrpUrr/0OPhU6HRqSd31pVldXk=
Received: from CO2PR04CA0151.namprd04.prod.outlook.com (2603:10b6:104::29) by
 BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:38 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::bd) by CO2PR04CA0151.outlook.office365.com
 (2603:10b6:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:38 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:36 -0600
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
Subject: [PATCH v10 41/45] x86/sev: Register SEV-SNP guest request platform device
Date:   Wed, 9 Feb 2022 12:10:35 -0600
Message-ID: <20220209181039.1262882-42-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c4dcf0-b500-4de2-84d1-08d9ebf7c191
X-MS-TrafficTypeDiagnostic: BY5PR12MB4855:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48551970161B0409F3C66632E52E9@BY5PR12MB4855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZ4LTJmJZbvkUPeOU4apVQlck31PwvEAp0/PcEziUBZnbO/D6HwWnhC6PKcy5xLwVVDVI85h7hSkoUYaqSUr9kMinnHEdmSCp+UcwMVnKLfTuZgaN47rOVSdc9E06j89jeNfZYeoefmcwZgpH/pTpqmM+37bL4foCiAb5jeye9PQr1PCx2I+BL6nI/qYuIhfeQcs5gHHzuD8R7/PLKjLm2G0ZYj2Ccy/QIDy9JFbfZ6ttcTaM0iJhi1OC9HiInYed7nFnBHd6BCYiBRG4gOInSYkIDBjXU4w+pDtv46wZX7S7/ApYgcggXxPEne0ilTKtUr8u9ZZEzYI5xUxXAGh5XoL4DGiBMDkiUgrRVtZEx7x3+eDdkQ6ZiVLbsgNrp2gEkH8C4iS1OqUOuZ4ChTLqieV7TWNO91Kj4sK7SDCJ4htG6KqCyy7dDxbTV4FKgMeGPDCEO74gPA1XckcTxSw+j6qw5ftbcgrP8zth5yfMKiFwThrE+rXURu3tkbG+jf5PQPaOf/bPaaImTz54k4A2/BO5ygPHC09B0Clia4wtMKKjdrGTGHU9XUAGbi4UfpYZRjfwAANL6wXhV4LuXMW8R2iaIcrPn1ETB6gWFIlTR/NLy3iNMq1qG+CD0162VoG8T1YNji/3hmEaUpdJ2AYOL5Sz0RNjn/udIrIxd04ll2chLbkLeQCK+lOG+AzLEBD6SHzwpl3IG7BAqqFfXCCjnalK8rSOA9ujLKy4QwCX4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(70586007)(70206006)(86362001)(7416002)(1076003)(426003)(186003)(26005)(4326008)(2616005)(47076005)(316002)(40460700003)(508600001)(7406005)(7696005)(54906003)(336012)(44832011)(5660300002)(8936002)(8676002)(81166007)(36860700001)(356005)(83380400001)(2906002)(36756003)(16526019)(82310400004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:38.4749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c4dcf0-b500-4de2-84d1-08d9ebf7c191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855
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

