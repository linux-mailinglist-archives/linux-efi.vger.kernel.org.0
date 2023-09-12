Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272979CAE9
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjILJCW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjILJBt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FC10C8
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec9300c51so5077473276.3
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509305; x=1695114105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lY845+S01nhx09ii/MIWXs1MbygWhHKQ2btv9eU9x9A=;
        b=GJwRBNwoA0CyXzjxP3tSAf/DdI/z8sWZJ+z7S/BGBT0nhg4mDWMDikNapIMWC/DGar
         p2OAK9oRwnA2pLhgk24KBwQTfkWqJ6aYqAJuP76ZUr+KOeVFuj9A2mOZPtaErM6oHqR4
         EGWEVc/TuFm908tMn9rHCgFIwfdeRDwQq+vXksnU+Ot631QIB7tDp9s7DdjtwaggvwLL
         Kr3qxxLlhEwhRzoYr+1bCteS1r8amN81Q1Iv54JLjl20SLHAWLrl0jJpAqFZ5xmh0I45
         kloQVUjqDgx7qWHStA31c6lBNtAxjLGhgSaq3edbcdwz9t/nA5tChfjliQfl7OKTQ2is
         ASDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509305; x=1695114105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lY845+S01nhx09ii/MIWXs1MbygWhHKQ2btv9eU9x9A=;
        b=tUGLLygYWBlc+oqPdWtamxk/38EXvf2Sky8i6emwxA5xw+tJp44/5av1gQ9XTHr+kl
         9DR1tlZfYbgih+CDXbE7ay6J4SVCvzvyCQqkomCD6Sw5JwlXbYHno9FaT+0Ch71NpNjK
         43NHO/ogYP7pcyNBvBcGX31wLB387rtzpeONluVh5SJj+7dZDHEIvYDuV+xDNk6mCau4
         11MA2syQNVJmsYbPPklQK3QzQnP73D1vPEshRO6P+vX10wTgImdGd8vvoMU83TGLkXZ4
         GcuVIB9R564cm018vsKx+vAFfBT7TtnFZ/SaAn0dKY3PjjSiR5oizjdIhWSYaUQtKWb9
         1rkQ==
X-Gm-Message-State: AOJu0YzIKaQluzCfBsEhGWcyWSa/gX4dcYNtVfdLdDF4vkUVQL+QnVJV
        2f3Er3CSJ394cDOb/ubgCpoNyuEVlif+sZf9Eek4IiGPH2lJmJxZeJzmIig4PqH3SFGnmJeg2fm
        eDYyTdef177od9Fm9r46yRAPPeRdMEdQfd2L5L+9TyZdgiyZQ7oBD1u1dLFEy
X-Google-Smtp-Source: AGHT+IEQP2h+jQPbijxzPKpITToU6a3zTKdU704KIxanL1a5X045x+7UKWz7mY6HIzA+z3zuq8BGg/7/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:320e:0:b0:d79:3b84:9997 with SMTP id
 y14-20020a25320e000000b00d793b849997mr266670yby.7.1694509304400; Tue, 12 Sep
 2023 02:01:44 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:59 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=ardb@kernel.org;
 h=from:subject; bh=ZCOIzJuca8aCKR3/do/fxqf6xpAvtzsZS44F8RCRZaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4+zjkiM79G67utrwBm3s5u2eJWKkUHEiZRJTLIv0r
 m2+Yps7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQmMTD80+iymtmgbON3yvW/
 Ic+ZI8azVA8fiZMQ+sNeqVZzZl+lOMM/a57yBHM/PmHzBaVXZy4vjnDee+fKpaOfl6VeOLuhO+k /EwA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-25-ardb@google.com>
Subject: [PATCH v2 08/15] x86/boot: Drop references to startup_64
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The x86 boot image generation tool assign a default value to startup_64
and subsequently parses the actual value from zoffset.h but it never
actually uses the value anywhere. So remove this code.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      | 2 +-
 arch/x86/boot/tools/build.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index f33e45ed1437..0e98bc503699 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 660627ea6cbb..14ef13fe7ab0 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long startup_64;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -263,7 +262,6 @@ static void efi_stub_defaults(void)
 	efi_pe_entry = 0x10;
 #else
 	efi_pe_entry = 0x210;
-	startup_64 = 0x200;
 #endif
 }
 
@@ -338,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
-- 
2.42.0.283.g2d96d420d3-goog

