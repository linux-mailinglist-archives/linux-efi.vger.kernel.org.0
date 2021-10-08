Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD4427075
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhJHSKE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:10:04 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:13281
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243027AbhJHSIY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8UzFQBod5StB/MkyLVZrXu1NSPs3B+r1dqHtsnwrX41kFfbDsUEOYHQTpJiahplde1UFPkk/J1U3gewqPEwrjuMME97SSildkv36wGTuYXCU7tkufxEaiMaOMEp8Y5vzLeo7iB7ADjRPlYzirPiQ9HAsV7GeOxOdwxVpSNFrgzeMMdO/cPVtSe4nbb3Gct9fmdJY6dxNjB8gmvOMguRqrqflIJBv8nuhNmDcWNMvI7/J4Hlk4VsYq5vRxM3eK8J7D3WvpC2G604qKG5ljaeX7ncRdq2+m1OGxjtB2PGiNYPT9VWLyAIx8HY+0Er09TK3oYW04WPERAsIFTorzH3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4sgq9NrGeSNkfW3L9jhNQrk+zE0hqadrYAN0hqPn80=;
 b=f8ucgxtIncNXJeeM4SkC8rpU+eLMQPvgwkO3SspfsYUgtmx1L0nvIZTXGtQdwPW31SsjkNmbcuDOMzB6JxOCGqrZVMxUi8GHwPXuZhDhU45zxZoY/JIPzppTqXscEvbF/jFaTF56EfsfSybkoyk72nFAlbJKanJfzDodiW95nPefT0aA0HgTSk/3SDGl+E4wWgQu16t2QQy82Huo4OgTMtXjISir9XHQjAHdAkBeC9xz4rQ+31EDP2eSBiRFxw9fnORuePcUOm3SNjI5u2SEo/RZMNsfuMRiQ7R0KVSZvRQwszVMRlepi4hN87AYJ2RreV4eh8YS3/7OeZbVC1NCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4sgq9NrGeSNkfW3L9jhNQrk+zE0hqadrYAN0hqPn80=;
 b=LaJySJySE6fhWWFurGLteDN+gFaiCUKTWSQ2qmwDiCvZWUtPxVvhEuxz3MmM68qJPG6iRvDB2Ecmib5EZZXeBGeSquYcL8kxRsxyLOAtDolZv7zF/SfyGQl3/aMUBugrNh1pL3EZhTAkT0n1DYPdoUqZLcW2zcHgONRj7gfg55w=
Received: from MWHPR20CA0046.namprd20.prod.outlook.com (2603:10b6:300:ed::32)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 18:06:24 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::8d) by MWHPR20CA0046.outlook.office365.com
 (2603:10b6:300:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:22 -0500
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
Subject: [PATCH v6 42/42] virt: sevguest: Add support to get extended report
Date:   Fri, 8 Oct 2021 13:04:53 -0500
Message-ID: <20211008180453.462291-43-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0bb5298-a280-40fd-36b8-08d98a865746
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50596B19C966A4011FB3C28AE5B29@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvt8AuGpGE65e1BaT2QFsw3SPTk34u/31pfN4z6coBXEDOQDHWYVuo6Dh1wRlsscUEnF6jUKOsi5Mh5/NEdU3snFw9GQ6TIQ1YpNcj/ugAhkOMjBCP7WKNTw6OL0/g6tROktfauAFf7lNKALPGQJl+7JRpvbM5MfAPWUFPE/HFUydNKlTjU20WQfgi+lEnIP+FxsOJqdNdfgsJjz65Iza4kkez9E6jEKr5ox5L9PWP2pCanFZYhD6+a1pfA/l46q3nCYqMnSYGKbgpm4ux1IqgLuDMfb55Jnw+k7Le2cdj5SqyJjHzua/ESg6YCfQHwYhrgYWMIgvWpEgGCtpkyk6dae1gPCR4ZOAsEFTCjiH19W/8UCFJc3bNzYv1kzPvz45mPYBDRjf5I6s1hpvIxz1VlAuUjG5DdRuhgn/gF0BgVlQpeWwlBOMYewGh5eZ1EVh+H+AmkIn0ctSh3HbiQCe8h2KZkXJv0Z3F6LG4faKYSVpPQFjfYXz7i9WM+pslrjsui5Dbo/E5Ft2KzeSsJW2Rte5Tw4K4rj4+JhhpQn2prZu1m3zq5syDm29HLWLPdJCEE0NpsPFtWT09ARo1ZQwl1QrHxJPFpHfBAW2DoN+hWjQbjZD47FqOWDZ4WsF/GUsHtk1xE2EpFZ9IzqiNXg++tqW/HbrjPbsh62Irr5waAy+QUaAK2IwHwnNrWYVBMQjgqNBlDuTPoH8EzYjmU2yTRgSkjul+Oqj0ChMs2BvtPUt89Lw/YTysw0ZkyVoPyj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(86362001)(2616005)(8676002)(82310400003)(36860700001)(7416002)(8936002)(1076003)(7406005)(316002)(54906003)(426003)(81166007)(44832011)(356005)(5660300002)(47076005)(110136005)(26005)(16526019)(4326008)(83380400001)(186003)(6666004)(508600001)(336012)(7696005)(70586007)(70206006)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:24.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bb5298-a280-40fd-36b8-08d98a865746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
 drivers/virt/coco/sevguest/sevguest.c | 97 ++++++++++++++++++++++++++-
 include/uapi/linux/sev-guest.h        | 13 ++++
 3 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 4b524d1de37c..071dc93aad6c 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -86,6 +86,29 @@ on the various fileds passed in the key derivation request.
 On success, the snp_derived_key_resp.data will contains the derived key value. See
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
index c6ca7d861a3a..f7115adc4378 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -41,6 +41,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -410,6 +411,88 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
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
+	/* Message version must be non-zero */
+	if (!req.data.msg_version)
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
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, req.data.msg_version,
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
@@ -431,6 +514,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -508,7 +594,7 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 		break;
 	}
 
-	return NULL;
+	return key;
 }
 
 static int __init snp_guest_probe(struct platform_device *pdev)
@@ -554,6 +640,10 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!snp_dev->response)
 		goto e_fail;
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_fail;
+
 	ret = -EIO;
 	snp_dev->crypto = init_crypto(snp_dev, vmpck, VMPCK_KEY_LEN);
 	if (!snp_dev->crypto)
@@ -567,16 +657,18 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
 		goto e_fail;
 
-	dev_dbg(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
+	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
 e_fail:
 	iounmap(layout);
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 
@@ -589,6 +681,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index f6d9c136ff4d..3f6a9d694a47 100644
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
 #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
 
+/* Get SNP extended report as defined in the GHCB specification version 2. */
+#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

