Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946C24D0999
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiCGVf6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbiCGVfn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FF70CE2;
        Mon,  7 Mar 2022 13:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqjumSOMOwgDqtsrrHUMk/aJPZ2/BIC0eMNCsYEGG95Eb7/4TfavFVf4HurLo/iw+lBycxjF3UmcSDDndpq/koA+LQenrjGBlfJG6M4vYkrIBuoBDBYnknXMhO+y7ZqlG516IUpTH/B4KrqPYlBRWGUbo0xh7AzNxxcuOcrn4q1gbCdJfy9uXpUFsM13PenexN1EUsJOFIAOWpAEr+aPLEesw+zWrwJmIhlnL+a/oi5/ba0X/+XSDX4wmurlFnPJAwM2vLyQ9CZtWF1gyElCvnoHhsDgeH3ioZLU3EitwlZjPZiLL/5IFt7v+frks5t06XRgdpacNL74UNapw8EKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntl5F5XU60OWCFaYtPlwYC+9J/gONwjzf4p6mWBsqy8=;
 b=NRLgZlpGvl3HBao8opEyTnJQsJfC8WTEp9rXUlEgiv/mmCoT7/KRcmircuJ089ey8Tphdx+/FUE+DpMldGnLWjEEFWC/8Q7eG6CMMm0Nc9eA5mZC2vbUVkeBahvKzP/UnETyk7Q+ur5f30rKPYpl20Yp0lLBfMOdqCK5FkHA/yl5YbM4Xo5CpHMpzUkALdjcNzi/WHUtQYZ72rkKOMhwl0yVwZW4Dgp1m8NaWyDHi40bsIvAFufjBtb0exBktX/6esLThD5oaT/qfQgkoZPGZLbSkuMOZ3BETns96ZIJCZp9Xwm43FPPWFi4tZDYX+YqSZd/NZzf+lO5LcB7Ez6dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntl5F5XU60OWCFaYtPlwYC+9J/gONwjzf4p6mWBsqy8=;
 b=jVwiQuOsRGPgVmzuTgqj4XdfOygQ8WF3mgrxdksQOARl+OplAECEFN2NBm73zSLyRLpTIukQ70xyyJbXi0DUWa+tm9lc4mUCO4NQ5aMdSeHCeoTjAPdGsBpD776fC4PMn6kY6QiLj9+04qLhDKb1Zxzry8jEu1Mxr72KQOoCalI=
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:38 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::46) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:38 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:30 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 08/46] x86/sev: Detect/setup SEV/SME features earlier in boot
Date:   Mon, 7 Mar 2022 15:33:18 -0600
Message-ID: <20220307213356.2797205-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9390f74-6135-4dbd-e40b-08da0082482f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3823:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38231D989185BBC5DEB44DC4E5089@MN2PR12MB3823.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXlz8aabFmX+NxXfrZeEVrzdInHOGHOr0FgEzBBYNG/4UjOZxiw2NYsPRVJCbPsrqyKYKMWk+9WjduPT3bD+Sjd/HmzpaSvdwxhI+ydGBcfvYshSiKPOVeVIcvvQYCPlv7PwD+LvWoz85EtyXneac3KF5JExYqumCSgf6/MfyT+ju7gDXvScowu+Bu9UnLXKOlGaY9rWxrq8sEImSsx+wXfqSAbZ5wLnpWY8ibqrnIMQccf0M0Perrw7O75x6XY76RLhXYrtv/lcW1gG5qWcxn+99gstoShUqRpCkDTHdHucZasAYi8/GgmTtodIXtuNSiQtSZSp2od8q2a3ewOY2itO7DJLK1YNdNZYGzsdoM+lh7RaMpNGxyEkbBjzWwJvQc+9JSDPM5vF0/+6fYrWHmpwJB7S5pDtmV/IYOQI9JExlaD3VDGYK9m2nGblGhRUdK7RYrA+I2lxG+u3PFl7ENMUUzTZ2Jf/dDNfvyJsGLCkbprV+/EaVPVk+VxR/nixH+ZIinSXlMALkra1lXA4mxVHmH90qtxGzh+e5NPsjoKTBCfykxbRKl62rmbd1dyzT0cacVaWcVmxzuzBruECrtMWDk2coIv3fmzJ5BNkYRR9k2XgV6KGSKodPtscK8JXD8foB7R368xOsg9JnTxEu3gdwhiQpnFQMXp9IseDysp//gbh1ph1z4fUdTUppu7Jol4tVlLExax9hExPK01FHciNJmkNSUUOPit17DkMiJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(2616005)(36860700001)(70586007)(8936002)(2906002)(356005)(81166007)(508600001)(316002)(110136005)(54906003)(36756003)(82310400004)(4326008)(44832011)(7696005)(70206006)(8676002)(5660300002)(7416002)(7406005)(47076005)(40460700003)(16526019)(26005)(186003)(83380400001)(6666004)(426003)(336012)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:38.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9390f74-6135-4dbd-e40b-08da0082482f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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

sme_enable() handles feature detection for both SEV and SME. Future
patches will also use it for SEV-SNP feature detection/setup, which
will need to be done immediately after the first #VC handler is set up.
Move it now in preparation.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c  |  3 ---
 arch/x86/kernel/head_64.S | 13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4f5ecbbaae77..cbc285ddc4ac 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -192,9 +192,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (load_delta & ~PMD_PAGE_MASK)
 		for (;;);
 
-	/* Activate Secure Memory Encryption (SME) if supported and enabled */
-	sme_enable(bp);
-
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c63fc5988cd..9c2c3aff5ee4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -69,6 +69,19 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
+	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
+	 * which needs to be done before any CPUID instructions are executed in
+	 * subsequent code.
+	 */
+	movq	%rsi, %rdi
+	pushq	%rsi
+	call	sme_enable
+	popq	%rsi
+#endif
+
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
 	leaq	.Lon_kernel_cs(%rip), %rax
-- 
2.25.1

