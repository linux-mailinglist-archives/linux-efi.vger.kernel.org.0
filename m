Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4D18C51A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCTCBO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:01:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34415 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCTCAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so5471887qkh.1;
        Thu, 19 Mar 2020 19:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyuZ8M8hTl4MaCMTYbXHyAXP3KMzGBIXaWWMgKU8ijQ=;
        b=bmWXNWwB8GtLQVdbJpZBZTdl3SMZvQJYTpUcxfTpTYBd1LFqKTv8BxecgmUQCs5GCY
         C9EthtWyk2AtmaWS2MLb692DY5r1b2ySQMPEMkPpCuHNcLikiII6OuIhNCmiIKwP5SAb
         ebJ4L1+X0lvLAIfFv2+2B2YM6UOrcphgr6gkQFs8zD7zOKmEAPzagRy7vbmwM6TE/Ybk
         3Zp/UG3oS8zugsJglq2vn1r3hHISKjxj4UjsCO6hfRVevgKIzV2LTVtJnLvTwXbSyhHy
         nk2h7G3enIQY1JyP7fH3eUlRc7MvCp/nZOxOxtMG6bojaXN0zY8wdieD3w99sGgEmml8
         bn+A==
X-Gm-Message-State: ANhLgQ0jc6Sp6n4Nxzo+LwwmunKvFC73MtBhRFZAyAGCMRHXMo8yqTnD
        cw4xp93RWVu6TIyEyQRK4PI=
X-Google-Smtp-Source: ADFU+vstf0QpP2kqgq0e2yzW6Tx65yPke7CM+e3g96oIBbpntCYmoarfKV3+TH/sQq9Zje7b6Uci3A==
X-Received: by 2002:a37:6411:: with SMTP id y17mr6065401qkb.437.1584669635482;
        Thu, 19 Mar 2020 19:00:35 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] efi/gop: Move variable declarations into loop block
Date:   Thu, 19 Mar 2020 22:00:20 -0400
Message-Id: <20200320020028.1936003-7-nivedita@alum.mit.edu>
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

