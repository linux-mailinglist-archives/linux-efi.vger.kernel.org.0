Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE483BEE8C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGGSVh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:21:37 -0400
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:21697
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232406AbhGGSVA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqFYSo6znlzYi/XSmwlsKMfH6UiRv5+HtGnPVxEXGc8A+Nyie+V6xcS5VzPM6r0kakFyD1veedRtjTwlp6pgwkD0cOI3aj2PBPtMnilBzpINSDY2iILDLHp4161WKWVt9H2HIF63LnjST/joNuF57ya3xY3AQU1VCQIUeYi9jM+fIz3sCLpqpz9E6zaEwaHoG+fc/f07Agk7sr9dGThHd1TImgc5Q6iOpEEo7hQt+ptYw9Q0qSRIch820jHfQ740Os08DmkHiaXXYocosZQ6RdSGUYzplI0ldXZ7bUI+6IMSzgid5/xYwfHUVqWKs+f6z5wMxAc/yCNUIyQ4A36PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR23niDP6KqzoZ++CMef5OYnX++6222K6rIuW+vAly4=;
 b=W2s424oX8KerALJ57Y5H245CiKX6cxWhS8w36zuFhFNVbp9YwJh3GTE4GKG5whpuA9ccT7bHmkvB5xJVjJaC7SKtu1Cfi0fnpDlYdhpuI0TAcKAQyDbjJNWhKc81LUIZqGq4CGfFaaJrQR+d5nMvZ7t1unpCZi4onW+qATTi+wYiYOvtG9fnehJMFTTCOdtNrhXYeGM2LM4ntRErZUuDT4x/yBP3wuVRpys7T0wNHk7LOk0PHcPXjPbVyPZ8wy73KIHKXCA/w7U4UxkkWgvEmlkBL08NITBIngv6VqGgkhlr7nHin8qEEJSxUt8B9UrW5HFPxJ0nrDvBjbm5aVw8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR23niDP6KqzoZ++CMef5OYnX++6222K6rIuW+vAly4=;
 b=WVdPB02OB76eQroV759C6fEH3uxQOrG44YQVfdYQzh5Z9zvuSmQd8r2zxGpkQWEbw/TDgnIsUqcYQR/Gw/E8lrQci6UvqpeBKOC5eboRM3vi0cSfQXIuNiKPx7VKauQm4rqQAyb9BNlYGxbU0+Tqcjyz2CBxbbrkKm9LnkhavUI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:56 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:56 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 34/36] virt: Add SEV-SNP guest driver
Date:   Wed,  7 Jul 2021 13:15:04 -0500
Message-Id: <20210707181506.30489-35-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55973e93-e350-47bf-5363-08d941736704
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3683629EC5857C6075B8E479E51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlITFMYdB7zBQh0R+TQFN4lbBwRgVnp8A9uZdLePyM8dJ4rN7EqAPKc33FoVXYLOyk2AkRGfsP4BvnqYuFEddytA7WgGO9wMVy/VQ3d4sL7OMGdASYqEceMupea5keB58jmwLbGzv9DCsrNcbJ4+ex+BM6v10NKQdi1Il8JzCE+tIk8ECt7e3v6WTWrWypsuEKpsS1bnKQu2sFkJQodTK7N9tb9zXKUBQjn4d5LHvnKU9g3+63Hiov8ds0dd+acRkAReTwMFCfPR4dUvAK/uHtuUFmOAUPWtI2kK5jrVUx2WoGZnJGJm1x4BnwmBSjhZvNP5kMPi22KcZAO7dgsDZ19gBbtUe1CUbG4tL8NtskJMUm4bgY+oNrv+/CZiSmIoqNphGMCwDe+c/dkRtXNmet1N51H/DSW6k5TypGwaTDbr+QjOVWTabGZ+hKXB7myI1TiHf36F5U/hkiFpbZtp+YNwtAdlEWCEE2/m1dGtkalQrDMzMD2RoB/NEF9G47rAFWTZq95YWlGZ2OuJ4Fqz/X1IVyxJI4d/ww3mHCJY/+nG1yjxGgfXCODxi3EZ7wVo1An/swFwdmY8IKhsmWgRQQo7Es/pCZ6oSObGTftLYga1sM1utp3rfWlh0/zBzSSbUsGwTf0hA+6S9BUgdpIFLXQB/1copbmQOl+4eWPQlzyoQecajXDNPoJdOuuwG6RpdEoenytoLZESMqSwMrDPGeI/kUsMyEAzTmJKJPuZtAZNhuDgNLuRUduybYN7R2L0iJvKS56DNlm9xkp9/BVrsjv8jhbx7ol9Gd8j842Tbb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(966005)(38100700002)(52116002)(186003)(6486002)(498600001)(7696005)(30864003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N523uKV03FMUVjZlLkolFFRZxOsZjwGF+fOLPMS36EPAoam3QQcvTr8Y8MCk?=
 =?us-ascii?Q?XUYtVhMcpPgIGIGu4Gckmqgyo33bjv121sRR5kzdvllZ80+uMuFf7KSce3T9?=
 =?us-ascii?Q?q6bXIRs6psFaoGVW3TzeqlEX0c7Znu4lYN6aiU6+nDZwGgtXdDePqG6OF0Et?=
 =?us-ascii?Q?R7lFaIfp5kpkJLpu84o5HIdluY49S1Xphn/xpqql693jHTxRUuDaISRlCj76?=
 =?us-ascii?Q?okfoZ1CavwRk75YPjCBAlrTXDMWH0ze+FgiOx/XMMVQqLeQ/O0YMSq3LgUKh?=
 =?us-ascii?Q?Pi3DnTmYR0AZyp9O558S2lNcRQbC/S0QeRvCiNvu923pNSom6ehEw4MDpNR2?=
 =?us-ascii?Q?XWJBgN0TL/Dz60WM6jV04A0rWlDDLJgF43VerLs1022zKOITBzJBX0ffGQLs?=
 =?us-ascii?Q?R2BN+I3Xbn1PPn202QXHWc/9kDsFircbEkXFrlG9qmTZMIW/WicFxS/qnbOp?=
 =?us-ascii?Q?HI6I/BOrAQdSSWpU2oFAPzNas4f4m915H/ceGM6I14Xn9NNV8E6GR52XAgH3?=
 =?us-ascii?Q?85amthwBuc7Xk9Ic/SlUTMavyKqrpjXPn6bWqdrysDHxcFj5bLuRA1fO41FM?=
 =?us-ascii?Q?j8rhABp2mduJkFWjeOPg3Un5XG9c2+MeJthS0CKk4rKugJ17UKL6RcmbXNtA?=
 =?us-ascii?Q?icHgHlSfYqorJso2vVNTMsU1ccNYfI09tJkqbJ63gU3F72M8wrH2Xs/aguPr?=
 =?us-ascii?Q?gZTHtNyAIYSXPm1z1EELfBy8HKO1jYQ02bAronuUCyK1c7nD9kT7w4uzAEsK?=
 =?us-ascii?Q?qVctpyI9FTdtzmK9t/krUlLYE4SKVJAwSnMc44pSW/uFp7Xgj65vbkNScu+Y?=
 =?us-ascii?Q?ZbI4y28qEDvPGvf4L8Gk6TBlKyagfa9AMI7CpAem3bkebG5TTLOwrWohoiTc?=
 =?us-ascii?Q?9WfvWk8DpSEBG2knuUDogCU43q3+8dHa579gGaJLhe/bsxjrNOdObJZBDLAG?=
 =?us-ascii?Q?lKO2XU/1bxvnqoX/v+Im6bp0BQ9n9BpqLTduBQF5EMEtNiQ85zEI68AF5Vo2?=
 =?us-ascii?Q?DLAghUPht44XeeWQJoheRxHPE8HIQJEAZoblUU9dvw9rME/E2kAjAI8nhhHo?=
 =?us-ascii?Q?AD9iL07xh+onmi/W7B/UXqLlWYSWvUluhBDqF+O+OPQVxlBln+EFEXj7Pjaz?=
 =?us-ascii?Q?Rihqlxpf5CxAKeAb+I2We0A0DjbRMIKjT4GAjFurtPrlQHAY0tQ9TodTOAQC?=
 =?us-ascii?Q?esuREHZz3UqhJhoSW9I1EEvwbxIq/0JT+OS9wN/TXIUnS26F2gGAPo/ahBBx?=
 =?us-ascii?Q?67IlmT6zDwfA2++B7YUeYINpIZ8Nj2r594VU6hGQjWFkbh2jVW62KdKYuJm3?=
 =?us-ascii?Q?ueRgbh/4ivu0MVXSm6vM6p2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55973e93-e350-47bf-5363-08d941736704
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:55.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+l2+4TjKIFoIwL14aXcAu/uN/SYv3YYd/ymhvDVUDWX2SRuL7hEVawZR8bHz38REU47b0nUVPif8DkIqJaMXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
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
 drivers/virt/coco/sevguest/sevguest.c | 449 ++++++++++++++++++++++++++
 drivers/virt/coco/sevguest/sevguest.h |  63 ++++
 include/uapi/linux/sev-guest.h        |  44 +++
 8 files changed, 640 insertions(+)
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
index 000000000000..f3f86f9b5b22
--- /dev/null
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -0,0 +1,449 @@
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
+	uint8_t *iv, *authtag;
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
+static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, uint8_t *key,
+					    size_t keylen)
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
+			   uint8_t *src_buf, uint8_t *dst_buf, size_t len, bool enc)
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
+			     void *plaintext, size_t len)
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
+	if ((resp_hdr->msg_type != (req_hdr->msg_type + 1)) ||
+	    (resp_hdr->msg_version != req_hdr->msg_version))
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
+				 &req.user_data, sizeof(req.user_data), resp->data, resp_len,
+				 &arg->fw_err);
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

