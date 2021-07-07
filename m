Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679E03BEEFE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhGGSk1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:27 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232210AbhGGSkX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4QNkl3wJY9abX3h4KHEYoQc5GCz1se30TLN+gCDY6LEHt3RfmDiX/3qYKM68TWK5/5JLx0hVGOJnGhzosTYDrMlBXqFYWxK7QetQkZ81Yu7jBRM5pzWY0mWz71NY50YCpVxDAJXtdAkwIkq7IS1ba39cTdZmW1EWIRS73Zhstdkx4eWVgsRKcH8wUc9Bx6pQA1IUAUNDHIW8UThDeuaAn7L/afyzV+NWxqOG7k72R+xY2BBWIbPnhXsUhCHhy/+rrH4/GqoiEzRvyCJxqUOzbVqOH2yuHDWPHCImI+jw+0WVd+gpKDEZF1R0yjRZ6HDGoHDezPoZm5rUpfCBYM6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YM10bexFFbTUaqoUYN3i4AeltaltS2MnjClZMvMo3w=;
 b=B+JP7SsYtLhVRsux/WEP2qm7Ydt4FWJP7/Nrps2H/LH66LharlYB3p8JX5j2N5c6nAfLHyYwksjdvXMYmw1psSuTvcd1MJt+QyxBta8NpCbmAHnHbxKcupwbQz25e4iProzykwPU3m6F/InS6SGzfNsYMG1WH1dqClqC0pwUyJIRXZmfdfZEhQOyvxbxeHfovfdLkEX89De6duGdEFZ+QEY3OMaQqtMSeDHem+v7Tm844KbYgurkpeqXzv/VBOAo+BcOvnR9LMEI2kG8pAuTBKFWd3adnNKYBy5hhQZOmOUrfwMMmiFrcJBB6IPyxqTT188UN4HkLC4Iyr3ZC/qiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YM10bexFFbTUaqoUYN3i4AeltaltS2MnjClZMvMo3w=;
 b=YqkcGDGYOwbMryA4Rj3ZTcTwD85v+Ka7AKcYiSZf1LUhRfhFakPfOSjmvPaxjhexUx/eVzLwiY3xqHcYOUNaeaTIb9BWD0WFgelLdj6czyn3vFzRt8iTKQSIWYPkvqX7EdpVBNvUvHC0+oLsuK7AREfu6g6kp5KRBIvFycCV4Nc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:23 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:23 +0000
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
Subject: [PATCH Part2 RFC v4 11/40] crypto:ccp: Define the SEV-SNP commands
Date:   Wed,  7 Jul 2021 13:35:47 -0500
Message-Id: <20210707183616.5620-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 798d86b1-126d-420c-c2fe-08d941764280
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808E8BA827CBB2D97EE2F72E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnhTTqPm/lB1SgtgB3wwNs6BDqwejddKPJFblNIrRF7E3ZuOIZeGUImJatBmKHGHMajUcjs+g9MNA++rDgdkcS4MD5y9N9XWZ0i6Cz1oSdGAmUvN4kZYqP1HjYPkagpWJ7y10tA3MZnYl0OlqZ8tAOtcL/XWsZ5vyX5dd8L3ncj+85Nfh6d7dcNAsM5jPdBplQ3MH0YsSFt/b1Fj/YP/z5g94QimKMg9y1Phj6shZpg41zAbE0EF6nToR8+FhRWwC+Hisnftom6EGoqwFXPC4M/JWkF93T1Gk6oEs6p5H/MfzNaw7hVj/29PV0CS2wWwt/p47FwMdSeqwVkWAMumd1uZ961RRk6luTdDUrZCiAaY5aONEogtPoFq6hCi0mtGI+U3Z+1e002lu4yBORgFITsjSonQALzUNkiQ8w3dz2RvJISNt+89Ts9fW+/dbjOnBdUK3p76ycFdMMC5CAmvpggUiLv8//8Y4GYPU5zzH+otwu8k6F0ga0NqHwlz2jlgwtJiwrgU4/D9JEvIKR4uiMZE5G8rbgvC7f5akIHdcmRNIs+p5kQOtPL31G53fJ3VtuiSXlxhNEG2TY4FMHd19H+BayI1LDZpw7Vu053/fV2Fbe1MqY0b5mwCHkt/KITC1bu1fMcpyuSJ/8jSu9Qh5XMgGJKRJsXBY6KAKi7M21/eRIY3pQOWNmcSLaWiidrpM+9ggqUdHLbkRloDvTgMSJah/do3MoMs2z9Q56uDbtZ50AePcf9OicguCSMn5HspWEnZyukOtGSQek/oy0JJhZNjOuyRY+wrxiq7EQFS3qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(30864003)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?apDYDAMT8dHOBjkORCYDKk+v+RKtMaiMQxECOW9tT/So7ZgTeFP4dFc7E/wM?=
 =?us-ascii?Q?mqbGAkQmLje7lg+tv8aBrhxGF/Y5LScK396y7EzViD5BLrPjZF9DNiRRFuvB?=
 =?us-ascii?Q?JmiySlnhGw2FXtx3C8pfpLGNGUQPGPA7foP2mCQFUciIq6kzjSQ/FsPBaDDa?=
 =?us-ascii?Q?eWWNXw1XQ9fTmVOd1Hf7fuBCFCx7K2JyLtnWwiW/+6NMSzB50yE7jsXYjrLe?=
 =?us-ascii?Q?ecQCr48Yu6yC9rVUsf+8pL32ErKKxJcOebtpFQWuZcJypQOW10ZznGtb8F1N?=
 =?us-ascii?Q?nEcamPN88hIdttWYWd20J/4HRyobuCp/KLnqXxTWsnzwyiDOnrD8JEn/eNq3?=
 =?us-ascii?Q?HJj3NkPP0226RMSSEyhAyAzlC7K5tk6V/eB1tkJdGJ9wjVj/hV3HQ2Dsl0hb?=
 =?us-ascii?Q?0lR0j1C96yVo+efy8amzSj16M5Cz1lW8Xt+d79uu0/pqtPaYab5Hgc8zZyY7?=
 =?us-ascii?Q?EgkpCDqd+ybbyraQaUcox6cYbYzYrrKRkbcNPhrnB3BPqlFprqoguI8n/+L1?=
 =?us-ascii?Q?SKe4Zh76gWnkV/oiAMamxqM1MYXryocbmrHBAQ03LWffzM0QS/yoyCDn9MPi?=
 =?us-ascii?Q?K/oKhS1JO2UEdujhopdGOxE7Or09XJZ8t58y83GakDfxwqoMkNmpMRujpXFq?=
 =?us-ascii?Q?uVi5CL2N+3pCUDLyhRejNNSlqkOGqv2j9OzcsnKNwwhgpbinEJ5bezETbCFE?=
 =?us-ascii?Q?58am4qADUFGjaQY+BYcdRLBfH4aCGyKVOUv+8Tfa8KNkNCOQhLGsSqWh9Mal?=
 =?us-ascii?Q?p+6AEL66oYsQi+RaH2W2QHfJmkS1PM/nV1tEGY6rmCK4NA5ENI1S+ZjI0fZa?=
 =?us-ascii?Q?9LXbblbUHb0Ug744OJxY+j7L54ZGZ6+MAIfdVvCiD4yZfcXByTMa7ZgfuLtD?=
 =?us-ascii?Q?DK1V+LCQaYwvJQyGFtO7QfP8nT7SD1gRhhrywNa1b3/4Fh2kdakm7lsWB6qC?=
 =?us-ascii?Q?ZGb/7Rb83k9rRvw3kL9NG0lVYjXcDTF65Ko62kvaw0tEBdmGYdWYrkRf7ZKr?=
 =?us-ascii?Q?3E/eYIJxRUyIFJy5cpaAw067lIDajwBl7TW8RRKuyUBZQxFv33f8lP8zjJwz?=
 =?us-ascii?Q?V/jKW7B7FJ6EXduOIW9pRD5z4ivd1PMos3Y3/3kyTjv9UmvGFK/AR6qRLloY?=
 =?us-ascii?Q?mP+SR60j0gC42QIpkaw1+RH7gRsodgjuAFToy31ftjdFzO05aYyPHBNtVZsB?=
 =?us-ascii?Q?vDvXHnMGQlHqhKO9aAIl/Qc3Lxu02DdJR1tgd+ch9fFWgWnHFiKz7TvuChlt?=
 =?us-ascii?Q?EQfkYWKekynSDF32e2nwHBCYikPOVBSecxwfoqYVAZ/VSO4ckNjcJoGw0x62?=
 =?us-ascii?Q?lBS/KWGrM9qxLS0AFfU2x6nA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d86b1-126d-420c-c2fe-08d941764280
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:22.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRCninVBtXiM4vnGfpygB9ldmnUJ5R9J3iugnvi3PDQ/dfTSW2gCguKlFc8rt42+7RdUitKWeXw3Ax4Ex0Wy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

AMD introduced the next generation of SEV called SEV-SNP (Secure Nested
Paging). SEV-SNP builds upon existing SEV and SEV-ES functionality
while adding new hardware security protection.

Define the commands and structures used to communicate with the AMD-SP
when creating and managing the SEV-SNP guests. The SEV-SNP firmware spec
is available at developer.amd.com/sev.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c |  16 ++-
 include/linux/psp-sev.h      | 222 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/psp-sev.h |  43 +++++++
 3 files changed, 280 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 3506b2050fb8..32884d2bf4e5 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -130,7 +130,21 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
 	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	case SEV_CMD_ATTESTATION_REPORT:	return sizeof(struct sev_data_attestation_report);
-	case SEV_CMD_SEND_CANCEL:			return sizeof(struct sev_data_send_cancel);
+	case SEV_CMD_SEND_CANCEL:		return sizeof(struct sev_data_send_cancel);
+	case SEV_CMD_SNP_GCTX_CREATE:		return sizeof(struct sev_data_snp_gctx_create);
+	case SEV_CMD_SNP_LAUNCH_START:		return sizeof(struct sev_data_snp_launch_start);
+	case SEV_CMD_SNP_LAUNCH_UPDATE:		return sizeof(struct sev_data_snp_launch_update);
+	case SEV_CMD_SNP_ACTIVATE:		return sizeof(struct sev_data_snp_activate);
+	case SEV_CMD_SNP_DECOMMISSION:		return sizeof(struct sev_data_snp_decommission);
+	case SEV_CMD_SNP_PAGE_RECLAIM:		return sizeof(struct sev_data_snp_page_reclaim);
+	case SEV_CMD_SNP_GUEST_STATUS:		return sizeof(struct sev_data_snp_guest_status);
+	case SEV_CMD_SNP_LAUNCH_FINISH:		return sizeof(struct sev_data_snp_launch_finish);
+	case SEV_CMD_SNP_DBG_DECRYPT:		return sizeof(struct sev_data_snp_dbg);
+	case SEV_CMD_SNP_DBG_ENCRYPT:		return sizeof(struct sev_data_snp_dbg);
+	case SEV_CMD_SNP_PAGE_UNSMASH:		return sizeof(struct sev_data_snp_page_unsmash);
+	case SEV_CMD_SNP_PLATFORM_STATUS:	return sizeof(struct sev_data_snp_platform_status_buf);
+	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
+	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	default:				return 0;
 	}
 
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index d48a7192e881..c3755099ab55 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -85,6 +85,34 @@ enum sev_cmd {
 	SEV_CMD_DBG_DECRYPT		= 0x060,
 	SEV_CMD_DBG_ENCRYPT		= 0x061,
 
+	/* SNP specific commands */
+	SEV_CMD_SNP_INIT		= 0x81,
+	SEV_CMD_SNP_SHUTDOWN		= 0x82,
+	SEV_CMD_SNP_PLATFORM_STATUS	= 0x83,
+	SEV_CMD_SNP_DF_FLUSH		= 0x84,
+	SEV_CMD_SNP_INIT_EX		= 0x85,
+	SEV_CMD_SNP_DECOMMISSION	= 0x90,
+	SEV_CMD_SNP_ACTIVATE		= 0x91,
+	SEV_CMD_SNP_GUEST_STATUS	= 0x92,
+	SEV_CMD_SNP_GCTX_CREATE		= 0x93,
+	SEV_CMD_SNP_GUEST_REQUEST	= 0x94,
+	SEV_CMD_SNP_ACTIVATE_EX		= 0x95,
+	SEV_CMD_SNP_LAUNCH_START	= 0xA0,
+	SEV_CMD_SNP_LAUNCH_UPDATE	= 0xA1,
+	SEV_CMD_SNP_LAUNCH_FINISH	= 0xA2,
+	SEV_CMD_SNP_DBG_DECRYPT		= 0xB0,
+	SEV_CMD_SNP_DBG_ENCRYPT		= 0xB1,
+	SEV_CMD_SNP_PAGE_SWAP_OUT	= 0xC0,
+	SEV_CMD_SNP_PAGE_SWAP_IN	= 0xC1,
+	SEV_CMD_SNP_PAGE_MOVE		= 0xC2,
+	SEV_CMD_SNP_PAGE_MD_INIT	= 0xC3,
+	SEV_CMD_SNP_PAGE_MD_RECLAIM	= 0xC4,
+	SEV_CMD_SNP_PAGE_RO_RECLAIM	= 0xC5,
+	SEV_CMD_SNP_PAGE_RO_RESTORE	= 0xC6,
+	SEV_CMD_SNP_PAGE_RECLAIM	= 0xC7,
+	SEV_CMD_SNP_PAGE_UNSMASH	= 0xC8,
+	SEV_CMD_SNP_CONFIG		= 0xC9,
+
 	SEV_CMD_MAX,
 };
 
@@ -510,6 +538,200 @@ struct sev_data_attestation_report {
 	u32 len;				/* In/Out */
 } __packed;
 
+/**
+ * struct sev_data_snp_platform_status_buf - SNP_PLATFORM_STATUS command params
+ *
+ * @address: physical address where the status should be copied
+ */
+struct sev_data_snp_platform_status_buf {
+	u64 status_paddr;			/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_download_firmware - SNP_DOWNLOAD_FIRMWARE command params
+ *
+ * @address: physical address of firmware image
+ * @len: len of the firmware image
+ */
+struct sev_data_snp_download_firmware {
+	u64 address;				/* In */
+	u32 len;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_gctx_create - SNP_GCTX_CREATE command params
+ *
+ * @gctx_paddr: system physical address of the page donated to firmware by
+ *		the hypervisor to contain the guest context.
+ */
+struct sev_data_snp_gctx_create {
+	u64 gctx_paddr;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_activate - SNP_ACTIVATE command params
+ *
+ * @gctx_paddr: system physical address guest context page
+ * @asid: ASID to bind to the guest
+ */
+struct sev_data_snp_activate {
+	u64 gctx_paddr;				/* In */
+	u32 asid;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_decommission - SNP_DECOMMISSION command params
+ *
+ * @address: system physical address guest context page
+ */
+struct sev_data_snp_decommission {
+	u64 gctx_paddr;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_launch_start - SNP_LAUNCH_START command params
+ *
+ * @gctx_addr: system physical address of guest context page
+ * @policy: guest policy
+ * @ma_gctx_addr: system physical address of migration agent
+ * @imi_en: launch flow is launching an IMI for the purpose of
+ *   guest-assisted migration.
+ * @ma_en: the guest is associated with a migration agent
+ */
+struct sev_data_snp_launch_start {
+	u64 gctx_paddr;				/* In */
+	u64 policy;				/* In */
+	u64 ma_gctx_paddr;			/* In */
+	u32 ma_en:1;				/* In */
+	u32 imi_en:1;				/* In */
+	u32 rsvd:30;
+	u8 gosvw[16];				/* In */
+} __packed;
+
+/* SNP support page type */
+enum {
+	SNP_PAGE_TYPE_NORMAL		= 0x1,
+	SNP_PAGE_TYPE_VMSA		= 0x2,
+	SNP_PAGE_TYPE_ZERO		= 0x3,
+	SNP_PAGE_TYPE_UNMEASURED	= 0x4,
+	SNP_PAGE_TYPE_SECRET		= 0x5,
+	SNP_PAGE_TYPE_CPUID		= 0x6,
+
+	SNP_PAGE_TYPE_MAX
+};
+
+/**
+ * struct sev_data_snp_launch_update - SNP_LAUNCH_UPDATE command params
+ *
+ * @gctx_addr: system physical address of guest context page
+ * @imi_page: indicates that this page is part of the IMI of the guest
+ * @page_type: encoded page type
+ * @page_size: page size 0 indicates 4K and 1 indicates 2MB page
+ * @address: system physical address of destination page to encrypt
+ * @vmpl3_perms: VMPL permission mask for VMPL3
+ * @vmpl2_perms: VMPL permission mask for VMPL2
+ * @vmpl1_perms: VMPL permission mask for VMPL1
+ */
+struct sev_data_snp_launch_update {
+	u64 gctx_paddr;				/* In */
+	u32 page_size:1;			/* In */
+	u32 page_type:3;			/* In */
+	u32 imi_page:1;				/* In */
+	u32 rsvd:27;
+	u32 rsvd2;
+	u64 address;				/* In */
+	u32 rsvd3:8;
+	u32 vmpl3_perms:8;			/* In */
+	u32 vmpl2_perms:8;			/* In */
+	u32 vmpl1_perms:8;			/* In */
+	u32 rsvd4;
+} __packed;
+
+/**
+ * struct sev_data_snp_launch_finish - SNP_LAUNCH_FINISH command params
+ *
+ * @gctx_addr: system pphysical address of guest context page
+ */
+struct sev_data_snp_launch_finish {
+	u64 gctx_paddr;
+	u64 id_block_paddr;
+	u64 id_auth_paddr;
+	u8 id_block_en:1;
+	u8 auth_key_en:1;
+	u64 rsvd:62;
+	u8 host_data[32];
+} __packed;
+
+/**
+ * struct sev_data_snp_guest_status - SNP_GUEST_STATUS command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @address: system physical address of guest status page
+ */
+struct sev_data_snp_guest_status {
+	u64 gctx_paddr;
+	u64 address;
+} __packed;
+
+/**
+ * struct sev_data_snp_page_reclaim - SNP_PAGE_RECLAIM command params
+ *
+ * @paddr: system physical address of page to be claimed. The BIT0 indicate
+ *	the page size. 0h indicates 4 kB and 1h indicates 2 MB page.
+ */
+struct sev_data_snp_page_reclaim {
+	u64 paddr;
+} __packed;
+
+/**
+ * struct sev_data_snp_page_unsmash - SNP_PAGE_UNMASH command params
+ *
+ * @paddr: system physical address of page to be unmashed. The BIT0 indicate
+ *	the page size. 0h indicates 4 kB and 1h indicates 2 MB page.
+ */
+struct sev_data_snp_page_unsmash {
+	u64 paddr;
+} __packed;
+
+/**
+ * struct sev_data_dbg - DBG_ENCRYPT/DBG_DECRYPT command parameters
+ *
+ * @handle: handle of the VM to perform debug operation
+ * @src_addr: source address of data to operate on
+ * @dst_addr: destination address of data to operate on
+ * @len: len of data to operate on
+ */
+struct sev_data_snp_dbg {
+	u64 gctx_paddr;				/* In */
+	u64 src_addr;				/* In */
+	u64 dst_addr;				/* In */
+	u32 len;				/* In */
+} __packed;
+
+/**
+ * struct sev_snp_guest_request - SNP_GUEST_REQUEST command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @req_paddr: system physical address of request page
+ * @res_paddr: system physical address of response page
+ */
+struct sev_data_snp_guest_request {
+	u64 gctx_paddr;				/* In */
+	u64 req_paddr;				/* In */
+	u64 res_paddr;				/* In */
+} __packed;
+
+/**
+ * struuct sev_data_snp_init - SNP_INIT_EX structure
+ *
+ * @init_rmp: indicate that the RMP should be initialized.
+ */
+struct sev_data_snp_init_ex {
+	u32 init_rmp:1;
+	u32 rsvd:31;
+	u8 rsvd1[60];
+} __packed;
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
 /**
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..226de6330a18 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -61,6 +61,13 @@ typedef enum {
 	SEV_RET_INVALID_PARAM,
 	SEV_RET_RESOURCE_LIMIT,
 	SEV_RET_SECURE_DATA_INVALID,
+	SEV_RET_INVALID_PAGE_SIZE,
+	SEV_RET_INVALID_PAGE_STATE,
+	SEV_RET_INVALID_MDATA_ENTRY,
+	SEV_RET_INVALID_PAGE_OWNER,
+	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
+	SEV_RET_RMP_INIT_REQUIRED,
+
 	SEV_RET_MAX,
 } sev_ret_code;
 
@@ -147,6 +154,42 @@ struct sev_user_data_get_id2 {
 	__u32 length;				/* In/Out */
 } __packed;
 
+/**
+ * struct sev_user_data_snp_status - SNP status
+ *
+ * @major: API major version
+ * @minor: API minor version
+ * @state: current platform state
+ * @build: firmware build id for the API version
+ * @guest_count: the number of guest currently managed by the firmware
+ * @tcb_version: current TCB version
+ */
+struct sev_user_data_snp_status {
+	__u8 api_major;		/* Out */
+	__u8 api_minor;		/* Out */
+	__u8 state;		/* Out */
+	__u8 rsvd;
+	__u32 build_id;		/* Out */
+	__u32 rsvd1;
+	__u32 guest_count;	/* Out */
+	__u64 tcb_version;	/* Out */
+	__u64 rsvd2;
+} __packed;
+
+/*
+ * struct sev_user_data_snp_config - system wide configuration value for SNP.
+ *
+ * @reported_tcb: The TCB version to report in the guest attestation report.
+ * @mask_chip_id: Indicates that the CHID_ID field in the attestation report
+ * will always be zero.
+ */
+struct sev_user_data_snp_config {
+	__u64 reported_tcb;     /* In */
+	__u32 mask_chip_id;     /* In */
+	__u8 rsvd[52];
+} __packed;
+
+
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
-- 
2.17.1

