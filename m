Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B46B12F4
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCHUWm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHUWe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:22:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EDBA848
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 12:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E536194F
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 20:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4650C4339C;
        Wed,  8 Mar 2023 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306939;
        bh=hCF+hAbsi1kSVTUFGx6QBNohqjMbFB0ZWWixZUsaC+U=;
        h=From:To:Cc:Subject:Date:From;
        b=B84OWe7zSRoLZNhGfWSJCaqcO2tZ+Ik88c035CUCgoZys7COT8TVeX3tQJVPdrdUP
         K66NjvfDTnFSn7eIhqhmVqKna6LB0xh899jXxrqY+MUaujZHohzv7leGOD9yNh6FrK
         Jq1sRqRQ1sTt5Zm3ElO1HMaRZwAtHYAIBv10icrA04r6H+zii8Yvnp4uWWDtleCHl3
         fmrqby+3qsA17dSDzFeca0o9dPOi8Nt9bva4zNHCcWcq7hkdnfB1lqjydxI2sp05fm
         UjGIvkiflDyrM3vrbdMASUp+JNLjNY9lQlEXC4Q4eTcj1pnNYdtgj15WN4FEkmj/p/
         9qWZTUozkz4pw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [RFC PATCH 0/4] efi: x86: Use strict W^X mappings in PE/COFF header
Date:   Wed,  8 Mar 2023 21:22:05 +0100
Message-Id: <20230308202209.2980947-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=ardb@kernel.org; h=from:subject; bh=hCF+hAbsi1kSVTUFGx6QBNohqjMbFB0ZWWixZUsaC+U=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXjXZ7rPMHe68Gca/8+O3AreI4V/yOD98I8NtvDbROk1 y+bZf6mo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkfwUjQyeL58G6g0635Rfe CZo19XzBhB2LX4X0XKzUDjlwmHtGnh/D/4J7Rp0mmybF/GEwW3DgPbsb5+mFv3ZuSFNUuHduour 1v5wA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a follow-up to work proposed by Evgeny to tighten memory
permissions used by the EFI stub and subsequently by the decompressor on
x86.

Instead of going out of our way to make more space in the first 500
bytes of the image, and relying on non-1:1 mapped sections (which is
risky in the context of bespoke PE loaders), these patches reorganize
the header so the PE header comes after the x86 setup header, and can be
extended at will.

I pushed a branch at [1] that combines this with v4 of Evgeny's series
(after some minor surgery, e.g., to reorder the text and rodata sections
so they are contiguous)

We might split off the rodata section as well, and give it read/non-exec
permissions, but I'd like to discuss the approach first, and perhaps get
some testing data points.

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Peter Jones <pjones@redhat.com>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>

[0] https://lore.kernel.org/linux-efi/cover.1671098103.git.baskov@ispras.ru/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-nx-v4

Ard Biesheuvel (4):
  efi: x86: Use private copy of struct setup_header
  efi: x86: Move PE header after setup header
  efi: x86: Drop alignment section header flags
  efi: x86: Split PE/COFF .text section into .text and .data

 arch/x86/boot/Makefile                  |  2 +-
 arch/x86/boot/header.S                  | 52 +++++++++-----------
 arch/x86/boot/setup.ld                  |  1 +
 arch/x86/boot/tools/build.c             | 38 +++++++++-----
 drivers/firmware/efi/libstub/x86-stub.c | 43 +++-------------
 5 files changed, 59 insertions(+), 77 deletions(-)

-- 
2.39.2

