Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1342326D51B
	for <lists+linux-efi@lfdr.de>; Thu, 17 Sep 2020 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIQHt1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 03:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgIQHtM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Sep 2020 03:49:12 -0400
Received: from e123331-lin.nice.arm.com (unknown [91.140.120.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C3921D41;
        Thu, 17 Sep 2020 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600328952;
        bh=ESzv/yznbo3osqOliFruv56tCFJ4lz5ErMjvAhhJBXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pekohuTImsOB47B8pOQJccupMwaipWXrJOX4zHSDN7lFHjkcFOz1OEDCtIyLItcLg
         YhfBNz/gBI0IQIYih0ITWaghLyd8TJy9eGE5Nn3WOdSbXINEvmEP3JYtaX4hYmMsug
         rG1ZtzWOgKUS070++CEB0zhXf3IEnMRBuAUEqybs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.9-rc5
Date:   Thu, 17 Sep 2020 10:49:04 +0300
Message-Id: <20200917074904.15816-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074904.15816-1-ardb@kernel.org>
References: <20200917074904.15816-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit fb1201aececc59990b75ef59fca93ae4aa1e1444:

  Documentation: efi: remove description of efi=old_map (2020-08-20 11:18:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.9-rc5

for you to fetch changes up to 46908326c6b801201f1e46f5ed0db6e85bef74ae:

  efi: efibc: check for efivars write capability (2020-09-15 18:22:47 +0300)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
Single EFI fix for v5.9-rc:
- ensure that the EFI bootloader control module only probes successfully
  on systems that support the EFI SetVariable runtime service

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: efibc: check for efivars write capability

 drivers/firmware/efi/efibc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
