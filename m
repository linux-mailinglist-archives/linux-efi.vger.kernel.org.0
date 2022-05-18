Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5752352B6FD
	for <lists+linux-efi@lfdr.de>; Wed, 18 May 2022 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiERJ5R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 May 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiERJ5O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 May 2022 05:57:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC73220C7
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 02:57:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so1288789plk.8
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMWRi+RpI9EfHgaGzmTuiTtwswTwktoLVmDlPpJXLGU=;
        b=SmxAwuuNLFsiav9NwR2VOJpmtshTgs5aNMEFFJZ8HerwonyaiDij7y0KGmWgsyUi8X
         EUvzwoqx30XPI0/fzQzShC9WWLRAQQIvdkmPzLU32Wr8naGZaam1WFdZ9wQYMGFOCM3P
         jgwooWAuyvvHjIsksux4ebr0J//bjQOWWL+K2jZmwwQEM0Nu4MvZPNoYm6rmYa6W+rJp
         msoRwvH/cnc92HDQuzvE5kt1fXp8YbSS/a1PG6GnvAtqur1ZBKgtWaE15OPYcqFxdpnZ
         JOYsl95QMBCLFMUxdAAscbDKHSEQI5IB79PACZfBGgKR76E4Y9B5Bwd1RWRrukx6s6zu
         dorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMWRi+RpI9EfHgaGzmTuiTtwswTwktoLVmDlPpJXLGU=;
        b=yhw73KqsHLNq6UnbBPeiW31aHxb8htjEnu42ixHiReNrzM3JpiEOhFV/453qdOQq3v
         SBoVQhTSKCqb3Z2AOUytJIhX/OQllS3fgPGFG/RBzJm7NEj6iwRoRlirfkHXPXnHJcd+
         2wSIuPI0fuvmcoJTCUwsbkMyXr9EH7mKSJ0MgihpUMSblFl1GWgdpaW3kVf2/kt7rSaS
         sYsrofmCTBFnoF0i/tQ6+LGSsOpY5YTeTtPxF9Hu326bxFjrQz3n0TKwe6s4ucdVr9i9
         /r9LuR7hEBCIKQjHRiAB2TSP07Yi27chrJKdmA3wup3lxBEUvpcGE176X4wdTbl2mJFe
         7Lsg==
X-Gm-Message-State: AOAM530cyg0chE9rD+B/q2MtzFmVUsHcLZVbBR0mdrgH/2ViP7fCDAj3
        AcnPW4Ly2ebzszdKzNdo1kQdIA==
X-Google-Smtp-Source: ABdhPJyWK9OF1+2sLxkdi1qFTTZkvoplqztdXWVshfSufuv9hZdvKNjmq6vjPPaR08Ib/BCSnHlFDw==
X-Received: by 2002:a17:90a:aa8c:b0:1df:359a:1452 with SMTP id l12-20020a17090aaa8c00b001df359a1452mr18932511pjq.75.1652867829760;
        Wed, 18 May 2022 02:57:09 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b0015e8d4eb1b7sm1258252plk.1.2022.05.18.02.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:57:09 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V4 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Wed, 18 May 2022 15:26:45 +0530
Message-Id: <20220518095646.47548-1-sunilvl@ventanamicro.com>
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

 drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
 include/linux/efi.h                       |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.25.1

