Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2F598064
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbiHRIzv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbiHRIzt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50209B07F8
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF5D36123A
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151D9C433C1;
        Thu, 18 Aug 2022 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812947;
        bh=Ng5VHilNrFpPcQUAtJKXBrjz3/vRDGr2J8pIR0GUI5U=;
        h=From:To:Cc:Subject:Date:From;
        b=FwC8WQ8vOcW7c51GmWA+bjopA9xnwgCd70fLXBXEHg6V1CtQDxqhbHy+/h4f3dgcC
         8QfLFHCD5SWbiYzuckM9kQ1jBHUA8oWZG+X/D7qAkBmZiqwkJeZBytqnE7EHdbQV6D
         CQtyq3e8LKKP9KPKoKNjKL0uIlonFWfbeffSDRykScjngqvnfbhmtOMDaf/07Q+oEn
         /qz+wykJ64joyL+cFUl7kHtYZJ+e7+QYaMXuXZyNnWZpAptuaBWUhHTVSnlzZSyitX
         rP5XDyPeB94a1x1i4iD6hPeUZop/13ihWGRxPj5uQIpDsezPJhBSvkWhjqwSoD4ADG
         zmzVmZU6/0yow==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: [PATCH resend 0/9] linux: implement LoadFile2 initrd loading
Date:   Thu, 18 Aug 2022 10:55:30 +0200
Message-Id: <20220818085540.2075028-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4434; i=ardb@kernel.org; h=from:subject; bh=Ng5VHilNrFpPcQUAtJKXBrjz3/vRDGr2J8pIR0GUI5U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f527GRv0Iido393xsjjOo4NXUf5hs0OPb5DVY1l VbGKiN6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+dgAKCRDDTyI5ktmPJCCoC/ 9MYTrb9pcb6mMaFJU/+MAxhlMXC0TYF1iq4hQejNmk1VjesVTA3FQ3L8JIshgv5s/9RlXuWTLkGc+C 7lIDPdyI74jsbhkbdA2PX9hLIybJ+92xtLcAYSRgVvfsZlPSHS3ibB828JsolY1dqEjcmKxS1QjjtV EK7BuWztXpWjPGVlImsLAx50BAPt8ZSiL1Hs/dIDYx3ivniIP4G1dvOqdUd47iL28XdOw5kuDaj/DB 7OJjebV9roA8spjNK55NqPHFsNr0uWtIW2r/1WXYGzbiW1RaHwAn3B/pwJZTgAkUHLUmyx2fuixhFd k//G6gQfHanJOirwYxMHtORQD3HMIMIhcnIAZoJs2LUEpG6QtZYcIRr7KIqeQHHaAKbwVjIwZhtMTL fYbQAOwCwY3dQq/sZr7n2ce/r1/cvFvTNZU5OF/rVM5QmydVoozDVn2h5jXIXxdYeopE7jo5nBGMzb 8x2G4b7WxizCtwxf00Dq8HryhqnzgMZfsChO4yYqmXpJ8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This implements the LoadFile2 initrd loading protocol, which is
essentially a callback interface into the bootloader to load the initrd
data into a caller provided buffer. This means the bootloader no longer
has to contain any policy regarding where to load the initrd (which
differs between architectures and kernel versions) and no longer has to
manipulate arch specific data structures such as DT or struct bootparams
to inform the OS where the initrd resides in memory. This is especially
relevant for the upcoming LoongArch support, which does not use either
DT or struct bootparams, and would have to rely on the initrd= command
line interface, which is deprecated and of limited utility [0].

Sample output from booting a recent Linux/arm64 kernel:

  grub> insmod part_msdos
  grub> linux (hd0,msdos1)/Image
  grub> initrd (hd0,msdos1)/initrd.img
  grub> boot
  EFI stub: Booting Linux Kernel...
  EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
  EFI stub: Generating empty DTB
  EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
  EFI stub: Exiting boot services and installing virtual address map...
  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]

This is mostly a resend of my original v2 [1], although I did
cherry-pick Nikita's version of the first patch, which incorporates
Heinrich's suggestion to simply drop the argv[] argument from
grub_initrd_load(). I also included the patch I sent out the other day
to remove the pointless header magic number check, and included a fix
for the PXE boot issue reported by dann [2].

[0] The initrd= command line loader can only access files that reside on
the same volume as the loaded image, which means GRUB would have to
present this volume abstraction in order to serve the initrd file.
Another reason why this method is problematic is generic EFI zboot,
which is being added to Linux, and which calls loadimage on another,
embedded PE/COFF image which would also need to expose this volume
abstraction.

[1] https://lists.gnu.org/archive/html/grub-devel/2020-10/msg00124.html
[2] https://lists.gnu.org/archive/html/grub-devel/2022-04/msg00055.html

Cc: grub-devel@gnu.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Nikita Ermakov <arei@altlinux.org>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: dann frazier <dann.frazier@canonical.com>
Cc: Julian Andres Klode <julian.klode@canonical.com>

Ard Biesheuvel (8):
  efi: move MS-DOS stub out of generic PE header definition
  arm64/linux: Remove magic number header field check
  linux/arm: unify ARM/arm64 vs Xen PE/COFF header handling
  linux/arm: account for COFF headers appearing at unexpected offsets
  efi: add definition of LoadFile2 protocol
  efi/efinet: Don't close connections at fini_hw() time
  efi: implement LoadFile2 initrd loading protocol for Linux
  linux: ignore FDT unless we need to modify it

Nikita Ermakov (1):
  loader: drop argv[] argument in grub_initrd_load()

 grub-core/commands/efi/lsefi.c            |   1 +
 grub-core/kern/efi/efi.c                  |   5 +-
 grub-core/loader/arm/linux.c              |   2 +-
 grub-core/loader/arm64/linux.c            | 181 +++++++++++++++++---
 grub-core/loader/arm64/xen_boot.c         |  23 +--
 grub-core/loader/efi/fdt.c                |   7 +-
 grub-core/loader/i386/linux.c             |   2 +-
 grub-core/loader/i386/pc/linux.c          |   2 +-
 grub-core/loader/i386/xen.c               |   3 +-
 grub-core/loader/ia64/efi/linux.c         |   2 +-
 grub-core/loader/linux.c                  |   4 +-
 grub-core/loader/mips/linux.c             |   2 +-
 grub-core/loader/powerpc/ieee1275/linux.c |   2 +-
 grub-core/loader/sparc64/ieee1275/linux.c |   2 +-
 grub-core/net/drivers/efi/efinet.c        |  10 +-
 grub-core/net/net.c                       |   2 +-
 include/grub/arm/linux.h                  |   7 +-
 include/grub/arm64/linux.h                |   5 +-
 include/grub/efi/api.h                    |  15 ++
 include/grub/efi/efi.h                    |   4 +-
 include/grub/efi/pe32.h                   |   5 +-
 include/grub/linux.h                      |   2 +-
 include/grub/net.h                        |   3 +-
 23 files changed, 226 insertions(+), 65 deletions(-)

-- 
2.35.1

