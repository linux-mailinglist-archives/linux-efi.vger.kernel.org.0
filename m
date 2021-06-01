Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA6396E41
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhFAHzr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 03:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhFAHzq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Jun 2021 03:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E64BA6136E;
        Tue,  1 Jun 2021 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622534045;
        bh=+XAvuzMHMQcxwCnCNesqCmyb6X8V5ARJjsdHoon7pEE=;
        h=From:To:Cc:Subject:Date:From;
        b=vJX11QflGfehoVWetTIWOPft3Zql/d8Esr52RiXgnDt0LX43QF/OsR5I82cUSTyFr
         hHd8Ku5eS7qpq+nBWjBNkbpRHmqWK8B4a6pfW0cxdNWNRQtdKvnXT1M+Yfk1Ly4uXC
         4X+1t/UdvkbuXhBkBNjaWMctWMW1QZ6SxAgM0I8k40p6yGftCxnD6UD2dCYGj71uHJ
         /apes1WW4DGlpisAA4jHON6e/zx4+RiUFImA+3CzS3zy4If+EdAEkRdjpueLJrcNP0
         WhjYFC7TkmcF9WMeAljymC4rUZIvueGhD/CwHd6aMJ9gZD04v67b91yeVKOST+sWMA
         CGcb7cxAoOv+A==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] x86/setup: always resrve the first 1M of RAM
Date:   Tue,  1 Jun 2021 10:53:51 +0300
Message-Id: <20210601075354.5149-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Commit a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
changed the way early memory reservations are made and caused a regression
for users that set CONFIG_X86_RESERVE_LOW to 640K in their kernel
configuration [1] because there was no room for the real mode trampoline.

My initial suggestion was to reduce the limit of CONFIG_X86_RESERVE_LOW
from 640K to 512K [2], but in the end it seems simpler to always reserve
the first 1M of RAM after the real mode trampoline is allocated.

The first patch in the series contains the rework of early memory
reservations so that first 64K will be reserved very early before memblock
allocations  are possible and the remaining memory under 1M would be
reserved after the real mode trampoline is allocated. This patch also
update freeing of EFI boot services so that memory under 1M will remain
reserved which is also required for crash kernel [3].

The second and the third patches are cleanups that remove pieces that are
not longer required after the first patch is applied.

Randy, Hugh, I'd appreciate if you give this a whirl on your old Sandy
Bridge laptops as it changes again the way trim_snb_memory() works.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=213177
[2] https://lore.kernel.org/lkml/20210526081100.12239-1-rppt@kernel.org
[3] https://lore.kernel.org/lkml/20210531090023.16471-1-lijiang@redhat.com/#r

Mike Rapoport (3):
  x86/setup: always reserve the first 1M of RAM
  x86/setup: remove CONFIG_X86_RESERVE_LOW and reservelow options
  x86/crash: remove crash_reserve_low_1M()

 .../admin-guide/kernel-parameters.txt         |  5 --
 arch/x86/Kconfig                              | 29 ---------
 arch/x86/include/asm/crash.h                  |  6 --
 arch/x86/kernel/crash.c                       | 13 ----
 arch/x86/kernel/setup.c                       | 59 +++++++------------
 arch/x86/platform/efi/quirks.c                | 12 ++++
 arch/x86/realmode/init.c                      | 14 +++--
 7 files changed, 41 insertions(+), 97 deletions(-)


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.28.0

