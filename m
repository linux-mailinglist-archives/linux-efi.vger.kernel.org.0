Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515094704AC
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhLJPtp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:45 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:54304
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243404AbhLJPsc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR1mwqENXeBy/G05gx3KdMSBqWInNRg8+9Hr9uGLpAU2ekk+0LSR455Tl/DPnBEg7JG8pRXFmMtmaL4banNhIrDgUTs1JtLct5WZNjxdmbvFQbKIxq1Znr0GR5zTpdWbrz7nvCOHp+DIDTD5EoaAsRv/1vJNW6ewJ00Yyyyh4I85UrjxX6ONPhQmLdOQU0XP0k7FF8X0RlJYYJU9fW9H2GdEU7VzOxspJobIzb0bFJofj4WBYmq7uogBAOJKjGHxC2CqhXlKM0BuoF6Q4W7gGQCPSnC9m0R1guy2+gfQsmHE57EDK48RiOyVlWCy7qAwlrr/BLdWfmgVsWRCE35q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wTSvT9TDHMsUoCuOgmeZlasbJT89D9btICoWEjd3E0=;
 b=ix2ih9yC/NWl0vBQEAbpBvBbRzy/ztiSutvk9NcPIApQRIfuWPp8zZG4W+hm7RD1TublDq98XKKbQJwiw8+9dNFMe3GRasblvwuyLZhybQjgOl71NEffbpf7Fjk7We9bvpFqXQPvSlcqP4x9mw0I0AcoOOJLBLhvNyEY+7q1hl0zONtJbP0pI9333eu7hDsps0O8jSd6jd/wp/1+WTguoV8RTM/Gei1oL43nJ1AfZtXJDVURSePa/A0jTVnXnqQMB3BBVm3PHwKy4mINTjr+AUz6LCQqsqymw6QwefKzbyY9rXs2jKCp5A3SCAz2rHMWK+BCHjqSIRDrTzjFFwjMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wTSvT9TDHMsUoCuOgmeZlasbJT89D9btICoWEjd3E0=;
 b=m6kLyXAHi4pO18Tf8Sp+8RLiv8bsZmQmfDwvly09ztlsrZRF6lBU7UTxA5tJXoYfmlYGqxenH7PxqNvvsElsa2wHWzrk8dB5IrLYnt9KAbOHNpP+XIkR4xq7R63430GTee9unpb8mDNfZ7QVHf0t/J5+7GVWkPwS0TRGEYEQ8/Y=
Received: from BN6PR14CA0011.namprd14.prod.outlook.com (2603:10b6:404:79::21)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 15:44:54 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::1f) by BN6PR14CA0011.outlook.office365.com
 (2603:10b6:404:79::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:54 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:51 -0600
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v8 40/40] virt: sevguest: Add support to get extended report
Date:   Fri, 10 Dec 2021 09:43:32 -0600
Message-ID: <20211210154332.11526-41-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00a702d3-39e1-4349-1a06-08d9bbf402aa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1729:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1729EDBCFEFC565764E57AF6E5719@BN6PR12MB1729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m0ghY6fwm+VRvYk2MejYdtiwuR5Zd08FI6Ff3tWWIg8yLwKSRouvqSFBr2BFaOdp6Cc0kR18Q3OLKEe0J/kf8py8p/09D4DCUd6yzHIeTX5+ZlClDpvWmw7eNbRtr2OSbjBm83TMyBakfYbjkxbyKQbQJhrK2GYV2ENdbV7PNgqyEUfTeyckCo4ln5rzTSZS3mouYgJdSVQkCABC7Qfr0Q3itoGXhUocs4TYQBXihE5eo36CzALTx+mLs1SRZKJmzEjMov6DGRCNRk/U9tDe+8QQTj3fqxa6D2DMNsyTZm43AJcPbZylkX0cyuM73VAHI/NTrkQ0WLAwlwdoOzO1ob8gZmRKztV9jxaz0IwknOLHfcRi8P7Wc1wN7c/R7OtA8TuxLEGxbY0qyKvuWpAHKir0BaMw80oc7cQ8xqdCeFEqG4sIHd1raENrcJrkztD78+19cOztvgrYcmbAzym/4Gvc+/SZVYhs0ZHOy+6890uKmCuYWXofX8bpJDo7VSk8CknCBO3lDu3GGzSTg1zYwBb6YW0J8Bk0cJXB1D8sFdeMPK4U+M++Q4SJYYtg10agc/AXbKPWUav04Mfb43knts61RFmiEpuxa0at0CM2Qz3P+WTHZLZo7fVUHO68GnUKonUhItGNwIwCfqy5h5it+xrPWHLDmbx1CaNQJmRk42l5fJUhS5UVh+wYB3a2IGcObKC77YCo3YPDip6hisUqmeJ6D4RC+6TMD9pW57Dv7Ks5ZmEpRqbSxCUxpSvS3ZiMAbSS+gxt6nuG4AhljdjMEUCLVTUyukWx/2ZcXl7jgJGUavT0+Gxd9uAWa1UbwDc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(336012)(54906003)(1076003)(6666004)(110136005)(508600001)(7696005)(5660300002)(40460700001)(36756003)(82310400004)(2906002)(16526019)(186003)(70586007)(356005)(70206006)(8936002)(7416002)(7406005)(8676002)(83380400001)(47076005)(86362001)(2616005)(44832011)(36860700001)(426003)(81166007)(4326008)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:54.0283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a702d3-39e1-4349-1a06-08d9bbf402aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
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
 drivers/virt/coco/sevguest/sevguest.c | 89 +++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        | 13 ++++
 3 files changed, 125 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 8c22d514d44f..515af0d71469 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -90,6 +90,29 @@ on the various fields passed in the key derivation request.
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
index d8dcafc32e11..f86fa13b8e5b 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -41,6 +41,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -433,6 +434,84 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req;
+	struct snp_report_resp *resp;
+	int ret, npages = 0, resp_len;
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from userspace */
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
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
+		 * the host. If host does not supply any certs in it, then copy
+		 * zeros to indicate that certificate data was not provided.
+		 */
+		memset(snp_dev->certs_data, 0, req.certs_len);
+
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
+	snp_dev->input.data_npages = npages;
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+				   SNP_MSG_REPORT_REQ, &req.data.user_data,
+				   sizeof(req.data.user_data), resp->data, resp_len, &arg->fw_err);
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
+	/* Copy the certificate data blob to userspace */
+	if (req.certs_address && req.certs_len &&
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
@@ -465,6 +544,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -593,6 +675,10 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!snp_dev->response)
 		goto e_fail;
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_fail;
+
 	ret = -EIO;
 	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
 	if (!snp_dev->crypto)
@@ -606,6 +692,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
@@ -616,6 +703,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 
 e_fail:
 	iounmap(layout);
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 
@@ -628,6 +716,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index ce595539e00c..43127aa18026 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -53,6 +53,16 @@ struct snp_guest_request_ioctl {
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
@@ -61,4 +71,7 @@ struct snp_guest_request_ioctl {
 /* Get a derived key from the root */
 #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
 
+/* Get SNP extended report as defined in the GHCB specification version 2. */
+#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

