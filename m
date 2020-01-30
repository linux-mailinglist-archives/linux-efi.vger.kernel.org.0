Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9775F14E57A
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgA3WUH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 17:20:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41555 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WUH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 17:20:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id l19so3825825qtq.8;
        Thu, 30 Jan 2020 14:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=en1MT5pfFYZGlv9UT5t9agWedf83iVv/aGc5EUfT5Zc=;
        b=Ev4rTNf6mduRXJB3Lr9t6ESO8yGPYrVRQa8YXDWaE/1mkN71xFH7FPDV+8+Mp88wo6
         VWJ6SyEmxCVA4tIgG9X2eyUKeKX8LxS4be0SXKOvDMjBbNxKhC66iKjlptke6lZnjdv+
         ezfPz0ZA4P25JRQDYOcDSBv2E4bCzK+i61o+07vzvDhq8O+arvd8FcPxJmKcaNggPxbL
         Ra3x84wL4XwB5Aypy1LIYZQ22D7VlgmZdqbSLqC+iYe22j3vJG0W8CGPKCx8pEEWXX00
         eTdGcUdrlJZrQ60xqmwrKuJbw7MON1TUcSxYnqgXjvFs5JDyGJz13ZYrO1z/Pq0oZOBO
         8xbw==
X-Gm-Message-State: APjAAAUZQhcgTHV4c0XaejTXIOYfbY9wufN8IKzGxpYqlW3Z1j1yBOcw
        9aZecFQHcKzU9ZILZtQS+n8=
X-Google-Smtp-Source: APXvYqwmKk3Q21jsUq6mWGkYPBdAVXbqi23AQ2F6jBL81aRXB94JTeDkd8tDk/DKdk6qqZJx0UDOAg==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr473459qtr.198.1580422806255;
        Thu, 30 Jan 2020 14:20:06 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d25sm3465389qkk.77.2020.01.30.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:20:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Mark setup_graphics static
Date:   Thu, 30 Jan 2020 17:20:04 -0500
Message-Id: <20200130222004.1932152-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This function is only called from efi_main in the same source file.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 2447e4508aa4..5e5f89ff5226 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -316,7 +316,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	return status;
 }
 
-void setup_graphics(struct boot_params *boot_params)
+static void setup_graphics(struct boot_params *boot_params)
 {
 	efi_guid_t graphics_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
 	struct screen_info *si;
-- 
2.24.1

