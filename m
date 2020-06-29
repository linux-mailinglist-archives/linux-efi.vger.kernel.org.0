Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3720E140
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbgF2Uxj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbgF2TNU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:13:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE47C08EAED
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so4520664pjq.1
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=EVDjc0VqYgRB2DG2EzHcBoN2SoQ4nLRItPJPDmHm0b1Z1rE2TFzvswTjV0UFJMg0A+
         zk7wDPwhAdhR5pkqtDyugtOi4viSQFRF681TEkB9AOAbZShiWouWaRwMeqnrq0qniejQ
         Np9npLPCvLOYdVSL9z4v5SRp3hcbR0u8c56Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bArInUOY6/vKGVdecpLjfb0/2uC+GzWucHk89/LRTo=;
        b=eE8IAZ+sRrCyB3iv5C/1/sMWX3cXVtXflG9ICqZUk3Y9JouchJ4AbiVq9Ax9vk+LPh
         3Yl5a+ETbyKPLBzQMZomTHCTpruNp3As2FfcD2bmYWot9jLS2zJUKqaaFYP45IzzAIbx
         DaitVLPw7akxYZET+9aRrN8nH8xaq2Inl9BiWafQ/gWZlSrla+MSymclcpQeC7bI8Tvn
         Lo0oAx1KVgwpYgwOruWrH0VoX1Dod8sUROSEblN1XmDOSrLXXnSmoHgi9Gcc08xh/XRJ
         RZw50UOYx+yrlS51deSDqEW7OCt/cQc/Lh8cjMtBM7nvIqIE/VHJbCYeaG19MRvfCwM7
         Hxow==
X-Gm-Message-State: AOAM5309fzJFGi5MBUA2WpWUhGAmG1N1KQyUsHwZlnISqqMbLTKZGuTv
        N+1fNs+NuhtNvntZ8C1ORNNR+g==
X-Google-Smtp-Source: ABdhPJxYBenbTI5DJ7oZajl9d4KYYFff7a69/j4AFC+Rq7Vn12vxMy0qYgcyv5UfojptE8ebjeq4/Q==
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr4942997plo.262.1593411525398;
        Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm2979285pfn.54.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
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
Subject: [PATCH v4 01/17] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date:   Sun, 28 Jun 2020 23:18:24 -0700
Message-Id: <20200629061840.4065483-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..1248a206be8d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -934,6 +934,8 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.25.1

