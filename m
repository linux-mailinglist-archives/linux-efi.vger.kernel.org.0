Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698D2164BB5
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSRTc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRTc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:32 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9583420801;
        Wed, 19 Feb 2020 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132771;
        bh=IId9tFtmAQIViFoahhM+vjHsH6D75y3Dzt08ogv9os0=;
        h=From:To:Cc:Subject:Date:From;
        b=D+lETJ/A4PT06Mq0D2z8VItX6k5wxoaSwby+MQpY7Po3JxMHYxc/JKZNu633ebmwG
         kJFFS7iH+sTxB1i+vqNkR3ynU2LiSiMFEhO79sZwfkSliOOjGZVXmUCA752Xb28Ds4
         1N+Ncrh8rgLuf1pzeDhXsNopCUVD+vNpSfgGKWqI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org
Subject: [PATCH 0/9] efi: implement support for EFI RT properties table
Date:   Wed, 19 Feb 2020 18:18:58 +0100
Message-Id: <20200219171907.11894-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI spec version 2.8 errata A defines a configuration table called
EFI_RT_PROPERTIES_TABLE that carries a mask describing which EFI runtime
services are still functional at OS runtime.

Even though any runtime services that cease to be functional when exiting
boot services are still required to return EFI_UNSUPPORTED when called by
the OS, having this mask is helpful, since we can use it to prevent modules
like efi-rtc or efivars from loading, instead of allowing them to probe and
fail with an error.

So let's wire this up: make some room in struct efi for the mask, read it
from the EFI_RT_PROPERTIES_TABLE if available, and replace various instances
of 'if (efi_enabled(EFI_RUNTIME_SERVICES))' with checks for the runtime
service in question that the code relies upon.

Cc: Leif Lindholm <leif@nuviainc.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeff Brasen <jbrasen@nvidia.com>
Cc: Atish Patra <Atish.Patra@wdc.com>
Cc: x86@kernel.org

Ard Biesheuvel (9):
  efi: store mask of supported runtime services in struct efi
  efi: add support for EFI_RT_PROPERTIES table
  efi: use more granular check for availability for variable services
  efi: register EFI rtc platform device only when available
  infiniband: hfi1: use EFI GetVariable only when available
  scsi: iscsi: use EFI GetVariable only when available
  efi: use EFI ResetSystem only when available
  x86/ima: use EFI GetVariable only when available
  integrity: check properly whether EFI GetVariable() is available

 arch/x86/kernel/ima_arch.c                    |  2 +-
 drivers/firmware/efi/efi-pstore.c             |  2 +-
 drivers/firmware/efi/efi.c                    | 70 +++++++++++--------
 drivers/firmware/efi/efivars.c                |  2 +-
 drivers/firmware/efi/reboot.c                 |  4 +-
 drivers/infiniband/hw/hfi1/efivar.c           |  2 +-
 drivers/rtc/Makefile                          |  4 --
 drivers/rtc/rtc-efi-platform.c                | 35 ----------
 drivers/scsi/isci/init.c                      |  2 +-
 fs/efivarfs/super.c                           |  2 +-
 include/linux/efi.h                           | 40 +++++++++++
 security/integrity/platform_certs/load_uefi.c |  2 +-
 12 files changed, 89 insertions(+), 78 deletions(-)
 delete mode 100644 drivers/rtc/rtc-efi-platform.c

-- 
2.17.1

