Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F8164BB6
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSRTf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBSRTf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:35 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4791224672;
        Wed, 19 Feb 2020 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132774;
        bh=/RdEDGgtdl0/msLC4fuNxM0m8ky68tzeUwE94uyIBGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ieu07njezJsAb+jamnTTadsHcWRcwmhDka1gEMXQsiNRvHtRWGSZYo7m8gCuPt5DJ
         etip75nPMxFiizlTpGBlCVxvi+mW00iNAvPaRHtbCHGoNLzsrFn9m7eHedf5EuEESK
         2lGQgNxSdhiRGAQQXGL2jzeZtVjbPU0/us1LS+lI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org
Subject: [PATCH 1/9] efi: store mask of supported runtime services in struct efi
Date:   Wed, 19 Feb 2020 18:18:59 +0100
Message-Id: <20200219171907.11894-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Revision 2.8 of the UEFI spec introduces provisions for firmware to
advertise lack of support for certain runtime services at OS runtime.
Let's store this mask in struct efi for easy access.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 27 ++++++++++-------
 include/linux/efi.h        | 31 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7dbe1487b111..703a019d81b4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -34,6 +34,7 @@
 #include <asm/early_ioremap.h>
 
 struct efi __read_mostly efi = {
+	.runtime_supported_mask = EFI_RT_SUPPORTED_ALL,
 	.acpi			= EFI_INVALID_TABLE_ADDR,
 	.acpi20			= EFI_INVALID_TABLE_ADDR,
 	.smbios			= EFI_INVALID_TABLE_ADDR,
@@ -301,16 +302,22 @@ static int __init efisubsys_init(void)
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
 
-	/*
-	 * Since we process only one efi_runtime_service() at a time, an
-	 * ordered workqueue (which creates only one execution context)
-	 * should suffice all our needs.
-	 */
-	efi_rts_wq = alloc_ordered_workqueue("efi_rts_wq", 0);
-	if (!efi_rts_wq) {
-		pr_err("Creating efi_rts_wq failed, EFI runtime services disabled.\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return 0;
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		efi.runtime_supported_mask = 0;
+
+	if (efi.runtime_supported_mask) {
+		/*
+		 * Since we process only one efi_runtime_service() at a time, an
+		 * ordered workqueue (which creates only one execution context)
+		 * should suffice for all our needs.
+		 */
+		efi_rts_wq = alloc_ordered_workqueue("efi_rts_wq", 0);
+		if (!efi_rts_wq) {
+			pr_err("Creating efi_rts_wq failed, EFI runtime services disabled.\n");
+			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+			efi.runtime_supported_mask = 0;
+			return 0;
+		}
 	}
 
 	/* We register the efi directory at /sys/firmware/efi */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a0008e3d4e9d..57695f400044 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -523,6 +523,7 @@ typedef struct {
 extern struct efi {
 	const efi_runtime_services_t	*runtime;		/* EFI runtime services table */
 	unsigned int			runtime_version;	/* Runtime services version */
+	unsigned int			runtime_supported_mask;
 
 	unsigned long			acpi;			/* ACPI table  (IA64 ext 0.71) */
 	unsigned long			acpi20;			/* ACPI table  (ACPI 2.0) */
@@ -551,6 +552,26 @@ extern struct efi {
 	unsigned long			flags;
 } efi;
 
+#define EFI_RT_SUPPORTED_GET_TIME 				0x0001
+#define EFI_RT_SUPPORTED_SET_TIME 				0x0002
+#define EFI_RT_SUPPORTED_GET_WAKEUP_TIME			0x0004
+#define EFI_RT_SUPPORTED_SET_WAKEUP_TIME			0x0008
+#define EFI_RT_SUPPORTED_GET_VARIABLE				0x0010
+#define EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME			0x0020
+#define EFI_RT_SUPPORTED_SET_VARIABLE				0x0040
+#define EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP		0x0080
+#define EFI_RT_SUPPORTED_CONVERT_POINTER			0x0100
+#define EFI_RT_SUPPORTED_GET_NEXT_HIGH_MONOTONIC_COUNT		0x0200
+#define EFI_RT_SUPPORTED_RESET_SYSTEM				0x0400
+#define EFI_RT_SUPPORTED_UPDATE_CAPSULE				0x0800
+#define EFI_RT_SUPPORTED_QUERY_CAPSULE_CAPABILITIES		0x1000
+#define EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO			0x2000
+
+#define EFI_RT_SUPPORTED_ALL					0x3fff
+
+#define EFI_RT_SUPPORTED_TIME_SERVICES				0x000f
+#define EFI_RT_SUPPORTED_VARIABLE_SERVICES			0x0070
+
 extern struct mm_struct efi_mm;
 
 static inline int
@@ -761,6 +782,11 @@ static inline bool __pure efi_soft_reserve_enabled(void)
 	return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE)
 		&& __efi_soft_reserve_enabled();
 }
+
+static inline bool efi_rt_services_supported(unsigned int mask)
+{
+	return (efi.runtime_supported_mask & mask) == mask;
+}
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -779,6 +805,11 @@ static inline bool efi_soft_reserve_enabled(void)
 {
 	return false;
 }
+
+static inline bool efi_rt_services_supported(unsigned int mask)
+{
+	return false;
+}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
-- 
2.17.1

