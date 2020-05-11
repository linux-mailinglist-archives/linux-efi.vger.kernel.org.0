Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5461CE8A4
	for <lists+linux-efi@lfdr.de>; Tue, 12 May 2020 00:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgEKW6w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 May 2020 18:58:52 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43547 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgEKW6w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 May 2020 18:58:52 -0400
Received: by mail-qv1-f67.google.com with SMTP id di6so5415309qvb.10;
        Mon, 11 May 2020 15:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/AqPGNNCCRNNs6yWlXdcbQgq4XXU3JF7CTXbXn4IQg=;
        b=TkuINt049NqbOxt/5QvYSGXory14dQoG0dTb4WG7oKlI3QSUrBbPKmXMXmpUfZ2uj0
         u4Q0C0aVzSgOkNUyySuyqzO5JFjr7o3LcdRaD87Qv4qa0ylA1UHMGt18VPXnJQWCVdZk
         zSiPHSHqbInk+RxPduJTKLoKv16ym1LV9BK7NGpL6TLJHPXE7McuFjK0wv+XVndlkcMF
         uQML3uZKPpved7s0hziUgZB6KqoaBGp8P6swMQyp5M5+l4SS6eZLE/qcrCI05Bwa4axI
         z+nPN4OfFLKC9+N9KxHpL4t67tFTVsGLr7eut5AqacXyeNBDZDz8C7gINrh3uSyn9rjl
         bSRg==
X-Gm-Message-State: AGi0PuaAW45jI8JLVvre19Xrx4y814qxNU8lz00g1GjscMbocprj3gFg
        KCU8EezYRMKANT5YDyLaasA=
X-Google-Smtp-Source: APiQypJvKugSQTijiNRSvdV/bczPnuCaHCjQfpZ6x30X8mYYazVXIUSTt9mfY8tRbr2XDFdf7TyzkA==
X-Received: by 2002:a0c:9a4f:: with SMTP id q15mr17329705qvd.132.1589237931117;
        Mon, 11 May 2020 15:58:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m59sm10445345qtd.46.2020.05.11.15.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:58:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Mike Lothian <mike@fireburn.co.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: [PATCH] x86/boot: Mark global variables as static
Date:   Mon, 11 May 2020 18:58:49 -0400
Message-Id: <20200511225849.1311869-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511225324.GA1307788@rani.riverdale.lan>
References: <20200511225324.GA1307788@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mike Lothian reports that after commit
  964124a97b97 ("efi/x86: Remove extra headroom for setup block")
gcc 10.1.0 fails with

  HOSTCC  arch/x86/boot/tools/build
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  error: linker defined: multiple definition of '_end'
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  /tmp/ccEkW0jM.o: previous definition here
  collect2: error: ld returned 1 exit status
  make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
  make: *** [arch/x86/Makefile:303: bzImage] Error 2

The issue is with the _end variable that was added, to hold the end of
the compressed kernel from zoffsets.h (ZO__end). The name clashes with
the linker-defined _end symbol that indicates the end of the build
program itself.

Even when there is no compile-time error, this causes build to use
memory past the end of its .bss section.

To solve this, mark _end as static, and for symmetry, mark the rest of
the variables that keep track of symbols from the compressed kernel as
static as well.

Fixes: 964124a97b97 ("efi/x86: Remove extra headroom for setup block")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/tools/build.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 8f8c8e386cea..c8b8c1a8d1fc 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,14 +59,14 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-unsigned long efi32_stub_entry;
-unsigned long efi64_stub_entry;
-unsigned long efi_pe_entry;
-unsigned long efi32_pe_entry;
-unsigned long kernel_info;
-unsigned long startup_64;
-unsigned long _ehead;
-unsigned long _end;
+static unsigned long efi32_stub_entry;
+static unsigned long efi64_stub_entry;
+static unsigned long efi_pe_entry;
+static unsigned long efi32_pe_entry;
+static unsigned long kernel_info;
+static unsigned long startup_64;
+static unsigned long _ehead;
+static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
-- 
2.26.2

