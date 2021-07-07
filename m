Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B513BEF5E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhGGSmI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:42:08 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:38977
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232154AbhGGSlZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy/ise+fbkDGPT3eM6advu8YZzBQDxtyMJh22IQEKSztq4Z9O63cH3cixhuC863zjqjMOZR+eULqQI0E+xgg/4zBR9o7oqafzBnPRnWiOQs+ZliPWZ87DLqbofRjHYOuDZ7kHyv+ijkCk9GNgPAhl+9NwoTnarOoWZoHoCySsL/4HATM5/yzzN+PMAF55OUzUWM7TMVovXIweH2QxMFyfh4jdcd3fxZADtWyv+YwyMQ+kvjerlLV1qziLsK0MzWUzPAadoKv21YxHYqRjnn5QbLfSYoeFnYL8RI59gFbNnYR6EWwIxQAkDaVaLUubIV78bCMLwvJl7jaNSMJBn9JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RDvO1SeBTTdONAbw8qrNWEqb6uxjtb2FKLa+cR5mLU=;
 b=E1PM3nki4Nm+xVklpfoiwbWZUqn53aRUMgLFRKFq6QK68cZQU65iiRzxl9SrK/KgTgnxBFPpWX19+/71bmiqXbB2/jo/qO/oPN7on+dwBj4IdlFX8mc09S572veTbOpZ0BpLW1pcafz1nC2xw/DQQtIqQ3ftVsjNwBEHkahluanPmEiBJ37OyPsfViMgYp2bqnv7AUnrTHd79jTSGgAIPrxUDT2WBjGDO2bTL1s7KoCDBOwsxBJUjAKwly82IL9QQ4AESmgDyVNKHc83y5aHGcE4/6EUtDIUIs6MxCM3HARaQ+0HaawDpJRDpt4yoAQRaTVv7fHTgAgEvZQSBKY+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RDvO1SeBTTdONAbw8qrNWEqb6uxjtb2FKLa+cR5mLU=;
 b=SfSxtvMoRLh69AT1w19CORZvE3wrRAdJ+zPIxuu8LF2T+sBw2HhVMo4sCPc8NqIK+j+8U1d+BWFBVn/qL4R6gRzd8Ka+yTdiGVSxf/JqP1KKfsV0jBiKFaiNibfS/o9nV7NFcBTuBFRQlQjBuGwPPva2rUvRa2BZQpfaf6Q5MBo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:52 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:52 +0000
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
Subject: [PATCH Part2 RFC v4 22/40] KVM: SVM: Add KVM_SNP_INIT command
Date:   Wed,  7 Jul 2021 13:35:58 -0500
Message-Id: <20210707183616.5620-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a5d5012-605a-4fef-dae8-08d9417653d6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28088AAEFD662DF16D5B4869E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVLwaghKMVjfv+ZqeP+4BDwS+xunmrDUF/7bgE3P/ZaRneXq1DiQ8ib7OsaWaRq/gZDEmosP9NeTHAk46+JAjEbv/l9nwfXqUzWaGPgEeS1nMmIol+AHzcwSnaBMvqp/VznKvYuvSn2IUHPGz2VkTHrbwt77xUJtqgC3JXVdTpQdQTfjP+0vkiNaBRbHMk7qM39ghEUnutJYBpiU6rUl8DtM90sMguC7+MSPCAN9tf1bkwx0opAzAUuPVLl+ZZPchDEcW97iLnLHKLXp3nga89n7uzRxxR/RcniwyAzSpG8oasK63gMckThABzKEOZka9m+rM0mwDkwVQE/K8eQAsoMl2czre2SfswuMzg320emctVLKKZlT6Sf4z4yWPFRxWGH1JkXbN3sjf8yPBmVloWkYSM0Fcqanwqtyotlct0mBSYj9iYnbEemolDbpNjWByhfUUuXvEzrLlhyw7duvvwjEHOb44BmagGq5eM7GkfMX26+t5sC/HK3HMDGX+a2antd2Eg7jvxlA1tdyqceBtqjXdSNFWST9uHUWGWPAfTNIdzJkfvvONFHMfgCqiUox9g5P53N43qDQgQKC/pxbP4Cw76b124JtT2lQFA/zaob7DkU0Yw34L/iNojBYx9svaciMZ6GU848IPoBh0nm0BaY9nKaCuOmVXclomqwQuFJw44j1P5ccYTmHnMxgp2KRQIl1VM3QnKgPxgyJWE1CUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjFan0Gq7yOUFI7fQhe91SaEazMTMdRYfU2rA4+vWXqrf0xg/UiBvPWGpkAF?=
 =?us-ascii?Q?TxCu4IPuk3Ob7C5Q5nAxjDAtUDDW43G0gr11fZhfyaCzKu0z28ex7NxKRLUD?=
 =?us-ascii?Q?/akJ3uzfruSQRWxLhJ10xRNCxIBTBwmBwCGUhdWFt10pB+WQwVYG3qST7o8z?=
 =?us-ascii?Q?OhCI++4/F6bs53E7pR+eNt199I/kXw6DvMtn9EzGPAeitndq1RhcCxmo6ayj?=
 =?us-ascii?Q?f8uFOMRRZI9ltnWIqERWpayyMxyzF+iwyltmDRQRonzsT0a3ZjuGRgH6MGVI?=
 =?us-ascii?Q?rsmYaBgHH6GKG25dqKl46/1fYgb1kBCzzHPsHZMH9pRl/vcOBCpYOvEq6/in?=
 =?us-ascii?Q?dIJZWAmgjc9kHXyMVelmmuJFIvJhMpX6NvWm74LTTraJSjXTLIMvVzZ09qiD?=
 =?us-ascii?Q?tnecDJKllSUQu/dXYu/nSdjwO3KsTV/wBeEbkxM/nCa+xiPj0kTgE1WUr9Ac?=
 =?us-ascii?Q?UadlNAcPs9UQYw9uwoX7jdOzZYUsFHXEeVcZB9EduNxScGYoYBy7rlNXcmNu?=
 =?us-ascii?Q?owF9NpT2CdGgwUKOfkcE3e+8lgT4E3JFXoVe6ObqF29CtHOPhHEHATvBWyAE?=
 =?us-ascii?Q?S/p9xirlIHdMhsL01lcVyJonYy07WA4tYQSoqVwBLdDQ0Zu3QDbKmcKOzbLh?=
 =?us-ascii?Q?/Iutg0YBBtJYVW3pc4dElk+BSb6HydhcwSbsQ0RRviBZpgfCPBfkkQUblGC0?=
 =?us-ascii?Q?tmHaJwTXEdzLXVEAUTumz6W8zdCVuWmmvUYBJo8RGI8NkkYUg6SgrsS3lAk+?=
 =?us-ascii?Q?tWrfLNoxAUvj2IMw/+PZsOYDnUANOXPBbqFNfukRJadL9bbe46cgOsBqo+JK?=
 =?us-ascii?Q?xOMStSR2HPRM4beFzlpruv41qZoM/UNSkBKdAcfgfiroMXU2ro4ruDEC6xEc?=
 =?us-ascii?Q?+VMPudLczMj1Fs/bdmUNrC1joqUNUA6EBOAzCrWp7kgKCMkvEJn1QV4XjI6I?=
 =?us-ascii?Q?pLu4Vw8p8Cu0tE8s9+64PMamZTbo5VahxNXC6D0p3PI8kBo8Dc0aRYb+SFA4?=
 =?us-ascii?Q?mGgUqm6htxfAfdEoEVzsP6pAKO1GTaTZ88u0n+g/eSPxtDWdzDdBIR8YFd8E?=
 =?us-ascii?Q?mgO1O8OyVIuJUF9Cp3Bjs11qwjtmIFinbdsx+mV7TmZ8DW3zcwGKh7ugASZF?=
 =?us-ascii?Q?L6V9IdM4PPvf4S6Fmwu6rq/MJt/DeTQ7W2RFXmKrOyoRy34/oiNXKl0Buc08?=
 =?us-ascii?Q?Go0z4bN8FXnEiqEoPP3JBssY7liJ2AoWlDuzLHWkRTjS5Vhx+b1PgZIjO7ki?=
 =?us-ascii?Q?sKE+1Yziofovp1Y/4mi7zSMM/RiRxd9dBXvzYwo3ln+NAleDFXOv7brfZlxM?=
 =?us-ascii?Q?U0cNZOZ+fLK63/+Iy9ii3FuZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5d5012-605a-4fef-dae8-08d9417653d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:52.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLGiiUITRBaxLLXkNgakSlAMuUT8Uy9YX9V6nvfzis9ptXe/C1FZpueb9NYkUq6aeq9HCkbjju38EiTMP9TdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KVM_SNP_INIT command is used by the hypervisor to initialize the
SEV-SNP platform context. In a typical workflow, this command should be the
first command issued. When creating SEV-SNP guest, the VMM must use this
command instead of the KVM_SEV_INIT or KVM_SEV_ES_INIT.

The flags value must be zero, it will be extended in future SNP support to
communicate the optional features (such as restricted INT injection etc).

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../virt/kvm/amd-memory-encryption.rst        | 16 ++++++++
 arch/x86/kvm/svm/sev.c                        | 37 ++++++++++++++++++-
 include/uapi/linux/kvm.h                      |  7 ++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 5c081c8c7164..75ca60b6d40a 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -427,6 +427,22 @@ issued by the hypervisor to make the guest ready for execution.
 
 Returns: 0 on success, -negative on error
 
+18. KVM_SNP_INIT
+----------------
+
+The KVM_SNP_INIT command can be used by the hypervisor to initialize SEV-SNP
+context. In a typical workflow, this command should be the first command issued.
+
+Parameters (in): struct kvm_snp_init
+
+Returns: 0 on success, -negative on error
+
+::
+
+        struct kvm_snp_init {
+                __u64 flags;    /* must be zero */
+        };
+
 References
 ==========
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index abca2b9dee83..be31221f0a47 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -228,10 +228,24 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 	sev_guest_decommission(&decommission, NULL);
 }
 
+static int verify_snp_init_flags(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_snp_init params;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	if (params.flags)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
+	bool es_active = (argp->id == KVM_SEV_ES_INIT || argp->id == KVM_SEV_SNP_INIT);
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	bool es_active = argp->id == KVM_SEV_ES_INIT;
+	bool snp_active = argp->id == KVM_SEV_SNP_INIT;
 	int asid, ret;
 
 	if (kvm->created_vcpus)
@@ -242,12 +256,22 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		return ret;
 
 	sev->es_active = es_active;
+	sev->snp_active = snp_active;
 	asid = sev_asid_new(sev);
 	if (asid < 0)
 		goto e_no_asid;
 	sev->asid = asid;
 
-	ret = sev_platform_init(&argp->error);
+	if (snp_active) {
+		ret = verify_snp_init_flags(kvm, argp);
+		if (ret)
+			goto e_free;
+
+		ret = sev_snp_init(&argp->error);
+	} else {
+		ret = sev_platform_init(&argp->error);
+	}
+
 	if (ret)
 		goto e_free;
 
@@ -591,6 +615,9 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->pkru = svm->vcpu.arch.pkru;
 	save->xss  = svm->vcpu.arch.ia32_xss;
 
+	if (sev_snp_guest(svm->vcpu.kvm))
+		save->sev_features |= SVM_SEV_FEATURES_SNP_ACTIVE;
+
 	return 0;
 }
 
@@ -1523,6 +1550,12 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	}
 
 	switch (sev_cmd.id) {
+	case KVM_SEV_SNP_INIT:
+		if (!sev_snp_enabled) {
+			r = -ENOTTY;
+			goto out;
+		}
+		fallthrough;
 	case KVM_SEV_ES_INIT:
 		if (!sev_es_enabled) {
 			r = -ENOTTY;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3fd9a7e9d90c..989a64aa1ae5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1678,6 +1678,9 @@ enum sev_cmd_id {
 	/* Guest Migration Extension */
 	KVM_SEV_SEND_CANCEL,
 
+	/* SNP specific commands */
+	KVM_SEV_SNP_INIT = 256,
+
 	KVM_SEV_NR_MAX,
 };
 
@@ -1774,6 +1777,10 @@ struct kvm_sev_receive_update_data {
 	__u32 trans_len;
 };
 
+struct kvm_snp_init {
+	__u64 flags;
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.17.1

