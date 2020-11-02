Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B082A30DF
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgKBRG7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgKBRG7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:59 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C71223AC;
        Mon,  2 Nov 2020 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336818;
        bh=Z+RP+I44S2g5tcr50Du7zPQ+M31RcfMbP2e5NvR3de4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYgpGFPVjzMoTVq7TFhNP8YkulfkEWvZKKqX1taKvm9kszPXFjcreM4b+7PCz8GnH
         Wf+SNjVaVxvj31IOrZNEi0Mn0kNGTwenJcDchvQRkT0QUDtzMjx/vTHDFvWszQYru3
         FUiZyTvqHSP8kCedYDUVxB/3RUGPACY4qOv6IRAk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 4/7] efi/libstub: move TPM related prototypes into efistub.h
Date:   Mon,  2 Nov 2020 18:06:31 +0100
Message-Id: <20201102170634.20575-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move TPM related definitions that are only used in the EFI stub into
efistub.h, which is a local header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 9 +++++++++
 include/linux/efi.h                    | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2bc389ec7fcd..2c621bf4760f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -848,4 +848,13 @@ asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 
 void efi_handle_post_ebs_state(void);
 
+#ifdef CONFIG_RESET_ATTACK_MITIGATION
+void efi_enable_reset_attack_mitigation(void);
+#else
+static inline void
+efi_enable_reset_attack_mitigation(void) { }
+#endif
+
+void efi_retrieve_tpm2_eventlog(void);
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 0ac54295ec0b..1160e0c6d779 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1091,13 +1091,6 @@ enum efi_secureboot_mode {
 };
 enum efi_secureboot_mode efi_get_secureboot(void);
 
-#ifdef CONFIG_RESET_ATTACK_MITIGATION
-void efi_enable_reset_attack_mitigation(void);
-#else
-static inline void
-efi_enable_reset_attack_mitigation(void) { }
-#endif
-
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
 void efi_check_for_embedded_firmwares(void);
 #else
@@ -1106,8 +1099,6 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 
 efi_status_t efi_random_get_seed(void);
 
-void efi_retrieve_tpm2_eventlog(void);
-
 /*
  * Arch code can implement the following three template macros, avoiding
  * reptition for the void/non-void return cases of {__,}efi_call_virt():
-- 
2.17.1

