Return-Path: <linux-efi+bounces-1505-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8F93E95B
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 22:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55551C211C4
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 20:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179997BB17;
	Sun, 28 Jul 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6BjeUdH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296227D40B
	for <linux-efi@vger.kernel.org>; Sun, 28 Jul 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198667; cv=none; b=NR9NxqjIDLaseClfA/+eOwkbGCMQBmVUqTVO0T8MC3j3z0JW9zd3khgvirwIY/ul7jg5QSipoKE9NAjxJ5hLkOv+gPt6LdiMDX2cZHtO29HH7MzKXFq5ycfT+BV7ejP0he/MusHObNfDfUiIRbtZnBa+EPmAH5w43sLjjiwQ4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198667; c=relaxed/simple;
	bh=jgG0TSTo1c+hpUBT22yEfSilFpbm6otN2MQr5+RKpfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IFJZ6J1fZqR/J6ZzDBazFKFUsoitBQ5SbskhKI9/LY7TR6lApahM/R0LIvPhSZCSAUZPxNHY+6xUw/LqsKnscileUgtgPaWmTWnm8eDoixj4qdheq04l7MN4xCtYPNb3PLAaz1f+BC2i2Lkoc7cqsfx1E1N9ol9zxn3bEzL+RYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6BjeUdH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so42221667b3.1
        for <linux-efi@vger.kernel.org>; Sun, 28 Jul 2024 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198663; x=1722803463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=f6BjeUdHR36Kg9BILRErBF2TT4LyUUUeWe/2pIZ5RJ+8bUz3/NbWjd66ppYH8KLMcg
         wybYF/uZjne3GMXh1E+X1zAYra/WCpKEUBjZOVjjzz0/kOx4veBmncDp4c0wvtTsPXg5
         Q7gXKDwUc91Ffz70gcy8siG+Z0Z8BHkr4mNeJMykTEEKau1hFbkhlp/9cmPjSSyWsQTe
         MpRwuxKr7a7JOtgdouDxBAK4YVsVaopo8toXBrxqtqBLzkmJ/gJ/volGOdGKRdngDgrw
         IAbShFBlEXNFgyUQgorAI/NfrnUVubUQo28Ed5qPYkmr/8FVyRU0slQDy9KU844a+4q/
         YX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198663; x=1722803463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=Sfqw4nySm05RgBezjZjvcpiRHaNmStcqgkqZmcy3xBUDSg1xmRBFOIOeoIF2tPzm5J
         TA6++4ODAysqh0sO0e4O1DDpWxO0DXOHsqJzSpeUYrMnQRJ2i5y70xtDMNT/ADau/KMM
         dTt8fMyWFayjF5dDGi+vU8pQLyAiri5tgCutY8OppUa30d9YPI6dVpxE6zglHSgnHsmc
         WCVtHsRulSu5Y7S/0kqi1gGGLxt0nXibC+mkRL7vLSKazlERjOq5WTteGlakxH8BVw/K
         dXMzzExyHvVDbPYpN+DEM2APQmzJqLbGVCx0N4FD6TqDKxoHn30Ik+6viTRLxShXcCa5
         WNBA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8va9oqybKVn5827kQs+fnsHHn5WSntoc0rL3yKXO9AiG5y5j0UJsKlEgUlpWJcyJXOydWEDODvhg0GrHJ7+j1mzWQrOOKOqz
X-Gm-Message-State: AOJu0Yy+frXN6RvO/XuhLREjMkcsDCFeUlUzkeA7PJbxRnQkK2rvwpHm
	mZHv80wuLlcasX7hs/yXtUu3T3ZtzHB50SKEz/jjP4IWEnoKp9qMbhSgpoe558Wu2A==
X-Google-Smtp-Source: AGHT+IGFJCBpCGKio3GvIQMtPQU0FwuQLnvFXOWRFKgHtvK/N12utXtZSpDgbRkZ6jpM9dmXhNWYM7k=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:827:b0:667:8a45:d0f9 with SMTP id
 00721157ae682-67a004a2775mr1250767b3.0.1722198663143; Sun, 28 Jul 2024
 13:31:03 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:58 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-6-xur@google.com>
Subject: [PATCH 5/6] AutoFDO: Enable machine function split optimization for AutoFDO
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable the machine function split optimization for AutoFDO in Clang.

Machine function split (MFS) is a pass in the Clang compiler that
splits a function into hot and cold parts. The linker groups all
cold blocks across functions together. This decreases hot code
fragmentation and improves iCache and iTLB utilization.

MFS requires a profile so this is enabled only for the AutoFDO builds.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 scripts/Makefile.autofdo          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 97c8399e5532..7d9dc8a3c046 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -593,9 +593,14 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__unlikely_text_start = .;				\
 		*(.text.unlikely .text.unlikely.*)			\
 		__unlikely_text_end = .;
+#define TEXT_SPLIT							\
+		__split_text_start = .;					\
+		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
+		__split_text_end = .;
 #else
 #define TEXT_HOT *(.text.hot .text.hot.*)
 #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#define TEXT_SPLIT
 #endif
 
 /*
@@ -611,6 +616,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_TEXT							\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
+		TEXT_SPLIT						\
 		TEXT_UNLIKELY						\
 		ALIGN_FUNCTION();					\
 		TEXT_HOT						\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index f765bd9e81d7..80ad06689947 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -6,6 +6,7 @@ CFLAGS_AUTOFDO_CLANG := -fdebug-info-for-profiling -mllvm -enable-fs-discriminat
 
 ifdef CLANG_AUTOFDO_PROFILE
 CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
+CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
 endif
 
 ifdef CONFIG_LTO_CLANG
@@ -14,6 +15,7 @@ ifdef CLANG_AUTOFDO_PROFILE
 KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
 endif
 KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
 endif
 endif
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


