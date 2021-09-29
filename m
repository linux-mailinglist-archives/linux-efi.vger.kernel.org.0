Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BF41C7B5
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbhI2PCm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Sep 2021 11:02:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54886
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344934AbhI2PCm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Sep 2021 11:02:42 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B55840255
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927659;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=oiaYqb0MJQFX/9jFdpLYM2ENqCwV2wF/p7Oi3joCfDFiy0gj9drpdxbWV2wmCoN1A
         ve46xwFMmj2GfIxB0Z84r9KAsUpv3lelHZ18bmqSomqDfMzpK15/rOfod54Ok8TIco
         yDCMhWWVy0myOUm/lSne0OKI+6f1KyZER8ZQBbjoCowfiqfiN2vzpxcYcJ98VL8kO0
         tAPFWM7o10sIs09QXwkpTQa6BRDYoqt3KiqmyiWSIEPai49GL1xvaPnrtMAZGcxxFL
         A9QxxwRPEj7a5ebykfrFikeqzASsdzmSOSYhSW4lClZcTFlv6C9vFQS94/nEf5C+4v
         DKOKg+/nIk1Tg==
Received: by mail-ed1-f71.google.com with SMTP id a7-20020a509e87000000b003da71d1b065so2736057edf.4
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 08:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        b=7WzknQV3GQZPqVBVFOCxp8Cqr+eucYiBNGcBUpBdBKGB6LwCx6us3OiSDw4ZrYJIvO
         VIAD+Sj7+U/3xb+/32TKujihgBNJGp0N5DzCn63uHQshFzD9xaT7WCcfSXgmKagDKgbc
         EZKgd7td8j4S6cm1Xa1pl2udpUBfEjiuJkQ9m79ZN7P0+ZjMFRwOlNr2lhZ0NsM5DvQr
         c6wuYuz/1r3Q2aROeh2os24Rbm5qxWD8V7LrwUMATLGca4L05nBNrk1aePOF6zpti6gR
         W3U099LlUbJJNpAYrH/zqRMaO15Ua1xLypNKA4tFYEJZtqh9Nt4EIzITxYCHrmOJNOk0
         W9Qw==
X-Gm-Message-State: AOAM531Gpk9t+gCszfp8uSsZ+bQS7yxy0elyU0GD07UXpp3z6t1hxBT8
        X00/k1WAZL6N9pv6DU32tNR67U85Bkt8tt7eSfQMNyQPq9qtAS6mCGUxzDcSI/ogdk0jc0HSg31
        3vuN0sKvMdLOxZRP8jR/+cfPo3HX6GvTi8Lnm+w==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327576wrk.125.1632927646748;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfXtNjTqRwTy6zB0yjO+6WDv1SXfe8fP/ut2QpPS8jTHw1twOX+D4X0+hshAyxExD632O4tw==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327526wrk.125.1632927646559;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id e8sm142306wrr.42.2021.09.29.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
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
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 09/10] riscv: Initialize thread pointer before calling C functions
Date:   Wed, 29 Sep 2021 16:51:12 +0200
Message-Id: <20210929145113.1935778-10-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
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
index 8f21ef339c68..892a25c6079d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -301,6 +301,7 @@ clear_bss_done:
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
+	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.30.2

