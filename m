Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65761C04B5
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgD3S2r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:47 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38910 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3S2r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:47 -0400
Received: by mail-qv1-f68.google.com with SMTP id t8so3516626qvw.5;
        Thu, 30 Apr 2020 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sH54dpZ/XTFnXD/KKFyF1LiOzKMWBSjoCZ5Dsb+3EY=;
        b=RKPOyiyfs8U0hNrvSiXt3Z7lD4sfCHj5juz4jIiAqB34P6pWyGsEWtRn3AB+3rbDUy
         Dx2Tw3kLs9zfNde6k411qDIxwog+m4zf/KORaRTc3q3IN5i5WmnYD1yk2eHId1qIAHNM
         AU9PrTiUApbnILS4SWGJ7Aj99pq+E2KTEwocOOtwSo+D+jdSPH5poNDSMk0gVIwIkSB2
         gfMqQe0EhydSLNolonYjrBx49Aiyrgq7cFuF05fNU2JBt6Mkhf1KiSr0QSb4EcmZhLrm
         4KJnfEhBmFWexi1xfQih4JPC3UvAlwsFCbIiiTASULsLvR3v5YoJuT0/miqBCmJc0IRm
         XYxQ==
X-Gm-Message-State: AGi0Pub64x5EWjLFaJr3S6ChsAHsYedX/+cWg32OBftkbuMuvkBR63Te
        pqlSmIZ2WzqzgkLhReMs1bM=
X-Google-Smtp-Source: APiQypLEi//txaBtHBr4GcYMFnL5EucvjV3e2izI4+SkcsU3fzOvBTRP6MSWAJaQZtxhN1OO6P5+jA==
X-Received: by 2002:a05:6214:414:: with SMTP id z20mr197142qvx.242.1588271324862;
        Thu, 30 Apr 2020 11:28:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:44 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] efi: some cleanups/refactoring for efi/next
Date:   Thu, 30 Apr 2020 14:28:32 -0400
Message-Id: <20200430182843.2510180-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is on top of efi/next.

Patch 1 fixes the size allocated for x86 boot_params.
Patch 2 refactors the setting of various hi/lo 32-bit fields, mainly on x86.
Patch 3 renames pr_efi/pr_efi_err
Patches 4-6 convert the remaining uses of efi_printk to print error
messages to use efi_err instead.
Patch 7 updates dtb= ignored message to efi_err.
Patches 8-9 refactor initrd loading, moving it into efi-stub-helper.
Patch 10 adds support for x86 builtin command line.
Patch 11 adds error checking for efi_parse_options.

Changes from v1:
- Rename pr_efi/pr_efi_err
- Drop the soft_limit-removing patch
- Fix a couple of compile warnings

Arvind Sankar (11):
  efi/x86: Use correct size for boot_params
  efi/libstub: Add a helper function to split 64-bit values
  efi/libstub: Move pr_efi/pr_efi_err into efi namespace
  efi/x86: Use efi_err for error messages
  efi/gop: Use efi_err for error messages
  efi/tpm: Use efi_err for error messages
  efi/libstub: Upgrade ignored dtb= argument message to error
  efi/x86: Move command-line initrd loading to efi_main
  efi/libstub: Unify initrd loading across architectures
  efi/x86: Support builtin command line
  efi/libstub: Check return value of efi_parse_options

 drivers/firmware/efi/libstub/arm32-stub.c     |  12 +-
 drivers/firmware/efi/libstub/arm64-stub.c     |  14 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  46 ++++++-
 drivers/firmware/efi/libstub/efi-stub.c       |  63 ++++-----
 drivers/firmware/efi/libstub/efistub.h        |  32 ++---
 drivers/firmware/efi/libstub/fdt.c            |  16 +--
 drivers/firmware/efi/libstub/file.c           |  12 +-
 drivers/firmware/efi/libstub/gop.c            |  16 +--
 drivers/firmware/efi/libstub/pci.c            |   8 +-
 drivers/firmware/efi/libstub/relocate.c       |   2 +-
 drivers/firmware/efi/libstub/secureboot.c     |   4 +-
 drivers/firmware/efi/libstub/tpm.c            |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c       | 122 ++++++++----------
 13 files changed, 186 insertions(+), 163 deletions(-)

-- 
2.26.2

