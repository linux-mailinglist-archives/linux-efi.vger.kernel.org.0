Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9744BF42
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhKJK7j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:39 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53898 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhKJK7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:38 -0500
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 08A7540A2BBC;
        Wed, 10 Nov 2021 10:46:59 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] Handle UEFI NX-restricted page tables
Date:   Wed, 10 Nov 2021 13:46:08 +0300
Message-Id: <20211110104613.23881-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Note, that this patch series is RFC, since it is yet untested
and possibly incompatible with AMD SEV and related extensions.

The UEFI specification states that certain memory regions may
not have every permission, i.e. may not be writable or executable.

Furthermore there exist some implementations (at least on i386/x86_64)
that restrict execution of memory regions expected by the kernel to
be executable. E.g. first megabyte of address space, where trampoline
for switching between 4/5 level paging is placed and memory regions,
allocated as loader data.

This patch series allows Linux kernel to boot on such UEFI
implementations on i386 and x86_64.

The simplest way to achieve that on i386 is to disable paging
before jumping to potentially relocated code.

x86_64, on the other hand, does not allow disabling paging so it
is required to build temporary page tables containing memory regions
required for Linux kernel to boot with appropriate access permissions.

Baskov Evgeniy (5):
       Docs: document notemppt option
       efi: Add option for handling efi memory protection
       libstub: build temporary page table without NX-bit
       efi/x86_64: set page table if provided by libstub
       efi/x86: Disable paging when booting via efistub

 Documentation/admin-guide/kernel-parameters.txt |    7 
 arch/x86/boot/compressed/head_32.S              |   12 +
 arch/x86/boot/compressed/head_64.S              |   12 +
 drivers/firmware/efi/Kconfig                    |   17 ++
 drivers/firmware/efi/libstub/Makefile           |    2 
 drivers/firmware/efi/libstub/efi-stub-helper.c  |    3 
 drivers/firmware/efi/libstub/efistub.h          |   10 +
 drivers/firmware/efi/libstub/temp-pgtable.c     |  190 ++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c         |    8 -
 9 files changed, 258 insertions(+), 3 deletions(-)
