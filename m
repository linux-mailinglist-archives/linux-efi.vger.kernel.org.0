Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB99318C061
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCST3s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35001 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCST3D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id d8so4454382qka.2;
        Thu, 19 Mar 2020 12:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyuZ8M8hTl4MaCMTYbXHyAXP3KMzGBIXaWWMgKU8ijQ=;
        b=q9FUl+Yx+74dIMLFB5NNZv1hqvAOyB6l7YyS7FKqR7Bb9oxxHMMAGd2qlxyM3Yj5ke
         yvPQqdj1Xxe8czZ7i7qcDWU9N8Uk2dB6APJUDulWuty5LZzsm/M9dvtfry9x/MHZkK3q
         1PGN4wHCi6qlyon1n/0yTh3XK6w0FJyUMbq0LWodUIaiIVwbuC8I741Xg5ffTtrdFaTL
         UYY81f1nGP2dnjTa7+WDeEnxKmpvqgxROy70DhBcGtFpxgq8HwNTLoPsYAoDVlhLTbmx
         m9USfFkGNHmk0y7C3KtICIuR6ykHmM9m6Bcx0PY0N5fmXdc+u7G7iESoWWy5gnUIOAce
         N8jQ==
X-Gm-Message-State: ANhLgQ2a2o91G9z8OOXpwvQ64aW9M8MddxcJ9iTY4Sfk5nonLZwIXCss
        d5NG3oDPYDUAioW85gMSwsPd48oM
X-Google-Smtp-Source: ADFU+vt8r27sirTa1/TXK6kylHy9BON3NDa7IdMi9iAfCVmtWuq9ld+Fo2Sol5PW0cXR7xuFmoYlbw==
X-Received: by 2002:a37:92c4:: with SMTP id u187mr4414343qkd.466.1584646142803;
        Thu, 19 Mar 2020 12:29:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] efi/gop: Move variable declarations into loop block
Date:   Thu, 19 Mar 2020 15:28:47 -0400
Message-Id: <20200319192855.29876-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Declare the variables inside the block where they're used.

Get rid of a couple of redundant initializers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index a7d3efe36c78..0d195060a370 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -88,16 +88,19 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 static efi_graphics_output_protocol_t *
 find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 {
-	efi_graphics_output_protocol_t *gop, *first_gop;
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info = NULL;
-	efi_status_t status;
+	efi_graphics_output_protocol_t *first_gop;
 	efi_handle_t h;
 	int i;
 
 	first_gop = NULL;
 
 	for_each_efi_handle(h, handles, size, i) {
+		efi_status_t status;
+
+		efi_graphics_output_protocol_t *gop;
+		efi_graphics_output_protocol_mode_t *mode;
+		efi_graphics_output_mode_info_t *info;
+
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		void *dummy = NULL;
 
@@ -136,7 +139,7 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 {
 	efi_graphics_output_protocol_t *gop;
 	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info = NULL;
+	efi_graphics_output_mode_info_t *info;
 	efi_physical_addr_t fb_base;
 
 	gop = find_gop(proto, size, handles);
-- 
2.24.1

