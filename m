Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32E46947E
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhLFK75 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 05:59:57 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48306
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238862AbhLFK75 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 05:59:57 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 12A7A3F1B8
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788188;
        bh=CS+lflLGdqIBScWk3+o9lUxh8jVqR8Nq2WKSyjwTWok=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=kRQvGMmQbwuxrGCad0acS+UGXUGGVmvUr4mRKUgt8rHEOMcve4eyFknePpdsT746v
         SS6OxmxtIpZbVX1X21I7NjyK1DTWV1nS8pjNcJ1mr6CZ2fSal4r8cU5TviNX0+jv/7
         oPMP5l8JvSIDIJ0DYdCDZ596F/QyxwbF45GuIY+yC+xfYZH3bEHeZbK5c9VKnOEAwM
         g32jxTT33g+qtNGvlyF0DUQuVEROczp0r6vlU5bckHFnFDtnWjuJfWeJ9EzGNhHoF2
         uhyyAUwmN9H/9Mnv2geFNQCCSbAgQgSmx9CP2GRW1ONHIYvIEoVTBLWfNUGQEjf1X7
         pK8R7KgDaDOBg==
Received: by mail-wr1-f71.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso1889987wrq.16
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 02:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CS+lflLGdqIBScWk3+o9lUxh8jVqR8Nq2WKSyjwTWok=;
        b=MTokc6bs3QsdpvLzKXu2c1BiZHBry2AdVhqDYuIvkFNrxow/L7TAS9U7tm1HytbwdV
         fqZuZR1U2Z4qY2hiO7zY69YWDH7PmqoLbHRMQKcl1GcipGTd4GiNRxaADqVPgWE9/9dr
         zqYw4QCsSCEs50vRO08wAjJmfP7h6fbMyRCEmMYXoQRvqeYM6sTgyJpgccs6hkLUiYOc
         SNXf6TaJTEGfUgo1jf7fFJlQt8h11nxwJsvqUcFkxKaQPR55EQT8wWy42RVxxQwh3l4d
         GV2cOZQ36Y2oJHtIs7ZePKvuJHahihoz51+dXaQP6zCb0OiBWQTuZ1tIF1o7qzZ795GF
         siCQ==
X-Gm-Message-State: AOAM533JN2OcrpNtcp0QXSRMF/VWPRo/6TYyHeGHI3aTEdCpdY471nFV
        UNSFVcDR6FrJ15A34HEPbzHaFSQJPSxyN8wcx+FeKxjiJz8146gE1OXJmF9lIQlDxqI5+6t5xPI
        dDHvC5dqsqEezgNTjaYBIZen8FesKskxtOXEWYQ==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr41714884wrw.118.1638788187805;
        Mon, 06 Dec 2021 02:56:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVLYW0mXNza0Vbe+pg2BAchzw+eMDx5NF0VjULPJd5GzhsW1C+AKsPuIExWWzzUawkBQmTeg==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr41714859wrw.118.1638788187621;
        Mon, 06 Dec 2021 02:56:27 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id v6sm13522985wmh.8.2021.12.06.02.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:56:27 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 09/13] riscv: Explicit comment about user virtual address space size
Date:   Mon,  6 Dec 2021 11:46:53 +0100
Message-Id: <20211206104657.433304-10-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define precisely the size of the user accessible virtual space size
for sv32/39/48 mmu types and explain why the whole virtual address
space is split into 2 equal chunks between kernel and user space.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e1c74ef4ead2..fe1701329237 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -677,6 +677,15 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 /*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
+ * Task size is:
+ * -     0x9fc00000 (~2.5GB) for RV32.
+ * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
+ * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ *
+ * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
+ * Instruction Set Manual Volume II: Privileged Architecture" states that
+ * "load and store effective addresses, which are 64bits, must have bits
+ * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE      (PGDIR_SIZE * PTRS_PER_PGD / 2)
-- 
2.32.0

