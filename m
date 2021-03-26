Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC7349D34
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 01:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCZAFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 20:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhCZAE4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 20:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E536761A0A;
        Fri, 26 Mar 2021 00:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717095;
        bh=L9P4ui1NiLkugPcGrxgKRmTRmqu40ZRnD2TBPHJZ8RI=;
        h=From:To:Cc:Subject:Date:From;
        b=Dd5XrAQB6dAMw1+ivXRD2kI+/6neIfKNKqRE4pffNX2xlMhtmJh1IftjwpM9woy5A
         P9upW5bU+10i/WyvsXP2l6S3hJ7O1Juf98eJxBBu378FTvgYyqYHn2w68Qd2l+x+l7
         rwAUv39PQHLaQ1NHnhyKu8BiW6Msz+KYrLUc5KUXMDSGZSmVq5aCyuhsb9c5zBhl6z
         YDVKGJOhnxw2j/dYaXWiBMDCzEiXN8i3RgqmMSxcRruvlua0SsIYg2+bozLC3U5sst
         d756wlpIpe4UQvFt/ho0GC2czOfIF0Itl04O+JfOC+PPIZ1CYwX3ILoSifAPnZ1RW4
         ARTDUyCQmW2hQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Fix cross compiling x86 with clang
Date:   Thu, 25 Mar 2021 17:04:32 -0700
Message-Id: <20210326000435.4785-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi all,

This series fixes cross compiling x86 with clang, which was initially
brought up by John here:

https://lore.kernel.org/r/cceb074c-861c-d716-5e19-834a8492f245@gmail.com/

I have picked up that patch and added the same fix in a couple of other
places where it is needed.

I have tested this on an ARM based server with both defconfig and
allmodconfig, where the build now passes.

Please let me know if there are any problems.

Cheers,
Nathan

John Millikin (1):
  x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)

Nathan Chancellor (2):
  x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS
  efi/libstub: Add $(CLANG_FLAGS) to x86 flags

 arch/x86/Makefile                     | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)


base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
-- 
2.31.0

