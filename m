Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A783689142
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBCHwj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCHwi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:52:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEC92EE1
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:52:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k16so3203537wms.2
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlhJRyLGWhYCTglJAyNtdlMktkkn7B+K+8DalaA2gVM=;
        b=qQ4IzbW+3YUP1LGsXZqe+TW2yoNdt5CgIM9iCfoPeTDgRcMgdCF93Uik1VA+RXDJ6w
         /jbovzM4aJ6zefnsmmc88ugJf7g0TqnY8PFjV1D9ZMT9NBBQZwHCHJdn7r9+cbiLzmti
         RJQFrxE2IfePta/OjJhTxnpSxtTui+FBNymB1THoXsoy+lDE6UJ/ey1mOQt3Qvu0B/Uw
         AlsMy8Ua932t0qE+8JUTdRuYjP3YYPr4rNlE4U+KJzZkzxnJvzedEiWKGEK9vRGiXXsU
         84/XnF4I6ebriVsJtPGVUt3r3y0fHhqmgE4BiUj13dmhDv5+mEvv3RCtikwPAUhRrNg9
         WChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlhJRyLGWhYCTglJAyNtdlMktkkn7B+K+8DalaA2gVM=;
        b=BrcjLg9q9mLZPmpAt+YzI8kOixZs+hzrOQirTo1Nw6/hAYa/lXtJySPkj6UkrPwLQN
         qB1SYt9h6vwz3U/nPpnfnPf+ZCytTO2sQ0TqvrCiEPA/jBxh9fu+XwRbkGJaE6NnYpvk
         8ZWU8DjkYrg1I5HiRSTQ+vse7QUHJW6SKByo9vrE3W0k5kp4t7yyRzqRjhGejRiW3uTm
         ILdnStKT7z0tjslAV5A11dK1cM/hCy7Fq5H6j3MWNkLrUvRZhkvLE3LeMj7OCFTMlsX9
         W29uXZP7d1/v/4t/D6HsUHPk7uqEJUW/AMc/0w7qcZCyLE3JNQiyEdW/Er/tFaK6VMDR
         Q29Q==
X-Gm-Message-State: AO0yUKVE4FrKurC/MIIUCjcdNdM8F3Ciqi6JrKEEhqkJMivwYSvqSjqZ
        +iwFRMxweEVgqTQ5FK9+0rjoQQ==
X-Google-Smtp-Source: AK7set90A1kagYMQXQLp0Dpaj79ES5rzB/gI2zg7vosBGRuakhbiQzPbMNfGJHjyZk7AI2wAtWkDHQ==
X-Received: by 2002:a05:600c:1e19:b0:3dc:52fc:7f06 with SMTP id ay25-20020a05600c1e1900b003dc52fc7f06mr8189377wmb.41.1675410755367;
        Thu, 02 Feb 2023 23:52:35 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc433355aasm2020861wmn.18.2023.02.02.23.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:52:35 -0800 (PST)
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
Subject: [PATCH v4 0/6] RISC-V kasan rework
Date:   Fri,  3 Feb 2023 08:52:26 +0100
Message-Id: <20230203075232.274282-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
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

As described in patch 2, our current kasan implementation is intricate,
so I tried to simplify the implementation and mimic what arm64/x86 are
doing.

In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
instrumentation: all kasan configurations were tested on a large ubuntu
kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.

inline ubuntu config + uefi:
 sv39: OK
 sv48: OK
 sv57: OK

outline ubuntu config + uefi:
 sv39: OK
 sv48: OK
 sv57: OK

Actually 1 test always fails with KASAN_KUNIT_TEST that I have to check:
# kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan__test.c:1020
KASAN failure expected in "set_bit(nr, addr)", but none occurrred

Note that Palmer recently proposed to remove COMMAND_LINE_SIZE from the
userspace abi
https://lore.kernel.org/lkml/20221211061358.28035-1-palmer@rivosinc.com/T/
so that we can finally increase the command line to fit all kasan kernel
parameters.

All of this should hopefully fix the syzkaller riscv build that has been
failing for a few months now, any test is appreciated and if I can help
in any way, please ask.

base-commit-tag: v6.2-rc6

v4:
- Fix build warning by declaring create_tmp_mapping as static, kernel
  test robot

v3:
- Add AB from Ard in patch 4, thanks
- Fix checkpatch issues in patch 1, thanks Conor

v2:
- Rebase on top of v6.2-rc3
- patch 4 is now way simpler than it used to be since Ard already moved
  the string functions into the efistub.

Alexandre Ghiti (6):
  riscv: Split early and final KASAN population functions
  riscv: Rework kasan population functions
  riscv: Move DTB_EARLY_BASE_VA to the kernel address space
  riscv: Fix EFI stub usage of KASAN instrumented strcmp function
  riscv: Fix ptdump when KASAN is enabled
  riscv: Unconditionnally select KASAN_VMALLOC if KASAN

 arch/riscv/Kconfig             |   1 +
 arch/riscv/kernel/image-vars.h |   2 -
 arch/riscv/mm/init.c           |   2 +-
 arch/riscv/mm/kasan_init.c     | 516 ++++++++++++++++++---------------
 arch/riscv/mm/ptdump.c         |  24 +-
 5 files changed, 298 insertions(+), 247 deletions(-)

-- 
2.37.2

