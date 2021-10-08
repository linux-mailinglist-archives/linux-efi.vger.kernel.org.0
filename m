Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF742705C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbhJHSJn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:43 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:64768
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243010AbhJHSIX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyvw4sqICaf5MneBcAigpdviHLE7RFpt+MSOGbAR/Tyh3URLjUQpksOGs0pNakcvAoaRRQ976Wo/D1duIcW46j5kySkp7f6+tGtumm3LgFgFyRC0Ogh/txWDgY9ZJAopWpkBmzaChQkvW1SYqh2dKF6s7MdreQz03nu4oaL/22afqZwSYEYxe6LJj2+Bo7vk96Lpy6Swj1HwbVXnKTfFJaRx6yQ7xclm0dR2rcjMi/poA0Urg/t8wSO39ltsKATGurqvkszlAz+PxUluMnzVBBtKwv9M6SYSYQUpmchJPProSPTQPPDy2ZmwGoKXpoTC0lpV6AvhiESr6f5ZkOq06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ+aZXf3KN6ncFhQrj+V9CxSUa4Qh2kMcEbTQ601VXk=;
 b=HUmBjwS6ZOnozVSmjFwjdAjmBc9Aq19HI46hVJUlH6mbE0tmmW0ohxNE1jU6jGzTE7hxp5WAJrrOjlw5mWSLKEnAK1RR/xsrT6+BeO41+/JdpwK48Y2ftcoVLK13YlN+fimQIrag3sv8gzrZA0+Rqg+wDrfH1C4+jpUlufX1aar4K/hlHqWjFsEQUgck2tHdcDChOH+BYlLfXRkeNBbDE+CJdjfrdQBVajEHrK4Cz9jYNsS1WB5bAgRl5xQh12DrLx84Af1fyX9QFCfRGAFHPFT89I3GUWqpcvQIzgDlUVvorlbK0AOhmc1IL7QVQKZ7f3qylKUGRXZY4yqUmNNWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ+aZXf3KN6ncFhQrj+V9CxSUa4Qh2kMcEbTQ601VXk=;
 b=bjtPN5q5X9bFB3SPSA1JHtclPri/YF0QHs08J5XikgRt+qzMXINpMkMnsBYwMxFXKuIeJBgsVZEmwLHoyWROspQsauHIAq8Wr9+VVIPnTiHhMm9/hoiiHR9vDyeT7bU5dZlgkkv4JOu/ykOqGiXd2MY1yCZydstgp8YDUYQc9lE=
Received: from MWHPR20CA0037.namprd20.prod.outlook.com (2603:10b6:300:ed::23)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:06:23 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::31) by MWHPR20CA0037.outlook.office365.com
 (2603:10b6:300:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:20 -0500
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
Subject: [PATCH v6 41/42] virt: sevguest: Add support to derive key
Date:   Fri, 8 Oct 2021 13:04:52 -0500
Message-ID: <20211008180453.462291-42-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c329cc3-113b-4fff-5ee0-08d98a86567d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4472:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4472ECE35B79B5C54689947AE5B29@MN2PR12MB4472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqxCwVyuXtfdMLiSleUhxX90w0agzCZjqgrBsNyQ8g/Rh5jGpB8z6ukGxG1mvREAPEMZXgA9lxfWxNes09VjyPC1v8ZA8ag+QACusXkFhT0lioDlwDu+TMWl+SNFAiIfh+KAUA12mqSaclb5wEwe9Dn9kl5p/MZpn3AAB5b8Evk/4MLsdpOytocfVzRUg02M7PvOBzks1AUFUe/9QspeaGcZis44vU/SlkXDnVd6PwJj21kHcZYAdiX7/UGzeNuKq5oW1MGRNzFLMkRgLrwl1n2J73ELVLBKTqZVM+WvH9pXo9rpJ8K8yRfOXREABo5Xx/hkfm3RLsHYBt6wduokXmXVvgz6y+puCTzgUpHg40/tRuckTMweOT4L0Hg7z9NEeY2OTgu0sYFpJ5LEVuo+uq7B+4EGhQO6PZAvnNcLTzVtqKTJ8CQ+BY3I+cQ8YNRgj1aQspfBR4k9cm98qu5aVYhQDvH5Ak6HvQ6jqA3RprlJ6kplJpNkK1GMMANAvQd4W82W+9trndeb4ifl320Gakug7+B6rfK1VI4KURhEdxo12pDL5iobrTN5BcfKsDZR7znOAQgaY+MRY4/21dmK3Dsj86oz+l90wkZP0tYvvf9YXMB+dUcezjhiqSwVHgPJc/8+ideVF1iCz3OsFQMyP/7D/HEm4U1P3ScXrRa+MTmLwivnKUjxKrVYzC/bhiS0ZpAtH0EDbUUMi/VukqHorCtasI7fq2JBcXFB4F3B8AYsRUURuCKaXeWnClZ5tNsm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(36860700001)(186003)(5660300002)(70586007)(70206006)(86362001)(26005)(8676002)(4326008)(47076005)(7696005)(36756003)(83380400001)(16526019)(2616005)(7416002)(8936002)(81166007)(426003)(316002)(508600001)(1076003)(7406005)(356005)(336012)(110136005)(54906003)(6666004)(82310400003)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:22.9394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c329cc3-113b-4fff-5ee0-08d98a86567d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
 Documentation/virt/coco/sevguest.rst  | 19 ++++++++++-
 drivers/virt/coco/sevguest/sevguest.c | 49 +++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        | 24 +++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 002c90946b8a..4b524d1de37c 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -64,10 +64,27 @@ The SNP_GET_REPORT ioctl can be used to query the attestation report from the
 SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
 provided by the SEV-SNP firmware to query the attestation report.
 
-On success, the snp_report_resp.data will contains the report. The report
+On success, the snp_report_resp.data will contain the report. The report
 will contain the format described in the SEV-SNP specification. See the SEV-SNP
 specification for further details.
 
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
+On success, the snp_derived_key_resp.data will contains the derived key value. See
+the SEV-SNP specification for further details.
 
 Reference
 ---------
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 2d313fb2ffae..c6ca7d861a3a 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -364,6 +364,52 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_req req;
+	int rc, resp_len;
+	u8 buf[89];
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from userspace */
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
+	resp_len = sizeof(resp.data) + crypto->a_len;
+	if (sizeof(buf) < resp_len)
+		return -ENOMEM;
+
+	/* Issue the command to get the attestation report */
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, req.msg_version,
+				  SNP_MSG_KEY_REQ, &req.data, sizeof(req.data), buf, resp_len,
+				  &arg->fw_err);
+	if (rc)
+		goto e_free;
+
+	/* Copy the response payload to userspace */
+	memcpy(resp.data, buf, sizeof(resp.data));
+	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
+		rc = -EFAULT;
+
+e_free:
+	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(&resp, sizeof(resp));
+	return rc;
+}
+
 static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
@@ -382,6 +428,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_REPORT:
 		ret = get_report(snp_dev, &input);
 		break;
+	case SNP_GET_DERIVED_KEY:
+		ret = get_derived_key(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index eda7edcffda8..f6d9c136ff4d 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -36,9 +36,33 @@ struct snp_guest_request_ioctl {
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
 #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
 
+/* Get a derived key from the root */
+#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

