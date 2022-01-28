Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AAC49FF74
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350675AbiA1RVc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:32 -0500
Received: from mail-sn1anam02on2071.outbound.protection.outlook.com ([40.107.96.71]:44046
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350918AbiA1RTd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj0EDswyTU7HsGy2E/KFASfPf6r9JBtZupaLpa+uI0JADxGgSwPTGZ3cnPFXvlX2jDCx70Ik0eCrcrQiq5gD3sVOxqsbUZZSpK59ZZ5+qDAJQKLME1xBvN8rO29dpveC9lG9CnAOVmJCv8EzKA1h6WigWjvMdOBqQIGu2V0bufVpO0zg70Ql1p4d7k/212vrmZOJRtj02PvGTk0FlPdFHVJ61j1XMnC6VPn44h5pnJntebXkG296hFLX/cUL4lV7H2dy2PTeptBm8flQr8BrIUccerODTIkEktn/+2m4bjGIFOqXXrOTUZnoGriSL2TFkwUrC9lUhMmuSGNmxlz54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUURT8TW7xmYaSkHWuGVO9bbWHHkoQW+idfRpKp2JoE=;
 b=PCNPODNcEXayoSzGKChb91Ln8UsM8qSu8jUEtH5Q0NOpiLdJU1h4DOyYEVQmG7EeoKkam3tJmSAoaxi7SG+pagIDvhieSh2vgKFogG+TRnmXqKbqWyHMUGmbKqSRt7p/LJ5SzzCZu4g/lu4E6thrnWZGNHxKYbOC/4QZ92+ygYV8w3tpS0Jr41I/f5nKKo5Swm0rm3wjsE5yf050eYoMbdHo/dMrRBkLotjeyY9ye7PtBJd1O8Fr9QhSY1zouRFIomW5mXBVXACiDlIwy8EoPpB8nZ/y69kfwthVQwo8LrFeQF/LRc1En+dF5qOVYu6DnyKxt8j+3O8y/NGs/bFy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUURT8TW7xmYaSkHWuGVO9bbWHHkoQW+idfRpKp2JoE=;
 b=XUsHmTjU8HPH/yRo4PTWzpit3IsgrKZkk5ap2quJX5O/YECEr23V6meuBXBY3pHe+3JI8lX9uEhbzA7fNza9co36dDXYCWKrlq2BprfqV0z9KZk1XSB5gTKr5M2YbPjPLAcSiy3tziE2cClC2AVhSFRFjmXzKKRcEqgdkoQTHOA=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Fri, 28 Jan 2022 17:19:30 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::95) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:30 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:26 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Subject: [PATCH v9 42/43] virt: sevguest: Add support to derive key
Date:   Fri, 28 Jan 2022 11:18:03 -0600
Message-ID: <20220128171804.569796-43-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e60b1eab-62b0-4f89-3c04-08d9e282583b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3494:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3494EAC4BE24227EBA6616ACE5229@BYAPR12MB3494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeRUSw4Im5LnRyre48MVOGTrBebxYoWACsE+w1eIbQ645Yim5/5NTYKPLtC2XCwVy8XZ0n5YN2i9GF6BXu4xNkzpIz6iXsPBV/4CSW49EEYTLzV1pvhEJU+ncYgh1HkYwNSbAj+tYVLLQnw7PzU0dhboVtyHrY+xPsFjckYs+HOwI6goIghXNtq7JcdvPobYsyfL1bZYsy7wLWizL2zDYUY9Yryj86fqmJta/An0Aowibqze3E1T7TsE43D7ZGGLo0zAkGPmObjOqqS6TfxVESZVPN+UMVe7pqTvp7jsQ/gqI9DMpsK2GVIqWA3A9yv17mSpdNEtV3DCZYIQVYLWWUzsX3Pq+AAK89kF727WQpECA1hh+UsYDnhA5ibDeSIX8M30/LuMQKd/UMfsmN2c4TS4aCm0n045MO7xYhUVRq/Ecr+obivIsL6nNk9iOiqrGd3U+yAofJe8z6RwnUF8WYBgTJDOhmcir8VKEW3CtPtLbmV1N7c+1aXeeGrqpZ7PlFcvnZXE/dHQlc93m5db83mf1IVWMu5BdqTS7iUXI9QmnpdcPdap1ISzB3J2GXxoGnhP3/Xxx93qjUuvH+DN+nPqqd+ge2CfVSxyVYtX8b9EoEQIpOTlqTGUUAIzcySAbnoYATznotKJkKFsWFtoZnC08/ygpv8WFv92w1qXN6sjh8W4rmMW0Gi55M/yB0FBYcnRVrt9pBrmNqY4Ajr/Fq90XE8vMG54jClr3DwDlXQOxOXadKDg0cVhKkDZ2gLD3rKUvcl5T+g523ha/I0IiqX2jKKqjkC0Ldd1ws3bCr1XGLdBhNDh0XjijRhqHhPE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700004)(508600001)(47076005)(54906003)(7416002)(356005)(6666004)(7696005)(336012)(186003)(70586007)(5660300002)(2616005)(26005)(2906002)(426003)(8936002)(83380400001)(16526019)(82310400004)(44832011)(70206006)(7406005)(86362001)(316002)(110136005)(8676002)(1076003)(4326008)(81166007)(36860700001)(40460700003)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:30.2445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60b1eab-62b0-4f89-3c04-08d9e282583b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
ask the firmware to provide a key derived from a root key. The derived
key may be used by the guest for any purposes it chooses, such as a
sealing key or communicating with the external entities.

See SEV-SNP firmware spec for more information.

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst  | 17 ++++++++++
 drivers/virt/coco/sevguest/sevguest.c | 45 +++++++++++++++++++++++++++
 include/uapi/linux/sev-guest.h        | 17 ++++++++++
 3 files changed, 79 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 47ef3b0821d5..aafc9bce9aef 100644
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
+:Returns (out): struct snp_derived_key_resp on success, -negative on error
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
index 6dc0785ddd4b..4369e55df9a6 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -392,6 +392,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_req req = {0};
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
@@ -421,6 +463,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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
index 081d314a6279..bcd00a6d4501 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -30,6 +30,20 @@ struct snp_report_resp {
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
@@ -47,4 +61,7 @@ struct snp_guest_request_ioctl {
 /* Get SNP attestation report */
 #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
 
+/* Get a derived key from the root */
+#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

