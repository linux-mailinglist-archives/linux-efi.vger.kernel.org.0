Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBEB3978
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2019 13:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfIPLfz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Sep 2019 07:35:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfIPLfz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Sep 2019 07:35:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so38456331wrm.9;
        Mon, 16 Sep 2019 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mv491UnCKS4JNd7z2SOkwV0dvUpBxBoTZTqacB4oBDQ=;
        b=QlNxlAIQbvJb3OhnUhYCbkS2E2cmf2D/kPuUxGHT2UDqE/PX6Q+oUl305tVKtFn4Ht
         zIK+pTyv1hzrnV2DLspJUU8QUSzIXviK30cKnUvMtXqkVcES+MtKtJaRYXSNqV9W1fGU
         CegCxpAUaejap0b/1ehh1oZewOU1lyOYkZy5UhULLRSE+3LAyMCGBnX2Vx7QZ1r6+2Vk
         Pc+1vW9DOpMnTthcU93e4Hg+6L5idXIbDwBuuGTSr6nH6f3AibmiRBBiEQH3yE5oEWQh
         Zf40Kum8dKBkdOv4XNbMywvSDrrsCBYqeySGTwyXcQdtbPRWE2zkgjTtcV7kX7pfJJaP
         NWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Mv491UnCKS4JNd7z2SOkwV0dvUpBxBoTZTqacB4oBDQ=;
        b=SneGaGof9GNMahPws/mDELkkizRrBXevERSjf7p7U1qX1zDYG6JCKWmuBH+bphLgm3
         O7OOwHdrJV9DsFZ+A1BHsb6mba2rMdfO5J7O34mS54M0/VQzIDe7U+QijyJB8Ls6hr+X
         VjSFacuR5jjHACcUFImBYyDfLOzQxf53gkYFfsVMKk4CfUhVLLi0WFxICeVt47xSOdGT
         Ql8tKR0gpLbkO1tZAVVKYdxawh9VPeW5EVOJueZnJj9b7hfBg8I5ajn8iTC8TD+MbZVx
         BtjejpzuboZqDZgNgTPOS4gXeFL2zBn4f8s32BSk7AiHmuQO7+j7Kbm/VADCxVqSiU5q
         wJjw==
X-Gm-Message-State: APjAAAVSkyqD9yiC4Fuc+5d59+KtIgThxqvS5gEwihfj7DQl4R4pSBT2
        Nes9Twyq0OqVdci/kW8fssYJir4d
X-Google-Smtp-Source: APXvYqzFvF/jO3IjT5ZQsh3FJ2YQUpXu8iu759xLt+TfBC7t0w52DcNJOukvVWSAoosXgI55ZsTjIQ==
X-Received: by 2002:a05:6000:162e:: with SMTP id v14mr1456582wrb.112.1568633752298;
        Mon, 16 Sep 2019 04:35:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y13sm74527067wrg.8.2019.09.16.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:35:51 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:35:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI changes for v5.4
Message-ID: <20190916113549.GA76922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: d3dc0168e93233ba4d4ed9a2c506c9d2b8d8cd33 Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

The changes in this cycle were:

 - Refactoring of the EFI config table handling across architectures.
 - Add support for the Dell EMC OEM config table.
 - Include AER diagnostic output to CPER handling of fatal PCIe errors.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (3):
      efi: x86: move efi_is_table_address() into arch/x86
      efi/x86: move UV_SYSTAB handling into arch/x86
      efi: ia64: move SAL systab handling out of generic EFI code

Narendra K (1):
      efi: Export Runtime Configuration Interface table to sysfs

Xiaofei Tan (1):
      efi: cper: print AER info of PCIe fatal error


 Documentation/ABI/testing/sysfs-firmware-efi |   8 ++
 arch/ia64/include/asm/sal.h                  |   1 +
 arch/ia64/include/asm/sn/sn_sal.h            |   2 +-
 arch/ia64/kernel/efi.c                       |   3 +
 arch/ia64/kernel/setup.c                     |   2 +-
 arch/x86/include/asm/efi.h                   |   5 +
 arch/x86/include/asm/uv/uv.h                 |   4 +-
 arch/x86/mm/ioremap.c                        |   1 +
 arch/x86/platform/efi/efi.c                  |  39 ++++++-
 arch/x86/platform/uv/bios_uv.c               |  10 +-
 drivers/firmware/efi/Kconfig                 |  13 +++
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/cper.c                  |  15 +++
 drivers/firmware/efi/efi.c                   |  39 +------
 drivers/firmware/efi/rci2-table.c            | 147 +++++++++++++++++++++++++++
 include/linux/efi.h                          |  14 +--
 16 files changed, 251 insertions(+), 53 deletions(-)
 create mode 100644 drivers/firmware/efi/rci2-table.c
