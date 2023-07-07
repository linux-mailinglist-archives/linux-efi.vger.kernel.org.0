Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E674AD47
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGGIo5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGIo4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 04:44:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510941FDA
        for <linux-efi@vger.kernel.org>; Fri,  7 Jul 2023 01:44:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so2567835e87.2
        for <linux-efi@vger.kernel.org>; Fri, 07 Jul 2023 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688719493; x=1691311493;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6MNmBZkZiwOWAtBo5QJa5YcHi+crvtXYiCkURW4I84=;
        b=yg3BmoXxjDcdSv5i03LxVrD3ErleVKEvveBCzB9wVppBkxmVVOo1/C1qa4vTEYwFTF
         1/ZrXF3+wXYGlpJtKaJbBOhGeZCr0InhsluSYas5tIXewsDSgpMMeUB1x8zxjo9G43x8
         McOXOwRMT2UX7LmrMR31DvkVETOarvIavhRgfje0XkaIjsf2HywbjbN5U3ThxNucHplL
         Tq+Co0K7dvqc0+2OvgBgvqiu1AKztrQDfxdlMRuk2n2IU4DagLXpLwWZ4VfSiTZ6LQ7+
         TuAFSmecXiWGzRvCTm5zHnhZbhzt1ZlXzFE4T/EqQpk4pxGlkgBg+JJ8hb/x5NvYmREC
         cfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719493; x=1691311493;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6MNmBZkZiwOWAtBo5QJa5YcHi+crvtXYiCkURW4I84=;
        b=hyTLw2jFB338jv26cHy2LESMudi66rygu54gQsUcziFOa+jgNOib8/VipnaPq1uaeG
         8NqYgpGQ/j52612xH3u1M8BfRuBWi//NsVZ3ZxTp1GBKBMSoEhEZQzqfPwo3vFO9UkBy
         fEw8+MIC3vDpUpx7qLiv8L+cIauASPa+k+ooC+QSyuBuCfwQRKlS0W1p8rL2yjp8+QXp
         rlnABRKAE9HJgNfFmRUdtRSIgiTbBMVSl2asRHwkccET6qZxageIjt5lqkXxXaoHCiOT
         TE8to3vTUtRiEBt31r0ODQFVpkPRl7Jb4KmfbDaykcUuf+Gn9qV46bnW0aeM1wbZRU9O
         cV6w==
X-Gm-Message-State: ABy/qLaFaScrgeFHAeKCbdsuY1aoyknUnv5viHois0gNo8e4ejtpUoBk
        Mf55lwlO0DrTCR8Gsg3zQ72Q+jOcwr+sAg7U8AcGqw==
X-Google-Smtp-Source: APBJJlEaKgj+9uPvPpz3a4MrB/goNjvJbbDkfBTWdZ2m0SXgqWaCQuJE9Pu7t7erZdBK4i5fiFtMxYWjMcWDmhbnvak=
X-Received: by 2002:a05:6512:3c87:b0:4fb:7642:88dd with SMTP id
 h7-20020a0565123c8700b004fb764288ddmr3539103lfv.67.1688719493532; Fri, 07 Jul
 2023 01:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230621114439.42851-1-alexghiti@rivosinc.com> <20230621114439.42851-2-alexghiti@rivosinc.com>
In-Reply-To: <20230621114439.42851-2-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 7 Jul 2023 10:44:42 +0200
Message-ID: <CAHVXubicGLp0-aOpeq7M1Cs3YZ+3WC1d_0gjyaoS8Z1j03JAQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libstub: zboot: Use -ffunction-sections + --gc-sections
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Jun 21, 2023 at 1:45=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Static linking is done at an object file (actually section) granularity,
> meaning that if a function in an object has an undefined reference, the
> link will fail, even though this function is not used in the resulting
> ELF.
>
> To avoid such failures, allow the linker to garbage collect unused sectio=
ns
> (which actually are functions).
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/firmware/efi/libstub/Makefile       | 1 +
>  drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index 3abb2b357482..6182366d00c0 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -40,6 +40,7 @@ KBUILD_CFLAGS                 :=3D $(subst $(CC_FLAGS_F=
TRACE),,$(cflags-y)) \
>                                    -ffreestanding \
>                                    -fno-stack-protector \
>                                    $(call cc-option,-fno-addrsig) \
> +                                  -ffunction-sections \
>                                    -D__DISABLE_EXPORTS
>
>  #
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmwa=
re/efi/libstub/Makefile.zboot
> index 89ef820f3b34..5bb52d262133 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -51,7 +51,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/=
libstub/zboot-header.S FO
>
>  ZBOOT_DEPS :=3D $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/li=
bstub/lib.a
>
> -LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libstub/=
zboot.lds
> +LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libstub/=
zboot.lds --gc-sections
>  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
>         $(call if_changed,ld)
>
> --
> 2.39.2
>

Sorry to bother you, do you have any opinion about this patch? Does
that make sense? If not, I should find another solution for my riscv
KASLR series!

Thanks,

Alex
