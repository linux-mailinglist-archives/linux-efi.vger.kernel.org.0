Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50DB42D87E
	for <lists+linux-efi@lfdr.de>; Thu, 14 Oct 2021 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJNLtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Oct 2021 07:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhJNLtB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Oct 2021 07:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8DAC61156;
        Thu, 14 Oct 2021 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634212016;
        bh=srBNtehJ1ZVjQvxvJKiS3sP7kLbTPCUUcXn1ti4ntr0=;
        h=From:To:Cc:Subject:Date:From;
        b=qk+SpapDc+G19WF8wXGtHUKpBZU+MF9KZqbTJmVnf7bsRKdeoixpjaW42gB4qZTWy
         dWO2ENuWKD7g8oPjfELoRFeyG9Vc6tLhBaVEu1GsRhaYK+Q4nOFBlSxrBfBv2JiCxY
         yepjOPVnfK56e8mCfYWCcdKTgeDOJAa51yU4Ljwg5IYDM2iuMXkGGdD8V97UhthaV4
         Rh/HH5Lki8XvjQog8xJubJxKiu63niVTuuq7Uyyuh/Ml215GknR9yDaDjWBIAWChV5
         f9uZ05nXqP1QH9RmaRy5QzUKl5F4jyS/kJCzMILpL8ZFC8bNQoYfTvHir95/slpd1M
         oh5GMu3wGwHkg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.15
Date:   Thu, 14 Oct 2021 13:46:42 +0200
Message-Id: <20211014114643.2232141-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; h=from:subject; bh=srBNtehJ1ZVjQvxvJKiS3sP7kLbTPCUUcXn1ti4ntr0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhaBigE9GzRbtd7GOIRL1wdZU8bC+7ZgDdv9pbXqA9 /PryttmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWgYoAAKCRDDTyI5ktmPJOWzDA CCSvyNymcv2Rf8FOnfjZc7arQhVwgbixYmFaRN1jcgxsSkgJGExmA2HnqY5z0B63/QUVHBaACiExgX FTuUdjHPOPwigYZTVWNPJOv5npv9Wk/0Xhs+/MvFCXYGGARgT6/aXscAkOnX6d4Cb3B1EyovEI8+2I MajuwU9jP6bGROnRkH/HtPUbdcT8FxOSQU4L5RYXMZmB6od4iue80vWiy+UCV+nTxCxCVFzvDNYl9A AjFF79/Y/KUWJ/luaBNRDo6bDXsFx5v446LVhnIyE7NoJ882L1kQEaJUfJeWetJCLiOBtwWVhvmAO/ +ppnq09um77n8FmQPWu9mOfLWotvF3oFC+cogNVX5se1ZJIKPTwDZdFwXi05p2iHL33jo7hKG6QcAW YQdWCGGCdDgIULWtHxGQ64uW4nqb03mMdjBqqn5lFNRT0NeN6O5eWxKuZxTo7+w/8gNQI366Q2U1oN w4G32MlJgKb5chJyH6PqO47sW6bJAnX0k3h6TT8jc7T8I=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.15

for you to fetch changes up to 38fa3206bf441911258e5001ac8b6738693f8d82:

  efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock() (2021-10-05 13:07:01 +0200)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fixes for v5.15

Low priority fixes but fixes nonetheless:
- update stub diagnostic print that is no longer accurate
- avoid statically allocated buffer for CPER error record decoding
- avoid sleeping on the efi_runtime semaphore when calling the
  ResetSystem EFI runtime service

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Heinrich Schuchardt (1):
      efi/libstub: Simplify "Exiting bootservices" message

Zhang Jianhua (1):
      efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock()

 drivers/firmware/efi/cper.c             | 4 ++--
 drivers/firmware/efi/libstub/fdt.c      | 2 +-
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
