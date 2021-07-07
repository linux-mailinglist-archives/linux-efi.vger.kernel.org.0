Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162A23BEE6E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGGSU7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:59 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:54561
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231545AbhGGSUK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8TzpyaouPdKmfY4VaTGBurktzTrtruY+K6Oxb0UUl8DBSckD7mAQkCeUILEOd/G0SRnk/k1D544eEKr5Q+CAfAjMj0LJggCKLrA0wRno2HvJjO6/bgBa2OAe2W02JrGnLiU7Ps7IOJp5k2B4eQuMLgBOx3ciJszTaGtLzA3x3CAEhHOUq8dIVr1dIpE5qkCGOMqrFcJSKZ/0RgyuGAPv7CDzH/paB8qQggayUJlHE08Z8KG9i0f55g5MqwIMb93SCoQBPWy33rLID59atfuluk/aYgzi70YqbrSJBEFXrf861LuDLSb83rxQ4q+H7WjG1FMOaIRLiDhYb9FATUolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akna8e/oCRqjIlvjGoOzsD7jYm3bBYT+NhbNWSHJbQo=;
 b=Igwmvv2Q6K58RFbMT0LjyhI9d7gNQzlNVpM8VQyNvmpvI881IzbfxbcDhpR22LaRzGtwXlHlyK8FJaWBcjYc8v4BNl4EZ/y9i0pdEw+eWiw3eC0oNZ9vXQLLYsaUzTH8KYXsBvTwwDO2HRNWEwRa9ryqU0KTMa4nsq5XAJakNsCQymt1CDMRtzb5JH1HhKzXYf0kzfzia0X0bRA/IwsTSvBOZI0Ja1e01BhCnASxOGGFZn2j3CElQG7nf+2m/FNd3gviglwxWbbww2UNtXere2cTLgMeswXwTLzdS+rn85AkYFXKTg6ZXYk3X7weCpTkDeu18nHvHwM9awV3rTR1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akna8e/oCRqjIlvjGoOzsD7jYm3bBYT+NhbNWSHJbQo=;
 b=Eci1ks7z2w9BpaT4R2a5FOBov0w65TWdJqk101eafs4O2OAV+0/DQzLfhs7rKJa/0WhQeDVoAUZSBdSh7SKpVpfg/kbfQAcFM9nAO1QAjqatrcOKdPRj6ABKVqfyUIGYQfDg5FVf2Qi8o7o3oP6QxLNHqCPHsEA/xT4vTtV+iK8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:17:01 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:17:01 +0000
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
Subject: [PATCH Part1 RFC v4 36/36] virt: sevguest: Add support to get extended report
Date:   Wed,  7 Jul 2021 13:15:06 -0500
Message-Id: <20210707181506.30489-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199754e2-b797-4682-7f0e-08d941736a2d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3527B62B3D51DE809F560A80E51A9@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkljqQRdAT3v23NkVkwyjzkSx3nz1AgPCfCE1bYp7iu/ZrjPiL3/BkxbavP5ZJR3vVKYoNbIxSPUAD6D0vwm18u+lk4Bi9hfCFUx7+PwmrP7d8QuP5WmZ5iu3/pkiUK9OILKn9+XlG+5DnS9ukdrp9MPQxgoHeL5jCjZIjXE/zbPyUabh3s81vXvclqyi3f+KnWEKBINfWWosKyU2tRmwf/NJmgSBbyWVURYK1DiMKiUj39zO/aDk0g4X6bnr9bAHiUj7xlVJwgNyikSxpVW0g4/ZSgYPg+OfC1kzjj1ApBkaRi5AR7A/H6WQWh5xZnGIKceSpXuetGSBuN16TxB/o0cxk1dV4WDCGdFeH14hIqToT3V/Am4YXq2gshV9j/XPxJX0R2hiNO2tVo7KuWEkG2iqW1a9iM/nyfenHqieCreb7a5X6zQK7MtO0krRcoAC6ALbyLguZYaTHyV6VdhFiaCzYngaC+GYnQnT57DFIKa9FbKReIJskeiV1rnV+Q2xr/Qu368YQVLEFPiTPDE6gGf80lv0xdN5ZmQIDpjF8CgN2BfRCbQwUsSKRrYF3aUij4IicfJCbyT0bGmuqaYWJQzRhu3g2p2iRIAseBVFyjqbozOKgmUweE5XIz4fBEqelCyyMHVHVe4E3gEDpA98v0ri1iNhk4Z5bu39z//hetraYq4ECFnvO9h+c+CKbpWfqfh4GHN/d8gbS8sENQzOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2616005)(5660300002)(498600001)(44832011)(6486002)(1076003)(66946007)(66556008)(83380400001)(86362001)(186003)(956004)(66476007)(8936002)(8676002)(52116002)(36756003)(54906003)(2906002)(7696005)(38100700002)(38350700002)(4326008)(6666004)(7406005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYpfv6Siey88z3oNh9g4LboVPnlbDUYLRlA/JjIm1v+HSMr4g7H+zvlrbleR?=
 =?us-ascii?Q?1VWWdYZdCGw0Erossxbu07/G+UZ/jhNZaK/lSvtxqs6CuAldsa84pJdnltr9?=
 =?us-ascii?Q?dFQUC9rDrFv/i4zOlhMimJk62s5Dp1PXL1OAn1mn5kzcIZrpRYEXNZWMLul9?=
 =?us-ascii?Q?3UIQ9SvDx0ddmFRXxkwDS8LxQrGMDUOl8dfbbaqYQroSe7gw9mZHbyIx9hJ/?=
 =?us-ascii?Q?zysvyQJOYJyIEA1yPRF6DCn/+ZSSmgZbpLoUYmOzjfj8HqbXke9vuci9CV2A?=
 =?us-ascii?Q?ewe8o05CqiBzPOGN4jSjeKqGvBdn0ghhaATcqhKdeGAM2TlhYDzou7lQns5u?=
 =?us-ascii?Q?X7HiRe8u3myyMf4a3EWg6u20TsVpJw8iWRi7niPDLjkIqbPmlyY/Ahwz196i?=
 =?us-ascii?Q?OVsjiZSi80uf9Fs31+CDkIWHKxBc985zfraGE6nPBxiHnDWg7Y3dLiyKgRTv?=
 =?us-ascii?Q?g5w9heSZ/qd7Mm7wN8ImU/R1ghpAFePAxtwckgSfuZdB2nmXJsBpxwwdhNit?=
 =?us-ascii?Q?qlfGLvY8CpRb5x9YpI+mcYAT5LTfRcQjKPktXT3qZiBOpV0KQj0IzKrSqn2H?=
 =?us-ascii?Q?rJmzNMwtWYxvXDLg7LetwAbDHLcjZbzCxwmZwyPwj0XaTrru4q6LOq3xBJLr?=
 =?us-ascii?Q?0cvrhw8PipKCKLywWlrcJo/N6kHP6LLnEypOlZmxCmOEqLGQeOIMQsZJHBpw?=
 =?us-ascii?Q?pCAfeLDNNi1xSTN5SEY8Fz1SYRDCX1G0fX2m+Jw7WLVvPXhSYLk8o0TA/Hkf?=
 =?us-ascii?Q?QpEcnJwqI5BJfqVuiszmgVKOZ57E9gIB2nsOJatJxbd7VXE87ed8ag8bQoNd?=
 =?us-ascii?Q?gpOZe6EznrxivR21hcRTofYL7ptaJiHdMqOkw/6pDaQ/2KcCG8bw+tQxpNnv?=
 =?us-ascii?Q?y8NXbuks9d8PX2I254sFC08zFP5KvgyfC2g2BSayQIbhHnpH+W7Zo5Vjb2kk?=
 =?us-ascii?Q?KaAJiUpAoXMrcGSKtDt20xTwHMHnP9WWQmFEo5MF4eCLp6dbjmeJsc/pYBAK?=
 =?us-ascii?Q?88i/KVOnkZ7D+VjDn3UW6xKZn26M9C1E0urct+BVLZp6bgEk1FjMjQmiOd4Q?=
 =?us-ascii?Q?8/87dCaEmBLsioPCpc7rYieyKfW9IYcONcVeLB8blGDhmaSeIQ/yiqHEx8fe?=
 =?us-ascii?Q?L/hlC2sleGoC7ApRSGlNj9NPBIsdeMFHto0VApTXo6VnxV0GFjbuNdVL/xZm?=
 =?us-ascii?Q?hmsAXxKBHE0Bpow4tQaJ9+8UcUcEFrPH0DV7bgKIYMM3PverWYiB2WzqCroZ?=
 =?us-ascii?Q?W2QNR6izgtKOZzzAbHeSTUoHjqaiQysAZmLYDN6GuvNXZdicUgskj/7X0RQ0?=
 =?us-ascii?Q?J6nt1TCB0XQyX294ui8bZx2F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199754e2-b797-4682-7f0e-08d941736a2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:17:01.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btnfMS+ieb3RxGDHMvTFPMEenVQBlehu8x2WbytMGF5hAUcsuJMBvQGnkY735uu8Q7be+uyDQD5jQp/ZESusvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification defines NAE to get the extended guest
request. It is similar to the SNP_GET_REPORT ioctl. The main difference
is related to the additional data that be returned. The additional
data returned is a certificate blob that can be used by the SNP guest
user. The certificate blob layout is defined in the GHCB specification.
The driver simply treats the blob as a opaque data and copies it to
userspace.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst  |  22 +++++
 drivers/virt/coco/sevguest/sevguest.c | 126 ++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        |  13 +++
 3 files changed, 161 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 25446670d816..7acb8696fca4 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -85,3 +85,25 @@ on the various fileds passed in the key derivation request.
 
 On success, the snp_derived_key_resp.data will contains the derived key
 value.
+
+2.2 SNP_GET_EXT_REPORT
+----------------------
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in/out): struct snp_ext_report_req
+:Returns (out): struct snp_report_resp on success, -negative on error
+
+The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
+related to the additional certificate data that is returned with the report.
+The certificate data returned is being provided by the hypervisor through the
+SNP_SET_EXT_CONFIG.
+
+The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
+firmware to get the attestation report.
+
+On success, the snp_ext_report_resp.data will contains the attestation report
+and snp_ext_report_req.certs_address will contains the certificate blob. If the
+length of the blob is lesser than expected then snp_ext_report_req.certs_len will
+be updated with the expected value.
+
+See GHCB specification for further detail on how to parse the certificate blob.
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 2f20db80490a..d39667a62002 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -39,6 +39,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 };
@@ -348,6 +349,117 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_request_data input = {};
+	struct snp_ext_report_req req;
+	int ret, npages = 0, resp_len;
+	struct snp_report_resp *resp;
+	struct snp_report_req *rreq;
+	unsigned long fw_err = 0;
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from the userspace */
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	rreq = &req.data;
+
+	/* Message version must be non-zero */
+	if (!rreq->msg_version)
+		return -EINVAL;
+
+	if (req.certs_len) {
+		if ((req.certs_len > SEV_FW_BLOB_MAX_SIZE) ||
+		    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
+			return -EINVAL;
+	}
+
+	if (req.certs_address && req.certs_len) {
+		if (!access_ok(req.certs_address, req.certs_len))
+			return -EFAULT;
+
+		/*
+		 * Initialize the intermediate buffer with all zero's. This buffer
+		 * is used in the guest request message to get the certs blob from
+		 * the host. If host does not supply any certs in it, then we copy
+		 * zeros to indicate that certificate data was not provided.
+		 */
+		memset(snp_dev->certs_data, 0, req.certs_len);
+
+		input.data_gpa = __pa(snp_dev->certs_data);
+		npages = req.certs_len >> PAGE_SHIFT;
+	}
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
+	if (copy_from_user(resp, (void __user *)arg->resp_data, sizeof(*resp))) {
+		ret = -EFAULT;
+		goto e_free;
+	}
+
+	/* Encrypt the userspace provided payload */
+	ret = enc_payload(snp_dev, rreq->msg_version, SNP_MSG_REPORT_REQ,
+			  &rreq->user_data, sizeof(rreq->user_data));
+	if (ret)
+		goto e_free;
+
+	/* Call firmware to process the request */
+	input.req_gpa = __pa(snp_dev->request);
+	input.resp_gpa = __pa(snp_dev->response);
+	input.data_npages = npages;
+	memset(snp_dev->response, 0, sizeof(*snp_dev->response));
+	ret = snp_issue_guest_request(EXT_GUEST_REQUEST, &input, &fw_err);
+
+	/* Popogate any firmware error to the userspace */
+	arg->fw_err = fw_err;
+
+	/* If certs length is invalid then copy the returned length */
+	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+		req.certs_len = input.data_npages << PAGE_SHIFT;
+
+		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+			ret = -EFAULT;
+
+		goto e_free;
+	}
+
+	if (ret)
+		goto e_free;
+
+	/* Decrypt the response payload */
+	ret = verify_and_dec_payload(snp_dev, resp->data, resp_len);
+	if (ret)
+		goto e_free;
+
+	/* Copy the certificate data blob to userspace */
+	if (req.certs_address &&
+	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
+		    req.certs_len)) {
+		ret = -EFAULT;
+		goto e_free;
+	}
+
+	/* Copy the response payload to userspace */
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		ret = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return ret;
+}
+
 static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
@@ -369,6 +481,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		ret = get_derived_key(snp_dev, &input);
 		break;
 	}
+	case SNP_GET_EXT_REPORT: {
+		ret = get_ext_report(snp_dev, &input);
+		break;
+	}
 	default:
 		break;
 	}
@@ -454,6 +570,12 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 		goto e_free_req;
 	}
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (IS_ERR(snp_dev->certs_data)) {
+		ret = PTR_ERR(snp_dev->certs_data);
+		goto e_free_resp;
+	}
+
 	misc = &snp_dev->misc;
 	misc->minor = MISC_DYNAMIC_MINOR;
 	misc->name = DEVICE_NAME;
@@ -461,6 +583,9 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 
 	return misc_register(misc);
 
+e_free_resp:
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+
 e_free_req:
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 
@@ -476,6 +601,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 621a9167df7a..23659215fcfb 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -57,6 +57,16 @@ struct snp_derived_key_resp {
 	__u8 data[64];
 };
 
+struct snp_ext_report_req {
+	struct snp_report_req data;
+
+	/* where to copy the certificate blob */
+	__u64 certs_address;
+
+	/* length of the certificate blob */
+	__u32 certs_len;
+};
+
 #define SNP_GUEST_REQ_IOC_TYPE	'S'
 
 /* Get SNP attestation report */
@@ -65,4 +75,7 @@ struct snp_derived_key_resp {
 /* Get a derived key from the root */
 #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
 
+/* Get SNP extended report as defined in the GHCB specification version 2. */
+#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_user_guest_request)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.17.1

