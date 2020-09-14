Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FB2688DB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgINJ5Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ5Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:24 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662BC20731;
        Mon, 14 Sep 2020 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077443;
        bh=/i8JIdcof+/Z5OS77tF0K9DZIQIHnegrBkil34Gly4o=;
        h=From:To:Cc:Subject:Date:From;
        b=2NneM/9o2/b95pOV7zRr+ZxlLdz6ucZ4ECvf2SRE73KUqT1ZfZG7p+KSisxM7Nc1S
         on+3zlAfsO1gLZK63bgJqZeztEJMWopZHdfJE+9l8uTvt9wEAt2zi7P81dbGoJNoGu
         We40XaEq0dvdk44gDFad5jNJqIBhfTZwUN0/9zRM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
Date:   Mon, 14 Sep 2020 12:56:54 +0300
Message-Id: <20200914095706.3985-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a respin of the adr_l/ldr_l code I wrote some years ago in the
context of my KASLR proof of concept for 32-bit ARM.

A new use case came up, in the form of Clang, which does not implement
the 'adrl' pseudo-instruction in its assembler, and so for PC-relative
references that don't fit into a ARM adr instruction, we need something
else. Patch #2 addresses an actual Clang build issue of this nature, by
replacing an occurrence of adrl with adr_l.

I have included my existing cleanup patches that were built on top of the
adr_l macro, which replace several occurrences of open coded arithmetic to
calculate runtime addresses based on link time virtual addresses stored
in literals.

Note that all of these patches with the exception of #2 were reviewed or
acked by Nico before, but given that this was a while ago (and the fact
that neither of us work for Linaro anymore), I have dropped these. Note
that only patch #1 deviates significantly from the last version that I
sent out, the remaining ones were just freshened up (and their commit
logs slightly expanded).

Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Peter Smith <Peter.Smith@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>

Ard Biesheuvel (12):
  ARM: assembler: introduce adr_l, ldr_l and str_l macros
  ARM: efistub: replace adrl pseudo-op with adr_l macro invocation
  ARM: module: add support for place relative relocations
  ARM: head-common.S: use PC-relative insn sequence for __proc_info
  ARM: head-common.S: use PC-relative insn sequence for idmap creation
  ARM: head.S: use PC-relative insn sequence for secondary_data
  ARM: kernel: use relative references for UP/SMP alternatives
  ARM: head: use PC-relative insn sequence for __smp_alt
  ARM: sleep.S: use PC-relative insn sequence for
    sleep_save_sp/mpidr_hash
  ARM: head.S: use PC-relative insn sequences for __fixup_pv_table
  ARM: head.S: use PC relative insn sequence to calculate PHYS_OFFSET
  ARM: kvm: replace open coded VA->PA calculations with adr_l call

 arch/arm/boot/compressed/head.S  | 18 +---
 arch/arm/include/asm/assembler.h | 88 ++++++++++++++++++-
 arch/arm/include/asm/elf.h       |  5 ++
 arch/arm/include/asm/processor.h |  2 +-
 arch/arm/kernel/head-common.S    | 22 ++---
 arch/arm/kernel/head.S           | 90 +++++---------------
 arch/arm/kernel/hyp-stub.S       | 27 +++---
 arch/arm/kernel/module.c         | 20 ++++-
 arch/arm/kernel/sleep.S          | 19 ++---
 9 files changed, 159 insertions(+), 132 deletions(-)

-- 
2.17.1

