Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA45BE5BE
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiITM2G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiITM2F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 08:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18275389
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 05:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B7A61F2E
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 12:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663CC433D6;
        Tue, 20 Sep 2022 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663676883;
        bh=hOm5zcpZJLun8U4GW7Meg2Ojpzde3h4spCZwffF8n5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URLpsWsQh6B1na7flwFziWsmFgEQhJRKdu8JF20gpkUY7lHCT2/PkA1XC4yNKEJ2M
         Pk5udmukcuv7wHkSTfgizjemaBHQgTm/LhEZUhFF1sy+MlvciIwh0cOONq8XqjN5CB
         PCNdNaRplg5l5oMd8jGHNVwNPR1BE/qTlsy7qBxpEWStlX4gPvt5KngVXQPkNB6vUp
         dK2lu+/O1Q68rgTyVFvEOH9wYRThdldqUXEUwmWOrdVWD8FvwdoHO9C6gBzUsZG8QW
         LMZwFgqUKBeTGVI0ZZbVIdpoaQG9yszpaYfWPD1eYytGI7HqAraZ2+jublEJjmj5d2
         jGPfQt6XoX91A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Xu, Min M" <min.m.xu@intel.com>
Subject: [PATCH v2 2/2] efi/libstub: measure EFI LoadOptions
Date:   Tue, 20 Sep 2022 14:27:46 +0200
Message-Id: <20220920122746.3553306-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920122746.3553306-1-ardb@kernel.org>
References: <20220920122746.3553306-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346; i=ardb@kernel.org; h=from:subject; bh=L3KrP8TAQav5SOxL416PJKl+GuaHSlN6f4btetHQnEY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKbHBkeOlVBWudtBigm+xWOum+xwt1qjppPqCsOHM O6DAyiqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYymxwQAKCRDDTyI5ktmPJGAgC/ 9NJl2iZNT0cpIJ+KMFShW/t0yc/HhPlOVYUMVUT6gZZ/D45iehvIv73Ir+FKzxU4XoMf/PMzy/NFSr OHgSrBW3YL3IHrjQ+QUTuRxdMXZhKFobRMcV34A/e/TiGd2N4Axy1mUFzRL9OHVRDmuYOCMI6ktEfz aIK4bKxXBU3E6jXl3JSMPCEULtE86fIGGsBfWD4e9vhi1IykAo1m0DltRiaFws+kDHOlPM+kwulYRU Em3rI2ou97nJ1RzXS/im24Z1AeSVr2RaHuuWqkcXk0NSSx2UZUYcpE3OTF0GpFKbzTt2OKGRZkVoR5 PIRMky97Xim58FEETttkW8iy48eT1v+WvJwrExuuiHEM1DybXDRu/94iQaXajE9otAwJTXPNMtP7AW SjLCIuUZ+11TaQ4qhYX0p2cWK+SbPD7tQIV1cZblOQ4C4jnZSxq677iiHi1ITmQn8VKMy8ACgpjG9x yrC/i3oYC1XlHW+dBEKxTi3pmSS14s4XmMsK/KtYf2ebQ=
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

The EFI TCG spec, in §10.2.6 "Measuring UEFI Variables and UEFI GPT
Data", only reasons about the load options passed to a loaded image in
the context of boot options booted directly from the BDS, which are
measured into PCR #5 along with the rest of the Boot#### EFI variable.

However, the UEFI spec mentions the following in the documentation of
the LoadImage() boot service and the EFI_LOADED_IMAGE protocol:

  The caller may fill in the image’s "load options" data, or add
  additional protocol support to the handle before passing control to
  the newly loaded image by calling EFI_BOOT_SERVICES.StartImage().

The typical boot sequence for Linux EFI systems is to load GRUB via a
boot option from the BDS, which [hopefully] calls LoadImage to load the
kernel image, passing the kernel command line via the mechanism
described above. This means that we cannot rely on the firmware
implementing TCG measured boot to ensure that the kernel command line
gets measured before the image is started, so the EFI stub will have to
take care of this itself.

Given that PCR #5 has an official use in the TCG measured boot spec,
let's avoid it in this case. Instead, add a measurement in PCR #9 (which
we already use for our initrd) and extend it with the LoadOptions
measurements

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 10 ++++++++++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8f9a79bc4e8e..c26c59a69c76 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -336,6 +336,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 
 enum efistub_event {
 	EFISTUB_EVT_INITRD,
+	EFISTUB_EVT_LOAD_OPTIONS,
 	EFISTUB_EVT_COUNT,
 };
 
@@ -352,6 +353,11 @@ static const struct {
 		INITRD_EVENT_TAG_ID,
 		STR_WITH_SIZE("Linux initrd")
 	},
+	[EFISTUB_EVT_LOAD_OPTIONS] = {
+		9,
+		LOAD_OPTIONS_EVENT_TAG_ID,
+		STR_WITH_SIZE("LOADED_IMAGE::LoadOptions")
+	},
 };
 
 static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
@@ -423,6 +429,10 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	efi_status_t status;
 	u32 options_chars;
 
+	if (options_size > 0)
+		efi_measure_tagged_event((unsigned long)options, options_size,
+					 EFISTUB_EVT_LOAD_OPTIONS);
+
 	efi_apply_loadoptions_quirk((const void **)&options, &options_size);
 	options_chars = options_size / sizeof(efi_char16_t);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 02fb5f7c8eff..8ad6705b555e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -762,6 +762,7 @@ union apple_properties_protocol {
 typedef u32 efi_tcg2_event_log_format;
 
 #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
+#define LOAD_OPTIONS_EVENT_TAG_ID 0x8F3B22EDU
 #define EV_EVENT_TAG 0x00000006U
 #define EFI_TCG2_EVENT_HEADER_VERSION	0x1
 
-- 
2.35.1

