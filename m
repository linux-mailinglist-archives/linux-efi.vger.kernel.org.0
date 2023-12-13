Return-Path: <linux-efi+bounces-199-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654C811543
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B7928227A
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736052EB05;
	Wed, 13 Dec 2023 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BKDe+zE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC1107
	for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 06:51:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so84274597b3.3
        for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702479106; x=1703083906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuOVvQyWFF74ZGP/068HtHRQfRTCFgxGI2tyoRFPHLA=;
        b=3BKDe+zEMghI05lrv1gtkzUBzOLP67UikV7M84pXLsSn6+eeAKSM+x/O5vgVoSg84E
         y8FErX0sTD5NB6Lp9IU4onCA84diBUhpIlqnFKxcKevvxzqh2fYz06IdLMBaISgGFdNy
         AQoN3S0l6U3AfLIZZkQbdSUa08iE+pS04xttz6LaEgrBZp8KcwLamt7/XI2tHIJHIpXh
         vfVGQGaB8mHOnz+4VkxvPGw/XE4rK6B1mYsJL8ydZNF50FaOT3G5zSAXXIfkRn27GV/h
         HnzH/NCG90Nbwq7OSeuc5XLjIPjsiwS73FKD1ibDFjL6LeFMsfjn/6BZqtXUZiE3jdnz
         GgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479106; x=1703083906;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuOVvQyWFF74ZGP/068HtHRQfRTCFgxGI2tyoRFPHLA=;
        b=pa/UUeiHAIrKsPPn8q55ntuZvdhdl0X1ZNZz7SzA9IwLVO2teTkCNr3k0tK/eF+kks
         pfsfO3Sld0MGMcSJisFq1VJyQClGI5Ua8C3oEd5yv5z/Sk0xCK4yA9OKiuBBz1p4sQfY
         82rUcEvT2Hrh/gP421VQuZJxm4KCvP3CuPXhWIZaydojqfFEGP6lggcY772S44upcXQH
         ZL5kXOO32BZpi+Qpc9Zlxrsj/ptAOUUaWoizIhK7NC7WZ3kWZawxOMrCmpwr4EImYxtG
         7MgjAPxuAbalDVurDxTEGUoVvhx7wnNrxeA2rUnpn0K+3sBMyEhawaJlx5IyYHLxoGf6
         k0tg==
X-Gm-Message-State: AOJu0Ywk7uWIHE9BvtgT76kP6vGp5ebLvtdcNtLiZiNgEihv5RxOkRQn
	hjboE74k9oCfqQfEg4byKI0QDIQ9
X-Google-Smtp-Source: AGHT+IGKA4dUYH72tb5cSLBe/Zo2OtTFc2UI9Bo72ZaIiVgJLU7wFGeRe+us/R/7co6Ji1R60W2Hum3X
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:d93:b0:5d4:3013:25d4 with SMTP id
 da19-20020a05690c0d9300b005d4301325d4mr88291ywb.5.1702479105816; Wed, 13 Dec
 2023 06:51:45 -0800 (PST)
Date: Wed, 13 Dec 2023 15:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=ardb@kernel.org;
 h=from:subject; bh=8NwNGRo9WGP9wrnOVxRGwU1Mndbi3FhnpnBVg/2cV2g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbXyyCu2CRveilpsrr6061cd9xr9hC4jJY2Nq47seJTNu
 EJr8mO9jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR85wM/wPZYq+tDjadl6Bb
 f5VvredTU+el6noLshRn7vM+kth/NZ3hf3E2j/5u5Zc6D2cuul65wfeA9EpTId+THDlcdktUPmY UMgAA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213145121.2935172-2-ardb@google.com>
Subject: [GIT PULL] EFI fixes for v6.7 #2
From: Ard Biesheuvel <ardb@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI fixes below.

The following changes since commit 01b1e3ca0e5ce47bbae8217d47376ad01b331b07:

  efi/unaccepted: Fix off-by-one when checking for overlapping ranges (2023-11-28 12:49:21 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-2

for you to fetch changes up to 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1:

  efi/x86: Avoid physical KASLR on older Dell systems (2023-12-11 17:57:42 +0100)

----------------------------------------------------------------
EFI fixes for v6.7 #2

- Deal with a regression in the recently refactored x86 EFI stub code on
  older Dell systems by disabling randomization of the physical load
  address
- Use the correct load address for relocatable Loongarch kernels

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/x86: Avoid physical KASLR on older Dell systems

Wang Yao (1):
      efi/loongarch: Use load address to calculate kernel entry address

 arch/loongarch/include/asm/efi.h              |  2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c |  4 ++--
 drivers/firmware/efi/libstub/loongarch.c      |  6 +++---
 drivers/firmware/efi/libstub/x86-stub.c       | 31 +++++++++++++++++++++------
 4 files changed, 30 insertions(+), 13 deletions(-)

