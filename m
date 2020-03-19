Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD518C046
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCST27 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:28:59 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46382 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCST26 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:28:58 -0400
Received: by mail-qt1-f180.google.com with SMTP id t13so2879057qtn.13;
        Thu, 19 Mar 2020 12:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fO0ESG9ioh3Qb6IQVZmuJEmcqIIHJ324D9kNXryCnBo=;
        b=EH2FtY0xzd7cMj1PldoYDKGpOZDXxfW74bdEt1DKctIpL6QoUun4aUP+x/tHc829Y6
         ErP6JVl3pSAqf+7lfVas/RgkwWvF5dkNFF9fSQ4MH8F293qPz4bh/Sd7JlLjm40ECdva
         oYFRyW9vMCBhMUBA4vDzNeizZOqkXKgo3qboYZgYXT1A5Ntkw9xMg2oTEvfLxYFPKRLk
         CRwGNSE3g6yyFahEcFcES5X8Wk8e0G+am7bXSBOKBDuW80oxEsYNgB0VfYbeW2o+BjRe
         VoQPAhTfgLtPa69i43p5ShVd+rlL6C5nSkmgAEzdk2MVLUiyrg91hldJISLUzPI09h8S
         tcEA==
X-Gm-Message-State: ANhLgQ2BKm7+iz9pcE0gFlq3mJLXOyX3U6oh0n0tN7NTmCaxtTHeXva3
        kba0XEWQhI6Dfr+GAzZhLPOlQqyd
X-Google-Smtp-Source: ADFU+vuZF6p6+9nTJ9Roq33+C6hF/mST2zJ0B1tN5hEOnYljGm07bEulC7JQKL+2mMF2grhXQFphYw==
X-Received: by 2002:aed:24c2:: with SMTP id u2mr4671556qtc.269.1584646137247;
        Thu, 19 Mar 2020 12:28:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:28:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] efi/gop: Refactoring + mode-setting feature
Date:   Thu, 19 Mar 2020 15:28:41 -0400
Message-Id: <20200319192855.29876-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is against tip:efi/core.

Patches 1-9 are small cleanups and refactoring of the code in
libstub/gop.c.

The rest of the patches add the ability to use a command-line option to
switch the gop's display mode.

The options supported are:
video=efifb:mode=n
	Choose a specific mode number
video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
	Specify mode by resolution and optionally color depth
video=efifb:auto
	Let the EFI stub choose the highest resolution mode available.

The mode-setting additions increase code size of gop.o by about 3k on
x86-64 with EFI_MIXED enabled.

Arvind Sankar (14):
  efi/gop: Remove redundant current_fb_base
  efi/gop: Move check for framebuffer before con_out
  efi/gop: Get mode information outside the loop
  efi/gop: Factor out locating the gop into a function
  efi/gop: Slightly re-arrange logic of find_gop
  efi/gop: Move variable declarations into loop block
  efi/gop: Use helper macros for populating lfb_base
  efi/gop: Use helper macros for find_bits
  efi/gop: Remove unreachable code from setup_pixel_info
  efi/gop: Add prototypes for query_mode and set_mode
  efi/gop: Allow specifying mode number on command line
  efi/gop: Allow specifying mode by <xres>x<yres>
  efi/gop: Allow specifying depth as well as resolution
  efi/gop: Allow automatically choosing the best mode

 Documentation/fb/efifb.rst                    |  33 +-
 arch/x86/include/asm/efi.h                    |   4 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efistub.h        |   8 +-
 drivers/firmware/efi/libstub/gop.c            | 489 ++++++++++++++----
 5 files changed, 428 insertions(+), 109 deletions(-)

-- 
2.24.1

