Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2147867788A
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAWKJ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 05:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjAWKJ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 05:09:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E80CC21
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:09:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so10218662wmb.0
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BowUBQydnAafqAai7xO8TqOkM+didbH9IqQu35TSCq4=;
        b=dOwqxgrVb3ypUy4k4M318f6E0m70qvhPaXk+aDiLRN4MuUpj2iih++Rsv4zeEwZQ/Z
         gve4hd6zTyG8YvQ8gOY1uzbwnzAsu8I9uZILphr7ks/N2yRFJ1CpIjkgVlnnsXLZ2rUL
         kv1LZ40Yjom/NcmpJWLKMyTNYHqVb8qelkDTrEkp/Ke1pH/imyoTS902MaR6FW2fQGmX
         ZOW2vt+6UBqyMc3E+NRg5YaC9YTt3EeMpt35ByUCj8q+2MXSNjSiU/JPVfvxLaocF2FT
         Lhp0sAkCvc8dDuvPa4LLRyhtveEfzTDWMGuyFcq+DHJVqPUWTkG8iZ6UZJ/wAitUfsV0
         h2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BowUBQydnAafqAai7xO8TqOkM+didbH9IqQu35TSCq4=;
        b=ap2SMuYo2VoZa/fCc/0/NG65H7/B+RWxZovOzZ6mHShYkvqegoyGGo9hM97l9cJRz5
         q5yfgUICQYOZeqYJKFyIDkGn9w1bl3bL+nz1ScduZWueeW8iH0QcuQo3mDfZFpXC2WGW
         7UN4VxbAnu2hItm5oKQ2jciY67CM+fNqV0hVy1RW0mhUwSkGVvwGHzzHfahRhmGr1/ox
         kUo0iUJbcxcSMbc9IZqBPJ9vkA32NGCLFpoljEB7ftCciPMpbHFpRKw5SQGu6YhjNuQg
         XhdubanQlvVgfKAFRMpRC5C3tGe+q2cCuqlRRywkVWfD3jwp41KW8LNm4i3M2UPHJMfM
         Joxg==
X-Gm-Message-State: AFqh2koo3DiDJgZDX9CeYu2IPbM8Sk4H5LqrlxSBZT25CrkFHf+yLPGu
        OxMVNwrBHVvxAX0zVLai6O0luw==
X-Google-Smtp-Source: AMrXdXs7SiqkzdfbYCN4klaQirQ4x4dMCIkYAZcYH8jLjpLSn5XUFPnaT0RkC3gKysT8Z1wF4lVK7w==
X-Received: by 2002:a05:600c:1c01:b0:3c6:e63e:23e9 with SMTP id j1-20020a05600c1c0100b003c6e63e23e9mr23745245wms.24.1674468593747;
        Mon, 23 Jan 2023 02:09:53 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05600c3d9000b003daf89e01d3sm10170407wmb.11.2023.01.23.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:09:53 -0800 (PST)
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
Subject: [PATCH v2 0/6] RISC-V kasan rework
Date:   Mon, 23 Jan 2023 11:09:45 +0100
Message-Id: <20230123100951.810807-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
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

