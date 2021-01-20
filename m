Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E22FD8B7
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbhATSrB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387643AbhATRjp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A108kjHRUQdQY86++G1ojoBlN5bivr2NbhXvZVQXIjs=;
        b=A6yANgMW6HyJbpYRpd0ZGupej0qEAAdqYEopjBHmQU74lVJAtugb+7NzYfSdI+yccCvidO
        FGcfXPKv+q+nqcylhmmun1S+k+zW1pIqeZQuMe3k+K4rGJO9c407vcPM9VN1qprCWJNRY7
        3VhznynDdxLB+AKvcA7rYkMq/onoAew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-bki5L-AeP8u0eZV9ednh6Q-1; Wed, 20 Jan 2021 12:38:04 -0500
X-MC-Unique: bki5L-AeP8u0eZV9ednh6Q-1
Received: by mail-wm1-f72.google.com with SMTP id j133so1433607wma.4
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A108kjHRUQdQY86++G1ojoBlN5bivr2NbhXvZVQXIjs=;
        b=OxvMHlZNwAbHL5fYpuf5+J9cC77qcjDwRMjGVTdLV+r1xQCPGpnHgUb1tSFM1/rW/a
         OIXZznbchESUsPcF2P/U9PtKmtExB3brWDfkDym6mLpXBHbmTsdtzkRvZPOJqvaTivLY
         ClBybbUuwZxzPPJO/5o8kSqop5Py3T2MEPIVJf7xlt0vsdN4FNsDSXyPGSH6azCqbYhg
         lXb4ZveN6G6tjKOymLxzk2U5E0E8Jr5MaOBGjb5LGCzn8fmUjKZT7Xn4CPVqO48jRSXm
         Yig4E3UO+leiH38iiJC8a66Sfc6AuTJSNSGbWMN6j2ClsnTqyDGLUojbCB9nIcMMwN5T
         I9IQ==
X-Gm-Message-State: AOAM530Sj/xqgaPl/w1gegyqAwEP0tj+8ZxqyaCJlqpqb+znz1hWrGVG
        /IPYdhUiUjq8e66qT8wA7p9wEa1nkKamlHG/L6BktApEkRpEeVNiSwcT9rhXLsTduGkHUD6BdU7
        xxgZBnd0jTAAd3JtA3BvB
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr10630088wrz.109.1611164283634;
        Wed, 20 Jan 2021 09:38:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHore5PrQor0sfd+uGXcmG2lRqPQ/wDMgFvw29tveC12LEpMiYbOmQdf62PWPDL7v7WxO8/w==
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr10630076wrz.109.1611164283494;
        Wed, 20 Jan 2021 09:38:03 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:03 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 00/17] objtool: add base support for arm64
Date:   Wed, 20 Jan 2021 18:37:43 +0100
Message-Id: <20210120173800.1660730-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

This series enables objtool to start doing stack validation on arm64
kernel builds. It relies on the previous series I sent, refactoring
the arm64 decoder [1].

First, the aarch64 instruction decoder needed to be made available
to code under tools/. This is done in a similar manner to x86
instruction decoded. One limitation I encountered there is that most
of aarch64 instruction decoder is __kprobe annotated. To bypass that
it remove the kprobe include and had to add an empty __kprobe
definition, but I'd welcome a proper solution to that.

Then instruction semantics are progressively added so objtool can track
the stack state through the execution flow.
There are a few things that needed consideration:
- Generation of constants within executable sections, these either
  caused objtool to fail decoding or to wrongly decode constants
  as jumps or other instructions affecting execution flow and
  causing confusion. To solve this, tracking locations referenced
  by instructions using literals was needed.
- Jump tables from switch statements in aarch64 don't have enough
  information to link branches with the branch instruction leading to
  them. For this, we use a gcc plugin to add some information to establish
  those missing links in a format that is already supported by objtool

With this, there are still some errors when building with objtool. A
number of cleanups/annotations are needed on the arm64, as well as
handling SYM_DATA objects in objtool.

Those changes can be found on top of this branch here:
git clone https://github.com/julien-thierry/linux.git -b objtoolxarm64-latest

But it would be nice to have some feedback on this before I start submitting everyting.

[1] https://lkml.org/lkml/2021/1/20/791

Thanks,

Julien

-->

Julien Thierry (15):
  tools: Add some generic functions and headers
  tools: arm64: Make aarch64 instruction decoder available to tools
  tools: bug: Remove duplicate definition
  objtool: arm64: Add base definition for arm64 backend
  objtool: arm64: Decode add/sub instructions
  objtool: arm64: Decode jump and call related instructions
  objtool: arm64: Decode other system instructions
  objtool: arm64: Decode load/store instructions
  objtool: arm64: Decode LDR instructions
  objtool: arm64: Accept padding in code sections
  efi: libstub: Ignore relocations for .discard sections
  objtool: arm64: Implement functions to add switch tables alternatives
  objtool: arm64: Cache section with switch table information
  objtool: arm64: Handle supported relocations in alternatives
  objtool: arm64: Ignore replacement section for alternative callback

Raphael Gault (2):
  gcc-plugins: objtool: Add plugin to detect switch table on arm64
  objtool: arm64: Enable stack validation for arm64

 arch/arm64/Kconfig                            |    2 +
 drivers/firmware/efi/libstub/Makefile         |    2 +-
 scripts/Makefile.gcc-plugins                  |    2 +
 scripts/gcc-plugins/Kconfig                   |    4 +
 .../arm64_switch_table_detection_plugin.c     |   85 +
 tools/arch/arm64/include/asm/aarch64-insn.h   |  551 +++++++
 tools/arch/arm64/lib/aarch64-insn.c           | 1425 +++++++++++++++++
 tools/include/asm-generic/bitops/__ffs.h      |   11 +
 tools/include/linux/bug.h                     |    6 +-
 tools/include/linux/kernel.h                  |   21 +
 tools/include/linux/printk.h                  |   40 +
 tools/objtool/Makefile                        |    5 +
 tools/objtool/arch/arm64/Build                |    8 +
 tools/objtool/arch/arm64/decode.c             |  471 ++++++
 .../arch/arm64/include/arch/cfi_regs.h        |   14 +
 tools/objtool/arch/arm64/include/arch/elf.h   |    6 +
 .../arch/arm64/include/arch/endianness.h      |    9 +
 .../objtool/arch/arm64/include/arch/special.h |   23 +
 tools/objtool/arch/arm64/special.c            |  134 ++
 tools/objtool/arch/x86/decode.c               |    5 +
 tools/objtool/check.c                         |    6 +
 tools/objtool/include/objtool/arch.h          |    3 +
 tools/objtool/sync-check.sh                   |    5 +
 23 files changed, 2832 insertions(+), 6 deletions(-)
 create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
 create mode 100644 tools/arch/arm64/include/asm/aarch64-insn.h
 create mode 100644 tools/arch/arm64/lib/aarch64-insn.c
 create mode 100644 tools/include/linux/printk.h
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

--
2.25.4

