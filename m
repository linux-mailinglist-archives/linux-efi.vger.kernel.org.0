Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E063EFB9
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 12:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLALmg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLALmf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 06:42:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28469951B
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 03:42:23 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0hxH-0001D3-Pq; Thu, 01 Dec 2022 12:42:15 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        Conor Dooley <conor@kernel.org>
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, emil.renner.berthing@canonical.com,
        ardb@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 0/14] Zbb string optimizations and call support in alternatives
Date:   Thu, 01 Dec 2022 12:42:15 +0100
Message-ID: <3828190.OBFZWjSADL@diego>
In-Reply-To: <81679d42-7800-3f77-eac8-d7d942e3065f@kernel.org>
References: <20221130225614.1594256-1-heiko@sntech.de> <81679d42-7800-3f77-eac8-d7d942e3065f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Donnerstag, 1. Dezember 2022, 01:02:08 CET schrieb Conor Dooley:
> On 30/11/2022 22:56, Heiko Stuebner wrote:

> > changes since v2:
> > - add patch fixing the c.jalr funct4 value
> > - reword some commit messages
> > - fix position of auipc addition patch (earlier)
> > - fix compile errors from patch-reordering gone wrong
> >   (worked at the end of v2, but compiling individual patches
> >    caused issues) - patches are now tested individually
> > - limit Zbb variants for GNU as for now
> >   (LLVM support for .option arch is still under review)
> 
> Still no good on that front chief:
> ld.lld: error: undefined symbol: __strlen_generic
> >>> referenced by ctype.c
> >>>               arch/riscv/purgatory/purgatory.ro:(strlcpy)
> >>> referenced by ctype.c
> >>>               arch/riscv/purgatory/purgatory.ro:(strlcat)
> >>> referenced by ctype.c
> >>>               arch/riscv/purgatory/purgatory.ro:(strlcat)
> >>> referenced 3 more times
> make[5]: *** [/stuff/linux/arch/riscv/purgatory/Makefile:85: arch/riscv/purgatory/purgatory.chk] Error 1
> make[5]: Target 'arch/riscv/purgatory/' not remade because of errors.
> make[4]: *** [/stuff/linux/scripts/Makefile.build:500: arch/riscv/purgatory] Error 2

Oh interesting, there is another efistub-like thingy hidden in the tree.
(and CRYPTO_SHA256 needs to be built-in, not a module) to allow the
kexec-purgatory to be build.

The following should do the trick:

---------------- 8< --------------
diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 806c402c874e..b99698983045 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -27,7 +27,7 @@ extern asmlinkage int __strcmp_zbb(const char *cs, const char *ct);
 
 static inline int strcmp(const char *cs, const char *ct)
 {
-#ifdef RISCV_EFISTUB
+#if defined(RISCV_EFISTUB) || defined(RISCV_PURGATORY)
 	return __strcmp_generic(cs, ct);
 #else
 	register const char *a0 asm("a0") = cs;
@@ -55,7 +55,7 @@ extern asmlinkage int __strncmp_zbb(const char *cs,
 
 static inline int strncmp(const char *cs, const char *ct, size_t count)
 {
-#ifdef RISCV_EFISTUB
+#if defined(RISCV_EFISTUB) || defined(RISCV_PURGATORY)
 	return __strncmp_generic(cs, ct, count);
 #else
 	register const char *a0 asm("a0") = cs;
@@ -82,7 +82,7 @@ extern asmlinkage __kernel_size_t __strlen_zbb(const char *);
 
 static inline __kernel_size_t strlen(const char *s)
 {
-#ifdef RISCV_EFISTUB
+#if defined(RISCV_EFISTUB) || defined(RISCV_PURGATORY)
 	return __strlen_generic(s);
 #else
 	register const char *a0 asm("a0") = s;
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dd58e1d99397..1d0969722875 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -2,6 +2,7 @@
 OBJECT_FILES_NON_STANDARD := y
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+purgatory-y += strcmp.o strlen.o strncmp.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
@@ -18,6 +19,15 @@ $(obj)/memcpy.o: $(srctree)/arch/riscv/lib/memcpy.S FORCE
 $(obj)/memset.o: $(srctree)/arch/riscv/lib/memset.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+$(obj)/strcmp.o: $(srctree)/arch/riscv/lib/strcmp.S FORCE
+	$(call if_changed_rule,as_o_S)
+
+$(obj)/strlen.o: $(srctree)/arch/riscv/lib/strlen.S FORCE
+	$(call if_changed_rule,as_o_S)
+
+$(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
@@ -46,6 +56,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=medany -ffreestanding -fno-zero-initialized-in-bss
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector -g0
+PURGATORY_CFLAGS += -DRISCV_PURGATORY
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
@@ -77,6 +88,9 @@ CFLAGS_ctype.o			+= $(PURGATORY_CFLAGS)
 AFLAGS_REMOVE_entry.o		+= -Wa,-gdwarf-2
 AFLAGS_REMOVE_memcpy.o		+= -Wa,-gdwarf-2
 AFLAGS_REMOVE_memset.o		+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_strcmp.o		+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_strlen.o		+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_strncmp.o		+= -Wa,-gdwarf-2
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)



