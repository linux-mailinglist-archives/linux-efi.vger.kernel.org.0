Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4A67ABA7
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAYI1w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjAYI1u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 03:27:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296E7AA9
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:27:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b7so16235532wrt.3
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xmv+QSgbqVHZO5FLG2f26KzmGjk1zWdaRkSSaCJJ9A=;
        b=cbBspW8qJ+TGXotE39Oa2GtMgqgvEaxRYhO5hoiVi0ud4rsKGjyyMhGeWSEbTliuQu
         PeUr4O1lu088PVCipbmpjO0xJw9wvuZk+/4okqKqdh86qOXFy7I5tUzhr/fPkah8VI3a
         9N8G72tSz7j4xyTYwDhoG+P/goUThd3U9eirP7gIklgIcTl0A/rU6mHILG/9h52wlabF
         1Ao2ehXEQ8ebqT3m6/yspOli05h+eIaKYOnjR9zEF/UBqi25rdpavoWW3Hzs5BPZcD3x
         NAQpK+CWPziWqOfXXs5R8Uj+rOL3fy3Pte2cQP3RFwlo2s4mYjCSeqjPQTRuWy0k8e1q
         WlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xmv+QSgbqVHZO5FLG2f26KzmGjk1zWdaRkSSaCJJ9A=;
        b=FhD4RxZczDxntZoFP/KaqlEUfWjN93uG+FdysUuR0IxyqsvYUAzj0c7p3zxN19BQDN
         Xzcj4e2luVFLkn52RK+MKabOfFjDBnsQVJGiervs9ANJ1Rnbz8ujOW477wb+I+tEiU5P
         97BTlo+db90OdEwbCoFEtMb3+8wZeVjF6//aCjfjXPcZIvEab2y4q8VBe34ca7GO15Po
         hRyDf/v9zZlGXA2F/4hRwy5En62g1oTBgueld0aokRznkNbYN1rfjpLcs40Oktoo7deR
         P5KAiX/BLtMtfTu77y86WItL9Q0vU0zRXHFUMaOZd1vvGlSwUtSqosluocsiNkTAYM3g
         wGNA==
X-Gm-Message-State: AFqh2kq5KEh7iV2jmy35LkNyBjmXk5Ml1O7hez5OLmJSYvrweYzol3yM
        iTnwAmDQ4jEJ93WnOki2/IZgTg==
X-Google-Smtp-Source: AMrXdXu8PoPu+NFgqgrtB5cmrqLEb9a4CDisajsgtj/VZ1j268QbuemGFUZLIa8Y7cOSokqHZPwRQA==
X-Received: by 2002:a05:6000:1c0e:b0:26f:6bf:348f with SMTP id ba14-20020a0560001c0e00b0026f06bf348fmr24106837wrb.6.1674635266981;
        Wed, 25 Jan 2023 00:27:46 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id g9-20020adfa489000000b002b065272da2sm3863367wrb.13.2023.01.25.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:27:46 -0800 (PST)
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
Subject: [PATCH v3 4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
Date:   Wed, 25 Jan 2023 09:23:31 +0100
Message-Id: <20230125082333.1577572-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125082333.1577572-1-alexghiti@rivosinc.com>
References: <20230125082333.1577572-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub must not use any KASAN instrumented code as the kernel
proper did not initialize the thread pointer and the mapping for the
KASAN shadow region.

Avoid using the generic strcmp function, instead use the one in
drivers/firmware/efi/libstub/string.c.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/kernel/image-vars.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 7e2962ef73f9..15616155008c 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -23,8 +23,6 @@
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_strcmp		= strcmp;
-
 __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
-- 
2.37.2

