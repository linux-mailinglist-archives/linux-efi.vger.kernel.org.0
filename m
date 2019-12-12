Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7411D89D
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfLLVeq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:34:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42943 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfLLVeq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:34:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so27791qkg.9
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYk+pP/U4eC+SSzH9fa5Kd01UDBC1RKdUeYD1GrtGgY=;
        b=PptymULuUGiFOg9tYZ6HzlKjS0mkGDOz3z+AftXZTvTXvqqlol6eduXDvaDdY2rQRe
         rPGOI0S8GDIJfDpNKjA8WWO/eGzB/TGHz/aMduHp3ZeX3A5tBIdtEI0Qav9EBvx2KGQ+
         0rBGE1dma+0vwbOruZjY/g6V4qKTTHV17vWiuDxDytoOVA5owUY6X4v9y2dcl9wv/6OJ
         az5dstC9AX4vCUblKrikdmJNIKEhhXK3J8MASCh0h2hhGYZmVGAbbJFkZOiCrilaeURt
         3UN2p6av0y5XJWSuFaHMSOuhF4PwtCSeeHFsLMbBRMC/2diLql3k7UG5HMSzWP7GC04w
         EPIQ==
X-Gm-Message-State: APjAAAVpTQAufK2dJlRO9/54G1I8tp94gV7IoL7Yobehjik9UyPQspEV
        gJmuR0A2cVKVgEuDEd6q4XY=
X-Google-Smtp-Source: APXvYqx8jlFNYcGnUsQoErq4RGRJqDeMrN+4UkUQh76yCmUEbCeJQ309B1PcuxzcqbSsrsKSx3pJKQ==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr10110506qkf.344.1576186485690;
        Thu, 12 Dec 2019 13:34:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm2116467qkf.44.2019.12.12.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:34:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 1/5] efi/gop: Remove bogus packed attribute from GOP structures
Date:   Thu, 12 Dec 2019 16:34:39 -0500
Message-Id: <20191212213443.24128-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212213443.24128-1-nivedita@alum.mit.edu>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI structures are not packed, they follow natural alignment.

The packed attribute doesn't have any effect on the structure layout due
to the types and order of the members, and we only ever get these
structures as output from the EFI firmware so alignment issues have not
come up.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/efi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea595c8c..bffe6e0a9b53 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1429,7 +1429,7 @@ struct efi_graphics_output_mode_info {
 	int pixel_format;
 	struct efi_pixel_bitmask pixel_information;
 	u32 pixels_per_scan_line;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode_32 {
 	u32 max_mode;
@@ -1438,7 +1438,7 @@ struct efi_graphics_output_protocol_mode_32 {
 	u32 size_of_info;
 	u64 frame_buffer_base;
 	u32 frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode_64 {
 	u32 max_mode;
@@ -1447,7 +1447,7 @@ struct efi_graphics_output_protocol_mode_64 {
 	u64 size_of_info;
 	u64 frame_buffer_base;
 	u64 frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode {
 	u32 max_mode;
@@ -1456,7 +1456,7 @@ struct efi_graphics_output_protocol_mode {
 	unsigned long size_of_info;
 	u64 frame_buffer_base;
 	unsigned long frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_32 {
 	u32 query_mode;
-- 
2.23.0

