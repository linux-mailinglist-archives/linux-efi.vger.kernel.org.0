Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46172069C7
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 03:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbgFXBtt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 21:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbgFXBts (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 21:49:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA4FC0613ED
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n2so316705pld.13
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2Y9k0Aoe2PsZ9fBDANRxjQwY2H7eXTSzLJBeV/fV9o=;
        b=RC848NE0i/SynoMx88lxwIqaEnktRv/S08z+yAGNh98QRc3g4glJaSAeh83V0/+vPO
         sjMdPL0uY1PkRniwXJCNB+xOulhCOQhUnpKwy+H221ODhthgAsjRcLSarVWaiOiWz7xt
         Cc8BPSg3mJr7EYRRdfSeZSgwISEHMenzA02OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2Y9k0Aoe2PsZ9fBDANRxjQwY2H7eXTSzLJBeV/fV9o=;
        b=hdiBbokPAnrgmvaP8zf2V8i+SSDQw/GotB9El1ifqG5zZQ4ZP5j8EGw/HGY/mkpCw5
         mj2EGg0eOJZf580PyoaQh7NeMPLWJaOhhWbiWg6OPZw0MRYM/vt96j1GFgsTFW+z0rtM
         DAm5EUfOafdGHVJw/wh/hx4rOaHY78JFqpI4ACIfFhd/G9nn264T4xNY8r3V6lW3LYHo
         IG3WQPlFU/y7/W7wN9YB/L/WXN9cK95l+Aigo7+gPof7mjn1nIdGpGVSnrI1h87A2uwE
         gt630cyRl4CrNZEtun0TphyGXnsG2lj8d22cg9O67ypI/3CjgzQoemQ3potVvmBGzJJS
         a45w==
X-Gm-Message-State: AOAM530KHQaTykcEreyNjhah9ZksrR/CYbG4IQb+TMt5ENQfmMzuwxhL
        4M0qT9aiPbwyOsVEE+i36jI0FQ==
X-Google-Smtp-Source: ABdhPJwbPwuYwHHFtJvDEYHOAcax4lPh//ndXHRqaZjT6O+W3S86MG1guQT1J9/rY7vF5ODXFge+OA==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr25557096plc.226.1592963387558;
        Tue, 23 Jun 2020 18:49:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp15sm3524928pjb.45.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Date:   Tue, 23 Jun 2020 18:49:34 -0700
Message-Id: <20200624014940.1204448-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
make sure unwanted sections don't end up appearing under the .init
section prefix that libstub adds to itself during objcopy.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..9d2d2e784bca 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+# Remove unwanted sections first.
+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
-- 
2.25.1

