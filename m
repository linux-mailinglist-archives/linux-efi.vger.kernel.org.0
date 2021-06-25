Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2423B4417
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFYNMX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 09:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhFYNMW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Jun 2021 09:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624626601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vvZL1fz2dwOb7Upqb55JPmmwYtiHqp1yiqdJ6Cauu30=;
        b=iqzecFy2DKuHSWLo+Kq2F0j1mvrE634KN95PcAn7ghoEMVlcGYMMSMkon01HQQqFtX8f/V
        UBlH4lWEvQ1TlU9AvDtZ+xOJm4ZOZttZbcNZStTCn5VBJmpKKO19Uis5Ze8nZvZJeVCq6S
        VxKHjJVsQyvFiZL281Y6vaSdWm8YNM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-uBUbdjLrN52WQeYDzDc_0g-1; Fri, 25 Jun 2021 09:10:00 -0400
X-MC-Unique: uBUbdjLrN52WQeYDzDc_0g-1
Received: by mail-wm1-f70.google.com with SMTP id i82-20020a1c22550000b02901d64e84b3c9so2689701wmi.5
        for <linux-efi@vger.kernel.org>; Fri, 25 Jun 2021 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvZL1fz2dwOb7Upqb55JPmmwYtiHqp1yiqdJ6Cauu30=;
        b=i5hDdt2/9Xh9HXURx6N8gGHn6Wjl3RR1ZYOaGL45qEUiFIvFrtYPim2jLc6v6FOng5
         KRejrRZo4IgFTi2J1763jjC3krTvq76YMnkVxtLKXwULjxMnsIblD0YNU+++Wuzwd53F
         hSL9MLqlRhDSGOpfFwYBCaVYM9MN1pV/Z0ERokGSbUWM16yhLH/efcpYELG6k3lzyB19
         cz+EVzxv0MKwT7fn750YkAxMIttuRP73RmGYIsveq+NNsGz3SG3m7OqYBg176e2YYHdu
         59m7sEjuIGwnIhUG/3zGm1CXBjP67HPusf+k0Nolx3NG5/zmoaGZ/JvgCu4n25vt7+7y
         BpQg==
X-Gm-Message-State: AOAM533DcJpjFSxVZ78DJQibkBrQHsXJLy8TGAzsQqgI/YLd3+BlLOsr
        g9PcUGwKkY/urpwY5SD9DXJFzDMC3nGLYE4kB2ZV7cJS9CoRoy4Yqv5sdyvwSLKEKwQzLSSaXFI
        +lT2cWhKbpX7gZPf2Fzg4
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr10869842wrt.95.1624626599109;
        Fri, 25 Jun 2021 06:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxac5aAuPdj78okqR8e93aZVHiRH/QUWQDePxg/s70gh/LhsMF19zX80NB6m3SpVsyLwyMfkA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr10869804wrt.95.1624626598911;
        Fri, 25 Jun 2021 06:09:58 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id x7sm5995864wre.8.2021.06.25.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 06:09:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 0/2] allow simple{fb,drm} drivers to be used on non-x86 EFI platforms
Date:   Fri, 25 Jun 2021 15:09:45 +0200
Message-Id: <20210625130947.1803678-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The simplefb and simpledrm drivers match against a "simple-framebuffer"
device, but for aarch64 this is only registered when using Device Trees
and there's a node with a "simple-framebuffer" compatible string.

There is no code to register a "simple-framebuffer" platform device when
using EFI instead. In fact, the only platform device that's registered in
this case is an "efi-framebuffer", which means that the efifb driver is
the only driver supported to have an early console with EFI on aarch64.

The x86 architecture platform has a Generic System Framebuffers (sysfb)
support, that register a system frambuffer platform device. It either
registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
VGA/EFI FB devices for the vgafb/efifb drivers.

The sysfb is generic enough to be reused by other architectures and can be
moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
logic used by non-x86 architectures to be folded into sysfb as well.

Patch #1 in this series do the former while patch #2 do the latter. It has
been tested on x86_64 and aarch64 machines using the efifb, simplefb and
simpledrm drivers. But more testing will be highly appreciated, to make
sure that no regressions are being introduced by these changes.

The series touches different subystems and will need coordination between
maintainers but the patches have already been acked by the x86 folks. Ard
Biesheuvel said that these could be merged through the EFI tree if needed.

Best regards,
Javier

Changes in v3:
- Add Borislav and Greg Acked-by tags.
- Also update the SYSFB_SIMPLEFB symbol name in drivers/gpu/drm/tiny/Kconfig.
- We have a a max 100 char limit now, use it to avoid multi-line statements.
- Figure out the platform device name before allocating the platform device.

Changes in v2:
- Use default y and depends on X86 instead doing a select in arch/x86/Kconfig.
- Also enable the SYSFB Kconfig option when COMPILE_TEST.
- Improve commit message to explain why is useful for other arches to use this.
- Use "depends on" for the supported architectures instead of selecting it.
- Improve commit message to explain the benefits of reusing sysfb for !X86.

Javier Martinez Canillas (2):
  drivers/firmware: move x86 Generic System Framebuffers support
  drivers/firmware: consolidate EFI framebuffer setup for all arches

 arch/arm/include/asm/efi.h                    |  5 +-
 arch/arm64/include/asm/efi.h                  |  5 +-
 arch/riscv/include/asm/efi.h                  |  5 +-
 arch/x86/Kconfig                              | 26 ------
 arch/x86/kernel/Makefile                      |  3 -
 drivers/firmware/Kconfig                      | 32 +++++++
 drivers/firmware/Makefile                     |  2 +
 drivers/firmware/efi/Makefile                 |  2 +
 drivers/firmware/efi/efi-init.c               | 90 -------------------
 .../firmware/efi}/sysfb_efi.c                 | 78 +++++++++++++++-
 {arch/x86/kernel => drivers/firmware}/sysfb.c | 37 +++++---
 .../firmware}/sysfb_simplefb.c                | 33 ++++---
 drivers/gpu/drm/tiny/Kconfig                  |  4 +-
 .../x86/include/asm => include/linux}/sysfb.h | 32 +++----
 14 files changed, 180 insertions(+), 174 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (75%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (81%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (70%)

-- 
2.31.1

