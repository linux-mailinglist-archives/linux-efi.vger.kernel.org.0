Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836A6759548
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jul 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGSMkI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jul 2023 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSMkH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jul 2023 08:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DBEE0;
        Wed, 19 Jul 2023 05:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2A6615C3;
        Wed, 19 Jul 2023 12:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE75DC433C8;
        Wed, 19 Jul 2023 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770405;
        bh=DIdJB1tKscR1rR3ujrBSJpnHyT/V+Wqlv5mxqgqFyfo=;
        h=From:To:Cc:Subject:Date:From;
        b=JrzZEGAAyAH1UDXHME4ojHdWqSujNUNi7s/2QLjU4KPdJmC4YzkCnfpLJWsy1giIi
         4GfKf/YtkVIiRQh3ABlUkf77h0sv4JdaKf/Vl1FPgqFZ7Q9AP+FJHMyVanaiYlHRyn
         XhjbT1VbweWLETJajH46boExznIVXhvkYxrEgo9zFKUJiFKlNAz6apD8S1DPsT367D
         TDWhXjATRbaPWUN7/4LHlap/dNyW9Fz5CEvycj2DQjpc0EtPyXvbYt5ePy6xhhwmbd
         /BIf4DyZD3QTQDe2SgMuY/ua/2MJlpwAR6VLqGrW9QwblGXER1IPEh6DejVsQa5tGr
         UD0g9QPf5fqPw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
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
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/9] video: screen_info cleanups
Date:   Wed, 19 Jul 2023 14:39:35 +0200
Message-Id: <20230719123944.3438363-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
 arch/arm/kernel/setup.c                       |  7 +-
 arch/arm64/kernel/efi.c                       |  4 --
 arch/arm64/kernel/image-vars.h                |  2 +
 arch/csky/kernel/setup.c                      | 12 ----
 arch/hexagon/kernel/Makefile                  |  2 -
 arch/hexagon/kernel/screen_info.c             |  3 -
 arch/ia64/kernel/setup.c                      | 51 +++++++-------
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
 41 files changed, 178 insertions(+), 249 deletions(-)
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

