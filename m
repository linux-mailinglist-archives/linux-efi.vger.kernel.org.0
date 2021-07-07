Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AB3BEF64
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhGGSmL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:42:11 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232733AbhGGSlZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1hI1ZttB2GhvN3M93+uVLlmfPhFSb8MhRKrqTJiBRYrG5Y2n/wHOdYEYZDCoo5UBbhKE+LdEXADjHkYx8gYCrTtS2acd8zj+l23AqK8zj+xDX0/ktLGRV5fMQEZnQC9CjVLC0BJd41RwUugfnA2uZ3DNIT/ssTqm0UcWL9evXXLGtzFpa9skKwZw7wYJ5uEKGXy8I7H97FXqhhGVxDbjBBt7zPubqVTbZk+awnoPFGcsbSrrTLheZ7azVym8yQOf2Mk5btnufJTMgIMrMAe7D0tiTwi2WDDGTqpXcfCl5vxR1b4/dlp2Ha2a8FQpGmbuMhluEBLwEd5086FnS5ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9TOASJEPAxL4xyLROuLjD1yZ4zAkH5/F5yGRivQZuE=;
 b=kbY79exTBFuTVd/oDREtpUf87/YAzClXoGTaLJgNrRxg1NJ8fFXjAh5kwgvegUflU7Z9sJ8j5+YbyixjmTarWTs679ZlImmUvLfyzKRBtFqMaSE76K2C4X/xZz/rxtFI97SBaHzCQbnUWHBTKZqUf3qCNC3VLF+RN4e3SWemPkIGegT2TEKGWxLXCrTGELwKMAHIOTFuEXl2Qwe95qLsm2JbeiY008Nrysobtyy+uzNnWcoA8GjmCgTCtJhoEHEY67/JOOFG9rLyoUVLIjqfSowSnbRuZ5qRrdKtV7L8Jp+5MX717d8ZeaEbwoE3peigi2N+nxs5R2GEbMOeqTozcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9TOASJEPAxL4xyLROuLjD1yZ4zAkH5/F5yGRivQZuE=;
 b=K/rwXML6FnOkb52uO3e205uhWV5u7ouPr9Fw7kVZMn5ZRpQIwV2ZB08UKkKu/omXIJL0XnI9auY+1vjsrEViXaE5tsS3ELQWAlDn4MDxv6wUjIq3zKtgqUT7pbOXiORdddcMz78fksZuJ283e5AHXRda86dMo0MH5BZte1CaHWs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:54 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:54 +0000
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
Subject: [PATCH Part2 RFC v4 23/40] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_START command
Date:   Wed,  7 Jul 2021 13:35:59 -0500
Message-Id: <20210707183616.5620-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15511bc3-1fe7-4ec8-39e1-08d941765558
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808180B12ACE01E562456B0E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnvE3XwqzWZO1DXdvbbN4r7+7IlUZ7g3m3yvpJPOX1NfgWffe8iwHsh8eACzwTrM0srB/beA8pIEnNFcPwG8YUdNwhv3H/+ppxncPhri3v7LzUeCGhJOB3dUsvseuhIBvVM4ld516UBsdNmN4kloFKnQcvUECwu85v+HYRUeqMu4BhmQkPaMdYRknxhnc4nzH9T7g7bBPehk1uOhWdsBbQYce6OyLe5th1z4ufGg/hjLkkifAbyrV0vImm2RTdBpFtT2RxZHDN5kJieUc6feKHWDJu3iVvdoePpDDKa/iZxpv4wcMW0ValOUcecftHhPqXfVAmv2czQTvyPe84tI07tO1yzkq8+82CK4xmAWKhyN6kQ36ihhD+fvBH3qxkq4vmGEFctTaSaNPeJd8iEoNnGgCT+nfx8g4zCHRoToEDOuaOej12IuGUg7ctY+YJ+4e7zyTfSeYkJsenkV0QSpmnL+vAuDfxCWiMmdhNKGMJlrrV1APL4p+keMWOe+i4QEq1cMEANXEja31b1HPMyQ4iXMek7kaE7aSey5wJvGO5e0HkB9oxA+kQTvKxI/HLf7oMFmtzSKX/+GaLvKnx2f84fqJXb28/i0gW+Ld6VFqnIcFS5IX0cn7VhozwXZPO2Momt+a6nhxZbP898hfulR6EBK31um+qBl0mzH0QclhKBbKF+wEviOSea/X6T/Jsy/4RwA65fMwvwMXQowMH68Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kgcrr3RMFjIo9StNbPbGyaNmveiqYN5Xtj6W8ISUU3ewFuf5o/2f6s+iyjk9?=
 =?us-ascii?Q?MmI9hIZQ1mPmlwf2FazjwhBhDq1XEOBt/qgeJ4mbfe5vDwE5+Yxt/mPVvota?=
 =?us-ascii?Q?yvTs1oouCuYXJWdiQeo9JhRvGu3ee8gs0XAarQZy8Av/A9Zg2CKllRqiKl3q?=
 =?us-ascii?Q?7ChwRefw3Tua7cI0CK1Yifyj7VhIS7cd/aqNoJX3jljQLrAGfSYbSX960+ny?=
 =?us-ascii?Q?ivbyulBG7/gVhpTgxO4ZpeKBhmnaoAofbz6VvpwdNXCkLSdEk7RLZtzn+3HD?=
 =?us-ascii?Q?w6XQ5qe3gc0PUtZx+qpu9tBqNvfLfYYhgRM1WBFRRMAXMFlzLQqWznhd+USX?=
 =?us-ascii?Q?EQTTIjJocJky85ajheMNtCODYZVWcZ9XpFZjDSbVJeXWZKDOExH6Ek1qEefD?=
 =?us-ascii?Q?C76BqK/VQUhVQ9ric7Pz4eVgwxkA46JQPWZm9Rn2tGeLJreV16ddyAO/KM9j?=
 =?us-ascii?Q?zS6llturgKwnXLlzdNhqs8LPXK9KnmePSoIE9ZDeHMaKdc3HuhUl5vL8gE2P?=
 =?us-ascii?Q?s/tDD0uie6p0TsrcSFKVweZTspwY6VJG7rTb+Kg1Nv+Tr40TUslDf4/PfIXL?=
 =?us-ascii?Q?mMpGzYhhs0p0VW3WKFp0T3ATedLDYVT6a3KzfvOnmJRmwXvGdFci2Q/U4Fdn?=
 =?us-ascii?Q?8poGSyGYEB8WELiMyT0TiIJCzowim4m676kAxsjTwM8ETBKWQeKaVOlDT8B2?=
 =?us-ascii?Q?xsLxmRY+NIyXlVlWAH7zTO5ZZZq5cE8F4Rggectul6D2tbYXI4ggNdnZGogi?=
 =?us-ascii?Q?aRx10N+GzGb5JdLKKYYDrnPaiyvX92Ajpr8KclLj3juqOpoSP1lNve6OMA6b?=
 =?us-ascii?Q?GcesswzszVIHgBJ3WqKR32bmBKjRuZWNHEB6DPvSRNcbtkhB2LXX4rWr6idB?=
 =?us-ascii?Q?XgidQPe1nvywTfBfZa0NT1cSekj910xy1QOG6sdFMLKbANjOwO3naT2bpbnE?=
 =?us-ascii?Q?vzhgDPrgkJRXTeQ5cw9yRBOdvqJftOCfjsrx7iCXlTXN2Bodv5+ecHbrGUdL?=
 =?us-ascii?Q?NypxB/qlR130GmqP3mMOr0CWPaHTgg2zC9li33A8wpIR2JWYoy52gMj6RJRX?=
 =?us-ascii?Q?9i3qi3pjXQZyd153U7O/d8JAbIl73gSfnYA0L+msJzd9j4cIoqcYXv5zMx4z?=
 =?us-ascii?Q?eo9c+pSvzElgVxQK4/z+Eo3jSF+rG6+0VoXsWrirLPGMIEqX59j6TOxYvWZb?=
 =?us-ascii?Q?Sed4kxr/sf9I0ZCfF0VaSLyrHY781QXTOsiQL2jg6B6x3/XCiaPjEQJgU8+Y?=
 =?us-ascii?Q?1wJlLQW1YzXfKDLHOkLRrQBhEIcrkjUALciSkZbAb92Miak6uclj6eZZK54z?=
 =?us-ascii?Q?+frbyEW4K0uCOqg6Gj4tAjYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15511bc3-1fe7-4ec8-39e1-08d941765558
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:54.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CihhDUUbkFh02SGaIrx8/bqWVhe1A2ica8zjzxB+yltect4kGYVfOUkbmnuwUt/z6Gx5+qXVn2Das0xoUPvAzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

KVM_SEV_SNP_LAUNCH_START begins the launch process for an SEV-SNP guest.
The command initializes a cryptographic digest context used to construct
the measurement of the guest. If the guest is expected to be migrated,
the command also binds a migration agent (MA) to the guest.

For more information see the SEV-SNP specification.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../virt/kvm/amd-memory-encryption.rst        |  25 ++++
 arch/x86/kvm/svm/sev.c                        | 132 +++++++++++++++++-
 arch/x86/kvm/svm/svm.h                        |   1 +
 include/uapi/linux/kvm.h                      |   9 ++
 4 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 75ca60b6d40a..8620383d405a 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -443,6 +443,31 @@ Returns: 0 on success, -negative on error
                 __u64 flags;    /* must be zero */
         };
 
+
+19. KVM_SNP_LAUNCH_START
+------------------------
+
+The KVM_SNP_LAUNCH_START command is used for creating the memory encryption
+context for the SEV-SNP guest. To create the encryption context, user must
+provide a guest policy, migration agent (if any) and guest OS visible
+workarounds value as defined SEV-SNP specification.
+
+Parameters (in): struct  kvm_snp_launch_start
+
+Returns: 0 on success, -negative on error
+
+::
+
+        struct kvm_sev_snp_launch_start {
+                __u64 policy;           /* Guest policy to use. */
+                __u64 ma_uaddr;         /* userspace address of migration agent */
+                __u8 ma_en;             /* 1 if the migtation agent is enabled */
+                __u8 imi_en;            /* set IMI to 1. */
+                __u8 gosvw[16];         /* guest OS visible workarounds */
+        };
+
+See the SEV-SNP specification for further detail on the launch input.
+
 References
 ==========
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index be31221f0a47..f44a657e8912 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/internal.h>
 
 #include <asm/trapnr.h>
+#include <asm/sev.h>
 
 #include "x86.h"
 #include "svm.h"
@@ -75,6 +76,8 @@ static unsigned long sev_me_mask;
 static unsigned long *sev_asid_bitmap;
 static unsigned long *sev_reclaim_asid_bitmap;
 
+static int snp_decommission_context(struct kvm *kvm);
+
 struct enc_region {
 	struct list_head list;
 	unsigned long npages;
@@ -1527,6 +1530,100 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return sev_issue_cmd(kvm, SEV_CMD_RECEIVE_FINISH, &data, &argp->error);
 }
 
+static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct sev_data_snp_gctx_create data = {};
+	void *context;
+	int rc;
+
+	/* Allocate memory for context page */
+	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
+	if (!context)
+		return NULL;
+
+	data.gctx_paddr = __psp_pa(context);
+	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
+	if (rc) {
+		snp_free_firmware_page(context);
+		return NULL;
+	}
+
+	return context;
+}
+
+static int snp_bind_asid(struct kvm *kvm, int *error)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_activate data = {};
+	int asid = sev_get_asid(kvm);
+	int ret, retry_count = 0;
+
+	/* Activate ASID on the given context */
+	data.gctx_paddr = __psp_pa(sev->snp_context);
+	data.asid   = asid;
+again:
+	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_ACTIVATE, &data, error);
+
+	/* Check if the DF_FLUSH is required, and try again */
+	if (ret && (*error == SEV_RET_DFFLUSH_REQUIRED) && (!retry_count)) {
+		/* Guard DEACTIVATE against WBINVD/DF_FLUSH used in ASID recycling */
+		down_read(&sev_deactivate_lock);
+		wbinvd_on_all_cpus();
+		ret = snp_guest_df_flush(error);
+		up_read(&sev_deactivate_lock);
+
+		if (ret)
+			return ret;
+
+		/* only one retry */
+		retry_count = 1;
+
+		goto again;
+	}
+
+	return ret;
+}
+
+static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_launch_start start = {};
+	struct kvm_sev_snp_launch_start params;
+	int rc;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	/* Initialize the guest context */
+	sev->snp_context = snp_context_create(kvm, argp);
+	if (!sev->snp_context)
+		return -ENOTTY;
+
+	/* Issue the LAUNCH_START command */
+	start.gctx_paddr = __psp_pa(sev->snp_context);
+	start.policy = params.policy;
+	memcpy(start.gosvw, params.gosvw, sizeof(params.gosvw));
+	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_START, &start, &argp->error);
+	if (rc)
+		goto e_free_context;
+
+	/* Bind ASID to this guest */
+	sev->fd = argp->sev_fd;
+	rc = snp_bind_asid(kvm, &argp->error);
+	if (rc)
+		goto e_free_context;
+
+	return 0;
+
+e_free_context:
+	snp_decommission_context(kvm);
+
+	return rc;
+}
+
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -1616,6 +1713,9 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_RECEIVE_FINISH:
 		r = sev_receive_finish(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_LAUNCH_START:
+		r = snp_launch_start(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -1809,6 +1909,28 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 	return ret;
 }
 
+static int snp_decommission_context(struct kvm *kvm)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_decommission data = {};
+	int ret;
+
+	/* If context is not created then do nothing */
+	if (!sev->snp_context)
+		return 0;
+
+	data.gctx_paddr = __sme_pa(sev->snp_context);
+	ret = snp_guest_decommission(&data, NULL);
+	if (ret)
+		return ret;
+
+	/* free the context page now */
+	snp_free_firmware_page(sev->snp_context);
+	sev->snp_context = NULL;
+
+	return 0;
+}
+
 void sev_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
@@ -1847,7 +1969,15 @@ void sev_vm_destroy(struct kvm *kvm)
 
 	mutex_unlock(&kvm->lock);
 
-	sev_unbind_asid(kvm, sev->handle);
+	if (sev_snp_guest(kvm)) {
+		if (snp_decommission_context(kvm)) {
+			pr_err("Failed to free SNP guest context, leaking asid!\n");
+			return;
+		}
+	} else {
+		sev_unbind_asid(kvm, sev->handle);
+	}
+
 	sev_asid_free(sev);
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b9ea99f8579e..bc5582b44356 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -67,6 +67,7 @@ struct kvm_sev_info {
 	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
 	struct kvm *enc_context_owner; /* Owner of copied encryption context */
 	struct misc_cg *misc_cg; /* For misc cgroup accounting */
+	void *snp_context;      /* SNP guest context page */
 };
 
 struct kvm_svm {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 989a64aa1ae5..dbd05179d8fa 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1680,6 +1680,7 @@ enum sev_cmd_id {
 
 	/* SNP specific commands */
 	KVM_SEV_SNP_INIT = 256,
+	KVM_SEV_SNP_LAUNCH_START,
 
 	KVM_SEV_NR_MAX,
 };
@@ -1781,6 +1782,14 @@ struct kvm_snp_init {
 	__u64 flags;
 };
 
+struct kvm_sev_snp_launch_start {
+	__u64 policy;
+	__u64 ma_uaddr;
+	__u8 ma_en;
+	__u8 imi_en;
+	__u8 gosvw[16];
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.17.1

