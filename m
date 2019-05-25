Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00B42A3FC
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfEYL0F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 May 2019 07:26:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEYL0F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 May 2019 07:26:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t4so4092270wrx.7
        for <linux-efi@vger.kernel.org>; Sat, 25 May 2019 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Jmq85Hmw2WeX8gpf6pOoI0z6l9EWC+tkDaeefNI1o=;
        b=ldLaiCWcwfHAzZPNr/OkUNDMUtsFV81IstXNblmin3fdJrm4WBVKshRjXDYhIAQGBQ
         YY0iQMRNPSYJF6qcuAJkt7xpff8wZ0jJz5jlK+eHCCWOUNHE5hlTpG5KKUhAF2ecJSby
         GoqQ6l2PIL8dO7MkQqUO/BktFQiyWYqJJ/ZaAQZCLEdU9K/Lh4gVl5rPBxtOBAgB5JIR
         oHvWxA3a5EaoGbJ7eTpo9bY5gsLTmyqgGnErLbZwf1N+G0luqYe2ffMgu/2zwK6S8K27
         x9w9tWA7y6bRVWuj9YK2dCXCG08Vwv06MPwBnBldyvei5VDF+cmJ1Z3AiAXbLKLSeBEu
         u6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Jmq85Hmw2WeX8gpf6pOoI0z6l9EWC+tkDaeefNI1o=;
        b=gb2tLvsvsBpIC7PerrdXnkZl1NdiMDhFOtfTclwO/CeQW+Yfp2pv5FjKWWg2Hk4vSB
         WGbb6axV7gktIO5LLPmypzIHY0Dc6kBHp52705DqmM2PQ4TaGMnev4tpX6PAPRcNkvEH
         h3rD8ozWpMO3aLXmIRVnUF2d6WQHBMt1hCB/NaWcykS15QVYMKSzAOEjsAiCuC0rdpSR
         rzLq3DD8ikzaFUCpKAvBHds22YURp27Rizt/NWwKqPH3e5Qa2J4ATPEAbe9SoiO4sha3
         ONiAOnBesYTuvgHOkEEreV3mZRbqZgxJ8W9rzMihIXAcBAwseujykN6VNrBfDvex69j3
         wZXA==
X-Gm-Message-State: APjAAAVejbZomxGrqp+3egcfVW+DiRuXR2XuiI9Zhd8BMabYA3XujmUt
        WBUwlPXxBQSsXHE6rctVUCGyyJJhegQF0w==
X-Google-Smtp-Source: APXvYqy+jHj17CyeDcnuuzBRgIjzq+0LH01TDDqXY29xxw4IQdwZmhUcOU+muNgW0OCl981nMxs5sQ==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr6275253wri.61.1558783563569;
        Sat, 25 May 2019 04:26:03 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:3ccc:7074:9336:6a6e])
        by smtp.gmail.com with ESMTPSA id y16sm4942010wru.28.2019.05.25.04.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:26:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Rob Bradford <robert.bradford@intel.com>
Subject: [GIT PULL 0/2] EFI fixes for v5.2
Date:   Sat, 25 May 2019 13:25:57 +0200
Message-Id: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to a7decd94d514721f8bf5da02e3ae66758b80603a:

  efi: Allow the number of EFI configuration tables entries to be zero (2019-05-25 13:10:50 +0200)

----------------------------------------------------------------
A pair of low priority EFI fixes for v5.2:
- deal with systems where EFI does not expose a single configuration table
- add missing handling for memory allocation failures to x86 old_map code

----------------------------------------------------------------
Gen Zhang (1):
      efi/x86: Add missing error handling to old_memmap 1:1 mapping code

Rob Bradford (1):
      efi: Allow the number of EFI configuration tables entries to be zero

 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 arch/x86/platform/efi/quirks.c | 3 +++
 drivers/firmware/efi/efi.c     | 3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)
