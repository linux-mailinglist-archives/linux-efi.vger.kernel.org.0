Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3B68915B
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBCH5c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjBCH46 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:56:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B3945F6
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:56:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r27so48813wrr.1
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xmv+QSgbqVHZO5FLG2f26KzmGjk1zWdaRkSSaCJJ9A=;
        b=XuczLvagK7WsmiMD0NIH4cDz5zkpFSMaym/36WPwX6Y205bCcVSOQ92VH3FAKncIMI
         GbXhfd9wrEiD+c1UoE4uqBW8mp498tNU19ZMIQCkKUHPpdLUUD7bk4/PsnvaebVbyQeM
         stPD6wgdggxOckDKgZTizPhbUrJt7rPQjY6fKDeeP5eObV93YXpzZu0w7AdXZjK2mdAH
         sKDG8P1JeJyUm7nbbx35mn4OGRYRWHBN+DtJCFObe2AQL7GHvytWacR6JAFyY3yJxG1X
         Pz9j2ebIXJ6CZ9C6sfjRmQU9Lr2ZsTcw0whG/YLYnhEQz854eMuFWFqVWxQMu89W5kED
         Lvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xmv+QSgbqVHZO5FLG2f26KzmGjk1zWdaRkSSaCJJ9A=;
        b=Ap8dOhAlMdLk7FhyTp34nzBjre9aHztYh5IXKYCRDlArhZ8Y1pijoBKrPtrHGUr26S
         ih0TM8H/4hcft0FqXb8hSpOMjtm13AjvDNnajvn7tXSBSnZ8Wm+ioWfgdgSxm1OPqrxB
         J7gSyFy6jp/QIs7iNeQHyrh5NK4u1qLh5m+oDWSJ6Baidvg0lGeBkdojfbHRrt4utwza
         kdXZX7lRbXcX3gV4LtaBjNDP6bbfEboEFo4z+O1PUlFKXKksguqqBVdWSsTQxj7BymhZ
         /YWwtNgOS3nWM1ejb0NouFXp9VBAAyHAlh5JVK8PL7uQlwRmDH+P2/OZwqk436ITVeae
         45rA==
X-Gm-Message-State: AO0yUKXsSQrHLlu/PYoXbusDCgoD2Y/1S+QxpIfr5K0/fABV4HdTffR4
        xfbTOsSIOdym3EwI7yPcazcOAA==
X-Google-Smtp-Source: AK7set+5ZcYdlWkhKGsm8zg96baZB6eeAMJhwNaXjKnWKBcJQ1mmrPVa3PkvzJHu/WLFkCS58redgQ==
X-Received: by 2002:a5d:684d:0:b0:2bf:81eb:dc26 with SMTP id o13-20020a5d684d000000b002bf81ebdc26mr8135682wrw.37.1675410999759;
        Thu, 02 Feb 2023 23:56:39 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b002c3d29d83d2sm878564wrd.63.2023.02.02.23.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:56:39 -0800 (PST)
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
Subject: [PATCH v4 4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
Date:   Fri,  3 Feb 2023 08:52:30 +0100
Message-Id: <20230203075232.274282-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
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

