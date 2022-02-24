Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5314C3074
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiBXPz1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiBXPz1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 10:55:27 -0500
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 07:54:56 PST
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452116DADC;
        Thu, 24 Feb 2022 07:54:56 -0800 (PST)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id A1B6240D403E;
        Thu, 24 Feb 2022 15:44:52 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
Date:   Thu, 24 Feb 2022 18:43:28 +0300
Message-Id: <20220224154330.26564-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is another implementation of this patch. It uses DXE services
to change memory protection flags as you suggested earlier.

As I mentioned, you can reproduce this issue with any firmware,
including OVMF by setting the PcdDxeNxMemoryProtectionPolicy policy:
gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x7FD4
Restricting the user from creating executable pages is not an goal,
but restricting one from creating both executable and writable pages
is a goal, which is enforced in the firmware we use. We cannot allow
allocating pages of any type that have RWX permissions.
gDS->SetMemorySpaceAttributes() is technically part of the UEFI PI
specification, so it is not too bad to rely on it. However:
- DXE services is not something designed to be used by an UEFI application.
- From what we know, no other operating system uses this interface,
which means that it can easily break in production firmware on the
boards we do not control before anyone could even notice.
We do not strictly mind experimenting with this route, but it would be
preferable for this interface to become more standard in this case:
move it to UEFI Boot Services or a separate protocol and include it in
UEFI conformance suite. It will also help if we enable this feature in
Linux by default.

Baskov Evgeniy (2):
       efi: declare DXE services table
       libstub: ensure allocated memory to be executable

 arch/x86/include/asm/efi.h              |  5 ++
 drivers/firmware/efi/libstub/efistub.h  | 53 ++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c | 73 ++++++++++++++++++++++++++--
 include/linux/efi.h                     |  2 +
 4 files changed, 128 insertions(+), 5 deletions(-)
