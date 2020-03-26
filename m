Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C381944CC
	for <lists+linux-efi@lfdr.de>; Thu, 26 Mar 2020 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCZQ7z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Mar 2020 12:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCZQ7y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Mar 2020 12:59:54 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C1920714;
        Thu, 26 Mar 2020 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585241994;
        bh=rV3h8qQW0FYqgWhqZ43zHTAw48+LqjuopHgk1oz9eFI=;
        h=From:To:Cc:Subject:Date:From;
        b=OAJFIulTl2hFO5S3shSIYNsdtc5wosrzM1sChFB1FGubeEBrFs0nliXdBDWSTXmIJ
         kKrCamJcH5xpKtRdVYB02/2g9KeL1QPOH9FtnWqXaqvhu4EvHokac++F0yxnBg2/lQ
         caQFPX3w5M1ydgcJNBAOejNcvETos0V/CdPOdXNM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] efi/arm64: execute the kernel in place if possible
Date:   Thu, 26 Mar 2020 17:59:03 +0100
Message-Id: <20200326165905.2240-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update the relocation logic in the EFI stub for arm64 so it runs the
kernel in place if it was loaded by firmware at an address which allows
doing so. Then, update the PE/COFF header metadata and increase the
section alignment to force the UEFI image loader to honour the minimal
alignment requirement imposed by the kernel proper.

Ard Biesheuvel (2):
  efi/libstub/arm64: avoid copying the kernel unnecessarily
  efi/arm64: increase the PE/COFF alignment so the kernel can run in
    place

 arch/arm64/kernel/efi-header.S            | 2 +-
 arch/arm64/kernel/image-vars.h            | 7 +++++++
 drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.17.1

