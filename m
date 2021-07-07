Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7202A3BEDD7
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGGSSY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:24 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:20064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231394AbhGGSSR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSII+6LT5/ietR8kfCSwMGqw91bqPg6FnJfECZWTbgGgPhYYN4SL7diLLJgnnbZNBESHBN+50pcY3O/4MjMDFaRvXFt7r7d4DFLC0D1op1bk22ZCqL5MXq7H8hqKjqPTg4VMvyr+Dqsv9mDWirQCMJa31Mt8Hwx53QA9mScMGFE00jiZkZr9w5yQLCetNY8+cI9AhhtvQyFZ4pGVuge+Om8mv/doO0fXV0/4WEvLJIp7jFvEFdLW65WzEa2cralIzYfAagbK5FCOshSqpZ3eY7iHswe836NSY1J6RHZoByey+lZaa430ARck1ZgSgfSTHSguu1ZiSp8veVCoeuJ3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYJ7b2pk2vbOHgVoQcFe8dAUGVd72Tc9+N7EFxpikNs=;
 b=Wgmk25H6ceki9cT5pGj0S9Gp2o1oZ9W4dPit9GP9Z99GNHKqrg7zTNxYHllhAiLUXbPvFUnM1zpXYB5PZi8eWkhqySrpd8d/UQInFQGj8bbFpeWPnaE6o8hicx9CsTPvB+/muQE2SVMUFY3W61nodMYqRpCEL0H5SiWe+lp5a4VYzbHZfypc3UpDKd/PoxFExzNn2HOpgNuL+AC+FOA/Qc1ua64Lt6YVdszsK3K9T3veymsBU6S9XlD+YESZuWPcYOgMTjPHEyk9FtPO1I69TNJxTtADOJrlmlyxRMDnjRbVPMx12NfjYZK58rBvgcWHiTLpxbv55AwP0LNYH6pCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYJ7b2pk2vbOHgVoQcFe8dAUGVd72Tc9+N7EFxpikNs=;
 b=SVje3Ic/VJyijwc6FJ/+TtU4Z/3j6WNOwiYhcURX2gbJJp1qQoI2fOTcdRfGaDn589a/bCbYK9gEHbD3b+SoI1/fBA8JDnVpayVbwDQnFHWzTOo15yg3W0AQZyR9GnCWBokPzLQhBYau+1idxlAhBFuA4PCACWqROLQHuQQl1AI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:33 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:33 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 03/36] x86/sev: Add support for hypervisor feature VMGEXIT
Date:   Wed,  7 Jul 2021 13:14:33 -0500
Message-Id: <20210707181506.30489-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 133ea6c2-c9a5-4c3d-5154-08d941733611
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB46447E4A5AB1B27C1E109AAEE51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmMJqZoZyDUelITwBwP41LWNCJXzC0pOA/9ip38BJUhFw70wGlKo7zDO252U1q7MMppDzTm/cDHhWmEpiMvJ31HlXXdznkWINkEZpakoz4EaEZ+05a62Kyrc5Vj7haX/2N9fIO1Jz8m/VO2KE62Qwfu8BahdPWfQleoSSZviOJJy9NEoBtyfw4+68qNlYl2VtXtOIHAeHQW52NMkWVJXSPBH7lqQCpsS9yQbmwuE6+A7UOhkcMseySY27SmlM+d8EMPc9b6trZmEGdExDSN8/YPg7HooZaYWBbCTYu9DaQmtQXVDehv6umRpXM1hdqSPewjACE7nz/V4FTpp4DBkhCpppOYofwDPEaMfIVfQVCcSBhD/OibKOx1zwfLBwuenDm7cXG5Bgj0ZblenFqV6CPSBW1Yftr95HYtIg4IiYOKngO9NggkWxTDYwkB1KZrpV1oeLo2DM3BvPwkp5Qs9SJDjRg2P4XNjscc8Spkm3S+XIMBPVKZmNs9x5qwfUgm0wjr/uXNWMDiEWw1PJWVTVGFMirtvL7LOszQu8uEoy5z8dwVIVWpyN4wsyTbAjFNAkevsElDsihcTLiUnHXf/BYhmaC3VYZRcKhYtqgzYaP9Pj+2E70aR1TYHB6Z3YLLHPOLbWB9/66o1R3BWc8mIsnuqQ8rgq92iSrCEjedCM9uWiwr0TKoNPj5VpJFzy2j52nl2Dra4Qtt+tSMnS9lD4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3NsmtNbdSnJ4iqgpBh18gPcotE9QQEqap2+hprOLglT9ARvtYomDHWVtR+j?=
 =?us-ascii?Q?yxPzSzO86zULmtFslHT2gVYbHZR/oUVpbEzXmWdnpOuQvRWj8T00DFXyCXTh?=
 =?us-ascii?Q?UQZgOdWS4bTYl4D/kqr7suqCp3gHhBirCXPsArlRZq0gdv0/wUtMqqzRB7Bf?=
 =?us-ascii?Q?wjfZ2qvubjdeZ2jlwzbKbjRjyoAZuVGV8e3u5q4HoyS3ATZC85i8jBS1TVQv?=
 =?us-ascii?Q?/GELfsDAyRNsOCp6EhjzZySHNp6+sU7ChjZs1jnUltcWujKNNXK8NTn+euLj?=
 =?us-ascii?Q?0ZrnLFRMTjk0bjGjy8RtU7pK8DJXdmdTDILbnRXC4aiRRLZRarRchxs+PkgX?=
 =?us-ascii?Q?MoCl2kpGDvP9bOp3QVZY8NHSNqDniGAP8ZnaCU4mJjunLAG7XTf5v7zH2RXF?=
 =?us-ascii?Q?lX021gC+Je+RIosggMAQUdWoNAjqH5T+A7C8tRRAYCe79sDfYkGUaStCZyIr?=
 =?us-ascii?Q?3ddJXaVyQMXYY27z1t9q2l0xK2GfweflRUvtxzLK8C3K8Cfd4Ep7IfImPMqJ?=
 =?us-ascii?Q?nXwB1K1+R3eXoEr+5cN6/1diGmW2uf9wPkYmDpBMukdcK3SNcjpmtLbvKKTc?=
 =?us-ascii?Q?9JvOftn1YIDglP5LoCheDO3SY16YYGYHQZbagCqJc+Q9YR0epGxAlcDG6mkr?=
 =?us-ascii?Q?Dnv9MK/qWwyIU2KthufFlAoxPbG54T8k+aahy2/GELXYQgaaYdZ5ylV4pJxN?=
 =?us-ascii?Q?AAJsiukxwqybUOCmxPlQZlPopFq0+SsFZbLGGF5jZeQ8dnaMelTj0KD+b0ud?=
 =?us-ascii?Q?mXBDQ9fXVEtzDMTl3IVBXPYoTM42J5gx9fVftkQHq3Nkg2Ef7dEl8W6Dieq3?=
 =?us-ascii?Q?Gn8BhgYg1CTFmxGgBWHcvSKxrQEKvbMg97MnKHq0LqcF4entMrjBU4OVrXrv?=
 =?us-ascii?Q?Ovjgnva1SCI3XqHlXkJe7be5mOoBNqcU6Y4Rl/ujfJo25zB02ZJfgdEwBCOQ?=
 =?us-ascii?Q?HQ62aJoG5jodlG8aNTktSEymeFShYEigwv14qsyzsdRZnK4X3Eq1oIpjTPCO?=
 =?us-ascii?Q?ZlOreuY8F0CBkF1Cb3L10pk8vMY1ikjqAiGquDCBF+Z0RMQyjuwyG7PqcXOs?=
 =?us-ascii?Q?lKw6OYWLa06t7NETxEt9aIjHhTwHEyWHpZR0jKZeOhQGNJULuzA5nV72UyBM?=
 =?us-ascii?Q?1W37c3rDSTwpHJoA8YJ9iPwyPlURqWbttKls1o2YKfZnlL5Q2RQ3yyY8tqxE?=
 =?us-ascii?Q?RpD0EimHSAhJ2YxGs8b5it+F7cw9GS10fheoc479LccTAeCWtKpD1QV22ZoF?=
 =?us-ascii?Q?9JfRebUhuTjLmbYGzhx/NYEyFCFsoPizn1oY1Brr16N/aIDMf8Cplijdd5Vz?=
 =?us-ascii?Q?XULjuzyNVCLaZHuDMVPN6AyV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133ea6c2-c9a5-4c3d-5154-08d941733611
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:33.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgf9z06xOEo271VPa0/x0ji7jv3ZBZnzd7HgPzH7Cr7buhaP3mWrfli4KtcWxOH5jiA6i01ZGJCH9E8/Ds9F1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification introduced advertisement of a features
that are supported by the hypervisor. Define the GHCB MSR protocol and NAE
for the hypervisor feature request and query the feature during the GHCB
protocol negotitation. See the GHCB specification for more details.

Version 2 of GHCB specification adds several new NAEs, most of them are
optional except the hypervisor feature. Now that hypervisor feature NAE
is implemented, so bump the GHCB maximum support protocol version.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  2 ++
 arch/x86/include/asm/sev-common.h  |  9 +++++++++
 arch/x86/include/asm/sev.h         |  2 +-
 arch/x86/include/uapi/asm/svm.h    |  2 ++
 arch/x86/kernel/sev-shared.c       | 23 +++++++++++++++++++++++
 arch/x86/kernel/sev.c              |  3 +++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..8cc2fd308f65 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -20,6 +20,7 @@
 
 extern u64 sme_me_mask;
 extern u64 sev_status;
+extern u64 sev_hv_features;
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
 			 unsigned long decrypted_kernel_vaddr,
@@ -59,6 +60,7 @@ bool sev_es_active(void);
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
+#define sev_hv_features	0ULL
 
 static inline void __init sme_early_encrypt(resource_size_t paddr,
 					    unsigned long size) { }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 11b7d9cea775..23929a3010df 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -45,6 +45,15 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* GHCB Hypervisor Feature Request */
+#define GHCB_MSR_HV_FT_REQ	0x080
+#define GHCB_MSR_HV_FT_RESP	0x081
+#define GHCB_MSR_HV_FT_POS	12
+#define GHCB_MSR_HV_FT_MASK	GENMASK_ULL(51, 0)
+
+#define GHCB_MSR_HV_FT_RESP_VAL(v)	\
+	(((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK))
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7ec91b1359df..134a7c9d91b6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,7 @@
 #include <asm/sev-common.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
-#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 554f75fe013c..7fbc311e2de1 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_HYPERVISOR_FEATURES		0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
@@ -215,6 +216,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 19c2306ac02d..34821da5f05e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,9 @@
  */
 static u16 ghcb_version __section(".data..ro_after_init");
 
+/* Bitmap of SEV features supported by the hypervisor */
+u64 sev_hv_features __section(".data..ro_after_init") = 0;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -51,6 +54,22 @@ static void __noreturn sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+static bool get_hv_features(void)
+{
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return false;
+
+	sev_hv_features = GHCB_MSR_HV_FT_RESP_VAL(val);
+
+	return true;
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
@@ -69,6 +88,10 @@ static bool sev_es_negotiate_protocol(void)
 
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
+	/* The hypervisor features are available from version 2 onward. */
+	if ((ghcb_version >= 2) && !get_hv_features())
+		return false;
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 66b7f63ad041..540b81ac54c9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -96,6 +96,9 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+/* Bitmap of SEV features supported by the hypervisor */
+EXPORT_SYMBOL(sev_hv_features);
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
-- 
2.17.1

