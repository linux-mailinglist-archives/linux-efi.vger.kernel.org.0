Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0888D30595E
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jan 2021 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhA0K7G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jan 2021 05:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236243AbhA0K4l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Jan 2021 05:56:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E02A420724;
        Wed, 27 Jan 2021 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611744960;
        bh=C1qjMAXf5BSKD09p22gXGcWkx9+mBWgAZ968jY++61k=;
        h=From:To:Cc:Subject:Date:From;
        b=fMkGToZpdJhNQGWtAoedxEs6aF82EqzNsnlbbA1Tei+lRGlk8MeJYdZ6cXQ21/14R
         +IwQGT80Df2lIbjjLXaAVGyM14efG09emFMXvTqa6YMbEOJvKW6bXy57gYVcL44oCW
         9c2DdfotKodHXrpcRa6kbpSMLrv2opGnFKydyFr3aEkYNUUe2vkChP386PdM3q7KIS
         cI67lK6Y5BWYmVXVQjofXP6KicdyP7y2Xa5KTgpuK/5OkZE3p4euOyDQuNP75ajwx0
         G6LcB1fkaQYYf2COkkv/1eaH73Jj4GVgVy0qa3FQtoh/MFqi3w0dG1JvQ82wIYv8yd
         nazYn4fSVC+bQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fix for v5.11
Date:   Wed, 27 Jan 2021 11:55:53 +0100
Message-Id: <20210127105553.37741-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.11

for you to fetch changes up to 355845b738e76445c8522802552146d96cb4afa7:

  efi/apple-properties: Reinstate support for boolean properties (2020-12-31 10:28:53 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
A single EFI fix from Lukas:

- handle boolean device properties imported from Apple firmware
  correctly.

----------------------------------------------------------------
Lukas Wunner (1):
      efi/apple-properties: Reinstate support for boolean properties

 drivers/firmware/efi/apple-properties.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
