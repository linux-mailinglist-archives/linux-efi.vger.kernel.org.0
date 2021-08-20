Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D953F2F5C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhHTPZk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:40 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:55424
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241693AbhHTPYL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:24:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbKoEhI6FdEepLtSN1xzdTnLXXgr30q88geILL7K0VCMh/9QVt07WSg5n0UwVSdUt3AI7LC66g7zQv0aO+1KULzqgBfq6lI0cPBSgoHuuV5oVAyoTwbVGvG8aVrA7OpeWQJJCme6mPuDxmjKI3UytTWx5YRP1ZPfd1+XOHYa7Kq0KXLGZuZHQ8sHKm52D3FEKcMAhInMkG6R2TZMr84OwSZ2wGwlNTLsTZrQxokANvRN6J1f+W9ree5lKbuDlDOC8K9jMT9DIPwMtDBuX6+4kJ1owOVrmgcBtEvXGtTprxeZiMSHdztkMCTrUXVWZTVse5ltH2opCWiprPb70pgl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ8+m52Wwk4SOIkv2bA6CL8WxWzZ4G0YpJxaGEu7Hzc=;
 b=PLSzxbLXgF6y0Qk/2T4Of8XtdQnEwSXW4P1oJ7vGwYWJ3W3pEBL61CswTusnlprbcEujzAjHifC7ze9avnMEnPN3YLbDgEreiP6ER1rw5Z9XZoJFmja76OhMLzuS/kU5N5ELSGeFzb4BZn+n5uvk0Kruq7PA+8XtF37f1iQs6rJu1DWff9Omtit1SmrFAD9iZJgSWEEUlHpHDdwEUgYd795Ct/FPxkWHiax9DHnNBudWRbmapB6JdVj0Xr0e/Ilxr/rNoBgdTwV0wk2XrHptapecPNR9sO/weQzA3lnJxBZjF5DVmFkBn6oDCRm6wyWSflANTNDuA8jhbLt4DZb6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ8+m52Wwk4SOIkv2bA6CL8WxWzZ4G0YpJxaGEu7Hzc=;
 b=z0c4yMb9Yxlrx2SZYzYoxUEfhI0942Mca6pIzxW/SNTgNQr4PdhdZNoCTYj63Z8e1OASdbjwkkGTTcJdeCVBHhN00zPWJgn9JzzWapfT4PrpjnoYDr9eum/Xt7OyY3ZHBS5jhUhHYU35TT+UhVCnkfoF8ZLqSYqWFaIahyy6C0g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Fri, 20 Aug
 2021 15:22:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:22:04 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 36/38] virt: Add SEV-SNP guest driver
Date:   Fri, 20 Aug 2021 10:19:31 -0500
Message-Id: <20210820151933.22401-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ff181e-dc65-453f-c6a2-08d963ee3207
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637FA507F3AC9A5DF1A6F55E5C19@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8XxSv95lmTeMdoljh1BUnVw4+ojoou6ynm1UCTUHsz6sMa4Zu/WiFq3KncOwapsbLm5Z0Y8NxWC685CvA2s2lJa7rvL8ZJhZULPyx+jmOgocRDHBv77ZuONOuCJ+OplER3H8zEhzYaw/2kp+IJpZzo8S/iTdHyXRBPBFSXjOmUWpmIg/hZ5xw29upPqcZhY8K89BToLPvtv3v7eiDqY37OXKKyGxrK2L0jYXabux4vyJfwF3nnothbwXbUvJPyo4nNwgFcF13ebWrX0HLR016AAM3NW7Ezyh3wj6bim5mIA7gPOWQZx90IM3iMq2IKrWPPWjAeuLOpsKBiS7jafWCff79srUi+ioJaYQUDMVrfgv49PDpqXR2pn1GmvpXiuG7F77V8mix82evXWre6zo0TTuDRgbmLOx2zXVt5dbdP6g0pWmjK8Hw7Q3FwF1opfc84R+sbJDM1fzymMtbSD0lehW3dwsMdytSs8BNTf1PXp3Os957ITUSaTAjH3Gr8BVYJpdaIHXhk/hX4VdMMcapSn0VM/nm5m/W9RX64ZRxzPPPwiybgYAysBE7pG9pM3ztE5Wfr7//m9nVkLz79REA9ThJeIKexSdeHyHvPxt3LIufskOSdSLe8RnkVBCTmMDpYrX0TF7l9ntsi1DVf6XjycNgv9zyUERDhfoT9XOPpOz8e2qI4E+6joCith7R4FKnjygg+Eum1mR4mJhs//jbB5VXHpePGOWe3sXfinC5Lf70G0kaPJKXGCZ4Wi++Ys+3/nOm+LFuFnlYhn3ycxJbLcGDwa35KOV+ZqXCjFTj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(36756003)(956004)(8936002)(2906002)(4326008)(52116002)(8676002)(83380400001)(2616005)(26005)(86362001)(7416002)(7406005)(186003)(66476007)(44832011)(38100700002)(54906003)(5660300002)(7696005)(38350700002)(1076003)(316002)(6486002)(66946007)(966005)(478600001)(30864003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umYcCb+QI+Md9ld5f0jWFwg1zCEYbbw4EYyLoKys7MDhkf4kvkzhyU4wkn1c?=
 =?us-ascii?Q?yNVvkKdYC/8FnnzPzieP0dRioqzmGGbyThKGHGrtfLUUUD80q1wtz6zSCcR/?=
 =?us-ascii?Q?++RmBcLjjjwd86q0diAbMucf9KDJ0NbQT52zE0Ws9+qjYY04sH3lC68uemph?=
 =?us-ascii?Q?wcm7D+5/r1Nah+iuy6j8mJcoIJxIV1A34FXR4Yg+pm5v0KwxvcsSZxD6Iesf?=
 =?us-ascii?Q?rkL+RcRMAwNJ96pbYRW/rLizugcjMunP6ubbXa0XezWlugDZ6Yk10eql0JN+?=
 =?us-ascii?Q?QBPXe+lZa4WUQIRZX2OoHPoiI9AxEd+CatktXlgrC5httzMoet7r6bC8FRkO?=
 =?us-ascii?Q?42JDQgQTrSqsbI2PfxWg108yoRAWPdt03la4WS0sWXnDoX0ZpF/98IaH0VaR?=
 =?us-ascii?Q?BduEzwpP1+LO59XD+bKMQ2vVZLrOBpQGqgxYf71tVCVUJlvfNDRyesljZ22G?=
 =?us-ascii?Q?MzvA6tHW+o2SYJ2cgKHv5VK0/gEOo5I8zQIrE0qfDRKTfPZ76/b0qDCojbjN?=
 =?us-ascii?Q?ReGPulMyn4REErTjxCfimpGXFTsM5V+LgtqeaQOcPs2Z4nUSVC1HyDJSb7bj?=
 =?us-ascii?Q?lWQTP1oUbXC/omWZZVtD1S6PT/es/R9q3RX1FkpIenikf2DD2QwkbTqt4bUZ?=
 =?us-ascii?Q?q1nG8GY/wFm0LPejDaP1FfrQiQl90+9jV3QrQ1so4dpY370Ikbe1K+O/zrTk?=
 =?us-ascii?Q?xCwggZ0270e4qn5y8rTxalmTccfKjBvT7dZpRc8/BMQkLPrey8+AwRG+0Fy0?=
 =?us-ascii?Q?URwvw+tyycWjINZK1WyMO6Eb5aqP6zIfVamZia0PJ7CiYEGhdFpUckIwbQxm?=
 =?us-ascii?Q?3oYgz3ZX9gILocMxd5Ogyckjjn9S36+JDUIlYV7t6kLFqqJ7m6gtHdsEQcO2?=
 =?us-ascii?Q?ygcu65cJouZdxG0YEWniVwyCU6yZ86LhfXmwRLvFz7D+N+saN00zbbw1CCtp?=
 =?us-ascii?Q?KoRPtPF21GObcnWK9gzmi3cVJvtepb9C98TSE3UcKaXkAb2Md29mD+3PfUdf?=
 =?us-ascii?Q?SsG6jXwQLwSzEIPFzGsQo+t7bJ/y1/xHF7rlVdBnjFb7grqvvAM6P3KPkFrm?=
 =?us-ascii?Q?uIliiXpFTsJxAAQNRSzzANFZkecuHkke6lzyBw6SsG6uBnD2GN51xM3E9mvB?=
 =?us-ascii?Q?3QqnaQJeOQv6OSfFAt2wST8Nbri0uB84QlOi0jL9eVKGZtIkFaUI9jORrUEC?=
 =?us-ascii?Q?S4CzSUiHRRpnm0iHnE0NRhz6CVT7D7NAnMhJYdms/1mQxnoIZkX+6gMrv70Z?=
 =?us-ascii?Q?ugA4OErzCSWAGNHFHcqU2Uro7wab5nahk9mLEpPol67aeQlxgaaH9ZyK3hO4?=
 =?us-ascii?Q?Xw19GPlQGc1lckeXR7hZSBMc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff181e-dc65-453f-c6a2-08d963ee3207
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:34.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPwe1Mv5kOz2DwhJ5SANuOEZdd9WSMz4NBqpgo7l7UWKXk4wLRa06EIFzXyZ5mOcs+fQc2Ge9Ewxr9zhi8kyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
 Documentation/virt/coco/sevguest.rst  |  69 ++++
 drivers/virt/Kconfig                  |   3 +
 drivers/virt/Makefile                 |   1 +
 drivers/virt/coco/sevguest/Kconfig    |   9 +
 drivers/virt/coco/sevguest/Makefile   |   2 +
 drivers/virt/coco/sevguest/sevguest.c | 448 ++++++++++++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h |  63 ++++
 include/uapi/linux/sev-guest.h        |  44 +++
 8 files changed, 639 insertions(+)
 create mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 drivers/virt/coco/sevguest/Kconfig
 create mode 100644 drivers/virt/coco/sevguest/Makefile
 create mode 100644 drivers/virt/coco/sevguest/sevguest.c
 create mode 100644 drivers/virt/coco/sevguest/sevguest.h
 create mode 100644 include/uapi/linux/sev-guest.h

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
new file mode 100644
index 000000000000..52d5915037ef
--- /dev/null
+++ b/Documentation/virt/coco/sevguest.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+The Definitive SEV Guest API Documentation
+===================================================================
+
+1. General description
+======================
+
+The SEV API is a set of ioctls that are issued to by the guest or
+hypervisor to get or set certain aspect of the SEV virtual machine.
+The ioctls belong to the following classes:
+
+ - Hypervisor ioctls: These query and set global attributes which affect the
+   whole SEV firmware.  These ioctl is used by platform provision tools.
+
+ - Guest ioctls: These query and set attribute of the SEV virtual machine.
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
+The guest ioctl should be called to /dev/sev-guest device. The ioctl accepts
+struct snp_user_guest_request. The input and output structure is specified
+through the req_data and resp_data field respectively. If the ioctl fails
+to execute due to the firmware error, then fw_err code will be set.
+
+::
+        struct snp_user_guest_request {
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
+format is described in the SEV-SNP specification. See the SEV-SNP specification
+for further details.
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
index 000000000000..d029a98ad088
--- /dev/null
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -0,0 +1,448 @@
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
+#include <linux/sev-guest.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
+#include <uapi/linux/psp-sev.h>
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
+};
+
+static u8 vmpck_id;
+static DEFINE_MUTEX(snp_cmd_mutex);
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
+	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+}
+
+static bool enc_payload(struct snp_guest_dev *snp_dev, int version, u8 type,
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
+	hdr->msg_seqno = snp_msg_seqno();
+	hdr->msg_vmpck = vmpck_id;
+	hdr->msg_sz = sz;
+
+	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
+		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+
+	return __enc_payload(snp_dev, req, payload, sz);
+}
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, int version, u8 type,
+				void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz, __u64 *fw_err)
+{
+	struct snp_guest_request_data data;
+	unsigned long err;
+	int rc;
+
+	memset(snp_dev->response, 0, sizeof(*snp_dev->response));
+
+	/* Encrypt the userspace provided payload */
+	rc = enc_payload(snp_dev, version, type, req_buf, req_sz);
+	if (rc)
+		return rc;
+
+	/* Call firmware to process the request */
+	data.req_gpa = __pa(snp_dev->request);
+	data.resp_gpa = __pa(snp_dev->response);
+	rc = snp_issue_guest_request(GUEST_REQUEST, &data, &err);
+
+	if (fw_err)
+		*fw_err = err;
+
+	if (rc)
+		return rc;
+
+	return verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+}
+
+static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_report_resp *resp;
+	struct snp_report_req req;
+	int rc, resp_len;
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/* Copy the request payload from the userspace */
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
+	rc = handle_guest_request(snp_dev, req.msg_version, SNP_MSG_REPORT_REQ,
+				  &req.user_data, sizeof(req.user_data), resp->data, resp_len,
+				  &arg->fw_err);
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
+	struct snp_user_guest_request input;
+	int ret = -ENOTTY;
+
+	if (copy_from_user(&input, argp, sizeof(input)))
+		return -EFAULT;
+
+	mutex_lock(&snp_cmd_mutex);
+
+	switch (ioctl) {
+	case SNP_GET_REPORT: {
+		ret = get_report(snp_dev, &input);
+		break;
+	}
+	default:
+		break;
+	}
+
+	mutex_unlock(&snp_cmd_mutex);
+
+	if (copy_to_user(argp, &input, sizeof(input)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static void free_shared_pages(void *buf, size_t sz)
+{
+	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	/* If fail to restore the encryption mask then leak it. */
+	if (set_memory_encrypted((unsigned long)buf, npages))
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
+static int __init snp_guest_probe(struct platform_device *pdev)
+{
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
+	vmpck_id = data->vmpck_id;
+
+	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
+	if (!snp_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, snp_dev);
+	snp_dev->dev = dev;
+
+	snp_dev->crypto = init_crypto(snp_dev, data->vmpck, sizeof(data->vmpck));
+	if (!snp_dev->crypto)
+		return -EIO;
+
+	/* Allocate the shared page used for the request and response message. */
+	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	if (IS_ERR(snp_dev->request)) {
+		ret = PTR_ERR(snp_dev->request);
+		goto e_free_crypto;
+	}
+
+	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	if (IS_ERR(snp_dev->response)) {
+		ret = PTR_ERR(snp_dev->response);
+		goto e_free_req;
+	}
+
+	misc = &snp_dev->misc;
+	misc->minor = MISC_DYNAMIC_MINOR;
+	misc->name = DEVICE_NAME;
+	misc->fops = &snp_guest_fops;
+
+	return misc_register(misc);
+
+e_free_req:
+	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+
+e_free_crypto:
+	deinit_crypto(snp_dev->crypto);
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
index 000000000000..4cd2f8b81154
--- /dev/null
+++ b/drivers/virt/coco/sevguest/sevguest.h
@@ -0,0 +1,63 @@
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
+#endif /* __LINUX_SNP_GUEST_H__ */
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
new file mode 100644
index 000000000000..e8cfd15133f3
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
+struct snp_user_guest_request {
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
+#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
+
+#endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.17.1

