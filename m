Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A217E14FE77
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBBRN6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:13:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36061 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgBBRN6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:13:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so9630421qto.3;
        Sun, 02 Feb 2020 09:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNIctzUQqpzBYKShq+agBaG6jK3vI6wtoz79iRuDrBw=;
        b=sWkCGbdMQWvcwW4ZHprK51piBkeEU7tV8JfOcgdx8Bt5urzx+A56RoD4TFU3buuuM+
         6+3MuC5BTUgurRTh/MZ5YnuKisJEFFWVt9FUQ5IPXVI1m/QyFY+4rjCJHQvP5Uj535XQ
         NFLijm93UgzkXOtl/HIEGrOFSfy4id0ft5MFu3++hrivKTl7SCNUcemMJPhO2+X9x0Oi
         Edpab/AL3K+6EUjpYH0t0Wu2PlV1EkwST5wkZpyi7skfGilEv5PXAAJhGzj5VCxj67te
         iMQWnCSz9G8ls8NJTy74JwVIA8L2G5OOynIpCmzAi9AAKhqCTNbq9cngodyizQn96O0v
         niVw==
X-Gm-Message-State: APjAAAWAOoIO3xJTV39+3AJi9v+uqOK7c3eS/ih2U6jg2CwPE+Uu7T37
        yEBTu+pDtKbo9CESAKu01Jo=
X-Google-Smtp-Source: APXvYqwebnSPusJY9nsi2lbUddkkzsLGkBomkzxc7tNp5ELHxXeAL1BDDv5tcF6aLeDghjwGVDgjuQ==
X-Received: by 2002:aed:2321:: with SMTP id h30mr20706652qtc.355.1580663637426;
        Sun, 02 Feb 2020 09:13:57 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] x86/boot: Reload GDTR after copying to the end of the buffer
Date:   Sun,  2 Feb 2020 12:13:49 -0500
Message-Id: <20200202171353.3736319-4-nivedita@alum.mit.edu>
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

The GDT may get overwritten during the copy or during extract_kernel,
which will cause problems if any segment register is touched before the
GDTR is reloaded by the decompressed kernel. For safety update the GDTR
to point to the GDT within the copied kernel.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c56b30bd9c7b..27eb2a6786db 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -439,6 +439,16 @@ trampoline_return:
 	cld
 	popq	%rsi
 
+	/*
+	 * The GDT may get overwritten either during the copy we just did or
+	 * during extract_kernel below. To avoid any issues, repoint the GDTR
+	 * to the new copy of the GDT.
+	 */
+	leaq	gdt64(%rbx), %rax
+	subq	%rbp, 2(%rax)
+	addq	%rbx, 2(%rax)
+	lgdt	(%rax)
+
 /*
  * Jump to the relocated address.
  */
-- 
2.24.1

