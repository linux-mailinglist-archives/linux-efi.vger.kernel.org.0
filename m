Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347BC75CA4E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGUOmc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGUOmX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 10:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B330C4;
        Fri, 21 Jul 2023 07:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696CF61CBC;
        Fri, 21 Jul 2023 14:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0012C433C8;
        Fri, 21 Jul 2023 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950541;
        bh=vnKpGnxn8zUuKVtm2tFTj9MMIfa7Z34OzWEeyPxSowA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aqZrGQG4Xfno3udd5lvA7e9qj/WsOKad6KDELNXlUmoTSNUitZWMPNe5yENbKej7a
         /zO2jJCGbFFLtGCqLpuSiHJ09Xf/52xhyrEu/jy65+9+VsPmFZ5MAiCE3wC0+RzaHE
         OTwF/qqsrcTXjzF5229HVjh1d3/RtfKnp/mUJXGW5s/YrHavgCClKLuQLpWlNtHVqZ
         iACOXE8zEKevzLUJ/EDcZt9u7MikFaWDAsbYRmYBlEqAFipRO64VquByrXOz0w4TtM
         KFoblSMUeS6EiuKYUZC07IKIeoHP4hIyOCp183w8SIXJZmOc56OE1NzZh6GJp4LwIT
         bOLRuYTu2Plrw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3296060e87.1;
        Fri, 21 Jul 2023 07:42:21 -0700 (PDT)
X-Gm-Message-State: ABy/qLaKGLm3rYU3yV9BBszUdPiQSzBexRQn+czyAaFD+B4lXSIlI5bZ
        XC9VgvYjcJTdk68f+Y/5BUh+wIyJPpfSw5YhrE0=
X-Google-Smtp-Source: APBJJlFHpbtWUUSy2IGbyF1VU7MiOIsifP1VVHGSRYzs5vsiWHm+ULfddPC0zE3Oc2YFecvdrkMowBP8X6H96jYS/AE=
X-Received: by 2002:a05:6512:2036:b0:4f6:d7b:2f19 with SMTP id
 s22-20020a056512203600b004f60d7b2f19mr1436368lfs.24.1689950539887; Fri, 21
 Jul 2023 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230721074850.310644-1-alexghiti@rivosinc.com> <20230721074850.310644-5-alexghiti@rivosinc.com>
In-Reply-To: <20230721074850.310644-5-alexghiti@rivosinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Jul 2023 16:42:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF30WyFccj7uNTrf4YzndyaB8uL5PTQwJp8ADY-MTLTsQ@mail.gmail.com>
Message-ID: <CAMj1kXF30WyFccj7uNTrf4YzndyaB8uL5PTQwJp8ADY-MTLTsQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] libstub: Fix compilation warning for rv32
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Jul 2023 at 09:52, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> Fix the following warning which appears when compiled for rv32 by using
> unsigned long type instead of u64.
>
> ../drivers/firmware/efi/libstub/efi-stub-helper.c: In function 'efi_kaslr_relocate_kernel':
> ../drivers/firmware/efi/libstub/efi-stub-helper.c:846:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   846 |                            (u64)_end < EFI_ALLOC_LIMIT) {
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

For all I care, you can just squash this into the previous patch as well.

> ---
>  drivers/firmware/efi/libstub/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
> index be0c8ab0982a..afb857329799 100644
> --- a/drivers/firmware/efi/libstub/kaslr.c
> +++ b/drivers/firmware/efi/libstub/kaslr.c
> @@ -130,7 +130,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
>                 if (!check_image_region(*image_addr, kernel_memsize)) {
>                         efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
>                 } else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> -                          (u64)_end < EFI_ALLOC_LIMIT) {
> +                          (unsigned long)_end < EFI_ALLOC_LIMIT) {
>                         /*
>                          * Just execute from wherever we were loaded by the
>                          * UEFI PE/COFF loader if the placement is suitable.
> --
> 2.39.2
>
