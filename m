Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E467249FF78
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351507AbiA1RVh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:37 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:58080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345819AbiA1RTf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9h+95cEryT+h6Nsx1q283r7Q2XsjSIsQjxmykC5yYLpGdsQWTZ76AiF1xXRwEPInlZ8mF+kEGDz0w1UQpSyPhuLvVCLCukczs5TsXA6mfYp7ki1U+D5f1uMwDQH7ODCIHZGf1FPxJ9PQ2jHW5u4M3H+z8YOmvOHSVpICaSGu1VbCtsJIqXjLs8FNlfKaQYMn02Q7lnM+fRFntL+mSTQhPAa5tkiGNBuLX8NU1liUeuN1A0iDXjgP6rUXPm0fvCeYAgAQgracPC6BGKrStgAjlS4PI0npXsIsP28t3zQxHECk8xGYQTcaJb8Tb55rIDYKrnqxBSN3PMq1fxxWrC2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTceyGmLLdidnT8Dl2ZwpX4T1GwAM8w9Z3GoMLmYdSw=;
 b=DnNF/yU2D3YSRX/VnDkrMAbbDZhHZbWjOvcTDwhDJGhsgEgXrhxLqYNSG3gUvCAzYRRU0FVcJL/wEfXLZVktGBC8glmxzFGqap/oBaqPSDdmxmeBgGY7lOZ8/Bs0bZmwzMphQxt/hQHOpLTw3lOEvGgR2SCApFqwCR9v5opIZhPHP64GPUccsiOGAwEPpkYREBg2z0b3nQ/6iAk3OS8Unpm9DS+lRrWUwy7dhxymqgbzNk0ehcC9UrGhzu3nC0ya23jVYJfHRtsuBlb3NvICo/xNiLW8jGwbfGSWEwQC1lJNhrJfM0X776gRs96nwfUnar+lvX44zTm85n+cnxo35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTceyGmLLdidnT8Dl2ZwpX4T1GwAM8w9Z3GoMLmYdSw=;
 b=ODs3c1e6BPsp4/mkkHHugjl5AfJoBi3BWnsMMmXLuv2b/sSXcJDYQNHdAJFE8H6v9EwmOPEVyGy1CUIXYi9LXvcJB1fjtuGAvVPBNrpoFEhGzNvgmssmJ2hYp3PBsyrsFFAY9noXEZd9rZqV1IDWVUU6CA8YMT/c7rJln7OMDbs=
Received: from DM5PR11CA0024.namprd11.prod.outlook.com (2603:10b6:3:115::34)
 by MWHPR1201MB0094.namprd12.prod.outlook.com (2603:10b6:301:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Fri, 28 Jan
 2022 17:19:30 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::52) by DM5PR11CA0024.outlook.office365.com
 (2603:10b6:3:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:30 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:28 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 43/43] virt: sevguest: Add support to get extended report
Date:   Fri, 28 Jan 2022 11:18:04 -0600
Message-ID: <20220128171804.569796-44-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b5248f-93c1-4de8-b795-08d9e2825872
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0094:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB009406694E5A7C156A16240BE5229@MWHPR1201MB0094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeByOgTg4NwS8SC2H2uFuTHhePtyAL950AB4yND4aQIjhBcKY/DLZyStt7xQeHMsLO6x1NBQOrO5AUDELVlHIaeO4zfHiStuDyxW2sOfr+eIZ8M8KSlFbphIs1tk2lMbj4j1mmfz1Qa7/UziXZtHDZkaKXlPsYANrJFuXaPqbBL/kIhP4h3QIhO5oxF7M5ElXdXHwpf9bUpcWlNd7xxzGBHBuPzmuIemZLjMJtH9DPFV0mg4gVESBERtWfxhVJVWqJenQsplArFllDpsNWPlOJPMdlYk0rxRhUT5KvQSSvL6QtQOs8RCnSuphVvQEpLlJ8Or8rPUt8aTwTPquj8NbH0a5cK+ihN0sOqNG9wqgxzGwe5iwNr8tfvwx5aplCpLLjvosl/1vNNuLmTIubOPAeQaBrK3/C14j1Vmqx9A1X8dh7sDmtilh8wSMlxdck79gqnzbkvQYJwwLUgd1L8Lpn5DrRLzrVhHJuKzpMP0QUm79VfVrwmklNDE6TAosAvgVkGwhues4ZsDE/1kWg32TV6oAhNEMxD9NIDWXFUGJJAWe+B1EEBCjlUwnge7FaeS82XPT1mt/kN7wmChE4VWe+W0U/vV0gsM3d95s2DFaqeblBlqlsAWFsP1DwkPie1uSqw1nlb+vqbbC+9RUTtHwSP1D4Wq/PCqxVOUdqe/HlOZYrdSpH4aUgnH+uZoXv52Y7yCErI2kUF2weI+JCC+T2HIgskiJSr90Cjep0YT5lucnuVdpcpzVGiQfOAT3LZMoSRAKxUz22LsV9bCSt+/2qnyBtQWIUOAmiylfAFbg5T4whT9g9RZM38rrdTDBrGw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(70586007)(47076005)(2616005)(16526019)(186003)(26005)(2906002)(110136005)(86362001)(40460700003)(36860700001)(356005)(81166007)(508600001)(70206006)(7696005)(8676002)(316002)(7416002)(7406005)(4326008)(82310400004)(83380400001)(6666004)(426003)(336012)(8936002)(44832011)(5660300002)(1076003)(54906003)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:30.6081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b5248f-93c1-4de8-b795-08d9e2825872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0094
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
index aafc9bce9aef..b9fe20e92d06 100644
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
index 4369e55df9a6..a53854353944 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -41,6 +41,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -434,6 +435,84 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req = {0};
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
@@ -466,6 +545,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -594,6 +676,10 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!snp_dev->response)
 		goto e_fail;
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_fail;
+
 	ret = -EIO;
 	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
 	if (!snp_dev->crypto)
@@ -607,6 +693,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
@@ -617,6 +704,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 
 e_fail:
 	iounmap(layout);
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 
@@ -629,6 +717,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index bcd00a6d4501..0a47b6627c78 100644
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

