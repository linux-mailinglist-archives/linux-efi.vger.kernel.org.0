Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48812B5DA
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 17:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0QeO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 11:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QeO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Dec 2019 11:34:14 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272B120CC7;
        Fri, 27 Dec 2019 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464453;
        bh=sTA+SCCcCVyN0cayyjtEmIQOaDiD+MCeqJ+oW6iy5bQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MFI0fbKYjSJGP/o6cub+0qyMcH17A+gU8kADJiDxaR82U8C6nDYZaTYoPTle9D8wl
         BmgmdBEVPNp2LjL+WNdyh5x3DFj46jW7EjRDpqAnpqGYoCRIWcs0cJCIbXTKNw2ML3
         FnKKkga+7tXQD8xeEhsi/uOgbitgjabv+hH3zhAQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 0/3] efi/x86: righten memory protections at runtime
Date:   Fri, 27 Dec 2019 17:34:15 +0100
Message-Id: <20191227163418.16139-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For historical reasons, the EFI startup code uses R/W/X mappings for
most memory regions that it maps, and in the mixed mode case, it
even maps all of DRAM R/W/X in its 1:1 mapping.

Let's tighten this a bit, and use the NX bit where possible, and
ensure that at least the kernel text+rodata are not mapped RWX in
the mixed mode case.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>

Ard Biesheuvel (3):
  x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
  efi/x86: don't map the entire kernel text RW for mixed mode
  efi/x86: avoid RWX mappings for all of DRAM

 arch/x86/mm/pageattr.c         |  8 +-------
 arch/x86/platform/efi/efi_64.c | 21 ++++++++++++++------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.17.1

