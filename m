Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C608A8A1E0
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHLPFI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 11:05:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfHLPFI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 11:05:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so12496002wml.0
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0F14BMpIdBrIwMf7OjjkwazZeUP2fIGMTLlIBF/IWMI=;
        b=hcUxkiLMAl/dOL9yDehEtGU40JS15/VaEJX7cLv7kSyabMcS76nD4k9opnYkQI5gcJ
         2XQpSltFueRPr5Uv3n7XKjJvkNQxge8xqaWkLq3fh9Ub1HBWm+3JYhYtGUqXd+XH8NKU
         sRHzVgZ5QdEIy1LUOeutX20teYv35UfEOKCkOirih34BcteeFXYVybJnbGsB471APt0e
         lKP0K/u6nmxlXefO7Erc05fD5IIj04PBY6YDERiJ+hDhYhI4GPVAIY7BVskFSOjIYe4I
         5yH34TVBNH19zLAlC9cFyuHKEYUe4SRTZk/AxKv3Z8qzM4kqRc8JLfUF0+ip2KQW3xvX
         OFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0F14BMpIdBrIwMf7OjjkwazZeUP2fIGMTLlIBF/IWMI=;
        b=LXPMS/UNsZuO+C62XlFhwyiXZChX5PN8xSAan4s9glCf2ZeHyQGYro7gUW74NgCL0M
         W3Ky0a6xdDhdV5rj8rr/WxvffRHTXViBFA7oEz0leIRfLMJlOUAYvnyTHpNhVJLzpbHe
         vHmF+uMVNGLHq8oqXLHlrK40uzpGbNkBNv/vm78hYEhB7mLjMYg7WNmYmp/84cWG+t+E
         YOjtoXyjpmtcbTxD/yyAR9lnr1L4g03VPN5LPjpKOcJI6TksLc/kPKFOXAISSkLHV6fx
         7JNAgZ17CNeD5/ozmEMz/vkkftBymjUj+9unXdexrHyLPj8qJCyWg+c3ShbZc4CTmanQ
         yqKw==
X-Gm-Message-State: APjAAAX6cqhX2mihyVsODjjsvxH6Qdm4OAXH0jeKw6N+tCTEZyfHA+cK
        95rW3N+KCBaDulTtJfqnFUfqLIvsnaG43w==
X-Google-Smtp-Source: APXvYqxVoum+LOqtIzp50rwSLvG9uIS5/obLJMti4ktZt9A0ZS170CA9sAsz2ehuh+K1j+tQns7n/Q==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr27956868wmf.115.1565622306575;
        Mon, 12 Aug 2019 08:05:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [GIT PULL 0/5] EFI updates for v5.4
Date:   Mon, 12 Aug 2019 18:04:47 +0300
Message-Id: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to b194a77fcc4001dc40aecdd15d249648e8a436d1:

  efi: cper: print AER info of PCIe fatal error (2019-08-12 12:06:23 +0300)

----------------------------------------------------------------
EFI changes for v5.4:
- Some refactoring of the EFI config table handling across architectures.
- Add support for the Dell EMC OEM config table.
- Include AER diagnostic output to CPER handling of fatal PCIe errors.

----------------------------------------------------------------
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
