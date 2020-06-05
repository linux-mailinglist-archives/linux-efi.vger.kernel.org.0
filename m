Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DE01EFC28
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFEPGn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 11:06:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43637 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgFEPGn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 11:06:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id v79so9931512qkb.10;
        Fri, 05 Jun 2020 08:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3Aey2hCctLUVtXPUILLI/+0YxyP0j2psyrkXc/MfyQ=;
        b=GWEKckaOMxop4C+909X3+FSHfBi/FiGJt7wP3bHJmOM+xVnlrqbkV1eJke17jIv5yY
         8237i40t92QK1u5CfMwUBjkjT64pYkXumWA84RNzATmeif/1Mqq6lYRhmoyPAsyCTe4d
         reJQFqgHprrWBVmmonHfO00zAwJookMR442GjB0nXSrAevoL7iTXXvh7+I6qTtVoc6gs
         tf/KfpCGKHhhYDEVR4B94ZG3z3w6MUa66vhjGCBXgFCpMXUQxpZyKFUxYsfa51+YGS97
         WSTdFvtyx3Tq+9/B5Hf20fIG1uQskBO/7VNwso36Uy9NYM6HEqboSDTLYAaKIR6XRfY7
         aZXw==
X-Gm-Message-State: AOAM530oatul5jlNnR2a/JoGdpXUUKLGz1aJ4njHZYPdA9tVYZoflaR7
        4WiNJxz/gjcDn+65pI8aeXQ=
X-Google-Smtp-Source: ABdhPJzQVvaWzPe5L3NXYZvUl2LsIj1ARJRu0MKNhqtNR+G9RA9MB+/o/kOIo8nYLPwb1qD84FWcWQ==
X-Received: by 2002:a37:6610:: with SMTP id a16mr9691954qkc.17.1591369600693;
        Fri, 05 Jun 2020 08:06:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d17sm7162555qke.101.2020.06.05.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:06:39 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, Andrey Ignatov <rdna@fb.com>
Cc:     linux-efi@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] efi/x86: Fix build with gcc 4
Date:   Fri,  5 Jun 2020 11:06:38 -0400
Message-Id: <20200605150638.1011637-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605133232.GA616374@rani.riverdale.lan>
References: <20200605133232.GA616374@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  bbf8e8b0fe04 ("efi/libstub: Optimize for size instead of speed")

changed the optimization level for the EFI stub to -Os from -O2.

Andrey Ignatov reports that this breaks the build with gcc 4.8.5.

Testing on godbolt.org, the combination of -Os,
-fno-asynchronous-unwind-tables, and ms_abi functions doesn't work,
failing with the error:
  sorry, unimplemented: ms_abi attribute requires
  -maccumulate-outgoing-args or subtarget optimization implying it

This does appear to work with gcc 4.9 onwards.

Add -maccumulate-outgoing-args explicitly to unbreak the build with
pre-4.9 versions of gcc.

Reported-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cce4a7436052..d67418de768c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,8 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
+				   $(call cc-option,-maccumulate-outgoing-args)
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
-- 
2.26.2

