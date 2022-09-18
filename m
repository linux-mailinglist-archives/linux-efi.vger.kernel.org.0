Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310BE5BC019
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIRVgL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRVgK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431813FA8
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A043BB80C69
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F587C433D6;
        Sun, 18 Sep 2022 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536967;
        bh=VE09phF7jVlYnv0dRexTiSFp+nZ5ke1ppI0z3Bh2ARU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTWytO5PFPGA/zIqeNzlScFFMDDYgHMobrEJ4vJSM4v00Ipry+oCAD7OQTwX52TRx
         LQhx8aRupU19wju3HpXb6Xrri26HJM0uvf07PD0UX0fhIrYgtzVjR9ZnPS+A4/qo5Z
         sfZ0nAAvvr2s3Lw7HsJEcUbh/f41qSfWdqKPFjDwbg5+5o2Bi/4ql5oKmYxS0lfUMf
         eT/EB02h5byuZJnD0cnkTOwZZNXrIxr38o5EG728vyQh9OqxNSmaciYuBeU3a4BUh1
         WS6hZn5Hmb8Ib9puPT3fv82LqJr5giarUrRghdD6H3ubGWjwfNfaPswKH/Kb5pWElP
         b3RtCQ5ZzLl5A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 04/12] efi: libstub: fix type confusion for load_options_size
Date:   Sun, 18 Sep 2022 23:35:36 +0200
Message-Id: <20220918213544.2176249-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3306; i=ardb@kernel.org; h=from:subject; bh=VE09phF7jVlYnv0dRexTiSFp+nZ5ke1ppI0z3Bh2ARU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48gvkz/HXZ76M7IpoKgmMeLspsTIBBbBmtljpCk Lu1HS6eJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePIAAKCRDDTyI5ktmPJISHC/ 9p+nKyqm6VEAGDJ48fcOUQegUEp/988wdpN7oDoCmCI2+1kN8ix4vMQXFSA3xMdYJMCfXvqYEHqeBa zNbd1xHCrYqrXzl+jfepS1z9Y1BL+2o0mhNqwUTpZihkulk05G+Y0jHjYoFai4Tk9uMN9OL0HWCuVD B7efOOT5fuLacbsxNOcmMqfzaL+JoJR1UvTWSu8msqau13eZPKRZDJ7ADNiSn4W2uWyzyHLR9oDeC2 TpFu6eFxy10C2/XjYvE/kZEXRZL9BLWYxRBFGA5aKNZH4bQ+YpigC4RivK2MlkKF4492Y46mamAibH 9DTQdZxb0njWNmr9/aqGvod7lU4PiF5DkwrsIW0caQcvlb6YdkArCPFrRLdaK3pYILzU6NaHLegf2S GBb6STv4zBGSvtBvEaMDxbbs4n1EHvpnzEmK9Bq2MODn3QPXRCvdoHw+A90ZclIZS+yfXIr7iqEMOp c65mTc8krmSmiXWQpFOrYdF9060FlJUhsCdGdgWfnVhu0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Even though it is unlikely to ever make a difference, let's use u32
consistently for the size of the load_options provided by the firmware
(aka the command line)

While at it, do some general cleanup too: use efi_char16_t, avoid using
options_chars in places where it really means options_size, etc.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 17 +++++++++--------
 drivers/firmware/efi/libstub/efistub.h         |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index fb27f4cc6ce0..08b551b7eb32 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -310,7 +310,7 @@ bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
  *
  * Detect this case and extract OptionalData.
  */
-void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size)
+void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_size)
 {
 	const efi_load_option_t *load_option = *load_options;
 	efi_load_option_unpacked_t load_option_unpacked;
@@ -341,21 +341,22 @@ void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_si
  */
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 {
-	const u16 *s2;
-	unsigned long cmdline_addr = 0;
-	int options_chars = efi_table_attr(image, load_options_size);
-	const u16 *options = efi_table_attr(image, load_options);
+	const efi_char16_t *options = efi_table_attr(image, load_options);
+	u32 options_size = efi_table_attr(image, load_options_size);
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
+	unsigned long cmdline_addr = 0;
+	const efi_char16_t *s2;
 	bool in_quote = false;
 	efi_status_t status;
+	u32 options_chars;
 
-	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
-	options_chars /= sizeof(*options);
+	efi_apply_loadoptions_quirk((const void **)&options, &options_size);
+	options_chars = options_size / sizeof(efi_char16_t);
 
 	if (options) {
 		s2 = options;
 		while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
-			u16 c = *s2++;
+			efi_char16_t c = *s2++;
 
 			if (c < 0x80) {
 				if (c == L'\0' || c == L'\n')
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 54f37e886be7..02fb5f7c8eff 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -861,7 +861,7 @@ typedef struct {
 	u16 file_path_list_length;
 	const efi_char16_t *description;
 	const efi_device_path_protocol_t *file_path_list;
-	size_t optional_data_size;
+	u32 optional_data_size;
 	const void *optional_data;
 } efi_load_option_unpacked_t;
 
@@ -906,7 +906,7 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
 
 void efi_free(unsigned long size, unsigned long addr);
 
-void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size);
+void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_size);
 
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
-- 
2.35.1

