Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155814C3303
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiBXRCj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBXRB5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0F723F4;
        Thu, 24 Feb 2022 08:59:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa7Prg5oxe6N1v7JnGw90in5mcrj+bnYRnygjpYS0Wuqx0OH9zcCbZ02VWyxuTQmDC8dNlaxgnWDwPttAbObtv/nruAGuOZQbQOZ8KELwdKP7cpeNv5XNiEAkxDPYSpDYIQ7dyfUvD4I7aSJRzF3Dq2U67yX4Oq/jMDl2lyY7+7+OZmlhtxLnDdruKJW4IzwH4oLDfBmwTWLsnc5/6QQN9vuqPQPt7DhfvKYpeO6VLrxPTBrLZYX/AfRsPKxYhnfxaLJX7NINVDt4fKa1prD0z69iqbKgEglNPblzvE9jf0CBPimulEyKYQ/7PejSXkDuJON/oHMI6V/LdK35Qeu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P1mVAqa7rfPQ11e+g/qBDxCymwI83pIEwF66yR0vMA=;
 b=GZ5vNRybFrhH2HmFQphgP2KD/Mln2eWf8Fk+IwAMlj+TLp3gEwKeAT8wOGQYVW8LDRBmvLjWKhDGsr4nMkBYMQ8ZWz4O0P9H04gpDW5UYN8yotxxg5OdeX8zvqSVHsQ+O99es6FCe6SLDVKPHQe2ZgYuSu0jZfJiAOsxl5W7xRLZSZe+LjN+vCP07hZKL075Mg9ERn6hix7mJYyvsrt9qkngoJas30PkHJxzHn7DdvDaN4tZCcbcUEWPt5DqprQOTrMd8shRNQ25OKfuds58LSnU5Zfqv0GAmTNJzs/1G0e0IdpXLxW5sG8eD4ZNfKKYtluXLQRkkwfHORi9DYQGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P1mVAqa7rfPQ11e+g/qBDxCymwI83pIEwF66yR0vMA=;
 b=gndkuFnZbPVrsGR69pVVIHzJuKnHjOKjANQecBOr0grlypNiA4FXDdMTgBqOPn5Tgy6ozL3AOGlv/Sc6XtefbhS3B/vkx/G4fczb1kXSLnulIoGdiuprsFTn5KDgxKmEk8vfEa09EbFT+XgCbvoihKOCF4I33l/ijRqCax08VRM=
Received: from DM5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:3:7b::13) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 16:59:13 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::93) by DM5PR13CA0027.outlook.office365.com
 (2603:10b6:3:7b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:13 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:59:08 -0600
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
Subject: [PATCH v11 43/45] virt: sevguest: Add support to derive key
Date:   Thu, 24 Feb 2022 10:56:23 -0600
Message-ID: <20220224165625.2175020-44-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3c588e-34c7-4745-d24c-08d9f7b6fbf9
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB595127F3A135794AF82CE386E53D9@PH7PR12MB5951.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4yqPIPdDWv/Pu0PGubXTu2Ituhmr9kcS3/gh2aZC/lyFombcRbRE0OxtANEdO3o5hrW50O1Dz/oR96H4pGEprSik5Oove5r/wzrTqljngUlpRiOEdv8RqiXQKIZuNjqR0qpw7l3LJpiGgoYNQy8pCkF+RS/ghDXOHt/H+gAS4iDHTXqpqkthXwcRyYzv200ixgy32M5FP4LrGvf22qpO2+2oJ9SplI/GpkXa2S7ca8lXG/nm8zB81IaL/+d0FZXrQShCuFdgyUCz5Ah//Ew69btTRM9St8cvg1YcnkbvQKO7KztOaXoFtzupEENLg6DYsWBQ5dmXbg7AFHN6V7wTEyhaQiyF6dWqYt7r61zs41QnpS/0+9mzxBet9RAasiCIEtWSS/z37vqJH5UZHagnm+rKXF062vEbeCYw54O+CgEnFK4lAAQ54AAARvQhq+OI9ycGKQLeTAXC6E40DZLCK7EY9eOH+fCTmcUBbX+kpj0iFSiQ1nDa1oVnk+5Oeb8/X3/NUe0LosRJljYEw02y3VqXm2uaEufZanmNq1DuncyG8kkO76CjaFzjTXl2z0TsI9OoXPwIjb6BX9UChDPeKmcfu28zdXjcmm3IiT7mDEc/6Sxajf7za9e+8VHVH8Gtje5gQ5beMscqQKgVBJHUmSctddcXst/kR0Ssxq1Xpup1y1hrVoBCJCQbk9USebeMtFDIX9uSMX736Ha3vhzH222TSXPFpj99BdRjuQiNco=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(316002)(5660300002)(36860700001)(426003)(6666004)(1076003)(8676002)(70206006)(4326008)(40460700003)(7696005)(16526019)(70586007)(86362001)(7416002)(36756003)(7406005)(8936002)(81166007)(2616005)(356005)(2906002)(110136005)(47076005)(508600001)(82310400004)(186003)(54906003)(44832011)(83380400001)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:13.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3c588e-34c7-4745-d24c-08d9f7b6fbf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

