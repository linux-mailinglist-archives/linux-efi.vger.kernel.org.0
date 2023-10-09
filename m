Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5E7BECBE
	for <lists+linux-efi@lfdr.de>; Mon,  9 Oct 2023 23:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbjJIVTQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Oct 2023 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378236AbjJIVTQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Oct 2023 17:19:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A78B6;
        Mon,  9 Oct 2023 14:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D85C433C8;
        Mon,  9 Oct 2023 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886348;
        bh=TSGItzmReuXxWm++8av4ew2EUzZA35IjrSGdiAa7ie8=;
        h=From:To:Cc:Subject:Date:From;
        b=AR02btZ4mgp9dab3ACYI6igrBGiVFEQdmNWNcxHdD8UJq1EhYHaLIGjb3Cwv4s+g+
         mmathlc5Veu0bcn46YVnxKQY9ABGfLimELcNw0klUlNtKHXpOmX5SgqRxTUCkLFS3o
         ZS0Ueu7JemOZJOGzANL0FRGqVPg0BpVr9dfyhsQ5nDwbUv63LLomoFEIvX/7i3O4Bj
         U55wVSdhQ8c2iMBNqigs0yUvbVUtg7hwnPp/Vnt3CUqJhGNKIVOsAVmLVPmdhMkwyJ
         uLzJxnSI5zcAdgJpatcdE4e1r1jp90wyIblBOJG7uZmhXO5MwaO5T8h/WirbhImG9y
         IaGxkq1DM1dMw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH v3 0/9] video: screen_info cleanups
Date:   Mon,  9 Oct 2023 23:18:36 +0200
Message-Id: <20231009211845.3136536-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

v3 changelog

No real changes, just rebased for context changes, and picked up the Acks.

This now conflicts with the ia64 removal and introduces one new dependency
on IA64, but that is harmless and trivial to deal with later.

Link: https://lore.kernel.org/lkml/20230719123944.3438363-1-arnd@kernel.org/
---
v2 changelog

I refreshed the first four patches that I sent before with very minor
updates, and then added some more to further disaggregate the use
of screen_info:

 - I found that powerpc wasn't using vga16fb any more

 - vgacon can be almost entirely separated from the global
   screen_info, except on x86

 - similarly, the EFI framebuffer initialization can be
   kept separate, except on x86.

I did extensive build testing on arm/arm64/x86 and the normal built bot
testing for the other architectures.

Which tree should this get merged through?

Link: https://lore.kernel.org/lkml/20230707095415.1449376-1-arnd@kernel.org/


Arnd Bergmann (9):
  vgacon: rework Kconfig dependencies
  vgacon: rework screen_info #ifdef checks
  dummycon: limit Arm console size hack to footbridge
  vgacon, arch/*: remove unused screen_info definitions
  vgacon: remove screen_info dependency
  vgacon: clean up global screen_info instances
  vga16fb: drop powerpc support
  hyperv: avoid dependency on screen_info
  efi: move screen_info into efi init code

 arch/alpha/kernel/proto.h                     |  2 +
 arch/alpha/kernel/setup.c                     |  8 +--
 arch/alpha/kernel/sys_sio.c                   |  8 ++-
 arch/arm/include/asm/setup.h                  |  5 ++
 arch/arm/kernel/atags_parse.c                 | 20 +++---
 arch/arm/kernel/efi.c                         |  6 --
 arch/arm/kernel/setup.c                       | 11 +--
 arch/arm64/kernel/efi.c                       |  4 --
 arch/arm64/kernel/image-vars.h                |  2 +
 arch/csky/kernel/setup.c                      | 12 ----
 arch/hexagon/kernel/Makefile                  |  2 -
 arch/hexagon/kernel/screen_info.c             |  3 -
 arch/ia64/kernel/setup.c                      | 53 ++++++++-------
 arch/loongarch/kernel/efi.c                   |  3 +-
 arch/loongarch/kernel/image-vars.h            |  2 +
 arch/loongarch/kernel/setup.c                 |  3 -
 arch/mips/jazz/setup.c                        |  9 ---
 arch/mips/kernel/setup.c                      | 11 ---
 arch/mips/mti-malta/malta-setup.c             |  4 +-
 arch/mips/sibyte/swarm/setup.c                | 26 ++++---
 arch/mips/sni/setup.c                         | 18 ++---
 arch/nios2/kernel/setup.c                     |  5 --
 arch/powerpc/kernel/setup-common.c            | 16 -----
 arch/riscv/kernel/image-vars.h                |  2 +
 arch/riscv/kernel/setup.c                     | 12 ----
 arch/sh/kernel/setup.c                        |  5 --
 arch/sparc/kernel/setup_32.c                  | 13 ----
 arch/sparc/kernel/setup_64.c                  | 13 ----
 arch/x86/kernel/setup.c                       |  2 +-
 arch/xtensa/kernel/setup.c                    | 12 ----
 drivers/firmware/efi/efi-init.c               | 14 +++-
 drivers/firmware/efi/libstub/efi-stub-entry.c |  8 ++-
 drivers/firmware/pcdp.c                       |  1 -
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |  7 +-
 drivers/hv/vmbus_drv.c                        |  6 +-
 drivers/video/console/Kconfig                 | 11 +--
 drivers/video/console/dummycon.c              |  2 +-
 drivers/video/console/vgacon.c                | 68 +++++++++++--------
 drivers/video/fbdev/Kconfig                   |  2 +-
 drivers/video/fbdev/hyperv_fb.c               |  8 +--
 drivers/video/fbdev/vga16fb.c                 |  9 +--
 include/linux/console.h                       |  7 ++
 42 files changed, 183 insertions(+), 252 deletions(-)
 delete mode 100644 arch/hexagon/kernel/screen_info.c

-- 
2.39.2

Cc: "David S. Miller" <davem@davemloft.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Khalid Aziz <khalid@gonehiking.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org

