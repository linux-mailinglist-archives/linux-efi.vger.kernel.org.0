Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBF4D09F1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbiCGVjz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbiCGVh5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051188BF0A;
        Mon,  7 Mar 2022 13:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQCtjw1/WhkqmZ9r29H5DJcvzyHwkdJJhbXnffvz+WzWlzTVdJdBNG7iQEaaVETp0BoOG0mnRVA/1DjCc28UJkwiY7RvUtYsAFPSsRgGS7J2dqcUMILlRFr/1xGVaDs8qLHXkMFUhasi/3INANJkLjQWIWbQQNvI//XXlGk3oVohEBcJDodDf7AljnGm5BNi4fjmJ/P3SphSuy1f3X5/cXIPucHLgSnDVGmDKgBCwAdKpW/YEfPHGGvaYrD2FxG4KGj9IMF/io8qfMzJH4Shc4sQyQMHyZTj7R7a/PM7LPmkhm5KTJWeO1UJJmbW0Jgiw8dyKmiRyV6Po8MNOp4EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpeeAuxcN22a6G98X6yAnloxx3qxLBlOuroK2GohjWE=;
 b=FsmWunX4LW2Fl9eMrnjh2sEObSQD7KtKDUjyRE734XeNb671c/TUeNLxnVyU9d7aVcqKIrW2AcjaQ5C+KGycMV0+Iqjy62Ikf2kv6mZngwCSR5HoX3ceEOo15GyYXAOxUCVHzbgwR28Z10W6p2niMkcIR87QdrDp09+6rjrsEUeBeRAtOd69YioGMEfwGjvMOy7zQGqC09CovL5t2xTw81CH1Ifm9H5RV7GWyj4XkQB6BvVCESHT+iNDw8A5QEUQiA9/ZqFlvVyS6wMTg3uGr8E8QL1WNA7mTErjtwtily/brd4cbnp+y2lGfrj45DpxLUJlbOLYqNwOlPCTHWOw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpeeAuxcN22a6G98X6yAnloxx3qxLBlOuroK2GohjWE=;
 b=3ZjbxZBtOE+5p0JbJ/84B8JZTSh1E2k8oT6bBUYuqY66PbYAGW/v/cP+TfcyD0PvKwFooucLZRoBdFH3me8TLnJouLvVhIMS1UGHPvkz08G8bQP1n+D5X21anpgxCH2D7wcm/EyFfitNRQ0labBDv1++Zypl2tQFpVaj/P3Cym0=
Received: from BN9PR03CA0130.namprd03.prod.outlook.com (2603:10b6:408:fe::15)
 by MWHPR12MB1693.namprd12.prod.outlook.com (2603:10b6:301:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 21:35:38 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::5d) by BN9PR03CA0130.outlook.office365.com
 (2603:10b6:408:fe::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:34 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Subject: [PATCH v12 44/46] virt: sevguest: Add support to derive key
Date:   Mon, 7 Mar 2022 15:33:54 -0600
Message-ID: <20220307213356.2797205-45-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0a51855-269d-4f3e-0139-08da00826b82
X-MS-TrafficTypeDiagnostic: MWHPR12MB1693:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1693357079CC4D51B9959432E5089@MWHPR12MB1693.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpHOIPNhUqJfenDoAFghIkOAW2OEI2F5wvC4CJKWmnwbUHPdgHSy/HqVAR/rT7FEbl66HK+ge/qbrr/lPYvDGZ/+SDRtkvJh3TVj6izbijU358UPUw7UDvEkpa9LOqG2gGwui0jSbgDWIC84OqpT86clKc5zG3owmLOo+uH5gjzGFFIXC/dkxg/F/qI0j4bp8UwgXNSCEkorD+FssO+dWiBx2KNMgIBIUFHZDQ7V73uzrNmKRD7NAfb9sLDxy5KKC788uiFg6wv+Q/kHfyB3+2speoIfIefoahRhpEpIXG4rBSBwi0K1PFpFF9RpHcuZ1/xDRoWPvNLq9rSysNsXXrO0FZTv8RLGH+FTTqUPfR9K1eIsbajs+AEvd6gBqzjMny7yQdccoMqhnYEcCvGx0VQZBq2QHohZ/MU8YWZ7ZhqiP+qjkoTuHhokhCFCbYOwLs3/Vgu8j0+zkKNNnouvEbXGzrUv066E+of0J+ffLJNLaqm13gRIyRiz3CNYgC4kyviTsFSIEgPeut5DKAx7fTtrAuOaLgzIpOnE19SEQCUHWhRYm2Eux8W7eiunVKM8PKv3tvqKNNQBXZ85olV3ehe2O37ddDzS+/qijb/ZdoPZTHOyvIrIii8NnzqzOXjl9k03NJt3iLax1heUG1X0rou//LB8Y/9jqrafsvtW2Y9uT5Vr+fbHPJSMINNtX0Xqs5C0gbznfxEsNAxCVL0hKTa4a0aQWjtdOHpFB6Zaai8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(26005)(5660300002)(16526019)(7416002)(2616005)(1076003)(7406005)(83380400001)(186003)(426003)(336012)(82310400004)(508600001)(86362001)(54906003)(110136005)(8676002)(4326008)(70586007)(70206006)(7696005)(6666004)(8936002)(36860700001)(36756003)(44832011)(47076005)(40460700003)(2906002)(356005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:37.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a51855-269d-4f3e-0139-08da00826b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1693
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
index 97b98a3f5f89..9057e8a661f6 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -391,6 +391,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	return rc;
 }
 
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp;
+	struct snp_derived_key_req req;
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

