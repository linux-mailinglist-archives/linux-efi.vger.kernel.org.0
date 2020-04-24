Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED77A1B7655
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgDXNG4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgDXNG4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:56 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50ED20728;
        Fri, 24 Apr 2020 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733615;
        bh=u/xP6CoK1MUmVKKpWlYTdz2lShxhmNKAh4XSY+FwLjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ej66MkSHbWOonlumdQ9GGnTn+UsiBagZBTkYO+Jv5zmh/HazYXl0bZV4rkQqIoVYE
         2Zq5Wa+A8Lo66KcR8sJF+lDLkNmALZBcBSP9Tk6oBNaJ3p3v/y6lVTUmKy4RuZyuUQ
         IGI9ILrieHZ3fH6Y+0ISv4vHQ282P9wI5Wf3O8D8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 20/33] efi/libstub/random: Increase random alloc granularity
Date:   Fri, 24 Apr 2020 15:05:18 +0200
Message-Id: <20200424130531.30518-21-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The implementation of efi_random_alloc() arbitrarily truncates the
provided random seed to 16 bits, which limits the granularity of the
randomly chosen allocation offset in memory. This is currently only
an issue if the size of physical memory exceeds 128 GB, but going
forward, we will reduce the allocation alignment to 64 KB, and this
means we need to increase the granularity to ensure that the random
memory allocations are distributed evenly.

We will need to switch to 64-bit arithmetic for the multiplication,
but this does not result in 64-bit integer intrinsic calls on ARM or
on i386.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 6200dfa650f5..a408df474d83 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -87,7 +87,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 	}
 
 	/* find a random number between 0 and total_slots */
-	target_slot = (total_slots * (u16)random_seed) >> 16;
+	target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
 
 	/*
 	 * target_slot is now a value in the range [0, total_slots), and so
-- 
2.17.1

