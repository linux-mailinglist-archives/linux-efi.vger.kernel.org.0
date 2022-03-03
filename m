Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF04CC084
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 16:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiCCPAt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiCCPAp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 10:00:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF52DF495
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 06:59:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so4895686wmq.4
        for <linux-efi@vger.kernel.org>; Thu, 03 Mar 2022 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyZKtms3/fooY346YEFh4aDUln7VR4f3ZkWUMV+VfiY=;
        b=XoZI7nJBCKEM9JhyOj4+4Q/Ee/yq2th4jAnz/UhBWAKDEgTrbUkfdcxKDciB6eEhjC
         eu1hktSPl2tRO0qnypW8sk7nLauSF373ejLjGCvkInaDqIkg8mTY8BOO0SbsT19/BQE8
         FU24TDNc2ZrpGUMsktjKuOK6lRIqhUtV4r4tniYIIPW/fYzB+c9YvQK3ouion6eS/abr
         dcu5rUaZ6s2dWGZ4ZbaVtabVYr1ASu4BeEA8hiVMqCVbcERpTZOxGCHrMksDLSSRL2eX
         VzrlPgWl6ukUwfM+NF0fwROCvjlq/g3LVy9wr/qzTzkRy26qkAIUi27HY72ND5MxX4Qi
         ir/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyZKtms3/fooY346YEFh4aDUln7VR4f3ZkWUMV+VfiY=;
        b=syzRT/lBUgqQvwutAPoJRb7zxMaWSwYYGCg6WBktKLc5o7aw0N+YPXR0AzhU2ehibk
         OK+Rh/qGOIJSIIie9bbPPW1mJelGUHh3eLgv3GFzEiRjkB0xnfeiT1st1xydTRz0Vdr6
         rq/17/ceI6J100XUHouS/4qMvj/PVofyzYjDBArKX6Hxq/CvuUiZAXSc7YD4iwaelqrm
         zxHqaeizwD03aG8bof4Oui/kBkJzce5TE5TteaeGWUgVT07ik9EB+VnppMmx9V38sKow
         lTZg9Mw3CuQ+spVjQm5pnjCzRz2+HHc/WGLXM/wIiiVLL/apIbDLT8XGFucoALVy6QM2
         1CVQ==
X-Gm-Message-State: AOAM530nyujvaiuRDLKoDBz23heHLAPlKGnBUXT7Z/kEfRIm4zbKq9wn
        AEnvKUxxZT2KVSk9tYNMZ5DA2g==
X-Google-Smtp-Source: ABdhPJyNhPVn3ujz+yed9ZU8ZsVBArmJ+s8GAWfDmrjEO7NKWveEpuqL/2TcQKekRcVES9Tf/1cDog==
X-Received: by 2002:a05:600c:1c25:b0:380:d306:1058 with SMTP id j37-20020a05600c1c2500b00380d3061058mr4125847wms.150.1646319598144;
        Thu, 03 Mar 2022 06:59:58 -0800 (PST)
Received: from localhost.localdomain ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d522f000000b001e85b14dadcsm2224166wra.5.2022.03.03.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:59:57 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH V2 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Thu,  3 Mar 2022 20:29:43 +0530
Message-Id: <20220303145944.307321-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds support for getting the boot hart ID using new
RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
solution of passing the boot hart ID through Device Tree, it doesn't work
for ACPI. Hence an EFI protocol protocol is recommended which works for
both DT and ACPI based platforms.

The latest draft spec of this new protocol is available at
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf

This linux ptach can be found in:
riscv_boot_protocol_rfc_v2 branch at
https://github.com/vlsunil/linux.git

This is tested in qemu with u-boot 2022.04.rc3.

Changes since V1:
  - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
    patch
  - Removed mixed_mode member
  - Separated return value and status.

Sunil V L (1):
  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
 include/linux/efi.h                       |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.25.1

