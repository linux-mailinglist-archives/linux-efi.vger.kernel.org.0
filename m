Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA81C1A6936
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgDMPza (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 11:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgDMPz3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:29 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EFF20656;
        Mon, 13 Apr 2020 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793328;
        bh=KTk9cwV2T7FyWit4wXThuE2JxgSVPpcA0ysORxgBS4A=;
        h=From:To:Cc:Subject:Date:From;
        b=ourQLy0Pu50wfyvmPf0GEFw6SRXfymR7uwYQ6s5a0bKlQDWia3uriewvRTq9fm0C6
         r2I9mTKQxpfeWX+DRLGVIcFkgydSJmh6AFNqKWoWIPFTO1D7sIkt9F7d8H3aimkvIV
         kCbo25zAlrlaefFHeNSkWR+iKDNJbrH2GQMxl3dI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/8] efi/libstub: simplify arm64 kernel image loading
Date:   Mon, 13 Apr 2020 17:55:13 +0200
Message-Id: <20200413155521.24698-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On arm64, the kernel image used to be virtually mapped via the linear
region, making the two mappings correlated in a way that required the
kernel to be located at the start of the linear region, or the memory
below would not be accessible. For this reason, the EFI stub loader
code for arm64 has the notion of a 'preferred offset' for the physical
placement of the kernel image, and tries to put the kernel there, or
at least as low as possible in physical memory (unless KASLR is active,
in which case the placement is randomized)

When KASLR was introduced, the virtual mapping of the kernel was moved
into the vmalloc region, and now, regardless of whether KASLR support
is built in or active, the kernel can be placed anywhere in physical
memory without any detrimental side effects on the linear region.

This means that we can drop the notion of 'preferred offset' entirely,
and invoke the kernel in place if the PE/COFF loader loaded it at the
right offset. If not, we can invoke the ordinary UEFI top down page
allocator to reallocate it elsewhere in memory. By updating the PE/COFF
metadata, we can inform the PE/COFF loader about the desired alignment,
making it less likely that we need to move the kernel image in the first
place.

Ard Biesheuvel (8):
  efi/libstub/random: align allocate size to EFI_ALLOC_ALIGN
  efi/libstub/random: increase random alloc granularity
  efi/libstub/arm64: replace 'preferred' offset with alignment check
  efi/libstub/arm64: simplify randomized loading of kernel image
  efi/libstub/arm64: align PE/COFF sections to segment alignment
  efi/libstub: add API function to allocate aligned memory
  efi/libstub/arm64: switch to ordinary page allocator for kernel image
  efi/libstub: move efi_relocate_kernel() into separate source file

 arch/arm64/kernel/efi-header.S             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S            |   3 +-
 drivers/firmware/efi/libstub/Makefile      |   3 +-
 drivers/firmware/efi/libstub/alignedmem.c  |  57 ++++++
 drivers/firmware/efi/libstub/arm64-stub.c  |  92 +++-------
 drivers/firmware/efi/libstub/efistub.h     |  18 +-
 drivers/firmware/efi/libstub/mem.c         | 191 +-------------------
 drivers/firmware/efi/libstub/randomalloc.c |   6 +-
 drivers/firmware/efi/libstub/relocate.c    | 174 ++++++++++++++++++
 9 files changed, 280 insertions(+), 266 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
 create mode 100644 drivers/firmware/efi/libstub/relocate.c

-- 
2.17.1

