Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF34AF9B8
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiBISQM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbiBISOx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78279C05CBA9;
        Wed,  9 Feb 2022 10:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFyqyxx9mg8E67nvrjCb1+raQWAkH3DDn6Q+ogHs6VdIexKVrez1BHE2dlvcZKwt6g7ziAAm8iAMd68eGE+iGcrjJNLlwWqMp71H7rCc54QH2BMLY4PN/HPMaIZtXyzA7xbTKbjWT91DF9xG9eGAshMSFfC8Nh1sGLHNxEqvQUHP4RIfKFZ1m/A5lCfAmsl8STotESv2tQTvU6ucREHXz+4H5tYk8QO9V6tkYHa0VFpqC/JnTA/krRZSkEnDZnJ2yz7idn3W+Ggx+k/awRipVvJbe7kaWWG4jL8ILOwpzisfxsewwy1cqT65ge6b6xHzZk8k0gOSX8gjhdFVvDlsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhswYmnERXxICUPqhZGTbKwdFlBe4HJkgbVgye8BLO0=;
 b=VYn/bovMmwD141j3c/ZNQrs9aHSoNGzObAsDMe+Vjb6wK6dFEj7665eoU2Lisuaul/XTgauwgoNG2jUkksyqnnRvF94IwMk1kiq+5dRkLgQkcSqZbhdfupJO3N0u2H/C4Qzg17bZBnmRC9JxLoqEcmlLDIbdaU75dp2zDxB3FKGjzh0Ry9Fhik8/CChw4kZbwucJCA5NhDlatZKg6W1LFhIxDJHIseTxJglnNo0Sr3GWGKTAAW8jOGeLzm/PuB1aHTUf4eEVTEQQbV+VUkvbCvLejbrMtqbhVsRrs4XNF+fqFdaWZRgRtORqA/jL5B8kP/9xJZREB6VsfL5/fQm5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhswYmnERXxICUPqhZGTbKwdFlBe4HJkgbVgye8BLO0=;
 b=JSjMv6zL+6eG4gUwHTkVBElmml+Ti4AprLQzvF1AJ1rcrPzE5KFkuCk35jbb7Oq0AWyth9YHTmXPIops1OtrhFBj1tREXSofnWxdoSXBGWdf6abUNccbP1nnXQLMUVEB0nqc2Hn9/FSqPvZWwgwVngpUm+P6UEp2jeflRKVOcfs=
Received: from MWHPR14CA0052.namprd14.prod.outlook.com (2603:10b6:300:81::14)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:12:45 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::b9) by MWHPR14CA0052.outlook.office365.com
 (2603:10b6:300:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:44 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:41 -0600
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
Subject: [PATCH v10 44/45] virt: sevguest: Add support to get extended report
Date:   Wed, 9 Feb 2022 12:10:38 -0600
Message-ID: <20220209181039.1262882-45-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88ed234-3eb1-40a2-fe8f-08d9ebf7c511
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1403ED912D37DE8BF55CA538E52E9@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCFuM9UPhNuY9vM2GWbxZvc5UKXa0whAAFYe4uwsPhzj2Cl/9wfIcTmFV4rkENWW+IowK2LPadOvRJIuwW7kuxlJK5Z1QDIlZQepP/Ts/6PkhozAprEkOMSMxD6X9EyGSpgPC+OkI2TCRUH7cngEibHCNkKa76ClnqkZ02LAvDHbGuMSYGL94OoRMy05nhV9vSyZA01LI307DXfiqQctuUWeRhrVYKmxwcWsalpid6fzJncvrqDI6PBtFKinaknGw1D2vEVmMUbOYom02AeKf4+YJ0gV4UuDM3QVqExt1+B2ejvXfZfjFPm2HiVXrDWoeA58EpfFPhUgZodemWi6xsUCbXlgnigGIBXPJcQP9Q5HQyiAroPV2ddP6BLtRkP4/B7F02iwIIp1hv1hCMvalFdBiLPb4fVWIbZWBkyzhi6nXSB3fzZlIYy8o+Zpb9YlPM2t+7PsmyqC6QVf1ZvSTHVFHp3+Ifmszryl62ggVmTjSTo/6GudutJTqrFUIDzoHtPucVYUGPB8dhrDb+Z07VBU4OMQRn5vAspVrFnDtE8sUuX3TzxrFdB97WcdQafRQ6KyItjVjDwHSgViO/nqQwTTAvvXnKLxRElP2rTKuuZTtk7+gbawjwOqnUv6mfaRcLX2C5/oRyaSp5arrU5owyZhTpa+gF0vPNwWHUX3xfJq2uT+yOMGt/fMQ8HH4hroywwdiMWB7IonNj7/eThRd7JfACUlJ6Q4kRdvfmmkntQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(7696005)(36756003)(8676002)(8936002)(508600001)(70586007)(6666004)(70206006)(40460700003)(83380400001)(54906003)(82310400004)(4326008)(110136005)(47076005)(2906002)(316002)(16526019)(26005)(1076003)(356005)(36860700001)(426003)(2616005)(86362001)(186003)(44832011)(7416002)(336012)(7406005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:44.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88ed234-3eb1-40a2-fe8f-08d9ebf7c511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
 drivers/virt/coco/sevguest/sevguest.c | 93 ++++++++++++++++++++++++++-
 include/uapi/linux/sev-guest.h        | 13 ++++
 3 files changed, 127 insertions(+), 2 deletions(-)

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
index 2062f94fdc38..b840cf426f38 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -41,6 +41,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -431,6 +432,83 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req = {0};
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
+		 * Initialize the intermediate buffer with all zeros. This buffer
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
+	if (req.certs_address && req.certs_len &&
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
@@ -463,6 +541,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -590,10 +671,14 @@ static int __init snp_guest_probe(struct platform_device *pdev)
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
@@ -603,14 +688,17 @@ static int __init snp_guest_probe(struct platform_device *pdev)
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
@@ -624,6 +712,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
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

