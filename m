Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779444E62C0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 12:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347696AbiCXL40 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiCXL4Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 07:56:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4F1ADAD
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:54:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so5169874wrc.0
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIfAgUFlQuuXkU1fEu/zVHtHcFjwIMuJbdKlY7p+oOQ=;
        b=mLly/YqVCxPLAJbooavjHV5mjXFaM/LxoLnG6gn2jf4dQkFUxhvFC0SoZ+TDZB2UDq
         HOlJ1H5dTfPFL/pjjoQxwDQIKblrolKef/4YvHw+q6jK+VgabdQ7Quvkz0R7wNmKlIfO
         Pa4G1X1L/wgejr1+fCojmWddwOqOIMUFDCWmMy7DbiVW8T2+NS5tk4DOrpXEAR/4xqVr
         3qLZaaHxwF6GSy5z++kLQ/K8Trt0FJAoTLMlG2NjtbrECOEnlv6Nv29vowexmD1gLzz2
         BSQagWAS6ZEC2uYcYrze/SBEWTt6L5lTEYXOpM2e6FYhQYa49vH5flwmqeaf+yUcSjZP
         uhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIfAgUFlQuuXkU1fEu/zVHtHcFjwIMuJbdKlY7p+oOQ=;
        b=d3q76YWmgP7CDyjeTEsdOlxiC9AwlRVgXMYp3jWyR94KorAhXPlWGbiul6zemnwnhW
         RvkEw0BDopwRvgqE1pYWYvpPjuPRydJtbBgWkhPNa2s/wtnqESkP1XkfChXLZNGgJJyE
         i4MeQZiPMflOw8pRzASndkmt2C70y/3e/O0e8Y/nnUXpugEGkR6fBR6KxbTbCu5+dZWe
         GHxIyJEevHZb40RVUa6Y7PuPEvX7DQle25pEQVmVijUnKRY+eRuwhud0VzKym+uwspWL
         SwBtKLiO3DKTopuar124YsnrfZD3mAYnj9HHeacV7yoW6ZYXsfMNIVAc+VpWfuloau8R
         WDCA==
X-Gm-Message-State: AOAM531u52z464EAMRxgYyM9Ir7ahZwq9IJJ2CsOLfgvzG7phQS3HvPd
        ebyRQ4xKqXfMZBuno7DxOf/PNg==
X-Google-Smtp-Source: ABdhPJxuJWmhZQ4LiNF2bBYCyyu4Ia+w/e4PXH2Kq0VpkzGuvh9YsYCEjwIeLKjFpDHbboX0ePbFIw==
X-Received: by 2002:a05:6000:1a85:b0:203:86bc:9816 with SMTP id f5-20020a0560001a8500b0020386bc9816mr4320729wry.67.1648122891324;
        Thu, 24 Mar 2022 04:54:51 -0700 (PDT)
Received: from localhost.localdomain ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm2543857wrf.61.2022.03.24.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:54:50 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V3 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Thu, 24 Mar 2022 17:24:37 +0530
Message-Id: <20220324115438.210390-1-sunilvl@ventanamicro.com>
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
solution of passing the boot hart ID through Device Tree, it doesn't work for
ACPI. Hence an EFI protocol protocol is recommended which works for both DT and ACPI
based platforms.

The frozen spec of this new protocol is available at
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc3/RISCV_UEFI_PROTOCOL-spec.pdf

This is tested in qemu with both u-boot and edk2.

Changes since V2:
  - Updated error message

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

