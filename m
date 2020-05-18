Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062D41D87E7
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgERTHf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41468 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgERTHe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id n14so11439016qke.8
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOw8zlM/FkyQy9W4Ki4Y1hrnF1IMps9I2hdJopKcb14=;
        b=nnTd36/S55hpLKny+M2mkogT0wNmjsl1D0Y7ofF6FE8Ninzo7RLoUQQQXDbc/98ti/
         LFEX7Mk9q+2kAWHIiyYhTfK5wFxpW/qHHdso123dJv9wjpBDoQiMiKde//FbNPxf/bI+
         v0OM6aOR8jdjfE3a7xajT15oGxG+F7EOLDRe4S5Fd56uc6m3caBl9GZWBrbK0xQVBHr5
         tDxufqkwkeo6XlZXi/PYrprAwmSSFSURuP4txcQMa4PO2hBMqAdlaQ/NtK+4J6Izc+xj
         mZDjRoY5lkvsTacYKSZzix1ajBCgbahCqYRILIACQy7zrTprHNQGLVV+TQ5YbBvc1L8m
         iTgQ==
X-Gm-Message-State: AOAM533AUXqnqRWIsSJPr+4gHb63oY38yHxsVzTwlMiL2hqFJcXa3cJn
        y8KAQ6BHgR21dPn6cBu/wUY=
X-Google-Smtp-Source: ABdhPJyTzX/cQRXDTCHIvpvUGmUwj4CmS8vKjq7iLpixjrbnbcw9BNqaSWPqrtfl+XCg9Of0T4Ypzw==
X-Received: by 2002:a37:38e:: with SMTP id 136mr17465742qkd.247.1589828852522;
        Mon, 18 May 2020 12:07:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 19/24] efi/gop: Add an option to list out the available GOP modes
Date:   Mon, 18 May 2020 15:07:11 -0400
Message-Id: <20200518190716.751506-20-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add video=efifb:list option to list the modes that are available.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/fb/efifb.rst                    |  5 +
 .../firmware/efi/libstub/efi-stub-helper.c    | 35 +++++++
 drivers/firmware/efi/libstub/efistub.h        |  2 +
 drivers/firmware/efi/libstub/gop.c            | 97 ++++++++++++++++++-
 include/linux/efi.h                           |  1 +
 5 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 519550517fd4..6badff64756f 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -63,4 +63,9 @@ auto
         with the highest resolution, it will choose one with the highest color
         depth.
 
+list
+        The EFI stub will list out all the display modes that are available. A
+        specific mode can then be chosen using one of the above options for the
+        next boot.
+
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index c0278a8063b7..a36f3af6e130 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -463,3 +463,38 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 
 	return status;
 }
+
+efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
+{
+	efi_event_t events[2], timer;
+	unsigned long index;
+	efi_simple_text_input_protocol_t *con_in;
+	efi_status_t status;
+
+	con_in = efi_table_attr(efi_system_table, con_in);
+	if (!con_in)
+		return EFI_UNSUPPORTED;
+	efi_set_event_at(events, 0, efi_table_attr(con_in, wait_for_key));
+
+	status = efi_bs_call(create_event, EFI_EVT_TIMER, 0, NULL, NULL, &timer);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_bs_call(set_timer, timer, EfiTimerRelative,
+			     EFI_100NSEC_PER_USEC * usec);
+	if (status != EFI_SUCCESS)
+		return status;
+	efi_set_event_at(events, 1, timer);
+
+	status = efi_bs_call(wait_for_event, 2, events, &index);
+	if (status == EFI_SUCCESS) {
+		if (index == 0)
+			status = efi_call_proto(con_in, read_keystroke, key);
+		else
+			status = EFI_TIMEOUT;
+	}
+
+	efi_bs_call(close_event, timer);
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c7c03099367f..ad7e0406d0ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -323,6 +323,8 @@ union efi_simple_text_input_protocol {
 	} mixed_mode;
 };
 
+efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key);
+
 union efi_simple_text_output_protocol {
 	struct {
 		void *reset;
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 34c0cba2c8bf..ea5da307d542 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -19,7 +19,8 @@ enum efi_cmdline_option {
 	EFI_CMDLINE_NONE,
 	EFI_CMDLINE_MODE_NUM,
 	EFI_CMDLINE_RES,
-	EFI_CMDLINE_AUTO
+	EFI_CMDLINE_AUTO,
+	EFI_CMDLINE_LIST
 };
 
 static struct {
@@ -100,6 +101,19 @@ static bool parse_auto(char *option, char **next)
 	return true;
 }
 
+static bool parse_list(char *option, char **next)
+{
+	if (!strstarts(option, "list"))
+		return false;
+	option += strlen("list");
+	if (*option && *option++ != ',')
+		return false;
+	cmdline.option = EFI_CMDLINE_LIST;
+
+	*next = option;
+	return true;
+}
+
 void efi_parse_option_graphics(char *option)
 {
 	while (*option) {
@@ -109,6 +123,8 @@ void efi_parse_option_graphics(char *option)
 			continue;
 		if (parse_auto(option, &option))
 			continue;
+		if (parse_list(option, &option))
+			continue;
 
 		while (*option && *option++ != ',')
 			;
@@ -290,6 +306,82 @@ static u32 choose_mode_auto(efi_graphics_output_protocol_t *gop)
 	return best_mode;
 }
 
+static u32 choose_mode_list(efi_graphics_output_protocol_t *gop)
+{
+	efi_status_t status;
+
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info;
+	unsigned long info_size;
+
+	u32 max_mode, cur_mode;
+	int pf;
+	efi_pixel_bitmask_t pi;
+	u32 m, w, h;
+	u8 d;
+	const char *dstr;
+	bool valid;
+	efi_input_key_t key;
+
+	mode = efi_table_attr(gop, mode);
+
+	cur_mode = efi_table_attr(mode, mode);
+	max_mode = efi_table_attr(mode, max_mode);
+
+	efi_printk("Available graphics modes are 0-%u\n", max_mode-1);
+	efi_puts("  * = current mode\n"
+		 "  - = unusable mode\n");
+	for (m = 0; m < max_mode; m++) {
+		status = efi_call_proto(gop, query_mode, m,
+					&info_size, &info);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		pf = info->pixel_format;
+		pi = info->pixel_information;
+		w  = info->horizontal_resolution;
+		h  = info->vertical_resolution;
+
+		efi_bs_call(free_pool, info);
+
+		valid = !(pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX);
+		d = 0;
+		switch (pf) {
+		case PIXEL_RGB_RESERVED_8BIT_PER_COLOR:
+			dstr = "rgb";
+			break;
+		case PIXEL_BGR_RESERVED_8BIT_PER_COLOR:
+			dstr = "bgr";
+			break;
+		case PIXEL_BIT_MASK:
+			dstr = "";
+			d = pixel_bpp(pf, pi);
+			break;
+		case PIXEL_BLT_ONLY:
+			dstr = "blt";
+			break;
+		default:
+			dstr = "xxx";
+			break;
+		}
+
+		efi_printk("Mode %3u %c%c: Resolution %ux%u-%s%.0hhu\n",
+			   m,
+			   m == cur_mode ? '*' : ' ',
+			   !valid ? '-' : ' ',
+			   w, h, dstr, d);
+	}
+
+	efi_puts("\nPress any key to continue (or wait 10 seconds)\n");
+	status = efi_wait_for_key(10 * EFI_USEC_PER_SEC, &key);
+	if (status != EFI_SUCCESS && status != EFI_TIMEOUT) {
+		efi_err("Unable to read key, continuing in 10 seconds\n");
+		efi_bs_call(stall, 10 * EFI_USEC_PER_SEC);
+	}
+
+	return cur_mode;
+}
+
 static void set_mode(efi_graphics_output_protocol_t *gop)
 {
 	efi_graphics_output_protocol_mode_t *mode;
@@ -305,6 +397,9 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 	case EFI_CMDLINE_AUTO:
 		new_mode = choose_mode_auto(gop);
 		break;
+	case EFI_CMDLINE_LIST:
+		new_mode = choose_mode_list(gop);
+		break;
 	default:
 		return;
 	}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 974648db0c68..609201bd4682 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
 
-- 
2.26.2

