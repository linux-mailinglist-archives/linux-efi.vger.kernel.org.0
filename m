Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE83F0FED
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 08:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfKFHJS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 02:09:18 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58738 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKFHJS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 02:09:18 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D805820096E;
        Wed,  6 Nov 2019 07:09:16 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8A4AF8045C; Wed,  6 Nov 2019 08:06:32 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@dell.com>
Subject: [PATCH 0/2] x86, efi/random: invoke EFI_RNG_PROTOCOL in the x86 EFI stub
Date:   Wed,  6 Nov 2019 08:06:11 +0100
Message-Id: <20191106070613.227833-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI v2.4 and later may provide for a EFI_RNG_PROTOCOL, which can be called
from the EFI stubs to seed the kernel entropy pool. So far, this feature has
only been implemented on arm/arm64. This series makes the relevant EFI
libstub code arch-independent and enables the feature also on x86.

Please note that this feature only works if Linux is booted as an EFI stub,
and that the EFI-provided randomness is not credited as entropy unless
RANDOM_TRUST_BOOTLOADER is set.

Thanks to Ard Biesheuvel for his hints on how to test the EFI_RNG_PROTOCOL
from the UEFI shell ( RngTest-X64.efi ), and especially to Mario Limonciello:
he gave me highly useful hints on the implementation of the EFI_RNG_PROTOCOL
which ultimately helped me to determine why the earlier RFC patch did not
work out as expected.

The patches are also available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git/ random

Dominik Brodowski (2):
  efi/random: use arch-independent efi_call_proto()
  x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table

 arch/x86/boot/compressed/eboot.c       |  3 +++
 drivers/firmware/efi/libstub/Makefile  |  5 +++--
 drivers/firmware/efi/libstub/efistub.h |  2 --
 drivers/firmware/efi/libstub/random.c  | 21 ++++++++++++++++-----
 include/linux/efi.h                    |  2 ++
 5 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.24.0

