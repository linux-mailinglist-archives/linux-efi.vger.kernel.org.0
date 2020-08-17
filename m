Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0755246488
	for <lists+linux-efi@lfdr.de>; Mon, 17 Aug 2020 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHQKav (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Aug 2020 06:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHQKau (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Aug 2020 06:30:50 -0400
Received: from e123331-lin.nice.arm.com (ip-213-127-60-218.ip.prioritytelecom.net [213.127.60.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDD9206FA;
        Mon, 17 Aug 2020 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597660250;
        bh=CYnq4zlUpjpbJqXvt7mAB6Db5o5Qq5z9z/rq39iMu2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=oD5PHC3yvszDmRNtekOIc0XGeFFgS4jhENZllkE5s9uzTXGjlTX25Y3dcpU3j4iGA
         gvlBDLXk1IX2I9yifA9OrhwbK92jxdPBNB08RJIqWE03tdJB+BJefJ0wkNtmtR/dkw
         KNE4aUARzhyTn8rjMaPsUzcP/Smxah4PhBOx6B7I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] efi: old memmap removal followup fixes
Date:   Mon, 17 Aug 2020 12:30:42 +0200
Message-Id: <20200817103044.12163-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that the old runtime region mapping code is finally gone, we can
drop any mention of it from the Documentation, and merge some code that
was shared between 32-bit and the old memmap handling code into efi_32.c

Ard Biesheuvel (2):
  efi/x86: Move 32-bit code into efi_32.c
  Documentation: efi: remove description of efi=old_map

 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/x86/include/asm/efi.h                    |  4 --
 arch/x86/platform/efi/efi.c                   | 69 -------------------
 arch/x86/platform/efi/efi_32.c                | 45 ++++++++++--
 4 files changed, 39 insertions(+), 84 deletions(-)

-- 
2.17.1

