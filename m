Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53243F2F4E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbhHTPZJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:09 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:31073
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241103AbhHTPXf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:23:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/AiLSXyno3iK9cqQHF8c+/PecacSpMZPznQ6WcIj+NCQnf3xCuLRvW5G0GiM4c7KLCNM6L3CBTcqGQT4hjeUt1ztKePLhFz+4HCAwohh1cgjyXOcIGMYhoaFoFKtGxHiQ5xN/4jZWjlTNnTeOVOJ1UstKjPimQW+MUXH8Oj4CUzN+GMkNeh+VkGBD8FkvDXB/xu80U2TTMZox74cW0rEn8ON3wTQfZC2nXGyZYROOYNkIvPhwV+yoYL/fTo0Dm2JocPdZDbvEFYboJW2N+8gWG63Qv4fh8fNnhXUMZoT+1k5ABiq7hZ1fqQ+eF+00cGO6e01R7JwKYdRpqaVaH0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plGusQaUzjlGKvtFqSkW49mMIygUqMuW79b9e59qswI=;
 b=CoiZYgDpN9qQDgtlDc5wsMGXGZrvaaoP2tJo/uP2KMaAhHSFxtGUmsRuksquFh9ORxVYYY5GkOPuhtA7Iiwwp0uGAWN+fi/jitXbhnyb/396j0xEs06ES58qogo+0APOr89SCFHIaqdo/nixyc9GjOgkEkB1kQv1mJdJ5H5NqyPkDi5W3TC6mJ56E+sSNJWSNhNy67pS1xlI+QvFcj0kP8mkg2IL+xNsM9qnFKMupZsHYBoPmFLuZYAAJzRw9oAA2f8FJBTXl49W76NItBz3p/AD/Zxr7bBXMvZga6jd5oUGGcSodgT5IrmzgrqnJoWKVcbS9xuG3AtQlLG1HJzK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plGusQaUzjlGKvtFqSkW49mMIygUqMuW79b9e59qswI=;
 b=hzPjzMe7Gikifa0DTly81Gtgodz9GjQy2uKLDr80AWVBluug3nCjbGWVGrl4AiYZrDGRwXq0aMhCV0sDoakn2LaNXbvqMqdsARqOqWlM9teOLzhbO4lymPXGKE5e4kgpH71fpRomtCWL/s59KJCgMNz1h1aH2zuCInXygMlj9a0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Fri, 20 Aug
 2021 15:22:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:22:05 +0000
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
Subject: [PATCH Part1 v5 37/38] virt: sevguest: Add support to derive key
Date:   Fri, 20 Aug 2021 10:19:32 -0500
Message-Id: <20210820151933.22401-38-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd22eaf7-e52e-4294-e935-08d963ee32c0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB263725FFBA2C25518CE5A4B2E5C19@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bd3LUbm0C5gbcmL4KHfM8x0PRHD+Poncj7JZu1NUcWyrO5xJQLISO30Ty9zl71QKBoWLPuccjdrnNkysenXCZeCp2LpstRotlPQtqk25IRrz+Nx0ANcu/sFbAodjQ2D1FsI+oNaaWQDbIYXHveIAPlyuOaWhtKSuvg/hRBFula3amM99xwrRL+GB1fbRlt3tnrw1fNDjZkEyENd9IyM6XVM97MQLr5h18ks5Ys1SAKLaOun0TZd0a77wZ1OVgOi4TzAtKLRoI5w4Y1tLjnL40jVwUHI5lD71XsMyBYAMCAMXFA6LfmFnVM7Gu8FVsXCwtA2Rrf57mpr6H4fkh8UX3NQ2sovhCd23YVTgU0RHysL7q3enWvraubh7ZEjE86MMH4B8Mw7y/QEGpApJHI9VN5UTpOSxN94xpCdHXU/HlBjz9Melgm8RM3zFA4rKA5NfK3KWgbpfKT5Jgab4rAETxlBMbwGsBcPk8LSrF960XQMvyWAsm3U495qzOAZd15iJ3rR+DYBAI5+VGqsjTEqje+HE0HH41I9swWMtZxR/tMqRD6RJbzQR0x9pNpikag+SlZ0srTQnkjJzcXO3jkW/KuneP2DssfTW3s8eTg1zKn0B3wg4+LlnmeivdWO3zR+391RZxM3tT69BOCkhBOegBjkyLNsAZuMTVKVbr8L08tEJ65wjnPN6+7yRXyAcJMDXRHsbRMILIeIU+7xVvMZkpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(956004)(8936002)(2906002)(4326008)(52116002)(8676002)(83380400001)(2616005)(26005)(86362001)(7416002)(7406005)(186003)(66476007)(44832011)(38100700002)(54906003)(5660300002)(7696005)(38350700002)(1076003)(316002)(6486002)(66946007)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saSts6K+BUVJPIo4RaUDcZxiNVrfkzcWRIoGdkfFy9a6q3WMho+uoz7IBmgD?=
 =?us-ascii?Q?xeqbEfRzgAzWT16FjKWFMwVfrirhTfdmJCx9ZvPDH/50b1oG37LCjYlqM2tt?=
 =?us-ascii?Q?CDqXW/A/NTA6+X4yFToCZ9tVyIjQL681FmzxhcsCSu7T/m+b2bQ7JuNgOHpN?=
 =?us-ascii?Q?fl065nm2bH09yna5uqoBLAXsOKrP+kBghE/cx3EO1mpL3PhkklKc/wtlJu9+?=
 =?us-ascii?Q?euCaWIYl12eiotUr94iFOkm+HmtD205vsOeL1h1tLo2wk1zE1RQGskCAuFDi?=
 =?us-ascii?Q?XomyGGKgUpFzSzniURi0xE77lvPgv3NJ6DM25cJgSdodjb6wveZZedoILLIA?=
 =?us-ascii?Q?FP4gevg4RQsrUlPGZXAAKkGq/39wmLLmtrq/TfiotZIvlHpARSahQ46DL4WX?=
 =?us-ascii?Q?yC1gdm35M6kWjWQrExZ/9mtwCh5/+nenVuXsKgMGdsiKMPOAGl27E/Au72Qf?=
 =?us-ascii?Q?p/i8ibFdTQrMnRtwh0t5uJmb2hwXycxEMZ+BqTdK3Zx2+EcqhZmQyWgCElh6?=
 =?us-ascii?Q?kbuoD+VzElpCpSKfTJobhs/qVCqIkXPmARfRTvhlJPuLCgv8Wml9PeN2HnJ/?=
 =?us-ascii?Q?eMsnx1n3bZ6bkqdeDrzIP+zK616DxIdEbtJ377Q3QH05cdmZ8ighgYsgJj30?=
 =?us-ascii?Q?iQ5ffONcWdueJddD2KS0C0yVW316JkOBEdtTV93WBALpUcp8+11G6VmMRdWa?=
 =?us-ascii?Q?UKmHPDlUvm/L4k0YCrRONDv70OhAmhoHNtc29oeaJmnd7f0umftXbJiylA8D?=
 =?us-ascii?Q?Gt8Af+usj0ZF9jfGZN9hQsitlwD4Cg4eI+rlS72eUVprTvPMkyCJfPACztkw?=
 =?us-ascii?Q?44FT9Rf0TpwtVQbCS8OdpqKEsgQnbGgBrCjTHerSnRKCVMuPc0eOJ6qgH5aO?=
 =?us-ascii?Q?Gvg2YrxnSD0B8g/FAEx7hJ3OPTzpEPPvROEwp6joXfPeEaxQaYvo23Y5fzBX?=
 =?us-ascii?Q?EeXjlhgNIUs55TSBlqMK3SagN8gA0bjj6yt30N+c3LUqxCArWOl4CifTiD7c?=
 =?us-ascii?Q?Fzu+hX/wNIoHxiDu736M7Hy4VbCmxLjb3N/56HNXhpvHITRDa9mhPrqDzbGb?=
 =?us-ascii?Q?Lq1WDFGatQvyqNtDMbsNRB76Z5CvC5LEun495tkD1/wuSvYFJS109KEF/MXs?=
 =?us-ascii?Q?OailtzOL1SEli7mZX7NUKjtUyjgMOKOv7fGktnuu55Isg0Gb35OMtEE2aUF4?=
 =?us-ascii?Q?kRAqMSLFLx4V5UxPdKonRsNo6vKF0NXFyxc8nZTuflF2yE3iGO5gQZGmUkqC?=
 =?us-ascii?Q?wi+4F0uDpCXtCWJndVg/uk5eYE0M1AkN7r50LpE0hW9MdAI9j/PYlPshTIRE?=
 =?us-ascii?Q?SeqT3altqYof3HaSGSDAN5jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd22eaf7-e52e-4294-e935-08d963ee32c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:35.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJAW8pCcWsQ2lyqobr1uXGAjvWwzVceZYhv54jV9XAl44v1R1Ive59FkZgsklzE1hgovsCu1OCA4ohFuNFIy1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
index d029a98ad088..621b1c5a9cfc 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -303,6 +303,50 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_reque
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
@@ -320,6 +364,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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

