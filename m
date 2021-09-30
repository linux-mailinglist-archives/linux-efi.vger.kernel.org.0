Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4641E181
	for <lists+linux-efi@lfdr.de>; Thu, 30 Sep 2021 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbhI3Swp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Sep 2021 14:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345096AbhI3Swj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Sep 2021 14:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8841861209;
        Thu, 30 Sep 2021 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633027856;
        bh=UhBCHbOj9Jl5ZEx32c+R0M1PnzpsDKyF6CtjxvFScPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2tPiDJenxyQCvMzIY4Em8nsDs+rtaeSgB5mPhO6rdWaZxL8dx3plalQIb93rr+g7
         VQ8cGTHdyEbFp89BNk1xmo9SM+kleGvnBNuMMGt+h3NC2iEs3mimxx37p8Rh1Q49I1
         dICy9rhz40FtM07iwqUokDQc+WAsE9WW38PuHUYN59W32pQcFuBqF49AW2YbxvUmMe
         aml+AvUr5+hgysic8DOhS2c2vDqm1VwkFyfbPUhqrlF8CS9WEcfvcWhLGpQ9MtlfVo
         xwgzIBOzSTgMKLsybKBHHglY8ZfOkRoMe48nKFLqWW35isec2qKzGOkfCDbTRn1Osu
         LXpN7CWI+EqJw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 2/6] xen/x86: free_p2m_page: use memblock_free_ptr() to free a virtual pointer
Date:   Thu, 30 Sep 2021 21:50:27 +0300
Message-Id: <20210930185031.18648-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

free_p2m_page() wrongly passes a virtual pointer to memblock_free() that
treats it as a physical address.

Call memblock_free_ptr() instead that gets a virtual address to free the
memory.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/p2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 5e6e236977c7..141bb9dbd2fb 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -197,7 +197,7 @@ static void * __ref alloc_p2m_page(void)
 static void __ref free_p2m_page(void *p)
 {
 	if (unlikely(!slab_is_available())) {
-		memblock_free((unsigned long)p, PAGE_SIZE);
+		memblock_free_ptr(p, PAGE_SIZE);
 		return;
 	}
 
-- 
2.28.0

