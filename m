Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8F41B703
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhI1TME (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 15:12:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242218AbhI1TMB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 15:12:01 -0400
Received: from zn.tnic (p200300ec2f13b20078349fd04295260b.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7834:9fd0:4295:260b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03EEF1EC0731;
        Tue, 28 Sep 2021 21:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632856220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+XdhoQGzIN8rz2Q4VHmTGzW5OUUAI4zbVurx/C+SFw=;
        b=Yo909OX92n3M/cGLqS77ordtgA2tox4iPDFQFfqj90ti7VPQU2IrUuYwnMJGopwHyUg8Ex
        7pnCy6+oJgxD0E3vHZ0scxdMTXevKG3dVm9jvPA9z/Saeugp83kcj6Kifc6iNEhP1gH4KW
        aK+6e6Rz0t6QBeUqkA4X9sqEff7rZcg=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org
Subject: [PATCH 2/8] arch/cc: Introduce a function to check for confidential computing features
Date:   Tue, 28 Sep 2021 21:10:03 +0200
Message-Id: <20210928191009.32551-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

In preparation for other confidential computing technologies, introduce
a generic helper function, cc_platform_has(), that can be used to
check for specific active confidential computing attributes, like
memory encryption. This is intended to eliminate having to add multiple
technology-specific checks to the code (e.g. if (sev_active() ||
tdx_active() || ... ).

 [ bp: s/_CC_PLATFORM_H/_LINUX_CC_PLATFORM_H/g ]

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/Kconfig                |  3 ++
 include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/linux/cc_platform.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..d1e69d6e8498 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1234,6 +1234,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_CC_PLATFORM
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
new file mode 100644
index 000000000000..a075b70b9a70
--- /dev/null
+++ b/include/linux/cc_platform.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _LINUX_CC_PLATFORM_H
+#define _LINUX_CC_PLATFORM_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+/**
+ * enum cc_attr - Confidential computing attributes
+ *
+ * These attributes represent confidential computing features that are
+ * currently active.
+ */
+enum cc_attr {
+	/**
+	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
+	 *
+	 * The platform/OS is running with active memory encryption. This
+	 * includes running either as a bare-metal system or a hypervisor
+	 * and actively using memory encryption or as a guest/virtual machine
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME, SEV and SEV-ES.
+	 */
+	CC_ATTR_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
+	 *
+	 * The platform/OS is running as a bare-metal system or a hypervisor
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME.
+	 */
+	CC_ATTR_HOST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption.
+	 *
+	 * Examples include SEV and SEV-ES.
+	 */
+	CC_ATTR_GUEST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption and register state encryption.
+	 *
+	 * Examples include SEV-ES.
+	 */
+	CC_ATTR_GUEST_STATE_ENCRYPT,
+};
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+
+/**
+ * cc_platform_has() - Checks if the specified cc_attr attribute is active
+ * @attr: Confidential computing attribute to check
+ *
+ * The cc_platform_has() function will return an indicator as to whether the
+ * specified Confidential Computing attribute is currently active.
+ *
+ * Context: Any context
+ * Return:
+ * * TRUE  - Specified Confidential Computing attribute is active
+ * * FALSE - Specified Confidential Computing attribute is not active
+ */
+bool cc_platform_has(enum cc_attr attr);
+
+#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
+
+static inline bool cc_platform_has(enum cc_attr attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
+
+#endif	/* _LINUX_CC_PLATFORM_H */
-- 
2.29.2

