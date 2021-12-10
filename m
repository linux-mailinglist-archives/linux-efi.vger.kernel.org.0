Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6E4704B5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbhLJPuA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:00 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:9120
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243403AbhLJPsa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukl/HhkLxYSQqVvidVmFDRFCUay6tCewl/wKldH0zQXK4OxIbxLMAygL0PARD1CCbEjcwTB5kwGs4Bj86LC5cZgRDAxi3OxklljxSNNjsgJlV182SIEEDjhR5GfrekDIj+CJOCCrVN+jDFrHpNbrSnps1eDlHWeOLjCZyplJj3Y8q4vhp0uZhHxSD7qJrMkJkCX+wzt7W/hF3lWWhrD94uvlsY5A1PY+iKrPgCBeYPEyLltEjEXqWx5Cp5hK4auuvy5ib4+7q0AbnhpQRQbG+EuIw3F5aVpVNtyV69qFGXdzSKCkaDXElhNe1isWogGexqAurrzUo7hprdcfgC3UTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd45oy2gyDER6AqsoTMvBLH/Knv5ZWqcvzo1I7u7hEk=;
 b=GkaLnXtmj+PKmeedSrb2Q0UTsBjkJH/bCo7e7YzRp6L9Ki/0eFunGZLd0B4qJlD2K8hpzxXMOI6J6pDUYEz1yPdbGQPDEXEvhVMMUMSwH34cadt/YGmLsFWzf1UKu2QAYAFNVKvyCX6Yj92QEoTbRsVSmrPyc6IxZVwpJTNJz3YRD4CCZeN2ES5vvFTe5ofewaa6+ww8AMd9tIUY3ZiaYbXw2myzNa5T7/UhuNUk2YS4AUJrsI1FUvatF2jgIRovpl3WbiwI3zF378IVFXuX8FZzP3MIS2PywjcNJhmgrPQHOY63eipBz811+2UspWMfcFKP+xHyF1WyfS5zzNyohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd45oy2gyDER6AqsoTMvBLH/Knv5ZWqcvzo1I7u7hEk=;
 b=apD+O0bxlihifb2jvPcsRFspz+aMZAfBz8vJLkLfxTwF+nkv4c9GHWtjBUjBBaa9WkBNG8RimbDgY3svJThjtPxAAb3No1PjFmaYOg/+GAEMN2t/hkmpS+570pGFzXzyY43yhlo0qSpk/o5vSpP1z4AWzCJYpYE9V1Akcm37JNo=
Received: from BN6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:404:13f::23)
 by BYAPR12MB3317.namprd12.prod.outlook.com (2603:10b6:a03:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:44:52 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::94) by BN6PR14CA0037.outlook.office365.com
 (2603:10b6:404:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:52 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:50 -0600
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
Subject: [PATCH v8 39/40] virt: sevguest: Add support to derive key
Date:   Fri, 10 Dec 2021 09:43:31 -0600
Message-ID: <20211210154332.11526-40-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 15792482-61f5-4ef1-1d69-08d9bbf4019f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3317:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33179E8D45A50544639E8B33E5719@BYAPR12MB3317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xC3mdjOhBMD8PYVsBKpJG9CI3U0MBJ0rBUTtBQmY4f+mwWFpN31xmojhpYSKRG1Ps8nb25GR3hrBNkoOSFv4liU3fphmsfsPtq+TqtoFrbA0Qljwdko1RFx6UPOqqD1BZTh+TYsRd1RMMN2pK37BuoOlNIfRcgTlus0y+DPlH6LBCUiQ5Eb+eCVvuukmIa3K6+y9uGMgcHBWRC5aPznrz0RsyZH1L9XtVKC1ci+J0e+W3aV2sBihtvx+tBtugBq5Mn8zBv0slzxvSYaVKg6grbprwTwsVXDWT0anb9/6vk/mL8IESehURuyH0nRgVPwZKdWC00VhAQdkN0mxTExdCDbuFUy0HDpvSknKbR+Ggapqlq09o3RArCST7eXBD7A6nfaO279516FR71PS1+uasUtz5cQeT5MvesK2+WndHyGiGdjt6OmiNcGXLlJa2pTbLPVI1/DMbhlipFpeo6whRg+GoTyhpQQWMYHwNgz4sbixSX52uf4ESlW+88Cscjv8YHlRkhx/1glwcTH8P8PHi/gNUd7Lkw0ehHg1VrtJ6cPl2fHHh9q1V/SJWTMIz41rRToB2dKGuoUZSDmETreD1+0gpfPuJwtyRdDl+LKP4N/IixGKrs91cspLBjgtCrr+qNoxMCbM40PlDapwCLFAw9aqc8GRm6VjIMMMLy/goai8Hf100PlQtmRMjn7ixOeJgVd473l/CTt9HNc6zsx91hu33Wjirutlqlag78zTRu2phbW0U0pW6XarzyucUqYgNhQLVpxb0cSjcK9WgLc59PZcGfH3fZ8WDX4QfGITUgysPlLt25/nn9o27FFo/iJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(8676002)(36756003)(36860700001)(8936002)(86362001)(70206006)(70586007)(186003)(2616005)(83380400001)(356005)(508600001)(82310400004)(47076005)(81166007)(26005)(16526019)(2906002)(5660300002)(44832011)(4326008)(7406005)(1076003)(7416002)(6666004)(54906003)(336012)(316002)(426003)(110136005)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:52.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15792482-61f5-4ef1-1d69-08d9bbf4019f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
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
 Documentation/virt/coco/sevguest.rst  | 17 ++++++++++
 drivers/virt/coco/sevguest/sevguest.c | 45 +++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        | 17 ++++++++++
 3 files changed, 79 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 47ef3b0821d5..8c22d514d44f 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -72,6 +72,23 @@ On success, the snp_report_resp.data will contains the report. The report
 contain the format described in the SEV-SNP specification. See the SEV-SNP
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
+on the various fields passed in the key derivation request.
+
+On success, the snp_derived_key_resp.data contains the derived key value. See
+the SEV-SNP specification for further details.
 
 Reference
 ---------
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index b3b080c9b2d6..d8dcafc32e11 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -391,6 +391,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_req req;
+	int rc, resp_len;
+	u8 buf[64+16]; /* Response data is 64 bytes and max authsize for GCM is 16 bytes */
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from userspace */
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
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
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
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
@@ -420,6 +462,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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
index 0bfc162da465..ce595539e00c 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -27,6 +27,20 @@ struct snp_report_resp {
 	__u8 data[4000];
 };
 
+struct snp_derived_key_req {
+	__u32 root_key_select;
+	__u32 rsvd;
+	__u64 guest_field_select;
+	__u32 vmpl;
+	__u32 guest_svn;
+	__u64 tcb_version;
+};
+
+struct snp_derived_key_resp {
+	/* response data, see SEV-SNP spec for the format */
+	__u8 data[64];
+};
+
 struct snp_guest_request_ioctl {
 	/* message version number (must be non-zero) */
 	__u8 msg_version;
@@ -44,4 +58,7 @@ struct snp_guest_request_ioctl {
 /* Get SNP attestation report */
 #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
 
+/* Get a derived key from the root */
+#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

