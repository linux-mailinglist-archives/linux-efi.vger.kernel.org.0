Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6E3F2EEA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhHTPWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:12 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:31347
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241219AbhHTPV7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6Q9s63aiW8MteXZwLS8/12dbt6A1zsXDaSCgLRSXeH54cF6BVYs0q61t6VeZ+Xoy8ZWvmfGY40nUw+oNDpAo6nma3jmcMn4Yus3IeSmM+R7EWBPLHYoKhZdjQB+AvvWqknFNxOin9vDGvfFAFUyE+/suMgWWwgNNVwvQ4FQ5tVS4poS+cU+bbs/7nNSaAvTGaBcvACJ4UFdNHvG8pS32eFaYRwQJOfxcoZN6qio/yK8HJFssi7Q3z5iRFL3/Pjss0CwhEUwR+iznD1OnfP1OupYslyhfzTZkN8k7vDeDkfRCStZnyJfe/gwyMI2+23J9trUsRfa1bTfgx1IS1QEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icLgkybGDDeIqqJqg1fHJ3O1g4lcp0lEYcv8o7LwoxM=;
 b=KOhsHrD8bxRPfxSR/LtgSdw7anFAdmpflxz7o3lubnAnYlP/402+qvr6lugbnvqRebdj/uQWvK3hpfXYcIBzzWDVDloMNw+4biH6JJ5Pp551WQ+Ugy0eKLxLIUoUGl8oOQbHXk1gBH5thW8lizejLMd907enif4WL7jIwE1Yh/valzMmXhEUW9S6CtduVD4tqlOBbZ3A13A8DF4J+NKJ0Hr6b0G+woGABtJ0ppYv9VO1NdT+xdnQqZDcDzrpX1VNkSilNkNIYmEV4s++lZbOrMHYu9cBYrjpnEuZQFnboQOYnRF97uGOM+X5kLZqHwsERvcv+uqeJb2lBNbXSIQKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icLgkybGDDeIqqJqg1fHJ3O1g4lcp0lEYcv8o7LwoxM=;
 b=fwTVZH4iq2yfZbxLvfKkvfT9DseY4ZrdZVtBP7KHYIeljbOJcVOpYU4JJjcoUwIzRprfODSxW5u2m0uakatP4ZgWH4DDQWBj+jCwY4PLUR+ct/SYf+KupAoVDQHJ4uymtv+wHA/EVNaS8U6LnKy6J7uHyNAM+a/BjjJZ86JTivY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:55 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:55 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 07/38] x86/sev: Add support for hypervisor feature VMGEXIT
Date:   Fri, 20 Aug 2021 10:19:02 -0500
Message-Id: <20210820151933.22401-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de647e0-e6d3-4dc3-7265-08d963ee1af5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB271984A1F8C10B82458160BCE5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jziCwW9smmKYM+93HlN8ab1eTmVkTK5k3KcWmTzAe2Y3PP8Ley/1OKwEcexnSTYDXS3XNWiQVQiBqvdT7p+NxwKJWotUmcj/8Y4I9KPbVCqj1AlkYX47FA0GIcUV1up3Mkoq1Usa/XSyW003Qd7ccM+Q0VjqsonlsF6DKmzNKPXgkhZaSsF6gxfNzsuWSITkzzxd+XwRCdX91JBJZvO1vYhJnOHGzvduyKqb6FlzElQjNl2LXlzMv4cNudKWrhAk64ygUCHWcfBugDs6VL4fzAqDKoJH78SZQbMnsm530Y9V5DpkTg3Sqy0O6L4p7Ete0rxEAQo/IMEGKRogwGHcN8mhIdkWLd4bZ6Cx3siqBX/kQFEkFrzMaqaovgKBwIZk3cprdzKFvriSES/p3fHINqZoaBdXcvojJwWiwEK7aad6I9x+5awQ+FDToM1uj0amiAO7/m/dMNEtrtPmyxuZKIJxETl+HxjqksETztkJnOntVDFhLxNAZrv6iHPGc/jzJWlV/kakRIXmzGuSsUieiSqdHJtZqj3PPjxrqY0Q8GaCbqiFlnvsOKg00QsSZefFkP/7GcMbbgYXBMRY9FSOSyeG2JBlHPpgiNdt0pbZ9PuqVm0CUoADKWGmr6H+kCVRAa8aLpxl8VAyKYWXqcKWLpoduVYiBijIbabdcubmH/TVXR5S6Sf7lrexUQwgX3AjSrngfNGRwK0aha5WBJyePQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVPUoI2E0RSHmKlKB8CeDNBPnN9n5Y6KyR7KQ4qx1GqJHhHquTx5A57cCF3h?=
 =?us-ascii?Q?nRFk+0It6aTYXYuG2AGIbY+xwl/zW8Bi57G6VijmSz83LBBihqxCXzMrlMYL?=
 =?us-ascii?Q?G+9ymSLlsKASye7sxyzxxk/dBHfn1BiqR8/kjZn1fsjm5cbng71Id7LvdU8G?=
 =?us-ascii?Q?wJ7b69m9HOe8RqJdTsDwtkXef88tGHDASafmwdH0e1+B36v3hFRZ4ZqjVXhM?=
 =?us-ascii?Q?zPUze2wzChXewz4gO3v8T8VLfxe0jBYpeC/JA0rvdQHhuU8urcfBPcDRoBna?=
 =?us-ascii?Q?WnWMI2l3nqM0DWcxSKLwMOvSWBEXWn8yCNnErUtW/aYRz6MZIC1SjyY79FBn?=
 =?us-ascii?Q?ZKnhjVujF3y9Gpe14JsVJepZBBuDIhVp5KW2/Z5Qxv/LbhKEF5R8xMfnljG0?=
 =?us-ascii?Q?9vrcMoNjRkx5SH6WyinRNGsu3sdnmkL0z5PLZTacUPVy1J7Gq5vglo8eO7/T?=
 =?us-ascii?Q?TalUBWHmCn9+ShyTWgu4vMIXmH68gcakXIC2qD9lEYgs54VNxYACQjWuSvcW?=
 =?us-ascii?Q?OyHKEHPiHEpecDnw5spNlCxOqAgzS8e6DfMeLT4Edq7R3mYkBmruzVyoBapB?=
 =?us-ascii?Q?pdmN9iXrbR5zAYTGIYtpBBIDVBC3rM5QXNHXuBVqzX8BZK7XOvHFaNlqwYVl?=
 =?us-ascii?Q?stVcgdQNSiIox/F15eMyR2iMROZqyBJ4ThM5UrqPPZK2V15ORYW2Bs+4QTqa?=
 =?us-ascii?Q?QIz42uw422Is5V4iA8uRZcgoZHc4PH1RGLHIDdh1qjRma6TCupvTi4cVyMAA?=
 =?us-ascii?Q?pOt0CkDAIcj0adjBczqExBXySlMxGjUmopx+d399bAtMJdUzg1wkpDJPV3R/?=
 =?us-ascii?Q?zEHpBCxgPoMgx3+j6We+q/o35NOJDVDfa3sSSY0JLR8N0a0WusnUv/jZA7Ha?=
 =?us-ascii?Q?K08ObxrDy2VaCUEnMXQ4V8WUlTc6Ng1NzqQuh8sx2OY/XAYo0RQCgDnB4npq?=
 =?us-ascii?Q?kXWZxinDyxXYdQXFkV8hauTfnft8D0X8cpCoSe+TN24xjKiorBb2Ti9EE14e?=
 =?us-ascii?Q?hPwaf5qeUPtnGx9IxX7Wdey466VAfmZtVqgAaD6RvWrjpbnaP/rAWuEtE22j?=
 =?us-ascii?Q?f2ynGuD9/D5sabi2bs6guquiHEIV0T+CRaCdPkUMPK7NGPkBBZ9ktyb3GhLL?=
 =?us-ascii?Q?RPpPT1KRYNaduVBNh1T4GrMAdLgYflbWh8a7CrQQgh48eGm1iaMT416IgH6P?=
 =?us-ascii?Q?dmlJZ/XjO9iTW76C8p+c7AKU2MdRlqvf4haMZ9achbhK1EQV7VXhjSrMXFW2?=
 =?us-ascii?Q?i/KJW9T1sPg+yoQJoCRBC7YdwrF6hthx1ZKkAFRCOeY9heYctazFR7utMoHR?=
 =?us-ascii?Q?xbN7qIB+vZcGsGJP59DLVkhV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de647e0-e6d3-4dc3-7265-08d963ee1af5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:55.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4PUV4W4SNERFr9Kc7iORS1bKUGeise/oflB45u639zpQm2MEs9DotHE1xn7J4P4TpKSD1GY/QhI7AE1UJhrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification introduced advertisement of a features
that are supported by the hypervisor. Add support to query the HV
features on boot.

Version 2 of GHCB specification adds several new NAEs, most of them are
optional except the hypervisor feature. Now that hypervisor feature NAE
is implemented, so bump the GHCB maximum support protocol version.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  2 ++
 arch/x86/include/asm/sev-common.h  |  3 +++
 arch/x86/include/asm/sev.h         |  2 +-
 arch/x86/include/uapi/asm/svm.h    |  2 ++
 arch/x86/kernel/sev-shared.c       | 23 +++++++++++++++++++++++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index df14291d65de..fb857f2e72cb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -26,6 +26,7 @@ enum sev_feature_type {
 
 extern u64 sme_me_mask;
 extern u64 sev_status;
+extern u64 sev_hv_features;
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
 			 unsigned long decrypted_kernel_vaddr,
@@ -66,6 +67,7 @@ bool sev_feature_enabled(unsigned int feature_type);
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
+#define sev_hv_features	0ULL
 
 static inline void __init sme_early_encrypt(resource_size_t paddr,
 					    unsigned long size) { }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 3278ee578937..891569c07ed7 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,6 +60,9 @@
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
+#define GHCB_MSR_HV_FT_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
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
index efa969325ede..b0ad00f4c1e1 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
@@ -218,6 +219,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 58a6efb1f327..8bd67087d79e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,9 @@
  */
 static u16 __ro_after_init ghcb_version;
 
+/* Bitmap of SEV features supported by the hypervisor */
+u64 __ro_after_init sev_hv_features = 0;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -48,6 +51,22 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
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
@@ -66,6 +85,10 @@ static bool sev_es_negotiate_protocol(void)
 
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
+	/* The hypervisor features are available from version 2 onward. */
+	if (ghcb_version >= 2 && !get_hv_features())
+		return false;
+
 	return true;
 }
 
-- 
2.17.1

