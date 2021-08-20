Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9153F2F62
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbhHTPZ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:56 -0400
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:9212
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241239AbhHTPYk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm3SdFSuB0BIia9Zo+HvoxWPh88R0OqUeB46o0roOZnkogXDvQC/gS8PhNzk0f/ApyZ0NcM+HorcrmdPe84A/3bDybQbu6mUSvjIMxBKZLrRch1AqawYHQP3sBl5Z86LNWllXgxTTWqWd1Lme/ygWYRh9OcgbbrOrKrb9jkDq8Bjs3vh53d04Qo1Uyh9uURMp3rqmfmwkFpDh3NKW5Ip7v5g3FDqf+MPbE4g2MMgi6W9fxhc5oUzL48FNX92Px8OEWOkLvrYTocYQVaVsZu0NJh/Lgmn8m+Z/ug6pHQGs5Ytw00HmqfF2aTIhMZrbqPT61rGgQJQey/iqjxOeC1/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8bNytidg66ygsuLyodJpgFchUCYwjYh+hfQJ4427O0=;
 b=cMYlbitlaUKjDijfEm2gDwlyZ4FrjXPLkuFn7fM7UinDIJoLWsVKcI5bYF+r5dI6dxc5N6k8lHoyHzV+4TlMd8aLETOBKRWc9Uzrk5rd6Uc2a12soAtd+jaKxYOlp5uILn1UMOaLtjTsrVqLaa+st0Tm2zQnOumUzQQA3Fcl3GW3l8H03iuzts4Pznq945gJ5MASoiO0a8XN6dfPbmFAWMe+dAGBd5gDtN+2jegd5LvtHam7yVxi5Up4tJHIe6MJeTyTVad3oWow2Kt9QeMHRZfDglydCPofyQ0fpaZ/p8RCiXytupNqzYNu1udUIyV5gA7ruq7nspXxXNXEzv69Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8bNytidg66ygsuLyodJpgFchUCYwjYh+hfQJ4427O0=;
 b=BHtz2cITw+VsKZLT9NxXd0c3ju8HnAYbdvM99utJ1CEfdrJUug8HUOI4Pw7o8ZWttiEh6qqX32D2N7Rh24AgK9sCVGLiGVOQIFfXggUD0tHF0/hUgYHc0Ya2Bh5Y1SH6+zHvT04UaTFsP37fgK9OduhO2N1WoveDypKKtNiZAvI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Fri, 20 Aug
 2021 15:22:06 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:22:06 +0000
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
Subject: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get extended report
Date:   Fri, 20 Aug 2021 10:19:33 -0500
Message-Id: <20210820151933.22401-39-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91afe76-ab18-4ede-7c78-08d963ee337c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26374882BD326DE04E651D57E5C19@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGGZ3vlvg+i/10SgdFxDdStXJUrURTu1o7/KFOkEtQbUrpHL1IX9yXTrcSjXVUL8go1BOuauvGpPsoMhiUETpqZoovofzEaMa0d0I74zToHo27r/onP/dXLa1GJkbryq+UBf/n3gOxApZO/CIzvxf46e7hW7ZK9RYgxmUNj+bPf4AuCD11mE/vBRrTXbTFkmOaI1NAdQjvjQ0fvZWr57nc/RClziYHPUDri9H3sVwtkwvwiSa+rz2tLexWpcAudbogOnPzANYSjSaKumVOs6YZmV3Y5rJlvC0DAM6vMTewrl/j5wy0BkYoH/yX2o+gkUPirVFwuqf8imupX6ZTyMVkmN5CS24Zy9X5gelYS6K44FkQOADu3nTLlO8oCGRSEFdfn/vF3PGRQPpQx1Za1q8N5WYgiKczwjc373ggXqIwuAEmMnw1Bxljv/C+ne5frZr0JTjFOEyeT1UNaSFsTy/b4hVyRMotUaNYv0ZUir1xupuC+hIkLWSDwQ2V/Yn7977hHiSvsTOMAP3o9UeCxfflxFPLDgkiw7tbE5WGDikWJZaofUBG8zMvNA0LaWcukNlocPaodFd9Vmp96d91iU/1+5929QZxfZFMfl7nxi8cM5kIUBLGlkhcl8wW6KehwQnA/1Lgta+QLhDc8IJykGQgsOqqIzgb0wESx7mLIzSP+ERdvyVxo2sc59eEs8u8bOTIcvz0YmPAXGhsYoNksFrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(956004)(8936002)(2906002)(4326008)(52116002)(8676002)(83380400001)(2616005)(26005)(86362001)(7416002)(7406005)(186003)(66476007)(44832011)(38100700002)(54906003)(5660300002)(7696005)(38350700002)(1076003)(316002)(6486002)(66946007)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gGL04gisLp4HugJHzDUddOnI7IDoyfG/+4+Du7ga190m0NrSl0ZsS8Qrxqc?=
 =?us-ascii?Q?RdLXLVzMsNZcCqAcWxdHAwDoVvN6JvTJcFMwiwebhkF4K4gnm9CTKN1GBi56?=
 =?us-ascii?Q?7Y4Yzw6YHwe0TMwx8LM3xP48xXl+CAY892TD6BPD+/Zb3WGvSSou2Cw9Pc+d?=
 =?us-ascii?Q?NpFgl0P16Z6/SfJouwzMmV+S1IbqpZhPk9IkaUBmZTzZoFgoOM1OnyibDtWv?=
 =?us-ascii?Q?gNcwIG0pF3FCdaVEj6FgBjb+rZ4Wuk4xvsS715yyjPIw2VELlwtqh1xvw7TE?=
 =?us-ascii?Q?wv/dZKQVXZ8GFokb2ESMObUU+ioodOQWpDvFS0cgv76wP7L1JuK/AtQ4IpfR?=
 =?us-ascii?Q?zATveoduA35/MmuL15mCSUxGgTWGTL1YhE8GybOCZS0iERjCoZLXKgAiMSDc?=
 =?us-ascii?Q?UyfqyCa5k0s9iHbB0HchExrW8L7fI8YS/v/zKbi9UR2Q2NbmRtbQ+QDwXyoS?=
 =?us-ascii?Q?3KLdqjrMZf9FdsQV/YCmyW5y64C04hTGJ0lykdQmE4T5LjGX+9Bot+x0KtA2?=
 =?us-ascii?Q?/gkruBA/Kih3qKIqInFdoQt9ift/EHYeGuoSSj/wMZ/+fHXWfKQwt5Hx0CKS?=
 =?us-ascii?Q?MDUOQjv8R3TYlPuJ4GMZuaVKwEu+nZuzBYupyGg1nkaKgXyD2dglKByQcsky?=
 =?us-ascii?Q?qgiJOFpAVApYUqY5fstUPLizRjJhwj3Upaj7+wntypjI6dTXvi8yxwcqZOf3?=
 =?us-ascii?Q?n6EutfEbKlUWChn3CW9EJ9/ufa/qoLcpYO9q8FPBmeNi0/sR1GgD+7hKcdUA?=
 =?us-ascii?Q?McTFfGf6hPX6qWMW48CgmZuC8iKcPeSJ7gU3ky8mUkRjlherzi/rGUSkpeB7?=
 =?us-ascii?Q?VdqtEC0kGliGZpqTW0xu0RUWRn7AVVg1SIoePN71AmEjCb29p3hPIsijKkDp?=
 =?us-ascii?Q?Elf0+2BjaVVKeC99wuGa7vsaGPBfRCz6FeAW0i2GSkFXL7Kg9Bsc+Hvo1EPX?=
 =?us-ascii?Q?9CVrTJ/jp0mtKOZrMTWtLIv2WueJ4O51ywoZtuW4tjvgpqWuS8Dwj0q7ytuL?=
 =?us-ascii?Q?foYuqexTm/US83MtlJXuI6q5jgdpGpoWpS8j5TwDzxwY0XjEJJHxulDoXdW4?=
 =?us-ascii?Q?45Ahb3YHR47Fw3J9tKCpn7XGUo7NHXPKWNSnycO23RcfDBrPtUvNh/J4odIj?=
 =?us-ascii?Q?eeS7SpnnpIZz7qbJ5eCXXIVL24D2LLi6tM7DZsIfRUGxR3Eu9jNhmbP8lUT5?=
 =?us-ascii?Q?r/bdkf7yMKMFAISv+dCtLsfmxiy+fkpUuW1Pha5r50PRxZvAAWdjnGqT3z80?=
 =?us-ascii?Q?/U1rfZ3v9Stc8uikEw6wd+7OxyQT33rSn+3yd/byBdbpv89nupGmY+nIDgRl?=
 =?us-ascii?Q?q8FfBgHnzHbanQUFc0UYlddG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91afe76-ab18-4ede-7c78-08d963ee337c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:36.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgs+b+DV9Ep+4tJra2062V9JnqOfJnE6C4cgunH5Cvyatqt0A2l0+rb4i0Qsb8soZX9w45D2a4iaeElWUFGeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
index 621b1c5a9cfc..d978eb432c4c 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -39,6 +39,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 };
@@ -347,6 +348,117 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_
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
+		if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
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
+			 req.certs_len)) {
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
@@ -368,6 +480,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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
@@ -453,6 +569,12 @@ static int __init snp_guest_probe(struct platform_device *pdev)
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
@@ -460,6 +582,9 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 
 	return misc_register(misc);
 
+e_free_resp:
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+
 e_free_req:
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 
@@ -475,6 +600,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 
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

