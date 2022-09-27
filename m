Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C85EBDE3
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiI0I67 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiI0I66 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 04:58:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E847CAA9
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 01:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3EA61628
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 08:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C96C433B5;
        Tue, 27 Sep 2022 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269136;
        bh=mGT8IYCiIqJ+xhweRLSyCgqFOtdB7hNQ8qX9oeqmvaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRNfD7Ca/q2InMGXBQ5ID1+Bzk0QIMzUneUO2ZdnLF7+RXvvZatW+KrsycE29vq1C
         RZPMJxZpE1rY025CSq+zPEKo/HS4NCTTlhvWMjPpuuf+yGFXM7cw2qJuzPlVGXhiqd
         NjtCPYlvpOAFyl56PBgZ5KSKYlYHLza6dPI7AEwzwbTDDuyw5svdev3BpVT6wwFR20
         wID4QJByROEBcJ0TzWxq+82rXafo9qzjwAcD9jAVIf+eXIe0CXXWNSk7q/fs6adM5z
         R66a2pfzhq5ITs4VdoMm2RTgts09qOs/7pljqnMLiw8OsY4wlMMtCT/UEAYWgZPHs+
         CMUE1LFkLXSVg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Lennart Poettering <lennart@poettering.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/4] efi: libstub: Permit mixed mode return types other than efi_status_t
Date:   Tue, 27 Sep 2022 10:58:40 +0200
Message-Id: <20220927085842.2860715-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927085842.2860715-1-ardb@kernel.org>
References: <20220927085842.2860715-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=ardb@kernel.org; h=from:subject; bh=mGT8IYCiIqJ+xhweRLSyCgqFOtdB7hNQ8qX9oeqmvaM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMrs/srtA86IP6E/BjEJyORs1wz2TGOR/Efs856XT PK77hTSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzK7PwAKCRDDTyI5ktmPJOfYDA CqBmIwdRDH8ULp4IMQioXsf+J+8UVdvukYgBgZn/Xh7yTQrPxqmMVazTp7nZ2ISWMoMwngXplWHx6O av9LpUVe4DW2GWpyGEuwVAbrGa5IcM7Rh12SKYgfUq1xsdPiYNmNOdAocjKMDhUij8+mQUXPIh2PTs lKOdOb0oJlNaRSUpsja5Zw1kmpiA+4t7tWHoxaEiQ4zqsCJs9WzaKorzH2JTdIsUs9h84+emvttIwr ya1C3/VdPzFrJcQm96S2H7TXZMn5vZeftIgxvjcqfznE1Hj7A0Ac3dTB37VwM4Cq7F5SHpqMT7O9Rs /t99sYfaBh9uvMI8V2Gs9Uiw5mf6o9Us5lbxHN0VcDr5CfNR1GGsQ8TXpoaVQZ7HvSIMCXaAdEwOoW d0qCxJiJy3KbzoRi1mvFPBntAc8VaeyjgWJmIXp3zO/QkHuK+j8LWnduN2HMjODdNi8kST2ExIFB52 ibA+/sBr7coY0D7DNojRf4DuSsZsFpZY2arCQNd3vTDqw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rework the EFI stub macro wrappers around protocol method calls and
other indirect calls in order to allow return types other than
efi_status_t. This means the widening should be conditional on whether
or not the return type is efi_status_t, and should be omitted otherwise.

Note that this does not take into account that unsigned long types might
exist that are not efi_status_t, but that can be addressed when it
becomes an issue.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_thunk_64.S |  6 ----
 arch/x86/include/asm/efi.h              | 38 ++++++++------------
 drivers/firmware/efi/libstub/efistub.h  | 16 ++++++---
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 67e7edcdfea8..0c988f2a1243 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -93,12 +93,6 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ebx, %fs
 	movl	%ebx, %gs
 
-	/*
-	 * Convert 32-bit status code into 64-bit.
-	 */
-	roll	$1, %eax
-	rorq	$1, %rax
-
 	pop	%rbx
 	pop	%rbp
 	RET
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 233ae6986d6f..8edead8568ec 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -178,7 +178,7 @@ struct efi_setup_data {
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
-extern efi_status_t __efi64_thunk(u32, ...);
+extern u64 __efi64_thunk(u32, ...);
 
 #define efi64_thunk(...) ({						\
 	u64 __pad[3]; /* must have space for 3 args on the stack */	\
@@ -344,31 +344,23 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi_eat(...)
 #define __efi_eval(...) __VA_ARGS__
 
-/* The three macros below handle dispatching via the thunk if needed */
-
-#define efi_call_proto(inst, func, ...)					\
-	(efi_is_native()						\
-		? inst->func(inst, ##__VA_ARGS__)			\
-		: __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
-
-#define efi_bs_call(func, ...)						\
-	(efi_is_native()						\
-		? efi_system_table->boottime->func(__VA_ARGS__)		\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
-						   boottime),		\
-				    func, __VA_ARGS__))
+static inline efi_status_t __efi64_widen_efi_status(u64 status)
+{
+	return status ? status ^ 0x8000000080000000ULL : 0;
+}
 
-#define efi_rt_call(func, ...)						\
-	(efi_is_native()						\
-		? efi_system_table->runtime->func(__VA_ARGS__)		\
-		: __efi64_thunk_map(efi_table_attr(efi_system_table,	\
-						   runtime),		\
-				    func, __VA_ARGS__))
+/* The macro below handles dispatching via the thunk if needed */
 
-#define efi_dxe_call(func, ...)						\
+#define efi_fn_call(inst, func, ...)					\
 	(efi_is_native()						\
-		? efi_dxe_table->func(__VA_ARGS__)			\
-		: __efi64_thunk_map(efi_dxe_table, func, __VA_ARGS__))
+	? inst->func(__VA_ARGS__)					\
+	: __builtin_choose_expr(					\
+		__builtin_types_compatible_p(efi_status_t,		\
+			__typeof__(inst->func(__VA_ARGS__))),		\
+		__efi64_widen_efi_status(				\
+			__efi64_thunk_map(inst, func, ##__VA_ARGS__)),	\
+		(__typeof__(inst->func(__VA_ARGS__)))			\
+			__efi64_thunk_map(inst, func, ##__VA_ARGS__)))
 
 #else /* CONFIG_EFI_MIXED */
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f403aebf0182..d26d3d7b99c0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -44,15 +44,21 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 #ifndef ARCH_HAS_EFISTUB_WRAPPERS
 
-#define efi_is_native()		(true)
-#define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
-#define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
-#define efi_dxe_call(func, ...)	efi_dxe_table->func(__VA_ARGS__)
+#define efi_is_native()			(true)
 #define efi_table_attr(inst, attr)	(inst->attr)
-#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+#define efi_fn_call(inst, func, ...)	inst->func(__VA_ARGS__)
 
 #endif
 
+#define efi_call_proto(inst, func, ...) \
+	efi_fn_call(inst, func, inst, ##__VA_ARGS__)
+#define efi_bs_call(func, ...) \
+	efi_fn_call(efi_table_attr(efi_system_table, boottime), func, ##__VA_ARGS__)
+#define efi_rt_call(func, ...) \
+	efi_fn_call(efi_table_attr(efi_system_table, runtime), func, ##__VA_ARGS__)
+#define efi_dxe_call(func, ...) \
+	efi_fn_call(efi_dxe_table, func, ##__VA_ARGS__)
+
 #define efi_info(fmt, ...) \
 	efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
 #define efi_warn(fmt, ...) \
-- 
2.35.1

