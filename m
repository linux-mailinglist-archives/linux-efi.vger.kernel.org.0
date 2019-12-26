Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3D12AD2F
	for <lists+linux-efi@lfdr.de>; Thu, 26 Dec 2019 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLZPQp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 10:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZPQp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 10:16:45 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9472075E;
        Thu, 26 Dec 2019 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577373404;
        bh=qte1HoMpw27seoR6IIS/kRXFxFkUuB5Z5+JuN2Zl9p0=;
        h=From:To:Cc:Subject:Date:From;
        b=XhWgznf14w2wtohUFYRPZz0scFpAKcAjQHXYeXY0BnT4u7dgY4HbHUF10gLao7nTv
         T878iJpxR695CEE1eywczymE9YraZzekX0AWdWev2hv/MfhO2KVyvsgNd69tOEmRDf
         rymiutBRxKHsPdukwvtLIFAznTqaq5lLotf0hOi0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 0/3] efi/x86: clean up and simplify runtime call wrappers
Date:   Thu, 26 Dec 2019 16:14:04 +0100
Message-Id: <20191226151407.29716-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are three different ways the x86 kernel can call into EFI firmware
at runtime, (native 64 bit, native 32 bit or mixed mode), and for each
of them, we have a special wrapper routine written in assembler that
deals with the peculiarities of ABI translation, 1:1 mapping of memory
etc.

The 64-bit version can be simplified, by getting rid of the FP register
preserve/restore, which is redundant in most cases.

The 32-bit version is only used to call the SetVirtualAddressMap EFI
service, so with that taken into account, we can simplify it a lot as well.

The mixed mode version can be simplified too, by using the stack instead
of global variables to store context while the EFI call is in progress.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>

Ard Biesheuvel (3):
  efi/x86: simplify 64-bit EFI firmware call wrapper
  efi/x86: simplify i386 efi_call_phys() firmware call wrapper
  efi/x86: simplify mixed mode call wrapper

 arch/x86/include/asm/efi.h           |   3 +-
 arch/x86/platform/efi/efi_64.c       |   4 +
 arch/x86/platform/efi/efi_stub_32.S  | 106 +++-----------------
 arch/x86/platform/efi/efi_stub_64.S  |  36 +------
 arch/x86/platform/efi/efi_thunk_64.S | 106 ++++++--------------
 arch/x86/platform/uv/bios_uv.c       |   7 +-
 6 files changed, 58 insertions(+), 204 deletions(-)

-- 
2.17.1

