Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300F6778E7
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjAWKQD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 05:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAWKQC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 05:16:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85C59D2
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:16:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so10261779wrv.7
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=rf0Qwpy9jDLACwBRHW/pTe733yWNS+5GkCJ3lpbac4R9t/4KBOcFFjNESynWlogYEv
         9s0FYx5LWv8VL7FOSfYeSx3l22EX3kJWzeMTlokBJXt6akEzTeA2NvaOsvqSim3qmxjP
         54HUEk8Du1+/WKUV2WaMInIbK4kof75WjqBAMFrHOcNQsY7EksIiR8/oe/DoVgr8dzG1
         Vz9soIjhqWGyCoC7S9+0D+RzHQm5Y691IbRZeCPWjDoVYOKo7vrAvSfqEJyk7wAv0HQ9
         cSjRuwf2YIXbfUMaNt5jpvFm7aNORGx1/Fc0MWxNMsou5kxweWshuY9cfu0GqESCgsHB
         EGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=871OGCI0aHwZZE6OKggKudWipUlPKXToB5Kn7OlT7Ew=;
        b=lDG4VBgHho3tL4iyyhAr/DkzypG3uzauu/aNfNwrwmg2zls5UggSOpPi6p9SuAna2o
         gOd9eiMzajI4/FXQYeUJMVmZ40ebUfK3kK0VMWY9hU2Nl18/kCc++thC4Xv87rYB78V+
         UIQ0FyQHpP5nPu2LjQZ6mqDW/2PIoEw42Ml06jHzwKwG8I7CvcUVIPwtWGcSFaCfLLfV
         4Q+jxf44YIovikdRTXgB2C+Hm2uIRwoNCwq91vkVAL0tCix18OTpLrvFbdz0jMGKcMFN
         XG9FJIC01vpIl7bx6FFwy5LB3wvz6TXz/XRB3bMU5B+ZQUhYwhMznC4w1Gi31fD7ch1R
         BtRA==
X-Gm-Message-State: AFqh2kpRu/yxqPvECsOknnPa9gnTOwejnUnFCjkPF2+TBtejbESyaKtc
        YFL9dLMesNWoYVS2/QrVQX7qTA==
X-Google-Smtp-Source: AMrXdXt+aB9WiXogOYH5qYIrSd/PSwMpNfUk6C0swXWoMoe+Z0T2xAC7vLxeSBPcQHinVaV3Qwdfxg==
X-Received: by 2002:a5d:4f90:0:b0:2bd:d542:e01e with SMTP id d16-20020a5d4f90000000b002bdd542e01emr21625059wru.10.1674468959652;
        Mon, 23 Jan 2023 02:15:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000100a00b00297dcfdc90fsm4296040wrx.24.2023.01.23.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:15:59 -0800 (PST)
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
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
Date:   Mon, 23 Jan 2023 11:09:51 +0100
Message-Id: <20230123100951.810807-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230123100951.810807-1-alexghiti@rivosinc.com>
References: <20230123100951.810807-1-alexghiti@rivosinc.com>
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

