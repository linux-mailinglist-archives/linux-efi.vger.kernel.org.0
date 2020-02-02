Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C958B14FE81
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBBROQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:14:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37594 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBBRN7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:13:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so11945102qky.4;
        Sun, 02 Feb 2020 09:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7z/YtSaq7WUzyq8uTh8INOXWGUnC01Sb7rXV3fObso0=;
        b=pp7H0XoQYSNYA4GFMEUYibj5HNzpPxzQMK+MCbV61x++knGyJ6trn61dhBcIVI7nlK
         DbpDJ0p/7Rw0dE0JFrgJSVpbIdFPt31lFno5QJTL+eESlAkP8Sx1dgcSTxzSrrcFasfq
         koUR/LGd73FsWm3HXR5tXYLZgQ3nZPSIZvgq1C7dWs11z4xMl5E3WTr92zQgeHNNWtUI
         xWNjJGiB9xAgMO3pHK/wRLAlxuv4XgL7JbKzdx20ZNwG3qgzuA7E31qD2KqZ293HsPM8
         zR8ZLj12u3ciyN5LbFJ3UmrdTitKfIvUIUxtIqA+RDMcY+6vU9yL+WqAXAuVlTzz1x+4
         ekiA==
X-Gm-Message-State: APjAAAXKu+adxd8KA85BjpfTUZamU6WJpBhLYAf3bIlAUlmvzAYd51yp
        H1kQ5/F0O/KGlg5UnMUOTrQ=
X-Google-Smtp-Source: APXvYqx/ENYUtOI2sS13110ci/muoumkUzIc1oq7r7XR5BT3TFvqqrlcgxGHBpUBdZE2WuV2sCY5xw==
X-Received: by 2002:a05:620a:1108:: with SMTP id o8mr19312466qkk.118.1580663638235;
        Sun, 02 Feb 2020 09:13:58 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] x86/boot: Clear direction and interrupt flags in startup_64
Date:   Sun,  2 Feb 2020 12:13:50 -0500
Message-Id: <20200202171353.3736319-5-nivedita@alum.mit.edu>
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

startup_32 already clears these flags on entry, do it in startup_64 as
well for consistency.

The direction flag in particular is not specified to be cleared in the
boot protocol documentation, and we currently call into C code
(paging_prepare) without explicitly clearing it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 27eb2a6786db..69cc6c68741e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -264,6 +264,9 @@ SYM_CODE_START(startup_64)
 	 * and command line.
 	 */
 
+	cld
+	cli
+
 	/* Setup data segments. */
 	xorl	%eax, %eax
 	movl	%eax, %ds
-- 
2.24.1

