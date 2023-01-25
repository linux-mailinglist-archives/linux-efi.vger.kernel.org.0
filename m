Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1967ABB6
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 09:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjAYI3y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 03:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjAYI3w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 03:29:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851047DAC
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:29:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso672349wmn.5
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=C0wvOpQb3U0DVvjPMPgyyNT1+YP+zfNBdXYl4gQ9ZKvrIdgqPBYNBaTBSPmh43qicA
         a1LJSTPWiSwzYXEeLtvo+26GCcml0gCxNjiATpq1q00LMLOCIA62ag4FyNQ9T8VTlEme
         8oXHMAL04imiMoZZueW0GkozNOJ+G+5vIvGykPewjxnfaNXbHT5k5+4aIsETOCwDq4bD
         HwbdpXSUZsZAJTyxGPSFqn4LqWQTwxxyiRFmS4IJp5LQSi1e9zzn66VmmxEjbhyvm3yy
         yXeZCUtdp/IdHS6PN6pE9DGSoyqFGqXpCM4fiC9vTHliLM0PrTlGcJdBI5YhVXALWy+f
         y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=IsalY69CuLPm+LxNW+rc73DxGac1hjl5+rDO2PXTqSslE9Kuf8+AOEL4+GTye9fuAq
         mqSHiCJVeZ8EbIAiMYTnLGkVQtGppBGIGOl+8GNn52or3UwDAKi90ILOuUGaFzGrb+GF
         YTcBQBz3vjmDVadutjJUeiXuKiFknT0cFWwxFc1meqNWDTgYnl38BnKR90XjolajwimF
         RBEcejy+eyZWY+wR5WUw+n16SWZJOvfIrhfg2dUurbZEIC8uquzm4S1uxoW9hi35MjV2
         53a/A1Fxx0Xqo31Bo9WzVyqnVXqW28wIYkkeqR0r+vYoTsrfHFD3v5J5PfmVCvTWkkbe
         tPYA==
X-Gm-Message-State: AFqh2kpcoTg6KswME3nDvee1bpSkIrMlMAPU/5lQ18+J8oAwjrBCYBSG
        FzZrPAbVTlPA9baPnGSTNk+F3Q==
X-Google-Smtp-Source: AMrXdXsuDmppa2cK6f9yHqBRO/sT58CjC7qn+D8bUDIkmfppKXnmAQCYCVk1D2pFp4XoIe6uX5V6oA==
X-Received: by 2002:a05:600c:3b9b:b0:3d2:392e:905f with SMTP id n27-20020a05600c3b9b00b003d2392e905fmr30562318wms.24.1674635389029;
        Wed, 25 Jan 2023 00:29:49 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id d24-20020a05600c4c1800b003db0cab0844sm1070737wmp.40.2023.01.25.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:29:48 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Wed, 25 Jan 2023 09:23:33 +0100
Message-Id: <20230125082333.1577572-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125082333.1577572-1-alexghiti@rivosinc.com>
References: <20230125082333.1577572-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..0f226d3261ca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -117,6 +117,7 @@ config RISCV
 	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select KASAN_VMALLOC if KASAN
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-- 
2.37.2

