Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651E31BE570
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD2RlX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42002 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2RlX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so2568538qts.9;
        Wed, 29 Apr 2020 10:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmaqVWTwC+lifYOHHk5qJWZIkbjYOF5n6zq/dLJ9qS8=;
        b=tLV+9VAkXyWZZviO0O8/8kFafwP+AcTqn6UHC1UNuMAxBEfMDfGxInei9A6ZHaPbqD
         pSlqUY8C6DSm1sOnaMPOXK1JZV851LnYj0qFHwYbl1b1EkhTojHf4uHurTF65bCQyOlk
         mNI+FuvIjXsQba582OVTO/5m54kuyuoqqp41EmmfaUJFZLFuNf3xyEx2beYtnRV4k+5e
         UDkGR6Msk5Bf+M33VVBzgJBjCIC02hVWufkyMfx0SPTmZoPrWMOJSqg8UqVuQ5NCz0Sf
         amAOPxudMlWAZrHyUPhfS1su7wHBl/dp2z2pmwIWjjBu+oySvHg+4rfborbE8f7WZ8oY
         k3yQ==
X-Gm-Message-State: AGi0PuY7nlTBpGMz2uWAe9ry79kEPERtyhOoGZ8/6qgwfNZkQCXSsGoP
        m5eG1D6sf7uPO1qQsXvsjMM=
X-Google-Smtp-Source: APiQypLxyLPkkPxJ7hAxvBZh2k8InnCXzIzNkEn7fexexbKw1lrg9fRqSlEQnYPvPhf/Y//hKel9Lg==
X-Received: by 2002:ac8:6d1d:: with SMTP id o29mr35735607qtt.327.1588182081959;
        Wed, 29 Apr 2020 10:41:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] efi: some cleanups/refactoring for efi/next
Date:   Wed, 29 Apr 2020 13:41:09 -0400
Message-Id: <20200429174120.1497212-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is on top of efi/next.

Patch 1 fixes the size allocated for x86 boot_params.
Patch 2 refactors the setting of various hi/lo 32-bit fields, mainly on x86.
Patches 3-5 convert the remaining uses of efi_printk to print error
messages to use pr_efi_err instead.
Patches 6-8 refactor initrd loading, moving it into efi-stub-helper.
Patch 9 adds support for x86 builtin command line.
Patch 10 adds error checking for efi_parse_options.

Arvind Sankar (10):
  efi/x86: Use correct size for boot_params
  efi/libstub: Add a helper function to split 64-bit values
  efi/x86: Use pr_efi_err for error messages
  efi/gop: Use pr_efi_err for error messages
  efi/tpm: Use pr_efi_err for error messages
  efi/x86: Move command-line initrd loading to efi_main
  efi/libstub: Unify initrd loading across architectures
  efi/x86: Drop soft_limit for x86 initrd loading
  efi/x86: Support builtin command line
  efi/libstub: Check return value of efi_parse_options

 .../firmware/efi/libstub/efi-stub-helper.c    |  42 +++++-
 drivers/firmware/efi/libstub/efi-stub.c       |  29 +++--
 drivers/firmware/efi/libstub/efistub.h        |  32 ++---
 drivers/firmware/efi/libstub/file.c           |  13 +-
 drivers/firmware/efi/libstub/gop.c            |  16 +--
 drivers/firmware/efi/libstub/tpm.c            |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c       | 121 ++++++++----------
 7 files changed, 130 insertions(+), 125 deletions(-)

-- 
2.26.2

