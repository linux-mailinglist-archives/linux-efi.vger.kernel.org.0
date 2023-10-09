Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6C7BECCA
	for <lists+linux-efi@lfdr.de>; Mon,  9 Oct 2023 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378764AbjJIVTg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Oct 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjJIVTc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Oct 2023 17:19:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2743112;
        Mon,  9 Oct 2023 14:19:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA836C43395;
        Mon,  9 Oct 2023 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886359;
        bh=0oKwSWjQM05Ao/uQ0wsIA8Wzs9vAdnSky5PBtFIwvT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cc6mgFQ7201CW0jtgb8bIADXktMt8MRMT5x+zQw138I5XhtRj2Z1lwGZhhPijjyLd
         kTwWA2c0xvwB5JiFtFlNwyF/2A1exupq+bHGHDWWtDRa+RvKY9VqTvDSMn5AeL+XSl
         yGEkvMDkhhWs5RmkDmAujwJhUssc5rFx4IJ6CqRFoUa/PIJIHBcZiNfYy4TdgmWMRg
         g/HUVfC3sFvxoDEj4LccmDA703CvrYglGO7CgRuySaLENAMMyCvJ/4Sw/IDMD0JjgG
         lXVfBLeNZaf41n+P4kVSO/kwBuSJQEbPztE0iTf6JqGSv44j1av9O3KWNhgiyM7vfm
         xaQYicgV0L0lg==
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
Subject: [PATCH v3 1/9] vgacon: rework Kconfig dependencies
Date:   Mon,  9 Oct 2023 23:18:37 +0200
Message-Id: <20231009211845.3136536-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009211845.3136536-1-arnd@kernel.org>
References: <20231009211845.3136536-1-arnd@kernel.org>
MIME-Version: 1.0
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

The list of dependencies here is phrased as an opt-out, but this is missing
a lot of architectures that don't actually support VGA consoles, and some
of the entries are stale:

 - powerpc used to support VGA consoles in the old arch/ppc codebase, but
   the merged arch/powerpc never did

 - arm lists footbridge, integrator and netwinder, but netwinder is actually
   part of footbridge, and integrator does not appear to have an actual
   VGA hardware, or list it in its ATAG or DT.

 - mips has a few platforms (malta, sibyte, and sni) that initialize
   screen_info, on everything else the console is selected but cannot
   actually work.

 - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
   in the opt-out table and declare a screen_info to allow building
   vga_con, but this cannot work because the console is never selected.

Replace this with an opt-in table that lists only the platforms that
remain. This is effectively x86, plus a couple of historic workstation
and server machines that reused parts of the x86 system architecture.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Khalid Aziz <khalid@gonehiking.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/console/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 30577b1d3de59..cbf303d76d39b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,9 +7,9 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
-		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
+	depends on ALPHA || IA64 || X86 || \
+		(ARM && ARCH_FOOTBRIDGE) || \
+		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
 	default y
 	help
-- 
2.39.2

