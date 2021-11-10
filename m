Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5644CC33
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhKJWNq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:46 -0500
Received: from mail-bn8nam08on2082.outbound.protection.outlook.com ([40.107.100.82]:13025
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233842AbhKJWL4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgeIRzTIgWusQFmQq96IKPSYtYkqg9YfQI/qGyOI4oCz9v5GyPBwqu37m/e6lnEufu2amQiiMJ7isBq0TFD9qHHIFOGXqgxae3b+qb1NLKroComZDuvAG9ypny/S7ANU1KhtTRJqswCmmQdtSHfhpieEx4SopuimIP38rDKICxvZ7xWZANuYRY4sgXs93TVVSXBBopwrWqa5FEFVMDeoWB0eFNZ3vxTy128WbMKEwZ3GscXt2cr+uoha02yGPvG0kKphLyQnxi8v/kVncXtWlA/cSq719DzPWikgACKINZOs5coct7OPZCWvpmwtb2q8ZXxEAJYknUa6nhdsfjnXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8erdydkVFo/NoU3MpBeAWFWg7KVS3yXF0sl5oTUXBis=;
 b=FLcD1sHs3O7/oyvSR0BqpB/eEGNwBvH59DfwHtubsNxvHxPAdOyeIuwLTP6lyR3UXbkDWZ1tcAgEDN/QepnhiRlAEtyNC44k/0qiQnc0F0at8pbhMcWLzkO3JzVSpB36cXJuLCM+SgUzXfLhtKnqZBZ74UnmrNAt8CVhIcvYGutXCp8M0FD23GXnjxvDxbf7bG0otN1x6Nnw5ZIKnbx/TbvZ75Iultv6Qcge1PeMl4ZlzOwvaEJ0O10pmy5PelEv6R3anmEi2aCeqdwe0Smv2VTnHUqMnPJQ9HmJdv7hVBDbuNvPHf722ArQmrdNsuOq9cDr0P5VHfFWr1ZeVAYBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8erdydkVFo/NoU3MpBeAWFWg7KVS3yXF0sl5oTUXBis=;
 b=oS2GOvNdT0F0EsiCtp5fKwfYRNh2mzYgG46yQh3KUIo3c/3sRuT0yQndlN54AeeA8n0614fjXR5b0tHrj7LbuvQMTsAl5uTHtEkQxwyMjUV0PLkANHUDK/HZ1+g+hmb0miQdKJoAtUf6a+fK3f9yd+dNhDpAxjBOCPCAfj125IM=
Received: from DM6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:5:134::14)
 by BN8PR12MB3539.namprd12.prod.outlook.com (2603:10b6:408:9d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 10 Nov
 2021 22:09:05 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4) by DM6PR13CA0037.outlook.office365.com
 (2603:10b6:5:134::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.4 via Frontend
 Transport; Wed, 10 Nov 2021 22:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:09:04 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:09:02 -0600
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
Subject: [PATCH v7 43/45] virt: Add SEV-SNP guest driver
Date:   Wed, 10 Nov 2021 16:07:29 -0600
Message-ID: <20211110220731.2396491-44-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1d58f19-8e4f-48b5-ed83-08d9a496b5a6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3539:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35390F54AF457F9089989677E5939@BN8PR12MB3539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPO3JGwDHOIxGSv6eLBZwOInqBOaroBrM/ts6j/RUz9aewKfFzKzap45JmZeyymhLIaoEcMXneFS+CMuAWUWNDPpxQoZBQ6kBpw4F/cxnHtUUe4NXH91ZV5e/fz1+onB59j0uMSNp/U+Elyw7JuLl2GtuimZ8x8DyAYIuz3FCv659fSNwmYfRwPSv2K02K3Svt01tVa8e0n1dWwY6GsIUqhND5gfPl2glOnLp6cPP3E+oT+7mk0KwwQN5e6zptEg1zgAWWTFIrl88NvqKG0JL8DKjRMRS8zRdvr2odVJDX/0wjZk0oZsTHYmQWpVpSi0Y4HzofdiMChLQ2hISympYdzUfQs+PGpMw3zDam2EhxOoJvSLY1nXBLqNOQJbkKTnnqMQglOs9tRyD54oBV0otXcwqqr6NFwFrzCtCzJnYMxqFOiFsvN+ZOpHfkx2fEzFnwviLQmvkuoIoMmfGHLEyRxJFfz3pQw51E1THaf3hAk/wzSZW2V/prfnYx4jHWB++RIFeOQSf0rloBcoAYCY+2p+nIA0b+NK9ut9zA9gJmYTAXCmeKYw2oISGjtWpr21ifLYLNEn0viruiH0ljqgCiIe/n8uuaUEzyZNrScluh9DdGhsm4JzuVoZc+7FAqxGnvZmK4x+cF0MCb3nZBzJecMTzqvyZSSYgq0HjWEpr9QGYcolerCJw1rUlKakQEd4x/xY5eDMSOUStQhn1iaHfpz7ZtMNT/uxuO94LQev1g5/SLBBGvhtjQ9S1zPrOPYP8aREAXRBNeJ6U5dCOh9rfaNYxmP9afQqNt+34xo2pIKevUzJEHgaQC9yDrF+wC8lbSOwosDE8+oAPXkVtJh9gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(1076003)(336012)(110136005)(36860700001)(26005)(44832011)(426003)(70586007)(70206006)(8676002)(30864003)(7416002)(83380400001)(36756003)(47076005)(7406005)(8936002)(81166007)(5660300002)(7696005)(2906002)(6666004)(186003)(82310400003)(16526019)(4326008)(966005)(2616005)(316002)(356005)(508600001)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:09:04.8561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d58f19-8e4f-48b5-ed83-08d9a496b5a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3539
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SEV-SNP specification provides the guest a mechanisum to communicate with
the PSP without risk from a malicious hypervisor who wishes to read, alter,
drop or replay the messages sent. The driver uses snp_issue_guest_request()
to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
submit the request to PSP.

The PSP requires that all communication should be encrypted using key
specified through the platform_data.

The userspace can use SNP_GET_REPORT ioctl() to query the guest
attestation report.

See SEV-SNP spec section Guest Messages for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst  |  77 ++++
 drivers/virt/Kconfig                  |   3 +
 drivers/virt/Makefile                 |   1 +
 drivers/virt/coco/sevguest/Kconfig    |   9 +
 drivers/virt/coco/sevguest/Makefile   |   2 +
 drivers/virt/coco/sevguest/sevguest.c | 601 ++++++++++++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h |  98 +++++
 include/uapi/linux/sev-guest.h        |  44 ++
 8 files changed, 835 insertions(+)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/uapi/linux/sev-guest.h

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
new file mode 100644
index 000000000000..002c90946b8a
--- /dev/null
+++ b/Documentation/virt/coco/sevguest.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+The Definitive SEV Guest API Documentation
+===================================================================
+
+1. General description
+======================
+
+The SEV API is a set of ioctls that are used by the guest or hypervisor
+to get or set certain aspect of the SEV virtual machine. The ioctls belong
+to the following classes:
+
+ - Hypervisor ioctls: These query and set global attributes which affect the
+   whole SEV firmware.  These ioctl are used by platform provision tools.
+
+ - Guest ioctls: These query and set attributes of the SEV virtual machine.
+
+2. API description
+==================
+
+This section describes ioctls that can be used to query or set SEV guests.
+For each ioctl, the following information is provided along with a
+description:
+
+  Technology:
+      which SEV techology provides this ioctl. sev, sev-es, sev-snp or all.
+
+  Type:
+      hypervisor or guest. The ioctl can be used inside the guest or the
+      hypervisor.
+
+  Parameters:
+      what parameters are accepted by the ioctl.
+
+  Returns:
+      the return value.  General error numbers (ENOMEM, EINVAL)
+      are not detailed, but errors with specific meanings are.
+
+The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
+The ioctl accepts struct snp_user_guest_request. The input and output structure is
+specified through the req_data and resp_data field respectively. If the ioctl fails
+to execute due to a firmware error, then fw_err code will be set.
+
+::
+        struct snp_guest_request_ioctl {
+                /* Request and response structure address */
+                __u64 req_data;
+                __u64 resp_data;
+
+                /* firmware error code on failure (see psp-sev.h) */
+                __u64 fw_err;
+        };
+
+2.1 SNP_GET_REPORT
+------------------
+
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in): struct snp_report_req
+:Returns (out): struct snp_report_resp on success, -negative on error
+
+The SNP_GET_REPORT ioctl can be used to query the attestation report from the
+SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
+provided by the SEV-SNP firmware to query the attestation report.
+
+On success, the snp_report_resp.data will contains the report. The report
+will contain the format described in the SEV-SNP specification. See the SEV-SNP
+specification for further details.
+
+
+Reference
+---------
+
+SEV-SNP and GHCB specification: developer.amd.com/sev
+
+The driver is based on SEV-SNP firmware spec 0.9 and GHCB spec version 2.0.
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..e457e47610d3 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
 source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
+
+source "drivers/virt/coco/sevguest/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..9c704a6fdcda 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -8,3 +8,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
+obj-$(CONFIG_SEV_GUEST)		+= coco/sevguest/
diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
new file mode 100644
index 000000000000..96190919cca8
--- /dev/null
+++ b/drivers/virt/coco/sevguest/Kconfig
@@ -0,0 +1,9 @@
+config SEV_GUEST
+	tristate "AMD SEV Guest driver"
+	default y
+	depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
+	help
+	  The driver can be used by the SEV-SNP guest to communicate with the PSP to
+	  request the attestation report and more.
+
+	  If you choose 'M' here, this module will be called sevguest.
diff --git a/drivers/virt/coco/sevguest/Makefile b/drivers/virt/coco/sevguest/Makefile
new file mode 100644
index 000000000000..b1ffb2b4177b
--- /dev/null
+++ b/drivers/virt/coco/sevguest/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SEV_GUEST) += sevguest.o
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
new file mode 100644
index 000000000000..982714c1b4ca
--- /dev/null
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/set_memory.h>
+#include <linux/fs.h>
+#include <crypto/aead.h>
+#include <linux/scatterlist.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
+#include <uapi/linux/psp-sev.h>
+
+#include <asm/svm.h>
+#include <asm/sev.h>
+
+#include "sevguest.h"
+
+#define DEVICE_NAME	"sev-guest"
+#define AAD_LEN		48
+#define MSG_HDR_VER	1
+
+struct snp_guest_crypto {
+	struct crypto_aead *tfm;
+	u8 *iv, *authtag;
+	int iv_len, a_len;
+};
+
+struct snp_guest_dev {
+	struct device *dev;
+	struct miscdevice misc;
+
+	struct snp_guest_crypto *crypto;
+	struct snp_guest_msg *request, *response;
+	struct snp_secrets_page_layout *layout;
+	struct snp_req_data input;
+	u32 *os_area_msg_seqno;
+	u8 *vmpck;
+};
+
+static u32 vmpck_id;
+module_param(vmpck_id, uint, 0444);
+MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
+
+static DEFINE_MUTEX(snp_cmd_mutex);
+
+static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
+{
+	char zero_key[VMPCK_KEY_LEN] = {0};
+
+	if (snp_dev->vmpck)
+		return memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN) == 0;
+
+	return true;
+}
+
+static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
+{
+	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
+	snp_dev->vmpck = NULL;
+}
+
+static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	u64 count;
+
+	/* Read the current message sequence counter from secrets pages */
+	count = *snp_dev->os_area_msg_seqno;
+
+	return count + 1;
+}
+
+/* Return a non-zero on success */
+static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	u64 count = __snp_get_msg_seqno(snp_dev);
+
+	/*
+	 * The message sequence counter for the SNP guest request is a  64-bit
+	 * value but the version 2 of GHCB specification defines a 32-bit storage
+	 * for the it. If the counter exceeds the 32-bit value then return zero.
+	 * The caller should check the return value, but if the caller happen to
+	 * not check the value and use it, then the firmware treats zero as an
+	 * invalid number and will fail the  message request.
+	 */
+	if (count >= UINT_MAX) {
+		pr_err_ratelimited("SNP guest request message sequence counter overflow\n");
+		return 0;
+	}
+
+	return count;
+}
+
+static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	/*
+	 * The counter is also incremented by the PSP, so increment it by 2
+	 * and save in secrets page.
+	 */
+	*snp_dev->os_area_msg_seqno += 2;
+}
+
+static inline struct snp_guest_dev *to_snp_dev(struct file *file)
+{
+	struct miscdevice *dev = file->private_data;
+
+	return container_of(dev, struct snp_guest_dev, misc);
+}
+
+static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
+{
+	struct snp_guest_crypto *crypto;
+
+	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
+	if (!crypto)
+		return NULL;
+
+	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+	if (IS_ERR(crypto->tfm))
+		goto e_free;
+
+	if (crypto_aead_setkey(crypto->tfm, key, keylen))
+		goto e_free_crypto;
+
+	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
+	if (crypto->iv_len < 12) {
+		dev_err(snp_dev->dev, "IV length is less than 12.\n");
+		goto e_free_crypto;
+	}
+
+	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
+	if (!crypto->iv)
+		goto e_free_crypto;
+
+	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
+		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
+			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
+			goto e_free_crypto;
+		}
+	}
+
+	crypto->a_len = crypto_aead_authsize(crypto->tfm);
+	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
+	if (!crypto->authtag)
+		goto e_free_crypto;
+
+	return crypto;
+
+e_free_crypto:
+	crypto_free_aead(crypto->tfm);
+e_free:
+	kfree(crypto->iv);
+	kfree(crypto->authtag);
+	kfree(crypto);
+
+	return NULL;
+}
+
+static void deinit_crypto(struct snp_guest_crypto *crypto)
+{
+	crypto_free_aead(crypto->tfm);
+	kfree(crypto->iv);
+	kfree(crypto->authtag);
+	kfree(crypto);
+}
+
+static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
+			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
+{
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	struct scatterlist src[3], dst[3];
+	DECLARE_CRYPTO_WAIT(wait);
+	struct aead_request *req;
+	int ret;
+
+	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	/*
+	 * AEAD memory operations:
+	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
+	 * |  msg header      |  plaintext       |  hdr->authtag  |
+	 * | bytes 30h - 5Fh  |    or            |                |
+	 * |                  |   cipher         |                |
+	 * +------------------+------------------+----------------+
+	 */
+	sg_init_table(src, 3);
+	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
+	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
+	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
+
+	sg_init_table(dst, 3);
+	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
+	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
+	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
+
+	aead_request_set_ad(req, AAD_LEN);
+	aead_request_set_tfm(req, crypto->tfm);
+	aead_request_set_callback(req, 0, crypto_req_done, &wait);
+
+	aead_request_set_crypt(req, src, dst, len, crypto->iv);
+	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
+
+	aead_request_free(req);
+	return ret;
+}
+
+static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+			 void *plaintext, size_t len)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+
+	memset(crypto->iv, 0, crypto->iv_len);
+	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+
+	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
+}
+
+static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+		       void *plaintext, size_t len)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+
+	/* Build IV with response buffer sequence number */
+	memset(crypto->iv, 0, crypto->iv_len);
+	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+
+	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
+}
+
+static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg *resp = snp_dev->response;
+	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
+	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
+
+	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
+		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+
+	/* Verify that the sequence counter is incremented by 1 */
+	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
+		return -EBADMSG;
+
+	/* Verify response message type and version number. */
+	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
+	    resp_hdr->msg_version != req_hdr->msg_version)
+		return -EBADMSG;
+
+	/*
+	 * If the message size is greater than our buffer length then return
+	 * an error.
+	 */
+	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
+		return -EBADMSG;
+
+	/* Decrypt the payload */
+	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+}
+
+static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
+			void *payload, size_t sz)
+{
+	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg_hdr *hdr = &req->hdr;
+
+	memset(req, 0, sizeof(*req));
+
+	hdr->algo = SNP_AEAD_AES_256_GCM;
+	hdr->hdr_version = MSG_HDR_VER;
+	hdr->hdr_sz = sizeof(*hdr);
+	hdr->msg_type = type;
+	hdr->msg_version = version;
+	hdr->msg_seqno = seqno;
+	hdr->msg_vmpck = vmpck_id;
+	hdr->msg_sz = sz;
+
+	/* Verify the sequence number is non-zero */
+	if (!hdr->msg_seqno)
+		return -ENOSR;
+
+	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
+		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+
+	return __enc_payload(snp_dev, req, payload, sz);
+}
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
+				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz, __u64 *fw_err)
+{
+	unsigned long err;
+	u64 seqno;
+	int rc;
+
+	/* Get message sequence and verify that its a non-zero */
+	seqno = snp_get_msg_seqno(snp_dev);
+	if (!seqno)
+		return -EIO;
+
+	memset(snp_dev->response, 0, sizeof(*snp_dev->response));
+
+	/* Encrypt the userspace provided payload */
+	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	if (rc)
+		return rc;
+
+	/* Call firmware to process the request */
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	if (fw_err)
+		*fw_err = err;
+
+	if (rc)
+		return rc;
+
+	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	if (rc) {
+		/*
+		 * The verify_and_dec_payload() will fail only if the hypervisor is
+		 * actively modifiying the message header or corrupting the encrypted payload.
+		 * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
+		 * the key cannot be used for any communication.
+		 */
+		dev_alert(snp_dev->dev,
+			  "Detected unexpected decode failure, disabling the vmpck_id %d\n", vmpck_id);
+		snp_disable_vmpck(snp_dev);
+		return rc;
+	}
+
+	/* Increment to new message sequence after payload descryption was successful. */
+	snp_inc_msg_seqno(snp_dev);
+
+	return 0;
+}
+
+static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_report_resp *resp;
+	struct snp_report_req req;
+	int rc, resp_len;
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
+	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!resp)
+		return -ENOMEM;
+
+	/* Issue the command to get the attestation report */
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, req.msg_version,
+				  SNP_MSG_REPORT_REQ, &req.user_data, sizeof(req.user_data),
+				  resp->data, resp_len, &arg->fw_err);
+	if (rc)
+		goto e_free;
+
+	/* Copy the response payload to userspace */
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		rc = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return rc;
+}
+
+static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	struct snp_guest_dev *snp_dev = to_snp_dev(file);
+	void __user *argp = (void __user *)arg;
+	struct snp_guest_request_ioctl input;
+	int ret = -ENOTTY;
+
+	if (copy_from_user(&input, argp, sizeof(input)))
+		return -EFAULT;
+
+	input.fw_err = 0;
+
+	mutex_lock(&snp_cmd_mutex);
+
+	/* Check if the VMPCK is not empty */
+	if (is_vmpck_empty(snp_dev)) {
+		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
+		mutex_unlock(&snp_cmd_mutex);
+		return -ENOTTY;
+	}
+
+	switch (ioctl) {
+	case SNP_GET_REPORT:
+		ret = get_report(snp_dev, &input);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&snp_cmd_mutex);
+
+	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static void free_shared_pages(void *buf, size_t sz)
+{
+	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (!buf)
+		return;
+
+	/* If fail to restore the encryption mask then leak it. */
+	if (WARN_ONCE(set_memory_encrypted((unsigned long)buf, npages),
+		      "Failed to restore encryption mask (leak it)\n"))
+		return;
+
+	__free_pages(virt_to_page(buf), get_order(sz));
+}
+
+static void *alloc_shared_pages(size_t sz)
+{
+	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+	struct page *page;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
+	if (IS_ERR(page))
+		return NULL;
+
+	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
+	if (ret) {
+		pr_err("SEV-SNP: failed to mark page shared, ret=%d\n", ret);
+		__free_pages(page, get_order(sz));
+		return NULL;
+	}
+
+	return page_address(page);
+}
+
+static const struct file_operations snp_guest_fops = {
+	.owner	= THIS_MODULE,
+	.unlocked_ioctl = snp_guest_ioctl,
+};
+
+static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+{
+	u8 *key = NULL;
+
+	switch (id) {
+	case 0:
+		*seqno = &layout->os_area.msg_seqno_0;
+		key = layout->vmpck0;
+		break;
+	case 1:
+		*seqno = &layout->os_area.msg_seqno_1;
+		key = layout->vmpck1;
+		break;
+	case 2:
+		*seqno = &layout->os_area.msg_seqno_2;
+		key = layout->vmpck2;
+		break;
+	case 3:
+		*seqno = &layout->os_area.msg_seqno_3;
+		key = layout->vmpck3;
+		break;
+	default:
+		break;
+	}
+
+	return key;
+}
+
+static int __init snp_guest_probe(struct platform_device *pdev)
+{
+	struct snp_secrets_page_layout *layout;
+	struct snp_guest_platform_data *data;
+	struct device *dev = &pdev->dev;
+	struct snp_guest_dev *snp_dev;
+	struct miscdevice *misc;
+	int ret;
+
+	if (!dev->platform_data)
+		return -ENODEV;
+
+	data = (struct snp_guest_platform_data *)dev->platform_data;
+	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
+	if (!layout)
+		return -ENODEV;
+
+	ret = -ENOMEM;
+	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
+	if (!snp_dev)
+		goto e_fail;
+
+	ret = -EINVAL;
+	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
+	if (!snp_dev->vmpck) {
+		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
+		goto e_fail;
+	}
+
+	/* Verify that VMPCK is not zero. */
+	if (is_vmpck_empty(snp_dev)) {
+		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
+		goto e_fail;
+	}
+
+	platform_set_drvdata(pdev, snp_dev);
+	snp_dev->dev = dev;
+	snp_dev->layout = layout;
+
+	/* Allocate the shared page used for the request and response message. */
+	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	if (!snp_dev->request)
+		goto e_fail;
+
+	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	if (!snp_dev->response)
+		goto e_fail;
+
+	ret = -EIO;
+	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
+	if (!snp_dev->crypto)
+		goto e_fail;
+
+	misc = &snp_dev->misc;
+	misc->minor = MISC_DYNAMIC_MINOR;
+	misc->name = DEVICE_NAME;
+	misc->fops = &snp_guest_fops;
+
+	/* initial the input address for guest request */
+	snp_dev->input.req_gpa = __pa(snp_dev->request);
+	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+
+	ret =  misc_register(misc);
+	if (ret)
+		goto e_fail;
+
+	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
+	return 0;
+
+e_fail:
+	iounmap(layout);
+	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+
+	return ret;
+}
+
+static int __exit snp_guest_remove(struct platform_device *pdev)
+{
+	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
+
+	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	deinit_crypto(snp_dev->crypto);
+	misc_deregister(&snp_dev->misc);
+
+	return 0;
+}
+
+static struct platform_driver snp_guest_driver = {
+	.remove		= __exit_p(snp_guest_remove),
+	.driver		= {
+		.name = "snp-guest",
+	},
+};
+
+module_platform_driver_probe(snp_guest_driver, snp_guest_probe);
+
+MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
+MODULE_DESCRIPTION("AMD SNP Guest Driver");
diff --git a/drivers/virt/coco/sevguest/sevguest.h b/drivers/virt/coco/sevguest/sevguest.h
new file mode 100644
index 000000000000..cfa76cf8a21a
--- /dev/null
+++ b/drivers/virt/coco/sevguest/sevguest.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * SEV-SNP API spec is available at https://developer.amd.com/sev
+ */
+
+#ifndef __LINUX_SEVGUEST_H_
+#define __LINUX_SEVGUEST_H_
+
+#include <linux/types.h>
+
+#define MAX_AUTHTAG_LEN		32
+
+/* See SNP spec SNP_GUEST_REQUEST section for the structure */
+enum msg_type {
+	SNP_MSG_TYPE_INVALID = 0,
+	SNP_MSG_CPUID_REQ,
+	SNP_MSG_CPUID_RSP,
+	SNP_MSG_KEY_REQ,
+	SNP_MSG_KEY_RSP,
+	SNP_MSG_REPORT_REQ,
+	SNP_MSG_REPORT_RSP,
+	SNP_MSG_EXPORT_REQ,
+	SNP_MSG_EXPORT_RSP,
+	SNP_MSG_IMPORT_REQ,
+	SNP_MSG_IMPORT_RSP,
+	SNP_MSG_ABSORB_REQ,
+	SNP_MSG_ABSORB_RSP,
+	SNP_MSG_VMRK_REQ,
+	SNP_MSG_VMRK_RSP,
+
+	SNP_MSG_TYPE_MAX
+};
+
+enum aead_algo {
+	SNP_AEAD_INVALID,
+	SNP_AEAD_AES_256_GCM,
+};
+
+struct snp_guest_msg_hdr {
+	u8 authtag[MAX_AUTHTAG_LEN];
+	u64 msg_seqno;
+	u8 rsvd1[8];
+	u8 algo;
+	u8 hdr_version;
+	u16 hdr_sz;
+	u8 msg_type;
+	u8 msg_version;
+	u16 msg_sz;
+	u32 rsvd2;
+	u8 msg_vmpck;
+	u8 rsvd3[35];
+} __packed;
+
+struct snp_guest_msg {
+	struct snp_guest_msg_hdr hdr;
+	u8 payload[4000];
+} __packed;
+
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPCK.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec version 0.9 for secrets page format */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imien	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
+#endif /* __LINUX_SNP_GUEST_H__ */
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
new file mode 100644
index 000000000000..eda7edcffda8
--- /dev/null
+++ b/include/uapi/linux/sev-guest.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Userspace interface for AMD SEV and SEV-SNP guest driver.
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * SEV API specification is available at: https://developer.amd.com/sev/
+ */
+
+#ifndef __UAPI_LINUX_SEV_GUEST_H_
+#define __UAPI_LINUX_SEV_GUEST_H_
+
+#include <linux/types.h>
+
+struct snp_report_req {
+	/* message version number (must be non-zero) */
+	__u8 msg_version;
+
+	/* user data that should be included in the report */
+	__u8 user_data[64];
+};
+
+struct snp_report_resp {
+	/* response data, see SEV-SNP spec for the format */
+	__u8 data[4000];
+};
+
+struct snp_guest_request_ioctl {
+	/* Request and response structure address */
+	__u64 req_data;
+	__u64 resp_data;
+
+	/* firmware error code on failure (see psp-sev.h) */
+	__u64 fw_err;
+};
+
+#define SNP_GUEST_REQ_IOC_TYPE	'S'
+
+/* Get SNP attestation report */
+#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
+
+#endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.25.1

