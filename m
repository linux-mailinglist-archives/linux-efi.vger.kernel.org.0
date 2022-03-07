Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCF4D09EB
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbiCGVj4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbiCGVh6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602788B18;
        Mon,  7 Mar 2022 13:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtzjC2wyTtaNB9FhcNvkDSLSGnAxRhKccxuaHtOGrPhl6YVpi3e/Ir/ccd80lDL4w+sY6r7OrTqUhsI2Izb/B21x5QumftDtEwci/D/CM+KkrH6L0xILQxjhSaflRq87+//Mj7pBlvntBZGIISL6CbNiVtIsZYhaJduhVyGi3oWOG7h/R8l+HQOSP16WfAdKZQzpP7XAkGRsGVfHRW3Ainrf2WSkCD4iCHQT5DjchEC+6xUAUIP/icHiQptgSUIBrNV7E4mXGyeJ55CLzaYrGaCw1rKs6SJi+VS4bfx2Pfv6Q+6k05hVjnOreMPVROX3VBwA+SIg04/YvNGi2iBFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYxfstPTSsEOx+mF2pGXmEFnesDYi1WhqBk/pwyDyfI=;
 b=GREmTnbfqxF3oe3DTHNvgJlpG3oZCpyfYwvumcfp1ZRnJx9I0X5oohc84pKZudPhdd2q66etTCZTva1NNE3Y6EWXBw6vC487/8+eGjdNx2ceBDpplW0V62+HmwqF2NVOVlzAO5hS7udkskXW+EjBLB74rjTTdeBEJoP+PV/EKs/jLWLQSXI/CzJ5C6mQggCd2KDxlMu0a8H0nojdi/9J3As7awb2I9/hNSCDT0goPokDFRqRUdmVhGusT7PvNwZxFL5iyJCPXvlwPQ4aTOaemQ2yK6dyrzMsZw6yCqIW7tuNnlxPSk+4frkpF3cqA51nKM7w5y9TeGHaMFrTCPSYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYxfstPTSsEOx+mF2pGXmEFnesDYi1WhqBk/pwyDyfI=;
 b=rsGS6S1159cbK/D76stOATDBUtdt+22Vns0qaJ9Kdt0drSMzt49M7tCvKHe76mhO7kXTvv2EhGPAopjp15ZRBPRpKo0h+dltmPtl7A1Ih/nKHG3ne9EnyMrMXczWjM6L1gpcfw4xQT1pJwBSxi01d9hT5MtLuP6OtEP/GQUyMoc=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:39 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::a9) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:36 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 45/46] virt: sevguest: Add support to get extended report
Date:   Mon, 7 Mar 2022 15:33:55 -0600
Message-ID: <20220307213356.2797205-46-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a6cd74-910a-4112-2c0a-08da00826c75
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192CB150D7C7DFE6ACB42C2E5089@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5l6Z29VvsvMVpoYokG0D4peDJUNGyeY/ZSjITRsAkvtf9CcXv8laEDjTdAlBmwUKs7VcPNcnsTO2cQj06KnA1NxzCpdVAdaxOdrmzy42Co2o21at6Q6jyvStMMYZ6eX1JGM9duXYGVNDVqr9qFyZN3PpQD7sXZSXfcyItbi12AEQxQJXSZN+/JmfzYviLQMo9KkRWyXDOzlZ23wpP1IE6jpe7DjJ0c2lY7k6iuLWEJjM4bW/igXC5bcSiSf8RSQ9AiQMZfLdlO5UEsGv2+SUyz6naoE2FPw1uW/sDq4SWXy4MD2fAo+0EFUekug1gxr9tCJxOCaNSW/wqZcuPWwgBNmK8bTrCJ53+fKExZOCZMWHPqE2fCO+62NAWT6xIxC6BArwjVkCUClcV/NJidt1zPwNUilfoMb9bONBYjr9tyiAQdG4l4sCL/rElLMaAapcMG466Jwv/WTLonTxoG0vd5Nz9ehkAi1FhDBb6Hbkfo6qYQPMEl6HOuMFSKKNsCzHHY6XAkiktYa0X/hanXK3WDU07WyjPdOwSP2W+2c1t92HiWFSFW98qC0zLIhB+BP+xx0oUd8JzI0iubExeEolM2hSuQsVi22ZBjvvwBHjIirVofgDqBnDFUmXYrDiwmu4zt+GWqYrM/mCc6qt4lZgU+/f68eH3ynf/ZDcNkQ+2d4HC+XgcP5YAnKonLjRpg6Ft4FvARH4ZlrB8F6Q8iBOIumlr5ZAXakTAjOs/9X1/Pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(2906002)(40460700003)(86362001)(186003)(16526019)(426003)(336012)(8676002)(83380400001)(7696005)(47076005)(70586007)(70206006)(1076003)(316002)(36756003)(54906003)(8936002)(2616005)(508600001)(110136005)(26005)(36860700001)(6666004)(356005)(81166007)(82310400004)(5660300002)(7416002)(7406005)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:39.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a6cd74-910a-4112-2c0a-08da00826c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification defines Non-Automatic-Exit(NAE) to get
the extended guest report. It is similar to the SNP_GET_REPORT ioctl.
The main difference is related to the additional data that will be
returned. The additional data returned is a certificate blob that can
be used by the SNP guest user. The certificate blob layout is defined
in the GHCB specification. The driver simply treats the blob as a opaque
data and copies it to userspace.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst  | 23 +++++++
 drivers/virt/coco/sevguest/sevguest.c | 92 ++++++++++++++++++++++++++-
 include/uapi/linux/sev-guest.h        | 13 ++++
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index ae2e76f59435..0f352056572d 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -95,6 +95,29 @@ on the various fields passed in the key derivation request.
 On success, the snp_derived_key_resp.data contains the derived key value. See
 the SEV-SNP specification for further details.
 
+
+2.3 SNP_GET_EXT_REPORT
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
+On success, the snp_ext_report_resp.data will contain the attestation report
+and snp_ext_report_req.certs_address will contain the certificate blob. If the
+length of the blob is smaller than expected then snp_ext_report_req.certs_len will
+be updated with the expected value.
+
+See GHCB specification for further detail on how to parse the certificate blob.
+
 Reference
 ---------
 
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 9057e8a661f6..112c0458cbda 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -43,6 +43,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -433,6 +434,82 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req;
+	struct snp_report_resp *resp;
+	int ret, npages = 0, resp_len;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	/* userspace does not want certificate data */
+	if (!req.certs_len || !req.certs_address)
+		goto cmd;
+
+	if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
+	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!access_ok(req.certs_address, req.certs_len))
+		return -EFAULT;
+
+	/*
+	 * Initialize the intermediate buffer with all zeros. This buffer
+	 * is used in the guest request message to get the certs blob from
+	 * the host. If host does not supply any certs in it, then copy
+	 * zeros to indicate that certificate data was not provided.
+	 */
+	memset(snp_dev->certs_data, 0, req.certs_len);
+	npages = req.certs_len >> PAGE_SHIFT;
+cmd:
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
+	snp_dev->input.data_npages = npages;
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+				   SNP_MSG_REPORT_REQ, &req.data,
+				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+
+	/* If certs length is invalid then copy the returned length */
+	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+
+		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+			ret = -EFAULT;
+	}
+
+	if (ret)
+		goto e_free;
+
+	if (npages &&
+	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
+			 req.certs_len)) {
+		ret = -EFAULT;
+		goto e_free;
+	}
+
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
@@ -465,6 +542,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -595,10 +675,14 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!snp_dev->response)
 		goto e_free_request;
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_free_response;
+
 	ret = -EIO;
 	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
 	if (!snp_dev->crypto)
-		goto e_free_response;
+		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
 	misc->minor = MISC_DYNAMIC_MINOR;
@@ -608,14 +692,17 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
-		goto e_free_response;
+		goto e_free_cert_data;
 
 	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
+e_free_cert_data:
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 e_free_request:
@@ -629,6 +716,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	deinit_crypto(snp_dev->crypto);
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 598367f12064..256aaeff7e65 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -56,6 +56,16 @@ struct snp_guest_request_ioctl {
 	__u64 fw_err;
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
@@ -64,4 +74,7 @@ struct snp_guest_request_ioctl {
 /* Get a derived key from the root */
 #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
 
+/* Get SNP extended report as defined in the GHCB specification version 2. */
+#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

