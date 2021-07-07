Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425F53BEF19
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhGGSku (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:50 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231757AbhGGSkd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIVM6RXqfU3/PzOvc5s7EYJ36YpQAwpj+8oyqSr2HA32KEvwABZwygar/AIA8SyvlUHTO9NIkCUzAXK18PRsFguvffoA+ZpKW1nJLa6JuCHrcvQDFgl7m4ACTIVI1qGRLZJigYA6HFJXPUhad2wdD7aTxalDPnHgh4GYaA07kSi8ceTzxpfmTnXJHkgInPowKJIOnnr4eqC3kbpbvh1ab/8O97sI8tLDJap4QoQW39hi3g3Q7SPPwcEtPhwTMI25XSHhp/bm1OX7aq1diLiEefWQdizgv4t53tK6n1kvgfbqK9KaQTjCwiQXbnvd44c3UsTZJDRhrGk0g1NaLU6KCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+Y8wdp3HNjL8kwUL37/cFthm5KYIqcEgNLxCys25wA=;
 b=ZEUvDQ99rUiZzqDB18uXCQjuMuMDzF6bwoFcuwB1a1Jaymr/7J6EvvYS9iIX1Xh8GbJP9s+qsFrBRlBOpY2Qp9t78KMKaulmeeABhREmLmhTGnHz50IH2XknTvWUv9tE3QViuCPnBQXpUoSqnZr3420BkzdIT3enUnOpQqrk9kJ+mkSc67oKwGYA+gCtppmqhLbHoy8SRCffcNeczIkjcBG98kpHVdNSEJ6rJpgdzDSvYKD8buOaJg9faclAOhLIRjw/j6x/E0UyNIx24i9PaWxCRkvPsyrtHF3NsED2vBbwdNq4nCSbIcz7x20Sp9CzGz9bEoiiEg/a8YcY+j5gNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+Y8wdp3HNjL8kwUL37/cFthm5KYIqcEgNLxCys25wA=;
 b=RC/MeIHkQVDrPXmJczIFLwQQ62WXJooWKAyffCdgUQzbyXP9neNXmLZS6AW+gfptEfPGCPupQZqWbZBdZRuZWbD8Hmd6hysc0zpY2GIM3umrUwQkXZA1giuIAB2OEDvOXn89inT7ca/OfcZ6U09mJXRV67u2QabrTdjBYSkxYTo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:39 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:39 +0000
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
Subject: [PATCH Part2 RFC v4 17/40] crypto: ccp: Add the SNP_PLATFORM_STATUS command
Date:   Wed,  7 Jul 2021 13:35:53 -0500
Message-Id: <20210707183616.5620-18-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5094db7c-e207-41b8-4e35-08d941764c13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808CB9CB1B36ACD27C1A21BE51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrhtAB3HSp7n7vJbz5saCkHGSe0m1QAU/2RMnJ7BSrnNvygUZUafs3P+AwukZv41QdD3nTvvE1m3i1BdIwkWhSADiDfcKKNgkBcA2QoUVAuvDWVVPZ5EsZVedOcGKGC8gPr2cdDHZg+46lwadLOEdUYjmUna3ovqABzcJprHAEVRL+gvU8EBup2NbFLpyHxu9QU5A+ZRRXATAosQaAqm4sp2hoM/OuZ28GOXeYdhvQV4ZM8Kj2nxxz6dNX2p8fQc2BUIHVDwSy85b1KT4W1CSW2w8Y9OZl3p3w6/phDmqnGPy8LcVhEJbDtduIRt3wRHjeLo5uB9PbX8NCqwwpJdTTzUJE1OmF54ORIN5wRoCKS7PEmWCw08+UkJ+n0sFTF2ffFDCsJ5wQCPF34FS5Wgg+WU+cyE+Fo8ny5KibbrD4Aqqi0kaBJpS3H5Tcp5e5So0o3ko7kkZrmg7oUAOHD3zPygCnVoW1gfjs+YYHvJ1v21pDufH5S+N7iTxe2ccDkDLsiKpO24SFi3PXFm7Ly3DfEOCx3rka+UeaAxZ59aYO8lUpfj/7V0kCH19JAAudHybUvCxfCsYSNm9cmKCdDqFxpUJt+s+5DbtOaCMHvFdn1trEzZLBC0ycfwTlyXcu0QVQ9VeeE0l6KUEVTHNoq6KnQCaK1uIxRe3kzlSJiUT/BAuIe7BtD7Zs9z6bW5rAp9oeIXV/zx5tNLN46QWUSDeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upc3LquoPTopr+BiraH+2LOMgZdQllEIYeQltCEzeUjvYZvIRCqphLD7L491?=
 =?us-ascii?Q?IBTvEGGO85jW9iUfVvC6Rwz874DgsUv3oU/2JtcFSFpkPLx2vgJo1wLjxxl9?=
 =?us-ascii?Q?hoiJmOwB5zKLEekzATy1amYZfyHHqBgkye4biqqHreRNMO5ZwjQCjlglDJuc?=
 =?us-ascii?Q?Gqt9chzsCg6bHsjWrsQ9A3G+feE3lqrHqOtPxNe+yFn3dd24P8Fm8scVAHDv?=
 =?us-ascii?Q?zuscvMhDNYLi/XF2UPvxSAwquX3VC6hxAAMaHEp0b8pQBF8p2rWYnp1aV6cz?=
 =?us-ascii?Q?9/PeFoI+Zoi6y6USwZoZ28/wm33VsmE8uZaLqivU+u5hnGn5nK5Np0GqSYk/?=
 =?us-ascii?Q?Koumo7f8fdh2ONNERFm1+eisHJvM2VYjRrwj0C9mCLfvGkjBQhyfvGMQYzLX?=
 =?us-ascii?Q?GQbVQChtX16RuLMVDHdVozP4ONM5s/xumGyNd3Q1smsZ9qk+KFrMO/IFBqMI?=
 =?us-ascii?Q?wplDRP8N1Qoh1tF5Ns9iNy2fTlGcOZBPyki4dPToQdhi5BqjdetSo8oecJid?=
 =?us-ascii?Q?JwUxlywelIkdHSQHaC62Zhp558+7WGeicrFnFi8emltJ2sgzL8x2aULOs4W/?=
 =?us-ascii?Q?7VvfaDnBrjA6D3jrSBOoSvfTp0lOCC6NErA846gY3LhjzAEYIwyt7hYIsOXt?=
 =?us-ascii?Q?PJ8WE0AIb1MjzT1R8MzjRqUPs//AhTOhyFzu9NvNpUbBViQ9hedls7gBjY6D?=
 =?us-ascii?Q?pOb/modf3fv26h39YW/FKZz0FgeVP5I/AUgUx69EFBcD4cHB+1+DPLDNt/Xs?=
 =?us-ascii?Q?HdmqCs3DJIsLdVODxiZdtvWQa5e8q7zWVLb0bzghkV3m4UkYdwcLyV/kLnxD?=
 =?us-ascii?Q?+uybL0YCnQZlvcOL/ROPp+Qtq7mNT7WFYo0pbXNE+9Gb1CApOd2l0mXriEY0?=
 =?us-ascii?Q?1QwU5jRYC1J/cuKffvlaoq1e4AODbeW/ke/Y5TyoKPN/01K56faH4QtzB09D?=
 =?us-ascii?Q?ojoaNNtwM3ZQb/z9jRkubVCd804Pa+RZowkj9Olaqhqpf/1WDllrUGtCyDL2?=
 =?us-ascii?Q?+j+nDs3CdnPgzFmfYfnlh2Ft3ZJdk/d6wk5UoMPQbcHZ7GJWWMB5occ1BmrG?=
 =?us-ascii?Q?pBzWxR2JHvHMJHyTg2ncB1xfl55zeIPbHVP/qOvnUWz3h9Ay+XgcPdaI9CGz?=
 =?us-ascii?Q?F6a0mluXTmiLZHLO869hL31IQrE7b2z6hrLqd3aZ7OTvEgRsieC8MdkgJrMY?=
 =?us-ascii?Q?uOcqQ2sM2xj3L6QqpHKs4UEjBix5/0JVhf7O329dHLIZMf7wgbXX2MswQ2DN?=
 =?us-ascii?Q?inGe+fQCOeVjsVppswBRIuBIEiNilRExykrkb1/Q0qV3RutMI5fzmsFc2DLG?=
 =?us-ascii?Q?1xRoOdJslA6xddVSMjMdo2do?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5094db7c-e207-41b8-4e35-08d941764c13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:38.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVNSSn5UB5deePkOvwNtD9Q9PRQkfpUPL86PFJIrzHUeeXIlEyJwBJr2ledPKuzLGm71Waw7NNktxVRXfU4W7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The command can be used by the userspace to query the SNP platform status
report. See the SEV-SNP spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst | 27 ++++++++++++++++++++++++
 drivers/crypto/ccp/sev-dev.c         | 31 ++++++++++++++++++++++++++++
 drivers/crypto/ccp/sev-dev.h         |  1 +
 include/uapi/linux/psp-sev.h         |  1 +
 4 files changed, 60 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 7acb8696fca4..7c51da010039 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -52,6 +52,22 @@ to execute due to the firmware error, then fw_err code will be set.
                 __u64 fw_err;
         };
 
+The host ioctl should be called to /dev/sev device. The ioctl accepts command
+id and command input structure.
+
+::
+        struct sev_issue_cmd {
+                /* Command ID */
+                __u32 cmd;
+
+                /* Command request structure */
+                __u64 data;
+
+                /* firmware error code on failure (see psp-sev.h) */
+                __u32 error;
+        };
+
+
 2.1 SNP_GET_REPORT
 ------------------
 
@@ -107,3 +123,14 @@ length of the blob is lesser than expected then snp_ext_report_req.certs_len wil
 be updated with the expected value.
 
 See GHCB specification for further detail on how to parse the certificate blob.
+
+2.3 SNP_PLATFORM_STATUS
+-----------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (in): struct sev_data_snp_platform_status
+:Returns (out): 0 on success, -negative on error
+
+The SNP_PLATFORM_STATUS command is used to query the SNP platform status. The
+status includes API major, minor version and more. See the SEV-SNP
+specification for further details.
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 16f0d9211739..65003aba807a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1056,6 +1056,7 @@ static int __sev_snp_init_locked(int *error)
 	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
 
 	sev_es_tmr_size = SEV_SNP_ES_TMR_SIZE;
+	sev->snp_plat_status_page = __snp_alloc_firmware_pages(GFP_KERNEL_ACCOUNT, 0, true);
 
 	return rc;
 }
@@ -1083,6 +1084,9 @@ static int __sev_snp_shutdown_locked(int *error)
 	if (!sev->snp_inited)
 		return 0;
 
+	/* Free the status page */
+	__snp_free_firmware_pages(sev->snp_plat_status_page, 0, true);
+
 	/* SHUTDOWN requires the DF_FLUSH */
 	wbinvd_on_all_cpus();
 	__sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
@@ -1345,6 +1349,30 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	return ret;
 }
 
+static int sev_ioctl_snp_platform_status(struct sev_issue_cmd *argp)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_data_snp_platform_status_buf buf;
+	int ret;
+
+	if (!sev->snp_inited || !argp->data)
+		return -EINVAL;
+
+	if (!sev->snp_plat_status_page)
+		return -ENOMEM;
+
+	buf.status_paddr = __psp_pa(page_address(sev->snp_plat_status_page));
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &argp->error);
+	if (ret)
+		return ret;
+
+	if (copy_to_user((void __user *)argp->data, page_address(sev->snp_plat_status_page),
+			sizeof(struct sev_user_data_snp_status)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -1396,6 +1424,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SEV_GET_ID2:
 		ret = sev_ioctl_do_get_id2(&input);
 		break;
+	case SNP_PLATFORM_STATUS:
+		ret = sev_ioctl_snp_platform_status(&input);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index fe5d7a3ebace..5efe162ad82d 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -66,6 +66,7 @@ struct sev_device {
 
 	bool snp_inited;
 	struct snp_host_map snp_host_map[MAX_SNP_HOST_MAP_BUFS];
+	struct page *snp_plat_status_page;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 226de6330a18..0c383d322097 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -28,6 +28,7 @@ enum {
 	SEV_PEK_CERT_IMPORT,
 	SEV_GET_ID,	/* This command is deprecated, use SEV_GET_ID2 */
 	SEV_GET_ID2,
+	SNP_PLATFORM_STATUS = 256,
 
 	SEV_MAX,
 };
-- 
2.17.1

