Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15994165C6F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgBTLHM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 06:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgBTLHM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 06:07:12 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529DE24654;
        Thu, 20 Feb 2020 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582196831;
        bh=Rc61oidSFnl+2+JQDZJjIg/HX8ehHzoHp3cLcOtUsco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfyjWW6NTPQrXg7m6YsbJbe6cpRWJ8m0hHawOCYFn5X62Ovm6IIDUrcDVogvo37CE
         d14uTG4MPVFntyCdZaYAPxNd+uRiZORA5z6aeF0wx7vRBZ7yHrKi/zL0s5iJmtEl3N
         2vFqc4asbU+kPmJ/98gqRhKqsgwJ/uK5XZS8gYE8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
Subject: [RFC PATCH 3/3] efi: Bump the Linux EFI stub major version number to #1
Date:   Thu, 20 Feb 2020 12:06:49 +0100
Message-Id: <20200220110649.1303-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220110649.1303-1-ardb@kernel.org>
References: <20200220110649.1303-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we have introduced new, generic ways for the OS loader to
interface with Linux kernels during boot, we need to record this
fact in a way that allows loaders to discover this information, and
fall back to the existing methods for older kernels.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index e0869f3eadd6..8ad71d763a77 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -10,7 +10,25 @@
 
 #include <linux/types.h>
 
-#define LINUX_EFISTUB_MAJOR_VERSION		0x0
+/*
+ * Linux EFI stub v1.0 adds the following functionality:
+ * - Loading initrd from the LINUX_EFI_INITRD_MEDIA_GUID device path,
+ * - Loading/starting the kernel from firmware that targets a different
+ *   machine type, via the entrypoint exposed in the .compat PE/COFF section.
+ *
+ * The recommended way of loading and starting v1.0 or later kernels is to use
+ * the LoadImage() and StartImage() EFI boot services, and expose the initrd
+ * via the LINUX_EFI_INITRD_MEDIA_GUID device path.
+ *
+ * Versions older than v1.0 support initrd loading via the image load options
+ * (using initrd=, limited to the volume from which the kernel itself was
+ * loaded), or via arch specific means (bootparams, DT, etc).
+ *
+ * On x86, LoadImage() and StartImage() can be omitted if the EFI handover
+ * protocol is implemented, which can be inferred from the version,
+ * handover_offset and xloadflags fields in the bootparams structure.
+ */
+#define LINUX_EFISTUB_MAJOR_VERSION		0x1
 #define LINUX_EFISTUB_MINOR_VERSION		0x0
 
 #define MZ_MAGIC	0x5a4d	/* "MZ" */
-- 
2.17.1

