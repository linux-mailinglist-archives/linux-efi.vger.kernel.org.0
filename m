Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E845D44CC42
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhKJWOD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:14:03 -0500
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com ([40.107.102.58]:14976
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233889AbhKJWMC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:12:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djSEuamJ/BoiBpw+SVC/AEK13SAwDudQyTlH4lJyc2g3DlZ+/yxVzce2HlDnwOwyFv7x8zoGITCIsZ35i215UQLIzrgooivUzQr3tQ9PvRtdFjyA/KMCzrg/jfdfNsuEEKhAt6jmTjYaoJRO0Y7+T2apyAvNxHCtDCkPVl5lp0Tx8xvMa0j8HWXN6qQmTMinZEsltT4n1DGVZERKvASXBu60uIga+R4JgMTFKxw6hGxBeZvw53IOE3/OBKvBzfnrRWhs5MQJfedCnVOnQ/xqtIDzYyMSV3nTvkWlmjljgEiNqBTYNCLya8sH/BqlGbNQbEwlbJbwdLXO3bpOtUl5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+QxYD+uZnOcFT079i6EGSxhKerMGI6Qsf663oJoFu0=;
 b=NrsL0IT9H2k2z9HluO15kkbUZ5xRR2vL9wwdXJ8bdy9MAWecA8vfMl2tlbRKnuYdYnijKZNBfb5GS3NQSnSN5WJjx9heB2j/VY6SRslxJ6E3CrkeXaIJX/FwdmgML11na1rRFIjEEcEs3JCSBZBoY7okoG+y6bq6KDN9yr83CkHOw7zhK6wuBy5pulhobXFDSHOB/E5C2ix8lc5509t/Vxre41rSDLW+u9DAC0T1c9W5tmUOST5cIcz86jHWq0o3oe2LeqULVdLCmdm6xuYdYEXEp/r4YzxvTakoZtKbjeHOMTDGmyg578slGNxLayH5hVOdNWsn3F7xs2Z7lwQt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+QxYD+uZnOcFT079i6EGSxhKerMGI6Qsf663oJoFu0=;
 b=iwk9uti8umXaI3MFykl042BL0sXg24TiFPdWHNgtRT7JxmpuQt14yOWRbQY30BD/qx9NiRV/3nOOhXJiqPRgtbYGkxC9tvBGsneyqZRbyE98owmr5NE9yDFVFlfMA1tKYuJv68xbTKQNBF0Q8AW+SXXQYALG4iPh6038q35NmbU=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:09:06 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::92) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:09:06 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:09:04 -0600
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
Subject: [PATCH v7 44/45] virt: sevguest: Add support to derive key
Date:   Wed, 10 Nov 2021 16:07:30 -0600
Message-ID: <20211110220731.2396491-45-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f9fa53-63f8-4908-4466-08d9a496b6b7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905C0358E8E25BB440EF5C9E5939@BN6PR12MB1905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/8kF2QEZjji7vIDvIFo91otRZ/i7qXB+qKKQw5SEjNzbrfb+vg82syT16+8r2w/ygrUS8QMTiFT7mE4XBss1h10o6nv3Qf2bR59P9SD0X2cUh2kQUDD/+W9BPnx8W8g6gQ/Yp4X+5z4BLzPkgA7/MrnlV3ZoB2IweRoNiEicf5vTOUHO0hzBYu10HWXlNz0e0lMlWCZPcJijKk97K/+ly+AfJhqTQf2vrG5HnC6WMTsgxJOgtQ3G1WBXcDEVq7vKXg+6s2Hu5NlJ/jxVSUBRwazN4hDOwCcvMLsn2acBM0nX7hbOSYPCWWvrd4haJEjr5MnQrcXSerWTM24WkJ68LLPlp+w0imk1m3xm3dsXwRBbiIoTKatEpKOO61PW/ufqU9kjlwJpK5ebY372QPmXRCkgNCAOTVMPWzfvC3DR/LTV2IXbKWPR22n0R6DGYZWXW5Bolen6p/HZwYJdzrYUS1AgidA0uc49t3ksYjkuPsPUo98mLAVIRhlT2lMYkthoPezykpsNHDhDYRzhJRJl40Ya1Ushymmt+MSLVvgNZgltM1I0G08FbUWUJWpk8wtzTWVJLCRO6FTZXSR5RuxWy6nMwPrU70LenzP/Paq7PoN29TNGTUAmIQxp7ix4AeSFeZhwlEhn9qv9G6CxQrz8X0Z6eTpGsquMmIjbsaqeTnYEFtxXEANyEi9G0qU+OuoYt0uFajTlpstiW705ZL9AR0r6K6lRsDbTV3LH4JeGelwbWW1gljVEPcLQxapgzxK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(36756003)(2616005)(356005)(2906002)(47076005)(4326008)(5660300002)(36860700001)(426003)(8676002)(54906003)(7406005)(7416002)(81166007)(316002)(44832011)(16526019)(8936002)(336012)(186003)(1076003)(508600001)(83380400001)(26005)(110136005)(82310400003)(70206006)(7696005)(70586007)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:09:06.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f9fa53-63f8-4908-4466-08d9a496b6b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
index 002c90946b8a..0bd9a65e0370 100644
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
+on the various fields passed in the key derivation request.
+
+On success, the snp_derived_key_resp.data will contains the derived key value. See
+the SEV-SNP specification for further details.
 
 Reference
 ---------
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 982714c1b4ca..bece6856573e 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -392,6 +392,52 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
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
@@ -417,6 +463,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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

