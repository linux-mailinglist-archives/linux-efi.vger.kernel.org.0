Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400774C3271
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiBXQ7d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiBXQ7Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B696D385;
        Thu, 24 Feb 2022 08:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsbGBtTWxr/IxEz3cJDolneAPjL5Fy3lQESKrj49jtCF3kI8fmxRkxCz+7oQ415LsJBEoylvHmIcY9oBxAs6n0jztwf17qiJ3/fcCrIfSj6uyrI8b5Ttf4MtGy/RS4xgfOVboCZ/ncSJ1hhjNIq4i3Y0MN/A29QujRumxFUD+e/Krk+3w+IwcRy3mA87thYIokXKOAszZ0VFo38SNiY4EDi1UiNGB0/2nvrO7zumloREDJ78BmT10hd3KG7LjLp8DA9P2xpXp9U7B+7R7mi5oX1L/tEtljaTbwAYMLVIdwpsZJhKQZhit9amtp13fcidE+pktQUfDPVjDCmgposyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ccvjm4i+niQVLhQjVWbKycD0kl0lY/pUSFg17Jwxg=;
 b=bKFO5TcUYpseDWvN03bfsefyXwWZQyWWB84zxhRDbY6bznlVUbepQYRsiMfhH45xx9QDXvT4dtTKANX09LsKO0OFRS6Gt8YfF8y8rqKibkZ+7Kzoo/hJO/oIjNx0d+6Qv2QZ7yszz2BMcuHxFBGLwXbpNdJp2RIeFcU+3mL7MwEUS9inbRtojdps/7FuFpo0GxUeCMDd2HFDmGq5PtATAgsnr2g8LkJ4ZF4ZL02eEqJvnDOFXwYQscohihrjPkuZ3u/TcOUTUNEfvTUzhmTqOHkotStsoOb04dnH+XZGmcyxzHoG1SVhnQZROi4jf8L62jSlVpMba2MlfKGoBZ/HMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ccvjm4i+niQVLhQjVWbKycD0kl0lY/pUSFg17Jwxg=;
 b=iSg7r8kkJ1yvGbzjcgJMCBAU4KQ4r3tGTw7fhHWs3lG7DLd9TwfGJUJ7WdH/A65UIzQ2itqTSilherxzMimt8XAmwqHwGW2iBoH9CL0Si4bGkWWaqdU9K+BKGwURP2EBu4Zsj9lM6D1rnRFJ5nQ/9CwmQw1IfQErIOc8b+THB5A=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by BN8PR12MB4626.namprd12.prod.outlook.com (2603:10b6:408:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 16:58:22 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::3e) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:19 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:07 -0600
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
Subject: [PATCH v11 09/45] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Thu, 24 Feb 2022 10:55:49 -0600
Message-ID: <20220224165625.2175020-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df51d1dc-6cc9-4c71-898a-08d9f7b6dbc2
X-MS-TrafficTypeDiagnostic: BN8PR12MB4626:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB462601C708366818C9C32FACE53D9@BN8PR12MB4626.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIVl0z9f8WA/oC9j+MmtJ3rLrL2NyWmi6CDI2fZmrz4daUIGyC1JZRJGh82JqnClGp2+8OkWj9yI+D9vZQLzCrsyTRejhHtbWRhcGEt6MxdOZVJV2zdHROyReWaoPHZYBUZLMe2U2yuOjAOGeyaHzljOUQnaeoD0DUn4f3koAaqB9Mj/DNAW0jY5U+/JL/tYmkABYShqputa/1/+cEe/VgLn50wN1hy/T8DdA28fdWk8ABeFe1r3jwVbKIhR/R0fcWcD2pXrKJyiK8GufbS17uOHbw4tNOOZpTq0od74MctT0qgj0VJZRkIJO59Lo6YBbbNJwKZVwI00VkNuM7+Y6MDdn6oeDkxwsMH2FpbaYEYFGg3P5BBrxTwePrZOAAQ5p2xRO+jxvBz23kHiP8RrbgQm6Rpyp5uaFyQPdDIua1f7jnKNPbufSo7Dn5NXDs5YLPpwzBEH+XbexwqpLbEUH8FAHFbfpk3Ih16NoWXc9pVobMRjaFBGvJub5Xn/1gQTZ+CQxfVLGQwwlhl04tYe2nKjXK9l3JDufzGu7wgDC9lMhog15YSO0La7zOEovYyydJftyTn+bc5IcQr0NeMIKFFyWJa8JpCBekQAPWrmzjhjWQTTL1shve1nmToyezZl0452iMNKWdQp1QbgB6CVd5iuIot59DBjKJjtQJQN54UPIJCZMi3ClHLCuYBOakiJaTBpDVyYmXH8JpwXh4VtS4wYZWKEwKiUol9o7Lokugs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(36756003)(82310400004)(7696005)(508600001)(6666004)(40460700003)(356005)(7406005)(7416002)(70206006)(8936002)(36860700001)(81166007)(54906003)(186003)(70586007)(4326008)(44832011)(16526019)(2906002)(2616005)(426003)(316002)(8676002)(110136005)(5660300002)(86362001)(336012)(1076003)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:19.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df51d1dc-6cc9-4c71-898a-08d9f7b6dbc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CC_ATTR_GUEST_SEV_SNP can be used by the guest to query whether the
SNP (Secure Nested Paging) feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/coco/core.c             | 3 +++
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index fc1365dd927e..dafd4881ce29 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -57,6 +57,9 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
 			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
 
+	case CC_ATTR_GUEST_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a142cab6882e..1315531e66ef 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -484,8 +484,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..f85868c031c6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -62,6 +62,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index efd8205282da..d08dd65b5c43 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -72,6 +72,14 @@ enum cc_attr {
 	 * Examples include TDX guest & SEV.
 	 */
 	CC_ATTR_GUEST_UNROLL_STRING_IO,
+
+	/**
+	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP features.
+	 */
+	CC_ATTR_GUEST_SEV_SNP,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

