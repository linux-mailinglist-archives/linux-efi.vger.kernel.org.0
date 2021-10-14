Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829BF42D87F
	for <lists+linux-efi@lfdr.de>; Thu, 14 Oct 2021 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhJNLtG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Oct 2021 07:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhJNLtC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Oct 2021 07:49:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9D961053;
        Thu, 14 Oct 2021 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634212017;
        bh=VPG65MJlYhS3mMDv/loXZ0FsBc+EzpLBxscclg0toIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpCjQydTp0TCf5triVmjNu4HeYKz4AYrFoLB9IP1BlzJrloYim2d27kURXEBSnBIb
         VurXgdgPjQBUJF7vGlcqGO4r+igzJA4x0n5qmwvzg1tMyqL8ak1Fw33mpdAJPhmRd1
         AYJ5fHeIy0YQBQw8FJWJak899flV5hcZah2g/SA3UKy/WCOhu3Y/WIJJSGverluegr
         TpclzdfzZeaYKGpkxeDULBPTCffSvgIt46mlT/l1z4rEhzy94Mch/T5T9ChbjSqBzk
         38zUr43j2vvP4/dXlhFN5EG0aq7w98FafO0ICY1zKVCcnrjggdEQ2LI8yBxMMwd/o0
         HudSRqeWvaEZw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI updates for v5.16
Date:   Thu, 14 Oct 2021 13:46:43 +0200
Message-Id: <20211014114643.2232141-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014114643.2232141-1-ardb@kernel.org>
References: <20211014114643.2232141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; h=from:subject; bh=VPG65MJlYhS3mMDv/loXZ0FsBc+EzpLBxscclg0toIU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhaBiiNUAWFDhbO1G1DPQ6OPBp1wFtJZeimT0A71Op kH6Pu9+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWgYogAKCRDDTyI5ktmPJEHrDA CUL2X6S+Ugiaq5FIXnV6300vO9zkhZNaIKtlKq8RyRQjskX3EX0uTM7YoPNtMLapHL2F6WstEvaauj BN3M7cgoA4HEBNEhNJV0k2GRaypWp9/RvPGKxgl0DUpMqeR5kcZtZJ+iSFs5eT2G9KXG8PQ21c40Dm 1NMTLtmWNnLiCt2Fynv8GkrDAN4hf7mLctL0nywl9/lSJDlviS1F4H0MfKDtHHQLj9COXTiS1JzAbP DaGNnCRLKqTmGGHVwXY+1aNBpJNk4tjULxRYAtGmTXzzQ7aSFTYeS91kWuMWgQNG8rSOtXYqV7uD8/ Cz/z7r0zcLYYykulpzQpVW44G0czoiF7p4GakQO2cHh7Bw8IGheFBi+Mx6a8y8Gv2eHYXYoh4hZ3yg 7l2THpD88RQtO00ZRvE9bQ3sVcu6oscRzTOESgiEM9s7jiZZktBKnBQ90XY8naPoveG6Kg04+zMdHu qToTVCLbhPvXti21j6KqYIbr2S2UXdmHZDRS5Nd/62k30=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.16

for you to fetch changes up to 720dff78de360ad9742d5f438101cedcdb5dad84:

  efi: Allow efi=runtime (2021-09-28 22:44:15 +0200)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI update for v5.16

Disable EFI runtime services by default on PREEMPT_RT, while adding the
ability to re-enable them on demand by passing efi=runtime on the
command line.

----------------------------------------------------------------
Sebastian Andrzej Siewior (2):
      efi: Disable runtime services on RT
      efi: Allow efi=runtime

 drivers/firmware/efi/efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
