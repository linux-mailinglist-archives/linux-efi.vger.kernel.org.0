Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD771750C8
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCAXFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:05:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43057 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAXFj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:05:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id v22so2678291qtp.10;
        Sun, 01 Mar 2020 15:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmClv7KUwsEhPV3Su7vBp7m1YxS3IV694ue7XnXG+Ow=;
        b=qKEpjBhGTrRrez8qm5wza2pft8/5X+eqJPie5m2ic0QjN7V4w8bBe2Ao1tukxzWqk2
         PLnsKfte2MnV70QFFLceFWW8D4n01Zm+c/cU/DYAo9hnrBh/hGgw4pVJ4C6pbkvzp2La
         lpafj4gADyu4aitjT2f+uQ1L5KUusgK5d1jTz4qx5f4ft7Oyuw99t1WEtsAoxR6REzOm
         QaoStTfGStRqtSvekATjJ+gfY2wfFR42h37C8uK3+MTKqCT+W/ZJiJGyfk4TtdbqLBNH
         uoJkSFvsAMHMFs8B+xU2wlUVhPb4qkRwMMTB1Y0gvX7hkWzJwKqVq8rAF22vEijr0IB9
         qI+g==
X-Gm-Message-State: APjAAAUqrT8gcPq/TgwD3rDk9x2I6Mcs3abfKL4XhymdaQ+1/snrngD2
        WGirOz8yoCeV2f3dPDuQn9A5i8bwk4M=
X-Google-Smtp-Source: APXvYqy56aMXIUNCZtAG2NF4c1uMnZeJwSYjOsPTfiahWJAg3V8HeA/L/WbLsWSZgGG5CIs6gxEbjA==
X-Received: by 2002:ac8:740f:: with SMTP id p15mr12682765qtq.211.1583103938201;
        Sun, 01 Mar 2020 15:05:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x131sm8923906qka.1.2020.03.01.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:05:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Minimize the need to move the kernel in the EFI stub
Date:   Sun,  1 Mar 2020 18:05:32 -0500
Message-Id: <20200301230537.2247550-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds the ability to use the entire PE image space for
decompression, provides the preferred address to the PE loader via the
header, and finally restricts efi_relocate_kernel to cases where we
really need it rather than whenever we were loaded at something other
than preferred address.

Based on tip:efi/core + the cleanup series just posted [1]
[1] https://lore.kernel.org/linux-efi/20200301230436.2246909-1-nivedita@alum.mit.edu/

Arvind Sankar (5):
  x86/boot/compressed/32: Save the output address instead of
    recalculating it
  efi/x86: Decompress at start of PE image load address
  efi/x86: Add kernel preferred address to PE header
  efi/x86: Remove extra headroom for setup block
  efi/x86: Don't relocate the kernel unless necessary

 arch/x86/boot/compressed/head_32.S      | 42 +++++++++++++++--------
 arch/x86/boot/compressed/head_64.S      | 38 +++++++++++++++++++--
 arch/x86/boot/header.S                  |  6 ++--
 arch/x86/boot/tools/build.c             | 44 ++++++++++++++++++-------
 drivers/firmware/efi/libstub/x86-stub.c | 32 +++++++++++++++---
 5 files changed, 127 insertions(+), 35 deletions(-)

-- 
2.24.1

