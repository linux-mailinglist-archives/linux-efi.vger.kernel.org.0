Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8937A0EA4
	for <lists+linux-efi@lfdr.de>; Thu, 14 Sep 2023 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjINUBq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Sep 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINUBq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Sep 2023 16:01:46 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE026BC
        for <linux-efi@vger.kernel.org>; Thu, 14 Sep 2023 13:01:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso893766f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 14 Sep 2023 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694721700; x=1695326500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hSVNqQkBP8/oOBhQ7IlwTAXgqWDkeXrhl3UxxN4AvHw=;
        b=ErKlNSrkqyFO79RlLAJLjfKvq6oU8PtcZOUEUFcl/lzGN4gdFyR8pHuUJu+O8ZIMw0
         PU245WviBqhxj5FNWl5OWzTReG/ZwhU81XVBVzWf4z/th/+o81JS+HGH5QIRlferdUvT
         IKWsZDrsw6vk9N4l388QA1vnVFHeEZ9pR7Iy1qafx6IguSWTtc6o3XDd6MwTb85AY0pY
         8jmafKoYAh/qBaocD/pEf/V7VxLEw41dMe+0kEa6ByYEk7N0wUOGlYW3NVLjkhVSPagQ
         7rFHHoIMgUgpLs+8u5Zij/fxmrGDBkWUweFRiH/toebNSFeO9x3PJOUlClkZJW3TdzCe
         A+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694721700; x=1695326500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSVNqQkBP8/oOBhQ7IlwTAXgqWDkeXrhl3UxxN4AvHw=;
        b=kL2+8JUdC2wAfJsIWiQXYP111uItvjHSDqtCCgmpmw2/KBVZFYA3WJBhY2QmD2HxsJ
         knBkdrhvPunMv0b2Dh0HlOudt41IkkDJ/Wcf+3FvacMFqU9Zy4abfsqZZEaKFlBxs6R8
         lPaheIDcfOXWiuM4L2CF2yisjNWlufniFkrJDrxlAZiHZZw+cownkZptVGpmMmpG2qE0
         Y6YhqJ0RUk8Xw2R9vhH7Vo5kNOYUYxLYglbBOtyN72cD0E6y7wfe2yoTrsR7lchNARCP
         VEQD8LAbWvnRJGU8sVRU6VQCpcWMmyzJeypjyEGn533OSMVzt4GmdUevPUPZ73MVFKdn
         CjVA==
X-Gm-Message-State: AOJu0Yz8YsROgEpuNQUawdgJdqJv4gdhdsRXjml+XU/oIEdUXyh/yfyq
        jYbWrUwt1liYys0+BrNbkOU9PbpS
X-Google-Smtp-Source: AGHT+IH3Vs8Rfga9HWMylXpA0UCQH16RatiArVqJIv3kK+RpbHbm/KauXEjHx4DWYWDDBUaiDKJ5TchT
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:ea07:0:b0:31f:eb88:e3cd with SMTP id
 q7-20020adfea07000000b0031feb88e3cdmr18779wrm.12.1694721700339; Thu, 14 Sep
 2023 13:01:40 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:01:27 +0000
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=ardb@kernel.org;
 h=from:subject; bh=ogwdwhDHmkUwTpghXsN7bCf1CkRilFshXAFXgA/weVA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZU5bbro54vpWrd/cYf4THBd3qayq8Rz/6zTezfuuPJ5u
 m6Q+67ZHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAib2UZGXa5SWcu5r0za+Xz
 zh9bXv95dGltqNYp3fNxG58cPL/1apUgw1/Zu0JL/85ZVFZwvyT6cqnd+dUr/8Torb39Y8/nOM1 0h72cAA==
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914200126.266849-2-ardb@google.com>
Subject: [GIT PULL] EFI fixes for v6.6 (#1)
From:   Ard Biesheuvel <ardb@google.com>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Just a couple of EFI fixes before I disappear on vacation for a couple of
weeks.  Another fix is pending but the reporter has not bothered to test it
yet, so I'll leave that for another -rc.

The first patch was intended to be part of the merge window batch but due to a
conflict with -tip, I decided to defer it until after -rc1.

Please pull.


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-1

for you to fetch changes up to 79b83606abc778aa3cbee535b362ce905d0b9448:

  efivarfs: fix statfs() on efivarfs (2023-09-11 09:10:02 +0000)

----------------------------------------------------------------
First set of EFI fixes for v6.6:

- Missing x86 patch for the runtime cleanup that was merged in -rc1
- Kconfig tweak for kexec on x86 so EFI support does not get disabled
  inadvertently
- Use the right EFI memory type for the unaccepted memory table so
  kexec/kdump exposes it to the crash kernel as well
- Work around EFI implementations which do not implement
  QueryVariableInfo, which is now called by statfs() on efivarfs

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/x86: Move EFI runtime call setup/teardown helpers out of line
      efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
      efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table

Heinrich Schuchardt (1):
      efivarfs: fix statfs() on efivarfs

 arch/x86/Kconfig                                 |  2 +-
 arch/x86/include/asm/efi.h                       | 32 ++----------------------
 arch/x86/platform/efi/efi_32.c                   | 12 +++++++++
 arch/x86/platform/efi/efi_64.c                   | 19 ++++++++++++--
 drivers/firmware/efi/libstub/unaccepted_memory.c |  2 +-
 fs/efivarfs/super.c                              | 14 ++++++++---
 6 files changed, 43 insertions(+), 38 deletions(-)
