Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102D52CB6D
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiESFPX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 01:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiESFPW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 01:15:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EC994D0
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 22:15:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r71so4114472pgr.0
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FnRdlHrEla6Dyd7Er3np/FEhy1piZaEXssJQV5c0vBg=;
        b=X7PIGUbjsnX+9thxa6uAkZM4MwFqyfuO4+IGUv2xRCyk5KRtzRZXdWCZ/en+OvmeqJ
         GfV655FXoVrgKNk6QgccY0PhQvGiTmcaWuXE/KRNvfc984v2kPu1yCJOXvWzchYyx6PB
         mhZ+1pMW0w3QdGDGh5Be9vxSsEwiRrn6rcffLyQv/68t++moJQZ86Mv9QD8YlP094BVq
         PO48tBY1ruxvX0shzKumY9T4woWYVg/co4PnQ5yycMkyiCujBG6b3vF1EdIuCXTZ1BJf
         Z0z5dIcQfRyVOgxgGeAnDP8BHaIzCS0UbXRKpervsgpiTzCvLb7ZYq8MuAHoOmObxp4m
         CK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FnRdlHrEla6Dyd7Er3np/FEhy1piZaEXssJQV5c0vBg=;
        b=s6tnNEPBK2UCshtIVgSyMC58BBJKQVSjg7trtlWN4HMW/7+F3yfyXrc8Te2BPFPcyJ
         YQByQ9zqSM8/Uj8pVS1rpLTXEltwnhsdsiestNnb2NJdNsV+aqiVn5XKYoPQ10QIIsWj
         vBRWUDkItG18BVhrct6vgZwwaWzlmGoe7TZpY/wc5OxPJ6WUqYqirOwA1UJrmmMpxtbO
         6qsoLynpfVxMCExxKgdM3DdaP/lApq5/eqKoVSyoOUajnq3BMFI3flwzg/gt6HkHHJ14
         SCsvDinovFLvy/LpSClP26my8w2IiY6GIP7eBAhpy2iwNdzWoa7s/uYy+KAvrWZw346w
         W85g==
X-Gm-Message-State: AOAM531LPTDiLwnplb4tV926Q1hP3i6ZOIZY6UKHyUNP9/fSpUlZrXcW
        yW0BKlyMArEA46PQOzX8gASQCg==
X-Google-Smtp-Source: ABdhPJyfsA7vHd6Skw4UKaV0vjCh4Vet52VObBCGk1xXZ8PdZ5VGQsKj41jCUnIXPgWRqs2DXVr8lw==
X-Received: by 2002:a05:6a00:24c1:b0:50d:33cf:811f with SMTP id d1-20020a056a0024c100b0050d33cf811fmr3177502pfv.78.1652937321167;
        Wed, 18 May 2022 22:15:21 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.10.235])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00235300b0050dc76281a3sm2929007pfj.125.2022.05.18.22.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 22:15:20 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sunil V L <sunil.vl@gmail.com>
Subject: [PATCH V5 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Thu, 19 May 2022 10:45:11 +0530
Message-Id: <20220519051512.136724-1-sunilvl@ventanamicro.com>
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
ACPI. Hence an EFI protocol protocol is recommended which works for both DT
and ACPI based platforms.

The spec of this new protocol post public review (Ratification-ready) is
available at:
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0.0/RISCV_UEFI_PROTOCOL-spec.pdf

This is tested in qemu with both u-boot and edk2.

Changes since V4:
  - Changed data type of hartid to unsigned long
  - Updated jump_kernel_func() to take unsigned long for hartid

Changes since V3:
  - Rebased, no code changes.
  - cover letter updated with link to spec version after public review

Changes since V2:
  - Updated error message

Changes since V1:
  - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
    patch
  - Removed mixed_mode member
  - Separated return value and status.

Sunil V L (1):
  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 drivers/firmware/efi/libstub/efistub.h    |  7 +++++
 drivers/firmware/efi/libstub/riscv-stub.c | 31 ++++++++++++++++++-----
 include/linux/efi.h                       |  1 +
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.25.1

