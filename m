Return-Path: <linux-efi+bounces-5510-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDCC5C166
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FF8834CEA5
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D022FFDDF;
	Fri, 14 Nov 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI3OILed"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD2301030;
	Fri, 14 Nov 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110280; cv=none; b=jFxkQNBpL7x6nr0UAuwV6ElLAmjiwdABEhhLmHmfBFUOV7q3I2q/Gbz3jsBfnPehSJl0QL46Rqt5RorBvlglcg6Lnp1JN7pJrBaqxRdvUGv+H/q1tdB3hM1VQqqYgG+DyW1jPqxanCmYhZNJoL+pMsY7uTx3zM+97Og6EM6ylhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110280; c=relaxed/simple;
	bh=55xIhoOmV8clm7ahG6/Y9I43bRUI1+9IozWLQorei9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHWQM8ULxnxPmU0LrQdtkOIzLLMYjCgG7/xfIYHkILxgR02ZrmJc05TgNA15+zTBbOrUf5J0ETDpehgPTMzYLwcoZTLr11l9W0PXdLucKG/zquY4hRqLdanqkmkMyXlXy6rTZaWx3nRNOAWPBR3cqT52O/g3bf3R14H+878Hsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI3OILed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B2DC4CEF5;
	Fri, 14 Nov 2025 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110280;
	bh=55xIhoOmV8clm7ahG6/Y9I43bRUI1+9IozWLQorei9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PI3OILedmZAte/njHsuiubEltqHMxrkruUK/JOX0Td3QyyiCsBsX2L0/F9ciKoHSQ
	 qTCVoFp2mQ52khQfOb+pyQpTdpd9WZJur4muILTvw3Gy5zwKkprSgqxSCd08f8O8ZC
	 H89gqMomBmVGoq6US24EMXpQwv9hqAaV4234jTt2sbxeK7+9P5L9gAek6d8YWYvTU0
	 scHsnpn2JEvfBvk4V0bRYL7GN9eSU/VLKC7LD2QvtGh1qNH3vXxWSO9BcJerob5XCu
	 w7XtSodLzKbhw08SqCRROm+JaYwizj5i/r6Wab13j8Cg0O/7VfvpSQgblfgnroN7KW
	 4/qLXTg1HW7TA==
From: Sumit Garg <sumit.garg@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	mark.rutland@arm.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	shivendra.pratap@oss.qualcomm.com,
	leif.lindholm@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 1/2] efi/reboot: Add support for EFI_RESET_PLATFORM_SPECIFIC
Date: Fri, 14 Nov 2025 14:20:57 +0530
Message-ID: <20251114085058.2195900-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114085058.2195900-1-sumit.garg@kernel.org>
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

UEFI specification provides support for EfiResetPlatformSpecific reset
type as follows:

"
ResetSystem:

Calling this interface with ResetType of EfiResetPlatformSpecific
causes a system-wide reset. The exact type of the reset is defined
by the EFI_GUID that follows the Null-terminated Unicode string passed
into ResetData. If the platform does not recognize the EFI_GUID in
ResetData the platform must pick a supported reset type to perform.
The platform may optionally log the parameters from any non-normal
reset that occurs.
"

Lets use the ResetData to pass the platform specific reboot command
issued and leave it's interpretation to UEFI implementation following
the specification.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/efi/reboot.c | 25 +++++++++++++++----------
 include/linux/efi.h           |  5 +++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
index ceae84c19d22..23a2fc68e9c9 100644
--- a/drivers/firmware/efi/reboot.c
+++ b/drivers/firmware/efi/reboot.c
@@ -10,7 +10,7 @@ static struct sys_off_handler *efi_sys_off_handler;
 
 int efi_reboot_quirk_mode = -1;
 
-void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
+void efi_reboot(enum reboot_mode reboot_mode, const char *data)
 {
 	const char *str[] = { "cold", "warm", "shutdown", "platform" };
 	int efi_mode, cap_reset_mode;
@@ -18,14 +18,18 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_RESET_SYSTEM))
 		return;
 
-	switch (reboot_mode) {
-	case REBOOT_WARM:
-	case REBOOT_SOFT:
-		efi_mode = EFI_RESET_WARM;
-		break;
-	default:
-		efi_mode = EFI_RESET_COLD;
-		break;
+	if (data) {
+		efi_mode = EFI_RESET_PLATFORM_SPECIFIC;
+	} else {
+		switch (reboot_mode) {
+		case REBOOT_WARM:
+		case REBOOT_SOFT:
+			efi_mode = EFI_RESET_WARM;
+			break;
+		default:
+			efi_mode = EFI_RESET_COLD;
+			break;
+		}
 	}
 
 	/*
@@ -43,7 +47,8 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *__unused)
 		efi_mode = cap_reset_mode;
 	}
 
-	efi.reset_system(efi_mode, EFI_SUCCESS, 0, NULL);
+	efi.reset_system(efi_mode, EFI_SUCCESS, sizeof(data),
+			 (efi_char16_t *)data);
 }
 
 bool __weak efi_poweroff_required(void)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa..5324db1518b6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -256,6 +256,7 @@ typedef union efi_boot_services efi_boot_services_t;
 #define EFI_RESET_COLD 0
 #define EFI_RESET_WARM 1
 #define EFI_RESET_SHUTDOWN 2
+#define EFI_RESET_PLATFORM_SPECIFIC 3
 
 /*
  * EFI Runtime Services table
@@ -874,7 +875,7 @@ static inline bool efi_enabled(int feature)
 {
 	return test_bit(feature, &efi.flags) != 0;
 }
-extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
+extern void efi_reboot(enum reboot_mode reboot_mode, const char *data);
 
 bool __pure __efi_soft_reserve_enabled(void);
 
@@ -895,7 +896,7 @@ static inline bool efi_enabled(int feature)
 	return false;
 }
 static inline void
-efi_reboot(enum reboot_mode reboot_mode, const char *__unused) {}
+efi_reboot(enum reboot_mode reboot_mode, const char *data) {}
 
 static inline bool efi_soft_reserve_enabled(void)
 {
-- 
2.48.1


