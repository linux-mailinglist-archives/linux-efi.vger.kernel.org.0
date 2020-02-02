Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA614FE7C
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBBROA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:14:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34620 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBBROA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:14:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id g3so3346546qka.1;
        Sun, 02 Feb 2020 09:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaSQqD1f11t4pGUDsgeYFl9+dx25Mu1OCOk2wHccxUc=;
        b=TTMwCmCrQz1HYEnLRwIdzFnaW69M9Rc1efT/gDVUaMyDW7OYyvPhYoyV8QQehEXeVa
         5DTB6owCKFzOCCxqttFYmwUgmdJHxpRUXpnsy7XwOkm4xkPKvmqGbaLRKpv5DYqiZGA1
         wkE3B4dQXTT2LMWOuI7oydriILNhkOLnnZKoMz0tmwD5u+v2D8+K5ZSiH0kWQm74JYBI
         PcoP8IfdT/JW7o6jNlReXMJ8qG0rXEysFnTcH73D7a92UI7y2Ow+yyKlazWPuMwZsJjx
         3zJ9j6UTFbZmXem9Mo4987IZLKg5ydp6OWLsJBDapksbhx6C4hNPIAEcacDp9qctcvCs
         FcJQ==
X-Gm-Message-State: APjAAAWtI5qVKc1eAXh+BOK/yUV8Q/6f66u3IXcvi/YK5JPRx/YMpdGm
        3FrK5DUtTZvZaK4G3hRvZWI=
X-Google-Smtp-Source: APXvYqwMtgW9EfbgzTEC8DH0j5loYu+zFEopOTh/5uDUhajtIkBVVcQ/d3uB0UAUTphurHIu38AIng==
X-Received: by 2002:a37:48c4:: with SMTP id v187mr20383369qka.198.1580663639639;
        Sun, 02 Feb 2020 09:13:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] x86/boot: GDT limit value should be size - 1
Date:   Sun,  2 Feb 2020 12:13:52 -0500
Message-Id: <20200202171353.3736319-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202171353.3736319-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The limit value for the GDTR should be such that adding it to the base
address gives the address of the last byte of the GDT, i.e. it should be
one less than the size, not the size.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 69cc6c68741e..c36e6156b6a3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -624,12 +624,12 @@ SYM_FUNC_END(.Lno_longmode)
 
 	.data
 SYM_DATA_START_LOCAL(gdt64)
-	.word	gdt_end - gdt
+	.word	gdt_end - gdt - 1
 	.quad   0
 SYM_DATA_END(gdt64)
 	.balign	8
 SYM_DATA_START_LOCAL(gdt)
-	.word	gdt_end - gdt
+	.word	gdt_end - gdt - 1
 	.long	gdt
 	.word	0
 	.quad	0x00cf9a000000ffff	/* __KERNEL32_CS */
-- 
2.24.1

