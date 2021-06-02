Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877D1398BBF
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFBOJI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:09:08 -0400
Received: from mail-dm3nam07on2075.outbound.protection.outlook.com ([40.107.95.75]:17697
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230445AbhFBOHx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOgECZfvxhR57Srnx5a6m0JBRxR80FkK2FDvJyqZelHaVYTfa5j4GYPTxnL9AcfAUg3xXKPsvBYUsMP20/uJWGjHLAhG1Md4JLO2ESQVvpdXSpWx/dNdWIRkVSevxRb1C8HFsHe5lfdsKFuR+pH0xa6eBGnx3nunUJWTMAFgRIePasf4YxW53QtFOwbOqJjJuwaIOY0BiP2R7SfWkCXKWnxL8koWAlICeXxhQvsv6ynpGUdQqaDRMm+hG7WSMBtn8pBCM3bWmLOOmpDYF4t+NZkx0LmoiAcKPOpXon+YyIDCykC7f7HVY3XPqOIFj4dM2ou06L1Mla/ulL57l5B3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJmw1kbpTVt2WC6F6eysFi7+4/+/zkbL7V1MiJ4BhvE=;
 b=Lf88bDQv7odM10VuFrmhqyeoHI4xmgAYlZv0yn5T69TqW6/ff0hVZURfQBm494CTo5Kd1nxiEc/fZr3OCgNQjrE+c4ZvHvqGcLUdKoGp7NANWk7O5y9gkdc9vSxgv059jmiWbgsF50YxeghbuJ8WyTDeq6GD9uXORoXegHZAt/IWhZdx0YYUoCp/XxHnEU2aPvxQEdsLmit7rOnkjHSPhzMYty9JmbP3YCsCiltZ51JNbUcQPcVdSaLh+4b1CvCrUBXMQlDgNi2RRMWuZZM/LJlQ7lJXCWTJR4xgq3w1zF7YXi8R/cWAYN1AivyawHGpHLYx7EmX1elodZnfcXo7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJmw1kbpTVt2WC6F6eysFi7+4/+/zkbL7V1MiJ4BhvE=;
 b=pcmeFPq+vJxrs9q0hCp5Vz/qL+TrEvWSnNVdI7kc8rxTD/B1wupN6KzlnwgORKLwbYn3m+ufXGr8YX1kHpf0sFHgcKKDLiPLHiNfviouVKrm9MEB+jD85Ia2Jtx6cmjCNOQLSaSycx3JBVi8B5s3+vJkwO0lDlfe6wyWj1qGQ+g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 14:05:26 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:24 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
Date:   Wed,  2 Jun 2021 09:04:16 -0500
Message-Id: <20210602140416.23573-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f33ebab-d25c-485d-832f-08d925cf7790
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592A0C4C93D8AD840527B04E53D9@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFbfdpwqLB3WkNLpXXSf7YDbbVgryAfGRyBvwLWjme8lyPsa9o+cf2SgsO3+ancFYX09kVw0DRHCWPe9lwp44ZqXqAQb5pIoaxqzdAmNrMb3CgY20AqbNZ132t9XtbUfwarnOQL/nZ5XlLrQqK7jeBlYfrIbtaQ94j/Y9E1wdVdRn4HcWa79WPiI+GhWnzhS7bDUxUNs9ERD5ireX+ZIsZUvLorxLlYhyFTDYWzh4wfLVwnqcWbSh80zUuY2rR1VC86tGEhHM4cVX7o4fcxkHMw63as8gDaYaK1piXs8lAn+FAwA1rlHqCqMQEm9R6NZ7VYXXHPD0+P45c2ZRpIESdXWW9lE/LIE1sU2tfprLVAFCeseut52g6fusDrXg1S3oF+epq8yh47e42Hv5ErI7pQDr1uSDyF6ludvTMMVT9Pmfg7Gp1TtsUubcA8LRoXPCzBUzyjcXP5LC9+lBCDL/GsKduWseyce+gw4a63IpSm+cTBQuc1oP/iCvRoBjALxM6Ju+qCHHH11UceTcG5BZOy7s//6F806sQZMM5XNBqol2kRcXQwjZZIwmwSHHTaNGF46lWVvRGIskt3BRozjoB4vZRoGShGuu70MwmzyOd2Wv9JrCQlF5siXdmPdpG21UV2F4lwis7nNCn+fdlNlQWyh23250fv2n7xp4v6iXKUYmsoB+d4ziZlfozop1Z78Jk25QIUtADWPNR+jQqzql5MTT7cvCKw7/2FgAgCk5X5NOE5yp23GriG2nJCg1OILI3JPJnUQ/+kZk3x+934Eug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(966005)(30864003)(956004)(8936002)(8676002)(36756003)(478600001)(54906003)(83380400001)(1076003)(44832011)(2616005)(6666004)(38350700002)(38100700002)(5660300002)(66476007)(66556008)(2906002)(66946007)(4326008)(26005)(86362001)(186003)(7696005)(52116002)(16526019)(6486002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5z7VgVKJI8WtuHI5+FmrfBrPritOMXHqisoUv1dZ2nTW9KbbzI22pu3iY0Wd?=
 =?us-ascii?Q?uVfm7WZ9FfRE+br+1e5CKwWmIUlh3n+zWnPDEYFDrXCJrm7gifwseE1OoQ1q?=
 =?us-ascii?Q?xVGsVjwx8YlhfEwemOIRd8/xA+io0c9pj8ggpNvlGqXNdAqh2VAHDvCSxGd+?=
 =?us-ascii?Q?3mY3QY7i7lNOlEMtzuYmrn9HXz3ss1WfqqeVCUpJ2IECL19VNQF4dnzZcdSh?=
 =?us-ascii?Q?/zohFDlsDUGsWHTCMykSBnyck+4fqzvk9XsaH7WUPZNky6bbM1RGaVCU2fEG?=
 =?us-ascii?Q?fvHEkMMzIzyWyQRDAQa/pJo8WHAXj2vBbgTqrTIrEZVdiDHK2RAQp8jI36+D?=
 =?us-ascii?Q?tagDSuc11vgtzpc9iH/Wqy/pI3zpgNgN+WK9MroM1WtW5/RqgYEyTq9hcjtl?=
 =?us-ascii?Q?1U9v7AVbK30UgG594PmRjssTYjMQdFT+nLtDcCMTGD0ROkNZo+Obp2mZd6nU?=
 =?us-ascii?Q?UgOhI51M4YMrbaFg3rSdfXw07ARhEgHjQuGq/NrgXT4RqBzv6r1n42wbBKSX?=
 =?us-ascii?Q?ml5WU8JcNW6syfmlGixCm87ShLMgptNi/gVqms4db7yFekIlHnszX6dkCx2M?=
 =?us-ascii?Q?REc6Gvwask74HFS+lWqUTkmbtJ/7s7pgl2VHRjVY0byJKDbz0XA6KOvmPuZT?=
 =?us-ascii?Q?M0n6q1nPCV14ApCc67LIR0aUCYmIaqlhPB3iW/rOdYmPcPuZeZkR+ZW6nWfS?=
 =?us-ascii?Q?U2AAIE7aHna4XHQLLQRGZRjnh9RBSrLQSPrNXBa9ZtZLeBwZiS/NXpSYDHO5?=
 =?us-ascii?Q?e3R1yTPqA+KUe/twYFmq1hMWZNt7rKAuBkvyMz3kLGK/uDLYPCg8kHzCPQtY?=
 =?us-ascii?Q?LYjnoT1RLjIxtm0d4RovsDXSi6FhDdKO6fNFocZUgaCWYxvQ3x3dtf29j6BO?=
 =?us-ascii?Q?AbV8lxjWRbNJCKFYFJNaiCHMpbbjnzZMFub/iwu05Z8HxJjHOD8b5KNW1DBg?=
 =?us-ascii?Q?rR399G+kusLKbRyWIJUfdkIVUtNnhsi/TPTojR42GgxoQlzizCIT240Ee3zM?=
 =?us-ascii?Q?85tbGVd37Qq/SCCtfbE9xE/6zS0J7rugJpRZvlVjylJfxaHmWnN6ypjjDSEl?=
 =?us-ascii?Q?Y+m9hJTAC89Gn/3FB6143NkHcHRMT1x2zKrrcNYRk6LWtt2CemqgouyxmTjV?=
 =?us-ascii?Q?ZlohrzKjqW4TpHghbRVrdyOmEDyPy0iu5cT0knaRmg4PaDzh8Q3smJtyjli8?=
 =?us-ascii?Q?wJiSajTj0CRtq5SMxMCDheDGurj5/UKdRvZS26G1AOL7IcRTwI4zkQbPKoT+?=
 =?us-ascii?Q?PaZcWYG72xZ2R/Z2SMM0Z+dVkg64SJW7ANylalpr/2HCypoWeTfZEdjYMbrG?=
 =?us-ascii?Q?rs3m2dsvxaAfiwpzDX/XvqKl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f33ebab-d25c-485d-832f-08d925cf7790
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:24.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w6RKjpEmUvLmyIfHVcFS5DaCXNrZ8gnB9JpgFLPJcBOs7xXm+C44URrvo3HrlrXlt0SBPpYZ5lRaYO0kcUjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SEV-SNP specification provides the guest a mechanism to communicate with
the PSP without risk from a malicious hypervisor who wishes to read, alter,
drop or replay the messages sent. The driver uses snp_issue_guest_request()
to issue GHCB SNP_GUEST_REQUEST NAE event. This command constructs a
trusted channel between the guest and the PSP firmware.

The userspace can use the following ioctls provided by the driver:

1. Request an attestation report that can be used to assume the identity
   and security configuration of the guest.
2. Ask the firmware to provide a key derived from a root key.

See SEV-SNP spec section Guest Messages for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/virt/Kconfig           |   3 +
 drivers/virt/Makefile          |   1 +
 drivers/virt/sevguest/Kconfig  |  10 +
 drivers/virt/sevguest/Makefile |   4 +
 drivers/virt/sevguest/snp.c    | 448 +++++++++++++++++++++++++++++++++
 drivers/virt/sevguest/snp.h    |  63 +++++
 include/uapi/linux/sev-guest.h |  56 +++++
 7 files changed, 585 insertions(+)
 create mode 100644 drivers/virt/sevguest/Kconfig
 create mode 100644 drivers/virt/sevguest/Makefile
 create mode 100644 drivers/virt/sevguest/snp.c
 create mode 100644 drivers/virt/sevguest/snp.h
 create mode 100644 include/uapi/linux/sev-guest.h

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..4de714c5ee9a 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
 source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
+
+source "drivers/virt/sevguest/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..b2d1a8131c90 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -8,3 +8,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
+obj-$(CONFIG_SEV_GUEST)		+= sevguest/
diff --git a/drivers/virt/sevguest/Kconfig b/drivers/virt/sevguest/Kconfig
new file mode 100644
index 000000000000..e88a85527bf6
--- /dev/null
+++ b/drivers/virt/sevguest/Kconfig
@@ -0,0 +1,10 @@
+config SEV_GUEST
+	tristate "AMD SEV Guest driver"
+	default y
+	depends on AMD_MEM_ENCRYPT
+	help
+	  Provides AMD SNP guest request driver. The driver can be used by the
+	  guest to communicate with the hypervisor to request the attestation report
+	  and more.
+
+	  If you choose 'M' here, this module will be called sevguest.
diff --git a/drivers/virt/sevguest/Makefile b/drivers/virt/sevguest/Makefile
new file mode 100644
index 000000000000..1505df437682
--- /dev/null
+++ b/drivers/virt/sevguest/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sevguest-y := snp.o
+
+obj-$(CONFIG_SEV_GUEST) += sevguest.o
diff --git a/drivers/virt/sevguest/snp.c b/drivers/virt/sevguest/snp.c
new file mode 100644
index 000000000000..00d8e8fddf2c
--- /dev/null
+++ b/drivers/virt/sevguest/snp.c
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
+#include <uapi/linux/sev-guest.h>
+
+#include "snp.h"
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
+static int encrypt_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+			   void *plaintext, size_t len)
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
+static int decrypt_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+			   void *plaintext, size_t len)
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
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, int msg_type,
+				 struct snp_user_guest_request *input, uint8_t *req_buf,
+				 size_t req_sz, uint8_t *resp_buf, size_t resp_sz, size_t *msg_sz)
+{
+	struct snp_guest_msg *response = snp_dev->response;
+	struct snp_guest_msg_hdr *resp_hdr = &response->hdr;
+	struct snp_guest_msg *request = snp_dev->request;
+	struct snp_guest_msg_hdr *req_hdr = &request->hdr;
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_request_data data;
+	int ret;
+
+	memset(request, 0, sizeof(*request));
+
+	/* Populate the request header */
+	req_hdr->algo = SNP_AEAD_AES_256_GCM;
+	req_hdr->hdr_version = MSG_HDR_VER;
+	req_hdr->hdr_sz = sizeof(*req_hdr);
+	req_hdr->msg_type = msg_type;
+	req_hdr->msg_version = input->msg_version;
+	req_hdr->msg_seqno = snp_msg_seqno();
+	req_hdr->msg_vmpck = 0;
+	req_hdr->msg_sz = req_sz;
+
+	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
+		req_hdr->msg_seqno, req_hdr->msg_type, req_hdr->msg_version, req_hdr->msg_sz);
+
+	/* Encrypt the request message buffer */
+	ret = encrypt_payload(snp_dev, request, req_buf, req_sz);
+	if (ret)
+		return ret;
+
+	/* Call firmware to process the request */
+	data.req_gpa = __pa(request);
+	data.resp_gpa = __pa(response);
+	ret = snp_issue_guest_request(GUEST_REQUEST, &data);
+	input->fw_err = ret;
+	if (ret)
+		return ret;
+
+	dev_dbg(snp_dev->dev, "response [msg_seqno %lld msg_type %d msg_version %d msg_sz %d]\n",
+		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+
+	/* Verify that the sequence counter is incremented by 1 */
+	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
+		return -EBADMSG;
+
+	/* Verify response message type and version */
+	if ((resp_hdr->msg_type != (req_hdr->msg_type + 1)) ||
+	    (resp_hdr->msg_version != req_hdr->msg_version))
+		return -EBADMSG;
+
+	/*
+	 * If the message size is greather than our buffer length then return
+	 * an error.
+	 */
+	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > resp_sz))
+		return -EBADMSG;
+
+	/* Decrypt the payload */
+	ret = decrypt_payload(snp_dev, response, resp_buf, resp_hdr->msg_sz + crypto->a_len);
+	if (ret)
+		return ret;
+
+	*msg_sz = resp_hdr->msg_sz;
+	return 0;
+}
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, int msg_type,
+				struct snp_user_guest_request *input, void *req_buf,
+				size_t req_len, void __user *resp_buf, size_t resp_len)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct page *page;
+	size_t msg_len;
+	int ret;
+
+	/* Allocate the buffer to hold response */
+	resp_len += crypto->a_len;
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(resp_len));
+	if (!page)
+		return -ENOMEM;
+
+	ret = __handle_guest_request(snp_dev, msg_type, input, req_buf, req_len,
+			page_address(page), resp_len, &msg_len);
+	if (ret)
+		goto e_free;
+
+	if (copy_to_user(resp_buf, page_address(page), msg_len))
+		ret = -EFAULT;
+
+e_free:
+	__free_pages(page, get_order(resp_len));
+
+	return ret;
+}
+
+static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *input)
+{
+	struct snp_user_report __user *report = (struct snp_user_report *)input->data;
+	struct snp_user_report_req req;
+
+	if (copy_from_user(&req, &report->req, sizeof(req)))
+		return -EFAULT;
+
+	return handle_guest_request(snp_dev, SNP_MSG_REPORT_REQ, input, &req.user_data,
+			sizeof(req.user_data), report->response, sizeof(report->response));
+}
+
+static int derive_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *input)
+{
+	struct snp_user_derive_key __user *key = (struct snp_user_derive_key *)input->data;
+	struct snp_user_derive_key_req req;
+
+	if (copy_from_user(&req, &key->req, sizeof(req)))
+		return -EFAULT;
+
+	return handle_guest_request(snp_dev, SNP_MSG_KEY_REQ, input, &req, sizeof(req),
+			key->response, sizeof(key->response));
+}
+
+static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	struct snp_guest_dev *snp_dev = to_snp_dev(file);
+	struct snp_user_guest_request input;
+	void __user *argp = (void __user *)arg;
+	int ret = -ENOTTY;
+
+	if (copy_from_user(&input, argp, sizeof(input)))
+		return -EFAULT;
+
+	mutex_lock(&snp_cmd_mutex);
+	switch (ioctl) {
+	case SNP_GET_REPORT: {
+		ret = get_report(snp_dev, &input);
+		break;
+	}
+	case SNP_DERIVE_KEY: {
+		ret = derive_key(snp_dev, &input);
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
+	struct snp_secrets_page_layout *secrets;
+	struct device *dev = &pdev->dev;
+	struct snp_guest_dev *snp_dev;
+	uint8_t key[VMPCK_KEY_LEN];
+	struct miscdevice *misc;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
+	if (!snp_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, snp_dev);
+	snp_dev->dev = dev;
+
+	res = platform_get_mem_or_io(pdev, 0);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	/* Map the secrets page to get the key */
+	base = ioremap_encrypted(res->start, resource_size(res));
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	secrets = (struct snp_secrets_page_layout *)base;
+	memcpy_fromio(key, secrets->vmpck0, sizeof(key));
+	iounmap(base);
+
+	snp_dev->crypto = init_crypto(snp_dev, key, sizeof(key));
+	if (!snp_dev->crypto)
+		return -EIO;
+
+	/* Allocate the shared page used for the request and response message. */
+	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	if (IS_ERR(snp_dev->request))
+		return PTR_ERR(snp_dev->request);
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
diff --git a/drivers/virt/sevguest/snp.h b/drivers/virt/sevguest/snp.h
new file mode 100644
index 000000000000..930ffc0f4be3
--- /dev/null
+++ b/drivers/virt/sevguest/snp.h
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
+#ifndef __LINUX_SNP_GUEST_H_
+#define __LINUX_SNP_GUEST_H_
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
index 000000000000..0a8454631605
--- /dev/null
+++ b/include/uapi/linux/sev-guest.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Userspace interface for AMD SEV and SEV-SNP guest driver.
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * SEV-SNP API specification is available at: https://developer.amd.com/sev/
+ */
+
+#ifndef __UAPI_LINUX_SEV_GUEST_H_
+#define __UAPI_LINUX_SEV_GUEST_H_
+
+#include <linux/types.h>
+
+struct snp_user_report_req {
+	__u8 user_data[64];
+};
+
+struct snp_user_report {
+	struct snp_user_report_req req;
+
+	/* see SEV-SNP spec for the response format */
+	__u8 response[4000];
+};
+
+struct snp_user_derive_key_req {
+	__u8 root_key_select;
+	__u64 guest_field_select;
+	__u32 vmpl;
+	__u32 guest_svn;
+	__u64 tcb_version;
+};
+
+struct snp_user_derive_key {
+	struct snp_user_derive_key_req req;
+
+	/* see SEV-SNP spec for the response format */
+	__u8 response[64];
+};
+
+struct snp_user_guest_request {
+	/* Message version number (must be non-zero) */
+	__u8 msg_version;
+	__u64 data;
+
+	/* firmware error code on failure (see psp-sev.h) */
+	__u32 fw_err;
+};
+
+#define SNP_GUEST_REQ_IOC_TYPE	'S'
+#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
+#define SNP_DERIVE_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
+
+#endif /* __UAPI_LINUX_SEV_GUEST_H_ */
-- 
2.17.1

