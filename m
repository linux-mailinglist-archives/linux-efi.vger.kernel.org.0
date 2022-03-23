Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186634E4A7F
	for <lists+linux-efi@lfdr.de>; Wed, 23 Mar 2022 02:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiCWBdy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Mar 2022 21:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiCWBdw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Mar 2022 21:33:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849176FA16
        for <linux-efi@vger.kernel.org>; Tue, 22 Mar 2022 18:32:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j13so187941plj.8
        for <linux-efi@vger.kernel.org>; Tue, 22 Mar 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1tdwMzgNU3+9ty6xkH9fMGGweeCwRgg1Dr+d/9eH3Qc=;
        b=Gb0kqmLT129jUYWppYcf+O0ptJfQ1chsmf0FWqDF33rRzHXnu9VU00lf82mCBhvMOT
         xEjT2gr2VnGPjBV+knw3swrECBoiOXP+IaNN3IZCyRh3fJbtolZLh24hhLZODv+yUM2N
         GFIiTiqXmm3LkBcYok5oDYtJXWYgk85zciH63XgxqfYUs5VWqb539wKbEnisMMJ9+fHX
         0fpcq6O1OMroRA0Ug9+nYbNeuaQKWOsm5Ke7a379DYXWXP67n6eeVB/IwCE/MNv+nWaK
         XUQCZ/XpQoF/T20F+m22W61xy9jzoFz/4ky/GkBcnOn9Lcp1py6ktikn1QFU79g7Rza4
         I0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1tdwMzgNU3+9ty6xkH9fMGGweeCwRgg1Dr+d/9eH3Qc=;
        b=j+VozCmBppt1/Vvxl8H1BS+m6kaWkdgOAalRZjiBfJOYjcQps0cFVTDPNIm2XI0OMm
         mhbrEbZ62xi6pfwNbruom5KRTsimAUVUVCiWgwlD/eUAVOZL1bNipfzms8oq3OzE8ii8
         KNyV8Mipt0aukHrUfzis/sCAxLP3ZTDfGIhEFvY6ce3bhvaSVEMlV4GZse7EPn+ao9hb
         jM8Pj/3L8vDRaovkqVcCgUreqlxe7C4LcZpJomKxIQmnNteLcOC7fFO2fC25/6Wou7O1
         2msnJMH5/dc9fS+xSbKwUHyCbxA0GAOr7b3WgBzHk9uOEt/1aLLJ1ZrN3qhlisob9DX1
         E9Jg==
X-Gm-Message-State: AOAM531rHPi7WlXPIAznNZ1A0WNxY6Hk/EevPbL0utpMcBRV1eU6TuFK
        IO/a2c0fiYf7H/mNFcFUETzjEQ==
X-Google-Smtp-Source: ABdhPJwy3tsZpMmtKAa8Z+PP3YAuWnFssj1dAbdwrL7GGL/i9W4P1ajH89rZtTfBAzTSrLgBPMJwkg==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr17771357plr.3.1647999142958;
        Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm24433562pfu.120.2022.03.22.18.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 18:32:18 PDT (-0700)
Subject:     Re: [RFC PATCH V2 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
In-Reply-To: <20220303145944.307321-1-sunilvl@ventanamicro.com>
CC:     ardb@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        abner.chang@hpe.com, jrtc27@jrtc27.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sunilvl@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-5eb23850-e2a9-43d3-8093-2f588c71de00@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 03 Mar 2022 06:59:43 PST (-0800), sunilvl@ventanamicro.com wrote:
> This patch adds support for getting the boot hart ID using new
> RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
> solution of passing the boot hart ID through Device Tree, it doesn't work
> for ACPI. Hence an EFI protocol protocol is recommended which works for
> both DT and ACPI based platforms.
>
> The latest draft spec of this new protocol is available at
> https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf

This looks fine to me, but we need the spec folk to commit to this being 
a stable interface before we can start using it.  Historically that's 
been "frozen" for RISC-V specs, but I'm not sure how that all fits 
together in EFI land as IIUC we also have to follow the UEFI forum's 
process.  Last I checked you guys understood that better than I did, so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # pending spec freeze

I had a minor comment about the error message, as well.

Thanks!

> This linux ptach can be found in:
> riscv_boot_protocol_rfc_v2 branch at
> https://github.com/vlsunil/linux.git
>
> This is tested in qemu with u-boot 2022.04.rc3.
>
> Changes since V1:
>   - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
>     patch
>   - Removed mixed_mode member
>   - Separated return value and status.
>
> Sunil V L (1):
>   riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
>
>  drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
>  drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
>  include/linux/efi.h                       |  1 +
>  3 files changed, 32 insertions(+), 5 deletions(-)
