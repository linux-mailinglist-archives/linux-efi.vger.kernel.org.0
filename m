Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923442A30E1
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgKBRHC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbgKBRHB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:07:01 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A70A20786;
        Mon,  2 Nov 2020 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336821;
        bh=B7VXb+3hChHM3e+iOn1NtAfnn+s6hdcntPodviUCuzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klJspx40NWmNUvUuen/FMuIQwXPCnNp7Wj/StgrN5n28gvJLwAGDZacLcK9TAdi8n
         txDZ5y3YXiUn6YcdVjh9ILKnuOvxYK+DaAHmPXCNTMEBC2Ehi8ZivAjgzDa+xMfSTf
         kXXP9dfszbpLnZ8D1U8D530lB2wNpF/0iAKA9j4Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 5/7] efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
Date:   Mon,  2 Nov 2020 18:06:32 +0100
Message-Id: <20201102170634.20575-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define the right prototype for efi_tcg2_protocol::hash_log_extend_event()
so we can start using it to measure the initrd into the TPM if it was
loaded by the EFI stub itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             |  4 ++++
 drivers/firmware/efi/libstub/efistub.h | 22 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b921b593e0a3..73316cd67086 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -303,6 +303,10 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_query_mode(gop, mode, size, info)		\
 	((gop), (mode), efi64_zero_upper(size), efi64_zero_upper(info))
 
+/* TCG2 protocol */
+#define __efi64_argmap_hash_log_extend_event(prot, fl, addr, size, ev)	\
+	((prot), (fl), 0ULL, (u64)(addr), 0ULL, (u64)(size), 0ULL, ev)
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2c621bf4760f..c96085133648 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -667,6 +667,20 @@ union apple_properties_protocol {
 
 typedef u32 efi_tcg2_event_log_format;
 
+#define EFI_TCG2_EVENT_HEADER_VERSION	0x1
+
+struct efi_tcg2_event {
+	u32		event_size;
+	struct {
+		u32	header_size;
+		u16	header_version;
+		u32	pcr_index;
+		u32	event_type;
+	}		event_header;
+	/* u8[] event follows here */
+} __packed;
+
+typedef struct efi_tcg2_event efi_tcg2_event_t;
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 
 union efi_tcg2_protocol {
@@ -677,7 +691,11 @@ union efi_tcg2_protocol {
 						       efi_physical_addr_t *,
 						       efi_physical_addr_t *,
 						       efi_bool_t *);
-		void *hash_log_extend_event;
+		efi_status_t (__efiapi *hash_log_extend_event)(efi_tcg2_protocol_t *,
+							       u64,
+							       efi_physical_addr_t,
+							       u64,
+							       const efi_tcg2_event_t *);
 		void *submit_command;
 		void *get_active_pcr_banks;
 		void *set_active_pcr_banks;
@@ -857,4 +875,6 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_tpm2_eventlog(void);
 
+void efi_tpm_measure_initrd(unsigned long addr, unsigned long size);
+
 #endif
-- 
2.17.1

