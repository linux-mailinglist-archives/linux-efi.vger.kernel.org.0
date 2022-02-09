Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F14AF9B4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiBISQJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiBISOx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:53 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699AC094CAA;
        Wed,  9 Feb 2022 10:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlCe023BfK5oUkFGRlXGL8BbwVveJfmjqlRA13n2uomUnwSHbIkK+tOIdzoAYsLmqrIKH5glEYsuNbgR7yLKkNIqSSWfP+Rxbi/ac4z3VRx9IVza6k/WBUYy9cN17ddzVYlav3TS5TndDH4klaCCOaptQKAK1PMphqJdHRb4NazDpmaP2En7HKJkUvmqjDgXUgeecn0HdZ0PJPZ+BXT+eCiB1VNQwoGZDklABy34UtBt9qWelrgxlE0I+Kj3x/nVEt8G0Ect/a9300iJwtTh8+5/G6poy8YOgfnuq58jTpH6IcEUG80kyIPeFCnGch/liFZEgvBM6gQ1NoN6a4LQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P1mVAqa7rfPQ11e+g/qBDxCymwI83pIEwF66yR0vMA=;
 b=H0uQ28NPwfoe82BcIjsHAC3PSapBrCiyg1NBIz9MOP13L93W8ucjStduU2SAV5eu0qSbh7bebndYtFXo5OQm2OeP5CHJi/OQh/Ew1qf/iqTTXJvoeNqz/AHXFbPMmkG9dCmMHzSWzE3NyVcs/j5mJnXDKtnN/DcegRfxpJf167sKYvfZ9cqOifn0n5ZZEIfKQCggsXPVqO36xy9LYapPI/V2XXFnQMI2EGAxcq6b0T29o5zN9KnLusLesqve7ROn899jV7K4EeO74Icxs9nx7czH2yJl3vSyTcmh8Kb+hjT2n7f7O3ncKNa9MHZWXXvj4gU9ePPYfXwDCGAtdfx1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P1mVAqa7rfPQ11e+g/qBDxCymwI83pIEwF66yR0vMA=;
 b=Vx0srS3TlbWl9vd4NhD/m7x9clzuSHkgQTo7fp3FCDRJDZK1TIxuAN0CLSirL+VHD+Bcf8MZ13hHV0hI/MRp+2z0u7JfVpWXCeKrBDo2r/9pMVR1PR2YqL5i8p3upyqVXSNvoCQDMH6l8FmSDcqzLgM4+Q/GgvPVM5vbYBXctSc=
Received: from MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) by BN9PR12MB5162.namprd12.prod.outlook.com
 (2603:10b6:408:11b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 18:12:42 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::26) by MWHPR1201CA0002.outlook.office365.com
 (2603:10b6:301:4a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:42 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:39 -0600
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
Subject: [PATCH v10 43/45] virt: sevguest: Add support to derive key
Date:   Wed, 9 Feb 2022 12:10:37 -0600
Message-ID: <20220209181039.1262882-44-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64b4fbdc-7ffd-4dbc-6dc4-08d9ebf7c3d2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5162:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51623706AB2A4A03CF2906C6E52E9@BN9PR12MB5162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/OFHpJkHdum9092BHoGfxwYPHGqGyadt5dZv/YWu0gBBy2v7wExnAHVe03nj8mNiCQe02+G9hbKvTTpvqA9s/kDA9rYFLAcL2CG4SieZX3CziOQlRKXE4MS9/avVFXl3M69AyOdkQJ6mdcaYFZYVALcgvh0Gb+imsNXIGnL5c8QaECvuagkZLiBXxsCIgNx9mL/M2K6GoZd1quD9k7E2ZO9Te34fT1lyy03AQNdhDdUGogsGtcy8kmUYTTPBiYcXQk2G3ORylJDtJOiEy6Qt5nAwzd3AScVJw5+HOJIdu5qZT6ABuTsk6tc9g8W4tZeGPcgvpIvsqQbEbzuGllxyyMAitLfD3tmFZKNYPQ6gwCaXFE1zvmTN2Q+1Ygu9xJ2xtOGF5K4a3WEvLQGzkTQxtVD1OEtnNnSWJTrV94yK0+JmuStsrYKS+/5JtG5MVYRUFQPE2TmnYETXbmbVdyMflrrc5Cofh09hsapC5cHyLa96PdWD/GuQWPf4lyDC8zOxqfOpCWJccsePoaJeXMpjL9d6pSDvnwRXPwYWB8l7rqlReJ2//5xhHW/cDLWtDDcIu3ZB0ZQ6D2KepxO780rvD5//E0/GKhMq6cvfDzi7Ed4nJiRFnMPxU7AcHNqRim0SMYcKUmak0DcUFJXuC+0X03hc0iCtJILoO3dEaDLIvTno8MOacvSkMqsLdY1CvBgyzXh75AlSV/iB5anDTdeDS7ag6gWUx0ZPV1UkN3toLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(2906002)(7406005)(7416002)(5660300002)(36860700001)(54906003)(44832011)(83380400001)(47076005)(508600001)(40460700003)(16526019)(4326008)(81166007)(356005)(70206006)(70586007)(36756003)(186003)(426003)(336012)(1076003)(26005)(7696005)(316002)(2616005)(8676002)(8936002)(82310400004)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:42.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b4fbdc-7ffd-4dbc-6dc4-08d9ebf7c3d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 34feff6d5940..ae2e76f59435 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -77,6 +77,23 @@ On success, the snp_report_resp.data will contains the report. The report
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
index 4fac82fd3e4c..2062f94fdc38 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -389,6 +389,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_req req = {0};
+	int rc, resp_len;
+	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
+	u8 buf[64 + 16];
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
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
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
+				  &arg->fw_err);
+	if (rc)
+		return rc;
+
+	memcpy(resp.data, buf, sizeof(resp.data));
+	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
+		rc = -EFAULT;
+
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(&resp, sizeof(resp));
+	return rc;
+}
+
 static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
@@ -418,6 +460,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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
index 38f11d723c68..598367f12064 100644
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

