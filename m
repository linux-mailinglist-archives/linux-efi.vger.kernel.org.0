Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4B601490
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJQRRx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJQRRw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D5E719B7
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E702B819A6
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E3BC43141;
        Mon, 17 Oct 2022 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027068;
        bh=f6JQEvHc9xoLhq5Xy+dK1/LY/DqjngVTqj9/zKPu1Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGU1NjSgSlnfVCbfvD/NywylkTqy2feARjPiV7QXPpSwH5CyQ5aGVY4+6W308O/90
         aQqCpPCgGfyOq8GK7hRNWWTb5UhFKTiGjWTSOq/vJvKKIxSOiurML8z5ejJn/qCBX7
         F/TObo/86PSGvzJrkCvTtC6TM4nMU9ujqUMHDk2LlIqh1oTTrK93FaVw8UKaHyOfsB
         gTevhN3Wl8g92dHjI/6OX0uF/jgWHfz0TtYOvM2x//AKI0awTPJtKNcTnnNicMcpzx
         gGNMPgiyWWVGEUo2Bg7LSeBd7eXMYEwdyqhbl5l4tI3+aO7540TvgzcOD4qMRivVEd
         QmDrY/BgxEvbw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 09/21] efi: libstub: Clone memcmp() into the stub
Date:   Mon, 17 Oct 2022 19:16:48 +0200
Message-Id: <20221017171700.3736890-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3992; i=ardb@kernel.org; h=from:subject; bh=f6JQEvHc9xoLhq5Xy+dK1/LY/DqjngVTqj9/zKPu1Bs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY33XMtDppcN4farj5jN+nQzCv6PHTu0oDf9Cp5n 7QducLKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N9wAKCRDDTyI5ktmPJM86C/ 0YOKVuUMfqKRvj3ppTV72mZC8ujFYP32laTT0h0VAeOuc5eqhuuacUtS1uJgAFJKLDhfydc63CqiGG isNITRKvB33TmeTP0RtJYmwjdSFqkJm/UESQzZLrMC+gjXnhn0LJjjA8E2yZsYde8pfIKnC2Dc/rDc TH/6970Ox8EVUfyOD61/KRjAwDNRfNccKJ6BxW083N/rQ1L3UnxMN4mTxpBDAv6qk8ski3bpXCXHSA HgmOm9H+yE8j6w61pTaGz1v9i0CcMzWI0iiVONVEqZIQLgN++lVmfhwZsC7bi5BDIlkDXVG2gbEfn1 wz+6cR8umDTeedGL146eHeNA8or1xm/qpS5bsxrOOkrRyScz263HR0tNwjtJIRfyZkqMaPRtFtPmji 1YJxLukLXFTigNnByebHDS2lNXruJfmUJ7oQ+bqSHbPln2nhEyznmtyi6q4y23WDUqNm6kxp1HvBkV xRRBSh9BhdLgKXyXqFmAUHK4GSpcQfcJbCczF9G8vZyYM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will no longer be able to call into the kernel image once we merge
the decompressor with the EFI stub, so we need our own implementation of
memcmp(). Let's add the one from lib/string.c and simplify it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h            |  1 -
 arch/loongarch/kernel/image-vars.h        |  1 -
 arch/riscv/kernel/image-vars.h            |  1 -
 drivers/firmware/efi/libstub/intrinsics.c | 18 ++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c      | 11 +----------
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 5a12ca2d7158..f7c8cdf0c302 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -21,7 +21,6 @@ PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-PROVIDE(__efistub_memcmp		= __pi_memcmp);
 PROVIDE(__efistub_memchr		= __pi_memchr);
 PROVIDE(__efistub_strlen		= __pi_strlen);
 PROVIDE(__efistub_strnlen		= __pi_strnlen);
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index 88f5d81702df..5b6c7f079942 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -7,7 +7,6 @@
 
 #ifdef CONFIG_EFI_STUB
 
-__efistub_memcmp		= memcmp;
 __efistub_memchr		= memchr;
 __efistub_strcat		= strcat;
 __efistub_strcmp		= strcmp;
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index b46322cb5864..9229cfe0754d 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -23,7 +23,6 @@
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= memcmp;
 __efistub_memchr		= memchr;
 __efistub_strlen		= strlen;
 __efistub_strnlen		= strnlen;
diff --git a/drivers/firmware/efi/libstub/intrinsics.c b/drivers/firmware/efi/libstub/intrinsics.c
index a04ab39292b6..965e734f6f98 100644
--- a/drivers/firmware/efi/libstub/intrinsics.c
+++ b/drivers/firmware/efi/libstub/intrinsics.c
@@ -28,3 +28,21 @@ void *memset(void *dst, int c, size_t len)
 	efi_bs_call(set_mem, dst, len, c & U8_MAX);
 	return dst;
 }
+
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+#undef memcmp
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index ea72c8f27da6..38173ec29cd5 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -47,15 +47,6 @@ static void error(char *x)
 	log(L"error() called from decompressor library\n");
 }
 
-// Local version to avoid pulling in memcmp()
-static bool guids_eq(const efi_guid_t *a, const efi_guid_t *b)
-{
-	const u32 *l = (u32 *)a;
-	const u32 *r = (u32 *)b;
-
-	return l[0] == r[0] && l[1] == r[1] && l[2] == r[2] && l[3] == r[3];
-}
-
 static efi_status_t __efiapi
 load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
 	  bool boot_policy, unsigned long *bufsize, void *buffer)
@@ -76,7 +67,7 @@ load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
 	if (rem->type == EFI_DEV_MEDIA &&
 	    rem->sub_type == EFI_DEV_MEDIA_VENDOR) {
 		vendor_dp = container_of(rem, struct efi_vendor_dev_path, header);
-		if (!guids_eq(&vendor_dp->vendorguid, &LINUX_EFI_ZBOOT_MEDIA_GUID))
+		if (efi_guidcmp(vendor_dp->vendorguid, LINUX_EFI_ZBOOT_MEDIA_GUID))
 			return EFI_NOT_FOUND;
 
 		decompress = true;
-- 
2.35.1

