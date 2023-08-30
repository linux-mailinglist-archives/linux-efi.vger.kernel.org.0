Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0EB78E17E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbjH3Vco (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjH3Vcm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 17:32:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA2CEE
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 14:32:14 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64a5f9a165eso1144466d6.1
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693431068; x=1694035868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrR3h31lbTk9xkTFf3cxnvH3CTKI0f+A5tILf14Z9rU=;
        b=gamCyvBVEajnCc8WkAh2xdKXgoOS/4ApS7ZU/ieo26ezcxY6beKXdYbnMcMgbbZfEQ
         ydTsO9EFzap/O57r2WUGilMJpUkWxD+pCRFLryMa/1Y6+tumhBxfMBlwWYQ9lpVOpRpm
         0OtwUVsxanYVv5WUAy9OSx+lD4siOBKztNCj5Ew36gjeR57om9TNbGxH+DuVfsE0AAnf
         UQXp9BWNK903VhDz/cgTjIyFXXh/jUq0otCd8srVcMFS00vhRscObUgZ30P6x6Xm3zoU
         rcqKqEkI2f25oosahcSR5eXN/CI11Pn78kfdOuTRTzgMLzxRQg3UwLAu3itbGOvJX4oL
         5aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431068; x=1694035868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrR3h31lbTk9xkTFf3cxnvH3CTKI0f+A5tILf14Z9rU=;
        b=CPofoPMvRPmK/3N+wVt3yFJNk1aS13iMfged4O8ZmBNg+sPT3MPHs/HwsK5DH21leL
         oZIfrd/f2uF7VKJWZ6JBk6QSgipaQFbbFrHrT6vKLtuy5fn9s2d591kEsOOLEbrOAIHQ
         uRvnmgX3ULvjC4YUgeKKyEz3e59fY98lx2Tl4b+2LDHqwKxL5WOek3LnDa6tefajClXM
         nzh0Bnu3Kq+d7gQFxeeLz6pPW6JDxUXrim/s9+U2T9j71SrgXHDtc9Ep4cY3jMFrTNSW
         r+OnFkrSQmhfth0lcOYpoYLN6Sh05i1K5slO6KPCxb65msDuoA8CUGsXZh27l73hboYk
         6i5A==
X-Gm-Message-State: AOJu0Yw/B3MIesWO21H6Zq/Dd/Fb1FcxjH2G48gtkJ4GWC7cjcLylbQT
        uSJn7eL+IOR8a3HfbL2aeFw5kpbBV/5bZLWj/hQWcQ==
X-Google-Smtp-Source: AGHT+IGrjJEwv2qzVN9QCDg++IKj/hIoaTc9P6YamyZpMeXxSw8x87Z+YFRb68fzXttUiOA1D22LxFIYohGyo3SEQJU=
X-Received: by 2002:a0c:cc13:0:b0:641:8ba9:68ab with SMTP id
 r19-20020a0ccc13000000b006418ba968abmr1039748qvk.42.1693431068402; Wed, 30
 Aug 2023 14:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Aug 2023 14:30:31 -0700
Message-ID: <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Alexandre,

On Sat, Jul 22, 2023 at 5:39=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The following KASLR implementation allows to randomize the kernel mapping=
:
>
> - virtually: we expect the bootloader to provide a seed in the device-tre=
e
> - physically: only implemented in the EFI stub, it relies on the firmware=
 to
>   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementati=
on
>   hence the patch 3 factorizes KASLR related functions for riscv to take
>   advantage.
>
> The new virtual kernel location is limited by the early page table that o=
nly
> has one PUD and with the PMD alignment constraint, the kernel can only ta=
ke
> < 512 positions.
>
> base-commit-tag: v6.5-rc1

Thanks for continuing to work on this!

I reviewed the patches and the code looks correct to me. I also
applied the series on top of v6.5 and after patching qemu to provide a
kaslr-seed, I confirmed that the virtual offset appears to be random
and is printed out when I panic the machine:

# echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
[   17.510012] lkdtm: Performing direct entry PANIC
[   17.510411] Kernel panic - not syncing: dumptest
[...]
[   17.518693] Kernel Offset: 0x32c00000 from 0xffffffff80000000

For the series:
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

I didn't test the EFI bits, but the rest of the series:
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Conor, in another reply you mentioned you're planning on reviewing the
patches as well. Did you have any feedback or concerns?

Sami
