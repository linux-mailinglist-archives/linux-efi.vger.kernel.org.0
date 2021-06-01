Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF323975EC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhFAPBK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 11:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234386AbhFAPBI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Jun 2021 11:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622559566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBakIu1dQtk22INC/4X9gLrUw+kGXTDgbjVD36Rzgzs=;
        b=iLyWy/5kdkKDEdvMMQLg053nj8yLJfThmyHs3dg5QIWMsNKvxrq6z+rfHgB+KwJKw6og2E
        Jp8FFCLcjQIx0179h6eN3+tdIRU33ye0/RIieKX7YojgEHyL4j3IvwEaZbaSuM6uB9kB4n
        tHrLIVh7ugBwjXbuhjr/c1Bz9/tjgdw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-uHd4y-ByMSu0ja1IRnhGeQ-1; Tue, 01 Jun 2021 10:59:25 -0400
X-MC-Unique: uHd4y-ByMSu0ja1IRnhGeQ-1
Received: by mail-wr1-f71.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so1073003wru.13
        for <linux-efi@vger.kernel.org>; Tue, 01 Jun 2021 07:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBakIu1dQtk22INC/4X9gLrUw+kGXTDgbjVD36Rzgzs=;
        b=MD79LDCMcusDFSeHhusbmzsuLyDcj/Pt2Ytbz36WgHhWmBi0o16cxPoAUWClHewG0k
         UpZ2ZYG6NadYJHcYa/E3OI3iXAo5qBTJCXMUGNoBPSthYZhAPGDbwYTj4Y3C+5Umz4u3
         RXhx3Sg0O1Id75vsDpg50W9Hmx2knHaYi9hl4yK/xonPmFmCt8pWK/OasB5I+a8BbB5t
         +HgAyd0Ogw4nOJmS5xqlh25D6MGHJhoGthYc6Lode+h/AvNdPww4nOPhn6gLomlha4BR
         nN4CMfQ9uErf52ZCvC6E9enlRt+iSALEFcAAAyr22cEkWwYgzDBzLq5Zb+IR5NlmEDGk
         u/BA==
X-Gm-Message-State: AOAM532rNyVDjZumd+4EDyGynieIRfPNwQHEFwL/BWgG2Dc4iqXXqnFt
        ZBIEkLZvIjB/W9J/HAt2rEI+7uN+RF5pQ5HoUKwIPhqdHyrEapIiDdtlx/N7X/1aiQWWUhJRLXP
        ZYnNZtFXTET+rqxkdR0MF
X-Received: by 2002:a1c:282:: with SMTP id 124mr350812wmc.82.1622559564310;
        Tue, 01 Jun 2021 07:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9XbrF5UjA3Lkw2unmQqkjrGQdtKb1lFgUux9RmxthjhbwQ8B+MLPzmwDX65DDh6SYfSo0EA==
X-Received: by 2002:a1c:282:: with SMTP id 124mr350790wmc.82.1622559564069;
        Tue, 01 Jun 2021 07:59:24 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h6sm3533153wrt.6.2021.06.01.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:59:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chester Lin <clin@suse.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH v2 0/2] allow simple{fb,drm} drivers to be used on non-x86 EFI platforms
Date:   Tue,  1 Jun 2021 16:59:10 +0200
Message-Id: <20210601145912.774054-1-javierm@redhat.com>
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
maintainers. Ard Biesheuvel said that can be merged through the EFI tree.

Best regards,
Javier

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
 .../firmware/efi}/sysfb_efi.c                 | 79 +++++++++++++++-
 {arch/x86/kernel => drivers/firmware}/sysfb.c | 42 +++++----
 .../firmware}/sysfb_simplefb.c                | 31 ++++---
 .../x86/include/asm => include/linux}/sysfb.h | 34 +++----
 13 files changed, 180 insertions(+), 176 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (70%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (82%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (68%)

-- 
2.31.1

