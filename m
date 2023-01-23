Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D496778D2
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAWKOU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 05:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAWKOT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 05:14:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DFFF1F
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:13:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so10190750wml.3
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzQuCSnEBk5gMM/0cxqbCinBRYL7OsazNWf1U0bm1VQ=;
        b=mObKqyJ3XaOMUCe38UnhDsG/WnSMBgcpNpgXAMV7UfbTJcrB1K3mWIIOkGfSsVtu2r
         JiM3rK/33BZaNHMFyZgOUYTUg2sEGJEMiP9YufPRxhEReJGZlu/xjxif2ZtiCxnDLRau
         1wl7blHF19tVm+3MoQba2v7hFJYZegyUnpDT0QVYpgoYG0pt/5LCN9z0QrRpxR660M+A
         DIpgXRAHwuHAbh9HZDSUFPkWpJYJd3np3uWycLeXN/O7Kh7SFsHBeIEPQZMvXXh06ai/
         3o5rSA5V1+lpycTPZ/+oFS7ubecg07stoXvCKEpgJcgLyZ9kXQSrpq1IahSAzpjFmUNh
         FLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzQuCSnEBk5gMM/0cxqbCinBRYL7OsazNWf1U0bm1VQ=;
        b=YaRxFe+/Msd8xjm+q8Xi3tDj2bqiGvDQcn3niHXITe4pFZQ41HSRlZ7bNXSXJOXm6f
         np/cJQJlIRJ+MnpeMLQIKpwK3AzVtpkHSPvXBNzjnPTIehmYHuHp7ggoFHyUCzovwhXA
         CB/4mzZ/Z/OaPPJXg3Mx/9eX+xFTxfrBuftHbitnxUSbXcSMzccmt1HreSYdW+pxxbG5
         3CFis7Qa3jF5886QbI1OYTFuoGi/9k/0XrxScPdt5T0I8+2a8fS9PmcpbSpC5D6CpNhE
         NT33k7sif2YrFMNQplY7U5ngJA37NqojWe80rvBPISrm3hKz8zoF/hYN6a+nQwXpPCTM
         TqUw==
X-Gm-Message-State: AFqh2kq/GyBWEddqOWEGjz0HyD20E2GelJ6hmVYVM4eH3JucoajP/20W
        0Ge1Ztj9eeECAn2UIQuxP6hBvg==
X-Google-Smtp-Source: AMrXdXtTmEiKZTnB5U/TX0g91Npj+BJfrEC7JbcTiWp8/aNr0ZBIqEWCtbTa9wq/1djDZez7HYitng==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id bi24-20020a05600c3d9800b003d6ecc46279mr19967175wmb.27.1674468837652;
        Mon, 23 Jan 2023 02:13:57 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b003db1d9553e7sm11373283wmb.32.2023.01.23.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:13:57 -0800 (PST)
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
Cc:     Alexandre Ghiti <alexghiti@alexghiti.eu.rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
Date:   Mon, 23 Jan 2023 11:09:49 +0100
Message-Id: <20230123100951.810807-5-alexghiti@rivosinc.com>
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

From: Alexandre Ghiti <alexghiti@alexghiti.eu.rivosinc.com>

The EFI stub must not use any KASAN instrumented code as the kernel
proper did not initialize the thread pointer and the mapping for the
KASAN shadow region.

Avoid using the generic strcmp function, instead use the one in
drivers/firmware/efi/libstub/string.c.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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

