Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08F473BDC
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 05:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhLNECS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 23:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhLNECS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 23:02:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B528C061574;
        Mon, 13 Dec 2021 20:02:18 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id l18so11601195pgj.9;
        Mon, 13 Dec 2021 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zISpoeMYICSaiB4z3xpc+ADTtV+w5l/Wcvj8K92an1Q=;
        b=fOqWBwX4Ya5XyCZzaaBzTzljxNwku+K+9af64cJDBtK0Ia414R1J4yxCvKUBvwT5Iz
         PMxg4Y1527qeFaFdhl2g8jaJXrSmwSqQ2w/RQLyEWEHxvpTtAIlsEcitIFywIXLPZH2G
         mXg20SK7hXXmIoNX41g/o2Pyppp0vdVTnxTXbdBRE2JxWGG2tNTOh64aZugLbKM7NPKM
         KUUi60cIrX6RKy1H0mansL6x1kVQ6ymtkm7zeT0IaB1eXuEtsJuKoEHHNqC26+Y1t5y/
         /mWh2OS1cIX4CRBSFSLefpK96fJjQp4bD5MUIUGonOcjnq8bvQcjMQdpUac45mrNYLRq
         3Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zISpoeMYICSaiB4z3xpc+ADTtV+w5l/Wcvj8K92an1Q=;
        b=EqGAU8PA4xgLc2eTGNwCIP936aKPIX+zN9Y/8iMJ6WiVtplUElOIaf8PCFGse8qd7j
         pxW6A5HAjxhZjZ8YCQTovshgOGQ+dCn1BHRHR2KMe499Pog03IQgWI/wI8ApsnFI7y9j
         95qzBwg7PBU3/Q/Hyuxsb8R2sRwETVOQLWu2sIGMJtkq2577WrrBvj51QwLT3tRBfIkp
         TDvZKOkWx/I2iWPV9fZauzHQWcyevFglNRNgxx+xLwoyNVqDMls1v8aZnA6cXvRvmSNG
         pbAXxc8RF/8I5dEK4V/seDE799f/4AElVos7qxUV55zRtyF8zlzyTKOb9Qf+BJCzxvQP
         goZg==
X-Gm-Message-State: AOAM533zPUN/3XItNIFWlrPo1ZuVSKM1vRRWClnplEN5ycwe4ynWKK19
        2GZHsvqYlvBpbOazntpcp5bUMVzykA==
X-Google-Smtp-Source: ABdhPJwLheIuYYNyneG8TfzZgX+skEctf9nWg/fJIOTO1QqJZwxV7AATQAqAvTBRL8LGIOZX7Qrj0Q==
X-Received: by 2002:a63:fa17:: with SMTP id y23mr2098027pgh.400.1639454536648;
        Mon, 13 Dec 2021 20:02:16 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v63sm11538777pgv.71.2021.12.13.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:02:16 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     devicetree@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 0/2] arm64: fdt: fix membock add/cap ordering
Date:   Tue, 14 Dec 2021 12:01:55 +0800
Message-Id: <20211214040157.27443-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In fact, V2 tackles this issue at efi_init() for both arm64 and risc-v.

Since in Zhen Lei's series "[PATCH v17 00/10] support reserving
crashkernel above 4G on arm64 kdump", [8/10] is self-standing and
meaningful. I abstract and utilize it.

I make a small change in it in order to use
early_init_dt_check_for_usable_mem_range() outside of/fdt.
(Cc: Zhen, please let me know if it is not fine for you.)

So finally these two patches can be applied as candidates for
Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")

[1]: https://lore.kernel.org/all/20211210065533.2023-9-thunder.leizhen@huawei.com/

v1 -> v2:
  Adopt Rob's suggestion to call
early_init_dt_check_for_usable_mem_range() from efi_init()

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-arm-kernel@lists.infradead.org
To: devicetree@vger.kernel.org
To: linux-efi@vger.kernel.org


Pingfan Liu (1):
  efi: apply memblock cap after memblock_add()

Zhen Lei (1):
  of: fdt: Aggregate the processing of "linux,usable-memory-range"

 drivers/firmware/efi/efi-init.c |  7 +++++++
 drivers/of/fdt.c                | 18 +++++++++++++-----
 include/linux/of_fdt.h          |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.31.1

