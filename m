Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01269165C6A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTLHE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 06:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBTLHE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 06:07:04 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6124924654;
        Thu, 20 Feb 2020 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582196823;
        bh=lFluvNekDub0DRH3Uxe8zzAIoxL7Jl4ubOE8d30vkXI=;
        h=From:To:Cc:Subject:Date:From;
        b=gV+WXeFrGlsX7drbVpiMhahSK6xnnM62rJoCrw2B5R59x4nWglkYkiScTCMZi2RjW
         pCfHIc2U8t65+vIsaqrniX73rkYtGAjGjPmTF68+8RVnu7gJ8pZxEcgB6U2i56pyns
         HAMP5flyjNBBUV2xuOJpe0uS8RhNRwZEb4bGZW4A=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
Subject: [RFC PATCH 0/3] efi: put an API version number in the PE/COFF header
Date:   Thu, 20 Feb 2020 12:06:46 +0100
Message-Id: <20200220110649.1303-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After having added new ways to load the initrd and the mixed mode kernel,
we will need to tell the loader about this, so it can use the new, generic
method if supported, and fall back to the existing method(s) otherwise.

This is an RFC - if there are better ways to record this in the image
somehow, please shout.

Cc: lersek@redhat.com
Cc: leif@nuviainc.com
Cc: pjones@redhat.com
Cc: mjg59@google.com
Cc: agraf@csgraf.de
Cc: ilias.apalodimas@linaro.org
Cc: xypron.glpk@gmx.de
Cc: daniel.kiper@oracle.com
Cc: nivedita@alum.mit.edu
Cc: James.Bottomley@hansenpartnership.com

Ard Biesheuvel (3):
  efi/x86: Use symbolic constants in PE header instead of bare numbers
  efi/libstub: Introduce symbolic constants for the stub major/minor
    version
  efi: Bump the Linux EFI stub major version number to #1

 arch/arm/boot/compressed/efi-header.S |  4 +-
 arch/arm64/kernel/efi-header.S        |  4 +-
 arch/x86/boot/header.S                | 64 ++++++++++----------
 include/linux/pe.h                    | 21 +++++++
 4 files changed, 58 insertions(+), 35 deletions(-)

-- 
2.17.1

