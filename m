Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD272564DB
	for <lists+linux-efi@lfdr.de>; Sat, 29 Aug 2020 07:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgH2FaM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Aug 2020 01:30:12 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:42000 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgH2FaK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Aug 2020 01:30:10 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2020 01:30:09 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-08.nifty.com with ESMTP id 07T5Gkdn022885;
        Sat, 29 Aug 2020 14:16:46 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 07T5FRB7012582;
        Sat, 29 Aug 2020 14:15:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 07T5FRB7012582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598678128;
        bh=LVsIE8pOMnNIR6mtGLK7uU0ZbQuhigKtOBoHF9Cro6g=;
        h=From:To:Cc:Subject:Date:From;
        b=p2mhvfjq+pNdkZEq+VGJVU+MKYFBXjXGA6p0PU8N2KD08IuRIrcGbrjA8zQ+af9Nf
         GazXaKt4Yx4PGQJyVKgvcwvj148TORAz3mEJn9VSHaOGxg/qWkCbbjEENE474n0Mzr
         Q7aprxpqwjPAIbx5f/JNcAl1+hB+gQBkiuxgtctnc8YzRSoMy93rNGaTGMMRg96dxT
         qXZifa8f+9nL1aj1ewlKHvbjaVzYBKNro/fhiu4X4u8btqWj+5BvmplGWwWQPla31r
         8AJmuCoG11Ra5LFdzDTVCA5Sh8/Sm1ijoBmv1YrpXbRlEktPKeuORJGCDFThf4f8zH
         RdPnFXgZKdj+g==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ia64: clean-up header dependency and build process, fix build warning
Date:   Sat, 29 Aug 2020 14:15:21 +0900
Message-Id: <20200829051524.706585-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Randy Dunlap reports the following warning with CONFIG_IA64_PALINFO=m:

../scripts/Makefile.build:68: 'arch/ia64/kernel/palinfo.ko' will not be built even though obj-m is specified.
../scripts/Makefile.build:69: You cannot use subdir-y/m to visit a module Makefile. Use obj-y/m instead.

This comes from the fact Kbuild descends into arch/ia64/kernel/ twice.

First, to generate <generated/nr-irqs.h>,
Second, to build kernel and module objects.

The warning is emitted in the first descend because it is not the
intended usage.

I looked into the code closely, and noticed arch/ia64/kernel/nr-irqs.c
was not needed in the first place.

It was separated out of arch/ia64/kernel/asm-offsets.c just because
<asm/mca.h> was including too many bogus headers.

IA64 is not actively maintained, and there exists unneeded obsolete code.

The first two patches are the outcome when I played with ARCH=ia64 builds,
but not prerequisites for 3/3. Anyway I believe they are nice cleanups
and folded in this patch set.

3/3 is the important one to fix the false positive warning,
and it is a nice cleanup too.



Masahiro Yamada (3):
  ia64: do not typedef struct pal_min_state_area_s
  ia64: remove unneeded header includes from <asm/mca.h>
  ia64: remove generated/nr-irqs.h generation to fix build warning

 arch/ia64/Makefile             |  6 ------
 arch/ia64/include/asm/irq.h    |  4 +++-
 arch/ia64/include/asm/mca.h    | 11 ++++-------
 arch/ia64/include/asm/pal.h    |  4 ++--
 arch/ia64/include/asm/sal.h    |  2 +-
 arch/ia64/kernel/Makefile      |  5 -----
 arch/ia64/kernel/asm-offsets.c | 18 +++++++++---------
 arch/ia64/kernel/efi.c         |  1 +
 arch/ia64/kernel/mca.c         |  5 +++--
 arch/ia64/kernel/mca_drv.c     |  2 +-
 arch/ia64/kernel/nr-irqs.c     | 22 ----------------------
 11 files changed, 24 insertions(+), 56 deletions(-)
 delete mode 100644 arch/ia64/kernel/nr-irqs.c

-- 
2.25.1

