Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94367AB84
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjAYIXq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 03:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYIXp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 03:23:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AB36695
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:23:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z5so16201820wrt.6
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 00:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YDvDkWAbLDWKsnQUnWtcsgg0pzlyYSw3Ro2XkM1b1U=;
        b=kcqF6iq5mRuvn+vLGKITzcs41XGVfxnke94ZRKDv6r/GXQtJq/DjhtH1Bka1ZuWmOz
         hs+sqQ3WOiAIzxmt/9Zuy/4eSmxyAq/uDcMuDh+FJbpdipz28DjE2DIVkgbNi25nI5zK
         jZGqHtN15KR7z7UdxlfjkoHN0aNKg85LhpwylDBIfJNneOTjMUQ1oWWjUE6Vj1+92pDr
         DRAh5QfaLNT5gzj81fbZsHRopjbSDX3pwjXbQqwgN0tn+3A3A42nZDMT6rcPdvCmhryC
         zOFWEjBbK4SyukL/JoRIo5lmLYlAkvj+bWXz40K7tGlP0Gc3CfH5evRrgYHF5D/SHgDa
         TiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YDvDkWAbLDWKsnQUnWtcsgg0pzlyYSw3Ro2XkM1b1U=;
        b=D1C9PhG+4zNSpEPey1YUGAmZ1V3Go5YDrW2xLB3FYx99+lk5SULQRqCe9LpnTekwbe
         fRO1xCX/pE7nOnFk5MMWFTX4Dyy9y0pR0OZiNkd90gxoCjz1eneZ8Q8jt+pyDZg8Lrhh
         AyMMfG4tYx6UtAqxvYKVSiBY2FODLNGel8fbYQVtByfQvsZENZfGrXXLw6t8h7QCIR8w
         kywHsso1OVvrH0no2h5IMel//fvvZUnQrTmDFQ23Dc/HJBCtkVWg6zFzqLwY4wbbFiLg
         qm7mxrdbnN3//jnVIrp7/KtuB+ppCKfNVRRH4bIWDSFeL2qtwSXpWDABvbcpXMtjWXDQ
         AEJA==
X-Gm-Message-State: AO0yUKV4jjk1eeOhimRBJPKjaR0w0Or78RPrethfEIdLHmJzoxq4n2cy
        Vw7gt/y3MVboDglTbj8RwhH1kA==
X-Google-Smtp-Source: AK7set8JCzmJVT6O7sSrzWnjZzAPmb2N1a6Du011MY/JsAbWFnt0usJeT+kWtq+HdmDEjFicCUfIZg==
X-Received: by 2002:a5d:42cd:0:b0:2bf:81eb:dc26 with SMTP id t13-20020a5d42cd000000b002bf81ebdc26mr7593494wrr.37.1674635023170;
        Wed, 25 Jan 2023 00:23:43 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002be25db0b7bsm3821071wrx.10.2023.01.25.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:23:42 -0800 (PST)
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
Subject: [PATCH v3 0/6] RISC-V kasan rework
Date:   Wed, 25 Jan 2023 09:23:27 +0100
Message-Id: <20230125082333.1577572-1-alexghiti@rivosinc.com>
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

