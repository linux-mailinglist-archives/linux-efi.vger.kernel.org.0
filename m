Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083E60148F
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJQRRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJQRRs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FFF71BE6
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FEB611EB
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E45C43154;
        Mon, 17 Oct 2022 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027064;
        bh=5cJEI/Wrlezymi/GKhKa7QYAgVawT7QR4kGy4v3xoDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnzRXxfWYh0/uhLfuscSqvjtV1oTa0Lwan3hSRU5WngbN1yl8WKPYfHgov4bq0sm6
         FjvxSsfQZgA/Cd5juBQSsdT19L729B7XMJnfRoniowsxlp9A9TuRXEb+WzBoISftbT
         0fUz2iBwdTwKYhb16CmIIfFFb5uKjtNhlw/Z4v14rB0hLX8aKOfixlt9d1kp/e0b7q
         u8UCcviw7r0M3pnx4Dd7hyPKBp3thR/KHKRRJJPghawGTXJeitZWfK9t8IsjQYEkaz
         GvAs9swOU5r56h32rFDCs25CdSOL125eoEe5+vQ0IEnpqX+nk9TQlMDTBax4FhnSY/
         KQS+Qg20O896A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 08/21] efi: libstub: Use local strncmp() implementation unconditionally
Date:   Mon, 17 Oct 2022 19:16:47 +0200
Message-Id: <20221017171700.3736890-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=ardb@kernel.org; h=from:subject; bh=5cJEI/Wrlezymi/GKhKa7QYAgVawT7QR4kGy4v3xoDI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY31gK8pGF3micRhJ3J4ZZ3c/DEVuyGlRj/Xjq/A XsAkux2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N9QAKCRDDTyI5ktmPJMFCC/ 9zY0cpFLNWd81AkniWVT8kk88xGzMR0Vd25Oz60SeCN3S/hP0Mh0A0cCb2MIr4C9pioalXGNFK2r8X +OJfVcqvL1JkrJ9Ee58/77Q+rMymO/iwXrhvIvhqHrqFarnvRd0c3WiMpWSdZiT5eQZHrR1QoKBCDT IUDSs+AMaK2WalZXq11DKU3Xzt5RIR3PVkmFCaW78p7Ak4EyZ8TVcxXAICPCIb/l+/a2E7r11K6GMC VkKDTvpHQZsQtt5JFZFMxlN7+YgE3weaIcbm6bYwakNHjl7elJOUxG+3qjVS+VIDPzpRQveGPwGMcp CEB8Q6SzW8BC1aPWnHLF2yhZQOFCPWR9C7yAqIih6uHB43Kg8m0g0d7SPgN0JWC0hjIK3EyO0HCVmB BV/x/RC8d9lUyaNmA2kxhsaLJbHpqN7r8VT7mcbqf34gA35ybciBo0hJ93einvMjQ5Z53dTqSgnNJ1 KThme//5yMTBZfO465MJpfpj4v9WmxgqH1/rT1XxS5VEQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for moving the EFI stub functionality into the zboot
decompressor, switch to the stub's implementation of strncmp()
unconditionally.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h        | 1 -
 arch/riscv/kernel/image-vars.h        | 1 -
 drivers/firmware/efi/libstub/string.c | 2 --
 3 files changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 74d20835cf91..5a12ca2d7158 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -26,7 +26,6 @@ PROVIDE(__efistub_memchr		= __pi_memchr);
 PROVIDE(__efistub_strlen		= __pi_strlen);
 PROVIDE(__efistub_strnlen		= __pi_strnlen);
 PROVIDE(__efistub_strcmp		= __pi_strcmp);
-PROVIDE(__efistub_strncmp		= __pi_strncmp);
 PROVIDE(__efistub_strrchr		= __pi_strrchr);
 PROVIDE(__efistub_dcache_clean_poc	= __pi_dcache_clean_poc);
 
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index d6e5f739905e..b46322cb5864 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -28,7 +28,6 @@ __efistub_memchr		= memchr;
 __efistub_strlen		= strlen;
 __efistub_strnlen		= strnlen;
 __efistub_strcmp		= strcmp;
-__efistub_strncmp		= strncmp;
 __efistub_strrchr		= strrchr;
 
 __efistub__start		= _start;
diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index 5d13e43869ee..9f5810d86646 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -35,7 +35,6 @@ char *strstr(const char *s1, const char *s2)
 }
 #endif
 
-#ifndef __HAVE_ARCH_STRNCMP
 /**
  * strncmp - Compare two length-limited strings
  * @cs: One string
@@ -57,7 +56,6 @@ int strncmp(const char *cs, const char *ct, size_t count)
 	}
 	return 0;
 }
-#endif
 
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
-- 
2.35.1

