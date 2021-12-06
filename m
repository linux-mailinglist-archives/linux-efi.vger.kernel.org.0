Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11B7469498
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbhLFLDB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 06:03:01 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46548
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242032AbhLFLDB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 06:03:01 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17E393F1EE
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788372;
        bh=Mpf1+wFXToHvdF/Ol73oVGZ3N1s6PxZDoxH3qziN9eQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dXCclNLRRCxEQOKbjzWa2rm+ng7eVoFjD6nrXqW89zYC7fQd+Ecce6HZ7m4dGyAup
         rpIXJ7+PsnHAhU928rPQaLz1jwIWIg8TjSIUVD9M5Satq3pEaYLt4C34oWQ2TnyMBv
         /UE+TmTJk67k9KwHWMw4CR9u0+Gub34G5IK7V/UAorPl7onH9CtzCV1m21fmJBdtWN
         XQMoiEql8dbgCdj7Dktx3qdQ9oNqJxxGheZxyXHLC1hTMAl0BqwPsIc58ubn5j3w6x
         nHBBTpdBjkiznYq65VEOeIB5Y3FFTF6q89XNHvwloGt2ghxIOG9U57SW+GGeuuaZNg
         6cyu737DL0nVg==
Received: by mail-wm1-f71.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso5917757wmd.8
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 02:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mpf1+wFXToHvdF/Ol73oVGZ3N1s6PxZDoxH3qziN9eQ=;
        b=BOBc9nUzPMgzTmrtiJ1JVhEfJsMvWFPUTmKvdn+X4b32DfqBLj/z7CII4ICcLqtE9/
         8ArXTsCAShg4p8mOgi9f0ii8uq2k6EBIQc2cRZ6tM5nGtn0eQ18P3Dx0Ptg6gNtT4vzT
         hVyNE5SZ3sDdot9PK9Uap2RSmiKGsPV6y7EfSdiU8WJpbe7kAzs4lzZQd+1ZVQy0UGCE
         m0fRRLDqxrhFJ1PxMAHi+Cnu1H4xs50sDyHj1EB98s7J+zhQf5tsxDtmhGNIbBpVf7yr
         Hn9hDQ1JU6M9yToxRVhvk4NBMCckFyAYJZyo1ekkAFSY4yjLsAm9suL266FWTURh3dwe
         0jiQ==
X-Gm-Message-State: AOAM533stCgwAuk5vR2VA/YhbazkvKqA5A81zQnLft1azS7Ey+Jbsvyk
        Ch6cHslIUIwQrp3i8HU3LxUL4Q8EWkglAMaQQ2mF7+0GESvQ/JVk3Y0fp8Ed2i93hWwgr9uroGv
        xmnCMLEjmffnn85DDdxB6bBWm3GYYpS4wIkeuTg==
X-Received: by 2002:adf:c146:: with SMTP id w6mr43633013wre.541.1638788371829;
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXPF8JNT/lii3k1vlfVVxG4fHHOfwgSDGLo6V1yi6JZC+9G72g0N+X1xsL2m+r1nRvWrUGCw==
X-Received: by 2002:adf:c146:: with SMTP id w6mr43632986wre.541.1638788371627;
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id l15sm10625964wme.47.2021.12.06.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:59:31 -0800 (PST)
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
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 12/13] riscv: Initialize thread pointer before calling C functions
Date:   Mon,  6 Dec 2021 11:46:56 +0100
Message-Id: <20211206104657.433304-13-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Because of the stack canary feature that reads from the current task
structure the stack canary value, the thread pointer register "tp" must
be set before calling any C function from head.S: by chance, setup_vm
and all the functions that it calls does not seem to be part of the
functions where the canary check is done, but in the following commits,
some functions will.

Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index c3c0ed559770..86f7ee3d210d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -302,6 +302,7 @@ clear_bss_done:
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
+	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.32.0

