Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0909118318
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLJJKC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 04:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLJJKC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Dec 2019 04:10:02 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F1E2073B;
        Tue, 10 Dec 2019 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575969002;
        bh=Qctr8HIQnkvJiRTSy7Zh1Yobn98pvpQLUdiwXsbTTG4=;
        h=From:To:Cc:Subject:Date:From;
        b=RzJZYobFhmU8319DmaxAyhUIfIU57jH6OE0svbr9IY1Zl2QwcereuxxzWTlAH3npn
         9To1nU9eZq4WBPd9RkehGAyXaYHmgSiRjRyVlotbUiE6+tCfhAv6ZZ5OYfLW7W6KoQ
         Hw+8zKYnQqWWoDxgUQ5MJHTov6ujqiNmSGI+E6qg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Richard Narron <comet.berkeley@gmail.com>
Subject: [GIT PULL 0/1] EFI fix for v5.5
Date:   Tue, 10 Dec 2019 10:09:44 +0100
Message-Id: <20191210090945.11501-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit b418d660bb9798d2249ac6a46c844389ef50b6a5:

  efi/earlycon: Remap entire framebuffer after page initialization (2019-12-08 12:42:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to e943a5491f445c0d39ec69e897eb1fd180d09ffd:

  efi: don't attempt to map RCI2 config table if it doesn't exist (2019-12-10 10:08:24 +0100)

----------------------------------------------------------------
Another EFI fix for the v5.5 cycle:
- Avoid dereferencing the RCI2 configuration table address if it hasn't
  been assigned.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: don't attempt to map RCI2 config table if it doesn't exist

 drivers/firmware/efi/rci2-table.c | 3 +++
 1 file changed, 3 insertions(+)
