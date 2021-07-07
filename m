Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A753BEE51
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhGGSUK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:10 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:54561
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232245AbhGGSTm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of4slQiKLwMtGjxmYKnrf1DMlecyWhsSbvPzHBEn7YzWvKhDxMJTUzGWJMkEU4gPCoy4WC78pAG8CspnlcVsxh7u22VZKBm6N3tVWk2Ki9y+Yz/uKUCAf+1aH5Drjl3GIxF35LJfqiOW6p1aB4lgAhAkdqy+LfcQehOP712F0KPchGcwifX34QTQB1bXo7/KhnvPx+VxHv0EcmdIY3jnBcU+ExfFMsqcaGXhSBzgQfVicoH5kZv7P4wUKmk6a0RpryvUh6RGfbZyrUaXx9Bo2r7YhVhrbyJkW2xNn16c2cbJCmVl7OFNLao/nucKyMEiKSFXzgZvokfehx1JxHeZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/IHMOVem7t7z2OV4kUnI967SHyn8TUBIuL3M5S8ay0=;
 b=BppHbiDQXPrApQ/vUUQsFlEyu7CRznKvdGP4wvBOdYvhdSQHkuxONKO/ksoVsPwXD4w4cnOVeNZ+5ae0c6TBqyih3NQUPTLvglmiimxAefa6xUbUJShsAhcF2/bUySch5/y3g6uVpygEsZs22BvEhBb3fje2OlRAPlZirpW/8cGq0MhvX0THQlnhhrXya+Xi7rwfvLNsTZvOYDJU4JWfifBOuCPkqk014U4C7vwCXAUx8MaOhrsZVJzVmOzIch+SOmxH8wl9mp4drhWRdsadiEH36015YD33dsbo+2CbvYauj/Rxv3PdooVPTyK6I9IuaF/YLNaxXhEj0xtmX/b9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/IHMOVem7t7z2OV4kUnI967SHyn8TUBIuL3M5S8ay0=;
 b=ScNWuFLi1miBzEuFDcjz5x/Frwzoy5kbgu80Hx6liy4J3yYBoRN0tSsFi+8TgVqgUvrLgevn64CInkzieSTLD1fB1NIS82OJaE/SwNjIVcfApkgKIKjTaMg/8TOtmnsUIcfF0IZ1CoDqi2f2mxQuPWAWCx9YBG7ba/qbWnkEtFk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:58 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:58 +0000
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
Subject: [PATCH Part1 RFC v4 35/36] virt: sevguest: Add support to derive key
Date:   Wed,  7 Jul 2021 13:15:05 -0500
Message-Id: <20210707181506.30489-36-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2112b32f-7620-48c1-6a87-08d9417368a5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3527C745657D1F2B148DD6AAE51A9@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5ydBn21GoXp2gFKS66M3DU/1eBS5DX4C/yWXkFHrjRLqvCvz5kvcOTwTqCkVHzCE1V//e3WNikES/2w/HF+eUGACHLP8Ast9pbD8lIs9Z0Xs1JR2nouy2Pj9xryWrt3CaeXgqL61d2tUIboYCkWSS1F3YwLXAI9+Sgm/wcx9jm0M9i/rJ30FQ9eAG3EzqxFa66SY/pbr2aekJFr+LaHpYFIUnnWJGSg0ZmJmoCyCFcdnnaU8T5CGBY8iTSvs+SK4Oh4FifUG479rtyXtgOF4kz2TqUphHsud361Do6Enz8tiS/kMjheawiGtQN5Pbf7k3/bH4gDvdoS8ZxJIy7G5P4xKudCiMmC6gBDwt8CZy8ebz8CLRnU40Uqe7BdU3YTiQFjIlbKI8xdep42TkIlziSIjYX+iGUsORg9pkwI3xxI3FKLiqJV4sVB3beyosumceXLnMrpOPX+6d38785nabbQ9uOKYk10PSw26SZbc7kYWuFOnQcdn2lbFmGW2wAPLNnfTJwkX2VI7UOGVGMIjEg0sk728CTzzcD6Eb9YRnp6xc64wIdplCmxBnGuVunr+T4jPuBPVJUDjF+9WF8O6+FCJm30yMnueDLSQS4Te0zgw22iknxOHcxMHbsrBhTnA1n3wi0TqEQcAiVkvOFTdipEc3LoiI3ZBG848/6VA+siuG5CtFZSJXnWvuT9ZRmz+v7RGXmeztbSKAuiG5yuqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2616005)(5660300002)(498600001)(44832011)(6486002)(1076003)(66946007)(66556008)(83380400001)(86362001)(186003)(956004)(66476007)(8936002)(8676002)(52116002)(36756003)(54906003)(2906002)(7696005)(38100700002)(38350700002)(4326008)(6666004)(7406005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6joJQOXuDsZ6RYp5TrE4w4WeXP5EmCBEixt/hxI4gKEyXrb9c/nvLVNjYke?=
 =?us-ascii?Q?qvMsi0CyBOm5Yl8xiHWMJkgpJlc9fpxf44fln2Y2FadDBbZdnDYaNDpO+DB/?=
 =?us-ascii?Q?KoycXVfdgpRJlfRwptAvXhzWtNQIs/x32rDAiFBRjXNPEurq2yuW64Chy2jX?=
 =?us-ascii?Q?7Yl5tDNfshmUf/0Wl8QmtSAUSMMyaId+f9F9AgoT9qhhVYG1RztfLcgN7vM+?=
 =?us-ascii?Q?bw6v03wwpq+zZJqbfmMAFeYHRV0hb2dP29lXaw6yI/rHACF+31os0tGZtLyk?=
 =?us-ascii?Q?5F+5gMufHPUhaKs2SOhfa5OituigBBRSKtl0+586Ft4BknJoWak+glxQqco4?=
 =?us-ascii?Q?BGMf4OlXVu7f/dZJpFF/a2WzVQTYzLybjtGtv9IdgX69Fu6a7LxVf+SkdDYM?=
 =?us-ascii?Q?XAHRb211ZIHcivbMCMC4mXregGfwSL2GApLli5XYY/+31VeDxYEovThiNOeL?=
 =?us-ascii?Q?oac8rWlaWcJ72L7QnOQ3A9KuhFRC0cOng2+FFhlFaNgkubMomKWoogR8otIn?=
 =?us-ascii?Q?jebPo4eyIyPMy7TgDJx8rjNIj1CJZw+CnEjDr3YCyGwd+O80GfLqeyCJeJXo?=
 =?us-ascii?Q?JVAWdlZsFbg/lMiZl71a68A8WTlkTUqKtY6twGmhut3/zNd3qJJ6aJIZj8N3?=
 =?us-ascii?Q?d3wfXp1Ay5zEJXsmChXskPI0AFrYX/054heGc9NOf132dlApOBzI8a61PhDj?=
 =?us-ascii?Q?okuY/SP5UNDiiQp3oDmGDr98LpdPqBZJ9bGKbZBXZm7VK3o8W1dqjQHhhqyU?=
 =?us-ascii?Q?XHwqTFDOdnZCGlHOSi8+7dWKs6/OMcwbr3Rm6todb1u89mxkAE+MOLufiHwJ?=
 =?us-ascii?Q?XNISxAOldiIlneLdHiJi0RL4TUutwW9aXSvWVYp5E5wdj4xMiQ+oSthTDWSN?=
 =?us-ascii?Q?h6Lii+QcsAHJgcMKTkpckg0DOAx560VVDnDf1e1+4mw3juERPmOUhRDJV8vB?=
 =?us-ascii?Q?rAd7wgkU0j6Xn+4sw2OrHrQTC7yV/CI31E2jwGFB7SiIqpORVXhc271K4YD3?=
 =?us-ascii?Q?+eO9U5gL1PGYjK5hC93vGQcZWH1sTjQ8eZolpyNq10QiOE9eptGLOoL/r0yS?=
 =?us-ascii?Q?ZFAxtB/H5Gh6jOIw1rCBv+9UR7G3KBhuAein9P8AqNdfhXYe7VRmgxU73t3W?=
 =?us-ascii?Q?j54E0z8ucHNkr5PPVIxXInxhGKOWFm1pXavuGXiuMfNt9b00gWq6bc/Ocw9v?=
 =?us-ascii?Q?twfBNVAbW2epwF2ahxmykV0DES+w1A2uzhUypNjCIyJirPZmZ4UCeYG32RVi?=
 =?us-ascii?Q?njbB1hXDoAfJ/EV9MzktVWpbq/IY1BXRnw84Qc/ffPQX9p6t5rBN68BQHSVM?=
 =?us-ascii?Q?4XZ4oK52UIEP1BqknX+RIYDh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2112b32f-7620-48c1-6a87-08d9417368a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:58.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvYpKSAjJuph2bQ0VjXhid9EUr/KNOjPeQlkvVBfvGYXZ8RlF5lPxmEbh97FNPmZkSg/60qZ4qTi6lJi91aEPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
ask the firmware to provide a key derived from a root key. The derived
key may be used by the guest for any purposes it choose, such as a
sealing key or communicating with the external entities.

See SEV-SNP firmware spec for more information.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst  | 18 ++++++++++
 drivers/virt/coco/sevguest/sevguest.c | 48 +++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        | 24 ++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 52d5915037ef..25446670d816 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -67,3 +67,21 @@ provided by the SEV-SNP firmware to query the attestation report.
 On success, the snp_report_resp.data will contains the report. The report
 format is described in the SEV-SNP specification. See the SEV-SNP specification
 for further details.
+
+2.2 SNP_GET_DERIVED_KEY
+-----------------------
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in): struct snp_derived_key_req
+:Returns (out): struct snp_derived_key_req on success, -negative on error
+
+The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
+The derived key can be used by the guest for any purpose, such as sealing keys
+or communicating with external entities.
+
+The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
+SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
+on the various fileds passed in the key derivation request.
+
+On success, the snp_derived_key_resp.data will contains the derived key
+value.
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index f3f86f9b5b22..2f20db80490a 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -304,6 +304,50 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_reque
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp *resp;
+	struct snp_derived_key_req req;
+	int rc, resp_len;
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from the userspace */
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	/* Message version must be non-zero */
+	if (!req.msg_version)
+		return -EINVAL;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!resp)
+		return -ENOMEM;
+
+	/* Issue the command to get the attestation report */
+	rc = handle_guest_request(snp_dev, req.msg_version, SNP_MSG_KEY_REQ,
+				  &req.data, sizeof(req.data), resp->data, resp_len,
+				  &arg->fw_err);
+	if (rc)
+		goto e_free;
+
+	/* Copy the response payload to userspace */
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		rc = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return rc;
+}
+
 static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
@@ -321,6 +365,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		ret = get_report(snp_dev, &input);
 		break;
 	}
+	case SNP_GET_DERIVED_KEY: {
+		ret = get_derived_key(snp_dev, &input);
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index e8cfd15133f3..621a9167df7a 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -36,9 +36,33 @@ struct snp_user_guest_request {
 	__u64 fw_err;
 };
 
+struct __snp_derived_key_req {
+	__u32 root_key_select;
+	__u32 rsvd;
+	__u64 guest_field_select;
+	__u32 vmpl;
+	__u32 guest_svn;
+	__u64 tcb_version;
+};
+
+struct snp_derived_key_req {
+	/* message version number (must be non-zero) */
+	__u8 msg_version;
+
+	struct __snp_derived_key_req data;
+};
+
+struct snp_derived_key_resp {
+	/* response data, see SEV-SNP spec for the format */
+	__u8 data[64];
+};
+
 #define SNP_GUEST_REQ_IOC_TYPE	'S'
 
 /* Get SNP attestation report */
 #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
 
+/* Get a derived key from the root */
+#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.17.1

