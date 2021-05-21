Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14DF38CE2C
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhEUTbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 15:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhEUTbL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 May 2021 15:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621625387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W/zi/LtHS0XDym1cIKLNS5P4Tl2hUYuQ3Q4oc605Ruc=;
        b=WbWoRry5olkobyvisfXDrjy1jOgWBoap15a3NtexQoqSsp1a+QLRw77NcxUVvVtYglVzqE
        LJVM0wGKlVj+7+k1Ohidy4hdtWXsX+iflDDnbgAuDNip7agZSdOFDdJHopBlhyD1g7s6Ji
        mdA5zxA3wfWjKdaUW5zb3BUS6c5ghT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-BBhUEnqFM5umXZIq2-vBjQ-1; Fri, 21 May 2021 15:29:45 -0400
X-MC-Unique: BBhUEnqFM5umXZIq2-vBjQ-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so9757941wrb.3
        for <linux-efi@vger.kernel.org>; Fri, 21 May 2021 12:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/zi/LtHS0XDym1cIKLNS5P4Tl2hUYuQ3Q4oc605Ruc=;
        b=m5KZ3ZXVmSopPCwbn2nVhMiJkyeWbIKjBem2ehUlKDpYUY6QvuCtd+gQ6AEh9pM/5I
         Nt/WER+Wk6Je1vFrYeavDUtPm9nlXwIxFXRDdg5d1ZDEsFEwW6ye6dxwA8m5Tc6Tnh+G
         U77BDWetRqcUyN7h+FBiNgPoPHy5S4IZfoCjQbLaijS4kC+WO86nF0JFOx852u3IDeNO
         br4drIK1h62ltcweWrR/hybQxFQyf85T9hMhYATsRjcOZbtPHMJ3kuIgYhbzFVzHF6I2
         bjaW1AsyPEtQtpDv/Tz0frjASgXR6j6ACgJyG/+UnsI9jCbwhzFLJfLLaw0xoacFqZVQ
         nJOg==
X-Gm-Message-State: AOAM531j79YJR/WJPU4u/dl+oq502e3fyq6C6RFNbABW+B4J91StpHTf
        B/MI2PqKVUPzXbSVvi+4ph3P668UqgOUImL+Nen/wT1eQuPXen7GkAsIi5ev9dVFVLYkMDBYd2i
        hylamxKQIbq3xodOBjDLh
X-Received: by 2002:a05:600c:4b92:: with SMTP id e18mr10110478wmp.71.1621625384766;
        Fri, 21 May 2021 12:29:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/OyYpeLIFQQtA9P7euza3ZHBvS4POGpr3Wcj1AR1IOx4wP4WYkmEu/V4dSruhwNMjfWVl2Q==
X-Received: by 2002:a05:600c:4b92:: with SMTP id e18mr10110469wmp.71.1621625384534;
        Fri, 21 May 2021 12:29:44 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s7sm434402wmh.35.2021.05.21.12.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:29:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH 0/2] allow the sysfb support to be used in non-x86 arches
Date:   Fri, 21 May 2021 21:29:04 +0200
Message-Id: <20210521192907.3040644-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The x86 architecture platform has a Generic System Framebuffers (sysfb)
support, that register a system frambuffer platform devices. It either
registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
VGA/EFI FB devices for the vgafb/efifb drivers.

Besides this, the EFI initialization code used by other architectures such
as aarch64 and riscv, has similar logic but only register an EFI FB device.

The sysfb is generic enough to be reused by other architectures and can be
moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
logic used by non-x86 architectures to be folded into sysfb as well.

Patch #1 in this series do the former while patch #2 the latter. This has
been tested on x86_64 and aarch64 machines using the efifb, simplefb and
simpledrm drivers. But more testing will be highly appreciated, to make
sure that no regressions are being introduced by these changes.

Since this touches both arch/{x86,arm,arm64,riscv} and drivers/firmware, I
don't know how it should be merged. But I didn't find a way to split these.

Best regards,
Javier


Javier Martinez Canillas (2):
  drivers/firmware: move x86 Generic System Framebuffers support
  drivers/firmware: consolidate EFI framebuffer setup for all arches

 arch/arm/Kconfig                              |  1 +
 arch/arm/include/asm/efi.h                    |  5 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/efi.h                  |  5 +-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/efi.h                  |  5 +-
 arch/x86/Kconfig                              | 27 +-----
 arch/x86/kernel/Makefile                      |  3 -
 drivers/firmware/Kconfig                      | 30 +++++++
 drivers/firmware/Makefile                     |  2 +
 drivers/firmware/efi/Makefile                 |  2 +
 drivers/firmware/efi/efi-init.c               | 90 -------------------
 .../firmware/efi}/sysfb_efi.c                 | 79 +++++++++++++++-
 {arch/x86/kernel => drivers/firmware}/sysfb.c | 42 +++++----
 .../firmware}/sysfb_simplefb.c                | 31 ++++---
 .../x86/include/asm => include/linux}/sysfb.h | 34 +++----
 16 files changed, 182 insertions(+), 176 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (70%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (82%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (68%)

-- 
2.31.1

