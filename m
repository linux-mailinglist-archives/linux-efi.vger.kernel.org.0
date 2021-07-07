Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78D3BEE7C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhGGSVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:21:17 -0400
Received: from mail-bn8nam08on2080.outbound.protection.outlook.com ([40.107.100.80]:33248
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232532AbhGGSU2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEYPkTjpnev5RIH6zVLT20O9VZdfCwHS95tPvPdId2CFE8ZxzKexURo92e+R6cTXFwsfhQFBKt+2+PNPtio/NH15k7KxpoNIeD+BI8yyehevu2xkC80mdmZDC59ixFfr+SxSGhR2IeHN58pX1M/BFrdHSI9Y6mzP03MJutYtOqtOKA9UATZ9EHbsN1MBjcmmq8+k+y126NYIfewZM3EaZwu8iusSr6UulYW1cPIRWN9vY61R0ohWzve0XqfAqgSbxwOUNqeWxi1t73vejVdEDIk5Y00ne/kt+ozx5uoy+34fBZZzx7MPC1z0U0TIkmoX/kGZW4IEdEqZwhoDCQE8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F+SidK1HDpN6741TNeAYv7xj0tMTlfPEyf+prS85qw=;
 b=mTqWjDDsL3YY2iAV23WcQFN8M+0Gdotyqe9XNUbgef/NKGKIBFG16AOj6f3iobEq90WX3KhlCzLvKREXBHnq8XxXx8N7JKaSqlI08rpgu/r0TD+svHFh6tWinOpRKzh7e9Hq23O8hV4xvQos6OxURF6Taf3jhQq9TFbfho1vrAkAJDdB6DRh6S7ZtNCwZ2lR3EK9ZP/b64rsE+ErtT2b7yrBpHZt89JCi1d6xVPU19C0IWI0QHZRYKHfuWufCoH0x2+ZGzDPVq0O22joZg2CTZVtPIPANBg/JjjRCMHwGC8nZhZoHQXtQ+G5eCxYREOOwOwAr1+xcwSVo2u1UybNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F+SidK1HDpN6741TNeAYv7xj0tMTlfPEyf+prS85qw=;
 b=vwT7CdvaaL2AtJzyEowNJUWOa9lnZO8vCcW41+SgaYpgaM/HfY/yZKb86Pes7gXnfz1jnHxw74i27Q82CcwfN3v865ACYPy/t+G8+20nciSpxfKOPmgmQLz8w/88mPIE4aunU4QahGPLjTzd4Thmc/t9DEafaNB3UH5kQG1avag=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:53 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:53 +0000
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
Subject: [PATCH Part1 RFC v4 33/36] x86/sev: Register SNP guest request platform device
Date:   Wed,  7 Jul 2021 13:15:03 -0500
Message-Id: <20210707181506.30489-34-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 890d6e5f-21a7-483b-0e3a-08d941736589
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683DAFCE99B76674183EF7BE51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDheqtBnUvDWQClSVVqfv5AqD01RZreWYWFtZvBW6rwnhLnx1XOvFYmHrNOlodZGI2K0Y2W8CS8ml6LGNwamHtkb5ueT5kzCyPge8pYt/2xlUCevZrxxvWO5kf3BCFkx++F24mIFCN83qK2wfbOZ9+2yWZdi6U8yPI0gYTUGJ5doPhpss5WOinljEv4XyMhYYPZ1z08ej6xXbZEijm3x3EvbwL2tNVMHE41JOuXPmZFwGSjVBiuxd+R/LPeBBo7Tn+JWBvSV2/bZBcmdmA0mMxQRZG9P8eatR2/SooDu25Am47MDAldzAonbBh0GE+9CleUxTfHF9OUtAWKoVw4M+jFvINO4VnNoMJi5AAzxo0ziWZ1Le/nDBZ3h1edJqD7gU1QDRjslRu4uPdGSK8vc0i1MN6IIdbqvSq1A19NzxldaJGiGtywvZ7RK3YrC4sFzrI2MAhzQc66mA/wxd1/fdz+SZO5KQ4eUYisLYtpceKQQXdDjsjAvx/aBgOHC1Z5UErnz8VmTxgapipmI5Af4sx23eod7Xt9a6CH4ZZGpXlMsHRjO9zsjqXRKP1xAgN7/IZgvvbBy8mr5rY5JRDrQ4EidBostsIRS7V/PHBMptCWkWg6EGtKuXXSFIVVhg7cL0hjoY43zq8n/L8c3zU2ifsi9Zv+oEaryDNzxFwflp1sHh/+TAImcAWefAQkmZSTeHE+jRVHVV3unqUn9Og6ZGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nx3CUrdxLNe6yaY5Hc+KuyUA6nW2xKtTmJh8MnURR0nYz0fibS8FOuRj8ciF?=
 =?us-ascii?Q?lV8kp6xTlLLNyOR27CiLx14xY4DA/qaqAom4jArLZZ/MnM6e7xPFf47rrWJJ?=
 =?us-ascii?Q?rV3PjLAbD9MrjG4lIIRSy3POF3PeqzKbkiSkNZUb7BiAD7Tjv07m5zQOmSrK?=
 =?us-ascii?Q?sFZhMRO/m+o9EaQzPwiR1j/HDPBBqfC1kaTb6n9O5kNUaMQspRWnHqMiw+6j?=
 =?us-ascii?Q?ilXjPODj/2c6nZFXaD3PHwLHfUci6vjrEI88scr4rJJ3KzGKAhDRwKzrEABX?=
 =?us-ascii?Q?HOGVRbTBUNL3iC+ag+PNdSilVAw/EgvN8ytTP973l/cs8hmtAfTshq8smswa?=
 =?us-ascii?Q?CUuAQZXV339XGLGqzjDK6mApL99nyoPt6eyhZuSEf+cF/Iglq3SNTvNpLSvg?=
 =?us-ascii?Q?cONzFc5dk1b6FlCWbDz/5k1yKqgL53V4pPoO7xIQZYbOntpwQgs+rTkGPCvF?=
 =?us-ascii?Q?BZmlrn07JKT1QtkOPtb8/guBt4kw6eZAgc3tCJpmo65OD4Y/OEVJTaFRFjsh?=
 =?us-ascii?Q?HIpe/14wwV1bNL9fuk1cihQVNZcw6ZLQJxjiZDlbO53HX8fzvX/q6XArstw4?=
 =?us-ascii?Q?5HWOIvH/LqgEHD4lPt7Iu8PwY+WhUmniApAKUgdDO3LkZrkadN5ZiTdFk2Rp?=
 =?us-ascii?Q?Dgu2pz5JMjwTF2OVKFgqcQXlPWRa/NXidwninr2B899KSPFSO/ab8on19mDD?=
 =?us-ascii?Q?vOrYSssGCxk8V934UV7fvtrFNEKA4wr88OvaSCEZpisHVBSME0NIzJ9tGC0k?=
 =?us-ascii?Q?nHYGYLNzliYKfNvuy3szP6//RQ48QcXhFRzGYRA53FHZoHsvFDhyGGA2YXTX?=
 =?us-ascii?Q?MCV9d8MVKlDMIB9NneASGDvzX39RXMS3Tr4ZMygIX0s9u7Zggc3h+5VlxMET?=
 =?us-ascii?Q?3Y5pr6ySX8FWtVwGQ6VHb543u4IY8YKG8YNTO+LMOUdWMKPuLUjGhSYG6KOn?=
 =?us-ascii?Q?tIJwdXNLp3umTu1d52fMwiSQGjH21dmLwdvjn/ESc3KqAZP6sKdz20pja1Wm?=
 =?us-ascii?Q?YkWEN+AeZsSgYYhjnFO83OsL5udOjSRcHuIU7bH+jUSLfY4By5TaVryemzFs?=
 =?us-ascii?Q?o4+JhqZLHHKl7aR4hs1fCd0qFg6bVuHSPfzJw3J9Iu/FKFg+QrHzLaNs0u7q?=
 =?us-ascii?Q?0ogy0HwpYAhgiohM1dK1GLzWFKsLjMsuqlPtdPapCfd3+VbsulnomjW8RrBy?=
 =?us-ascii?Q?AywGaLZoJ4fEZyTppYLJVgpqg6L5JdGQA+pIU51po4lh8uclUC+brl8zVbkB?=
 =?us-ascii?Q?55m3GuyxtjFOXv3eOiAQ6L7OuRpYZgxQD7PFloyfz0Oq7QU3iO4vlTtx0oHY?=
 =?us-ascii?Q?nUrEXnpT26cdxBVoJ4OQQNBt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890d6e5f-21a7-483b-0e3a-08d941736589
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:53.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t56lFF2VF5/ka9Gvif3ywC0jgEWPE7AYKS8pkBo3WOZik2f5opfG2rknFYBdfP3nd7RQjBjJiHxv/7NSnv3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides NAEs that can be used by the SNP
guest to communicate with the PSP without risk from a malicious hypervisor
who wishes to read, alter, drop or replay the messages sent.

In order to communicate with the PSP, the guest need to locate the secrets
page inserted by the hypervisor during the SEV-SNP guest launch. The
secrets page contains the communication keys used to send and receive the
encrypted messages between the guest and the PSP.

The secrets page is location is passed through the setup_data.

Create a platform device that the SNP guest driver can bind to get the
platform resources such as encryption key and message id to use to
communicate with the PSP. The SNP guest driver can provide userspace
interface to get the attestation report, key derivation, extended
attestation report etc.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c     | 68 +++++++++++++++++++++++++++++++++++++++
 include/linux/sev-guest.h |  5 +++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 663cfe96c186..566625707132 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,8 @@
 #include <linux/log2.h>
 #include <linux/efi.h>
 #include <linux/sev-guest.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -37,6 +39,7 @@
 #include <asm/apic.h>
 #include <asm/efi.h>
 #include <asm/cpuid-indexed.h>
+#include <asm/setup.h>
 
 #include "sev-internal.h"
 
@@ -2160,3 +2163,68 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device guest_req_device = {
+	.name		= "snp-guest",
+	.id		= -1,
+};
+
+static u64 find_secrets_paddr(void)
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
+	/* Verify that secrets page address is passed */
+	if ((info.secrets_phys && (info.secrets_len == PAGE_SIZE)))
+		return info.secrets_phys;
+
+	return 0;
+}
+
+static int __init add_snp_guest_request(void)
+{
+	struct snp_secrets_page_layout *layout;
+	struct snp_guest_platform_data data;
+
+	if (!sev_feature_enabled(SEV_SNP))
+		return -ENODEV;
+
+	snp_secrets_phys = find_secrets_paddr();
+	if (!snp_secrets_phys)
+		return -ENODEV;
+
+	layout = snp_map_secrets_page();
+	if (layout == NULL)
+		return -ENODEV;
+
+	/*
+	 * The secrets page contains three VMPCK that can be used for
+	 * communicating with the PSP. We choose the VMPCK0 to encrypt guest
+	 * messages send and receive by the Linux. Provide the key and
+	 * id through the platform data to the driver.
+	 */
+	data.vmpck_id = 0;
+	memcpy_fromio(data.vmpck, layout->vmpck0, sizeof(data.vmpck));
+
+	iounmap(layout);
+
+	platform_device_add_data(&guest_req_device, &data, sizeof(data));
+
+	if (!platform_device_register(&guest_req_device))
+		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);
+
+	return 0;
+}
+device_initcall(add_snp_guest_request);
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
index 5f6c4d634e1f..d13f2e2cd367 100644
--- a/include/linux/sev-guest.h
+++ b/include/linux/sev-guest.h
@@ -68,6 +68,11 @@ struct snp_guest_request_data {
 	unsigned int data_npages;
 };
 
+struct snp_guest_platform_data {
+	u8 vmpck_id;
+	char vmpck[VMPCK_KEY_LEN];
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
 			    unsigned long *fw_err);
-- 
2.17.1

