Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960B04F486
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2019 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFVIve (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jun 2019 04:51:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFVIvO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jun 2019 04:51:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so8717964wre.7
        for <linux-efi@vger.kernel.org>; Sat, 22 Jun 2019 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdrNbZk4+5GMH7+vINq3bjHxz2Mgfb8BRnXaK4Rpn5w=;
        b=J5J/G+b6+9YRAeBH4SXoiGYyWPDtznpGbzjZ6RJl7YlEvuROsMMjZBmDsffY2K20bR
         STp64a7nX+qTrx7cOvvK93yZIc1FCDBRxoXGHSNsHd3ccqa/9oMhlc4V47atX9JRsf+B
         qCoN5DY5ObbjPLmQG0i1MLZJ/GWSb8SsqDOB5XpZan8Cv0NZgAam4n+LnLh/tZmnyfxE
         GaCQllumsHuKrMDX6bZ+iCE6hs/s2KSm0cD4AIvU2kway0TWcr733LtPN0QQYUuXlcFv
         KbrHbU7QVtpeQ06RHxCopl490UGIfQe5Givt8772bb9LfGSvvZCDYtIRNgBT3e2VwNji
         U9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdrNbZk4+5GMH7+vINq3bjHxz2Mgfb8BRnXaK4Rpn5w=;
        b=ChvVsQmOpovJJ+IEROptj8xQSVdPJqbDy4yZAAZiDkfAS6iL4Y7EmHve3uv4ypiuGa
         g/CTrd7hAqckaMB4Tkdy+D6+2hMo7scMPO7qD+5ZV4U5iYx0zy5pZVDL8X2vO+FUiWH4
         1LoS1fYCgbXNR4YQfg+ioPUsliOIZ/5rQmDQ+I5THu4gvCJ4/+h2QKuGg4PEbozlmBzK
         6nAkaDK3ROPD9Ca0JhAkx/S4YD+tNBEmxS8+uu01Igz3sv7oZHOMtQji3qium7jbKa3J
         NquuERxQM2FyZ3ASiRuRbIN6UM2JxLWfFqSwVubF6K86YT38FOLh9zu0c3+tDbchStMK
         IDrQ==
X-Gm-Message-State: APjAAAWOtJKA3Cm7u0cg3tUG66WZgbu8jTqRJ37yFKDK2evy5xbYiPrJ
        DwTO0xqc0xF/D0Uw7GDbGaOVzT1533G8jtaR
X-Google-Smtp-Source: APXvYqy4Be5mkwMCWQ+mh8cyOP9H7kRvS9JY5Hnofo0qmiISxWzTOaXY1q1Fh0sj8nBIH7SJgvxN2A==
X-Received: by 2002:adf:f886:: with SMTP id u6mr31159299wrp.23.1561193471422;
        Sat, 22 Jun 2019 01:51:11 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [GIT PULL 0/4] EFI fixes for v5.2
Date:   Sat, 22 Jun 2019 10:51:02 +0200
Message-Id: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 975a6166a8584ee4a1b8bd93098e49dc101d7171:

  efibc: Replace variable set function in notifier call (2019-06-22 10:24:57 +0200)

----------------------------------------------------------------
Another handful of EFI fixes for v5.2:
- fix a potential crash after kexec on arm64 with GICv3
- fix a build warning on x86
- stop policing the BGRT feature flags
- use a non-blocking version of SetVariable() in the boot control driver

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/memreserve: deal with memreserve entries in unmapped memory

Hans de Goede (1):
      efi/bgrt: Drop BGRT status field reserved bits check

Qian Cai (1):
      x86/efi: fix a -Wtype-limits compilation warning

Tian Baofeng (1):
      efibc: Replace variable set function in notifier call

 arch/x86/platform/efi/quirks.c  |  2 +-
 drivers/firmware/efi/efi-bgrt.c |  5 -----
 drivers/firmware/efi/efi.c      | 12 ++++++++++--
 drivers/firmware/efi/efibc.c    | 12 +++++++-----
 4 files changed, 18 insertions(+), 13 deletions(-)
