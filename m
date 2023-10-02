Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B067B565F
	for <lists+linux-efi@lfdr.de>; Mon,  2 Oct 2023 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjJBPKl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Oct 2023 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbjJBPKk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Oct 2023 11:10:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0AAC
        for <linux-efi@vger.kernel.org>; Mon,  2 Oct 2023 08:10:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3231df054c4so12440900f8f.0
        for <linux-efi@vger.kernel.org>; Mon, 02 Oct 2023 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696259436; x=1696864236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BviuOqu94hunsSO/3Ul5WhMTTjDvZpGvaCCYOAqyBa0=;
        b=bU8XSnAyHcGPOJvJzjWf35Sj21egS4oTZnBl/V+y4kfUOo6aTkGD/4q7Fnn4jnGp/2
         c7U/1vdLd7odd/NILraXy6xfFl+mojvHCjARfLqr6vmLSY1o1ZnBGYoYKwsUm257tWaR
         4PqPngiRYDboNRY9oTTdSef6pO60zGyyEonP+5993kfYlXcuGeIXIpv05RSSR9YKMVYI
         irVhDRDoQgfoFfG4cmS1XeS8g0abGtQ/sBAwqqv/ao7un7UiFzrEjjV6Hp+10EJEn6W1
         5CZ9j3iyvUCPHGRXAQUn9MGht0b8l4UwIFP8n8WxO0XBnJuq7PAUmrP9QA4yOismJX0K
         jq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259436; x=1696864236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BviuOqu94hunsSO/3Ul5WhMTTjDvZpGvaCCYOAqyBa0=;
        b=hByHwvpggfXSyovPkCEToG8XYhTwYc8aqjhoWnMItV92V0yz7sjyYxJvhwsrpj5DJM
         M90FIduf+vn/+2qMuv/Y23wfUBFTcTqGlTpYC3c4PReT9VyxqSazgXptlKB4KUbwyKgv
         YdztalLXs9SgGuWgadhLgQsj+48lkwIHWm2fW2Gz5q+W9fVshWpaYVIT59K1zcB3GRye
         n4Klau3/Ggccc3zNYLzKkI28uxCT9h+HPsDxFkZsVPaRCL3d5e+Mp3QbM72KhMRWVuoP
         GSDhIxNkJSNQgAcfp8APRUdn5ahfEFegirKTXhkKbvMgG83Wf2IpBSwJVpQOsNqpMkaq
         n/pg==
X-Gm-Message-State: AOJu0Yx+ZXXiaS5P09DYLuAQdQHMOPscOXtVrfsGcG0FmWnaOWrI+0EV
        GdGqq83aNT0uYv5DJoDxy6u1uQ==
X-Google-Smtp-Source: AGHT+IFAtgaoRF40XzBvtOGWfYM9G4XzLkYMHt7t11y/gj67JLtREpQrgnLizsD6s7v4+vCjcvL7tw==
X-Received: by 2002:adf:ea8f:0:b0:320:1c6:628c with SMTP id s15-20020adfea8f000000b0032001c6628cmr11378844wrm.65.1696259436015;
        Mon, 02 Oct 2023 08:10:36 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0031fba0a746bsm8493981wru.9.2023.10.02.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:10:35 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/5] riscv: Use READ_ONCE()/WRITE_ONCE() for pte accesses
Date:   Mon,  2 Oct 2023 17:10:26 +0200
Message-Id: <20231002151031.110551-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is a follow-up for riscv of a recent series from Ryan [1] which
converts all direct dereferences of pte_t into a ptet_get() access.

The goal here for riscv is to use READ_ONCE()/WRITE_ONCE() for all page
table entries accesses to avoid any compiler transformation when the
hardware can concurrently modify the page tables entries (A/D bits for
example).

I went a bit further and added pud/p4d/pgd_get() helpers as such concurrent
modifications can happen too at those levels.

[1] https://lore.kernel.org/all/20230612151545.3317766-1-ryan.roberts@arm.com/

Alexandre Ghiti (5):
  riscv: Use WRITE_ONCE() when setting page table entries
  mm: Introduce pudp/p4dp/pgdp_get() functions
  riscv: mm: Only compile pgtable.c if MMU
  riscv: Suffix all page table entry pointers with 'p'
  riscv: Use accessors to page table entries instead of direct
    dereference

 arch/riscv/include/asm/kfence.h     |   6 +-
 arch/riscv/include/asm/kvm_host.h   |   2 +-
 arch/riscv/include/asm/pgalloc.h    |  86 ++++++++++----------
 arch/riscv/include/asm/pgtable-64.h |  26 +++---
 arch/riscv/include/asm/pgtable.h    |  33 ++------
 arch/riscv/kernel/efi.c             |   2 +-
 arch/riscv/kvm/mmu.c                |  44 +++++-----
 arch/riscv/mm/Makefile              |   3 +-
 arch/riscv/mm/fault.c               |  38 ++++-----
 arch/riscv/mm/hugetlbpage.c         |  80 +++++++++----------
 arch/riscv/mm/init.c                |  30 +++----
 arch/riscv/mm/kasan_init.c          | 119 ++++++++++++++--------------
 arch/riscv/mm/pageattr.c            |  74 +++++++++--------
 arch/riscv/mm/pgtable.c             |  71 +++++++++++------
 include/linux/pgtable.h             |  21 +++++
 15 files changed, 334 insertions(+), 301 deletions(-)

-- 
2.39.2

