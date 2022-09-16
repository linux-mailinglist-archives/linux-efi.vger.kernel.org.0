Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BC5BA832
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiIPI1D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiIPI1C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 04:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28094A4B2E;
        Fri, 16 Sep 2022 01:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA94F62921;
        Fri, 16 Sep 2022 08:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A2C433D6;
        Fri, 16 Sep 2022 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663316820;
        bh=TeA+Z+iJVc+IE04wIs427hBn63eWQx+Ir9CgYNaLl2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWRuz1bO0wVLag0NYjO8h+yoKfcIBz0qXkFO1VlJLQteUk6pqYRlEKuaPpEF9UJka
         zF7wy2J+7+scpPxu0Vq0h8hkbRc3BAoRg2KsvqIbun78Gz9iOJuMqIJk0Q3VDzlFIa
         fWWy+kJdDL4h4aJAcJFoKB08f1gwR6ZIsL97dbzrbtd3o57cpvNY+vZbI2LbuIFRnr
         om+eCYGTxMoVunoGlcXnzkeXBPZpr3igSOHbGbFbTc47iJ0j6i6q49lw5reyiHE5D4
         zOUpTxUOg+E8m6mmtbYesQTymKxgOV+AykKzKb99MFT74SrOqaKbnhYSa1fcwzLGRh
         iyUQYdx6IgPIQ==
Received: by mail-lf1-f50.google.com with SMTP id f9so33666153lfr.3;
        Fri, 16 Sep 2022 01:27:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf3/vqnDp2txi0dJUfUN4gE/b7n4KdVHOX/UP5bFtfvo3qhmfjyo
        13MwzEcq6yJJ33+Cb10Hegc1p10T91zYcv9sUjY=
X-Google-Smtp-Source: AMsMyM7FTBH03cBOW3t9CqWGe+sQB6qBmJw59BdKYW5uPq6K5NL8F8gUBjv6V+lEuK2iaN3xhEL54hkrU5CMSveGSYQ=
X-Received: by 2002:a05:6512:c0f:b0:49b:1e8c:59fd with SMTP id
 z15-20020a0565120c0f00b0049b1e8c59fdmr1216142lfu.426.1663316818086; Fri, 16
 Sep 2022 01:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220916081441.1993492-1-ilias.apalodimas@linaro.org> <20220916081441.1993492-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20220916081441.1993492-2-ilias.apalodimas@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Sep 2022 10:26:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEtzCF-19MHNmBB45t3X343bd1G+PRNn=h8=PMfLVq+pA@mail.gmail.com>
Message-ID: <CAMj1kXEtzCF-19MHNmBB45t3X343bd1G+PRNn=h8=PMfLVq+pA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/libstub: measure EFI LoadOptions
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     pjones@redhat.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Sunil V L <sunilvl@ventanamicro.com>,
        Baskov Evgeniy <baskov@ispras.ru>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 16 Sept 2022 at 10:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The EFI TCG spec, in =C2=A710.2.6 Measuring UEFI Variables and UEFI GPT D=
ata,
> is  measuring the entire UEFI_LOAD_OPTION (in PCR5).  As a result boot
> variables that point to the same UEFI application but with different
> optional data,  will have distinct measurements.
>

That is not the main problem. The main problem is that
LoadImage()/StartImage() may be used to invoke things beyond Boot####
options, and at StartImage() time, the load options could be anything.
So not measuring the load options when the image is actually being
invoked is a huge oversight.


> However, PCR5 is used for more than that and there might be a need to use
> a PCR with a more limited scope which measures our initramfs and
> LoadOptions.
>
> So add a measurement in PCR9 (which we already use for our initrd) and
> extend it with the LoadOption measurements
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 21 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> index 3ef4867344b9..5b03248527c6 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -370,6 +370,27 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,=
 int *cmd_line_len)
>         int options_bytes =3D 0, safe_options_bytes =3D 0;  /* UTF-8 byte=
s */
>         bool in_quote =3D false;
>         efi_status_t status;
> +       static const struct efi_measured_event load_options_tcg2_event =
=3D {
> +               {
> +                       sizeof(load_options_tcg2_event) + sizeof("Load Op=
tions"),
> +                       {
> +                               sizeof(load_options_tcg2_event.event_data=
.event_header),
> +                               EFI_TCG2_EVENT_HEADER_VERSION,
> +                               9,
> +                               EV_EVENT_TAG,
> +                       },
> +               },
> +               {
> +                       LOAD_OPTIONS_EVENT_TAG_ID,
> +                       sizeof("Load Options"),
> +               },
> +               { "Load Options" },
> +       };
> +
> +       if (options_chars > 0)
> +               efi_measure_tagged_event((unsigned long) options,
> +                                        (unsigned long) options_chars,
> +                                        &load_options_tcg2_event);
>

The name 'options_chars' is a bit misleading here, as it is actually
the size in bytes at this point.

>         efi_apply_loadoptions_quirk((const void **)&options, &options_cha=
rs);
>         options_chars /=3D sizeof(*options);
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index cb7eb5ed9f14..e3605b383964 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -741,6 +741,7 @@ union apple_properties_protocol {
>  typedef u32 efi_tcg2_event_log_format;
>
>  #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
> +#define LOAD_OPTIONS_EVENT_TAG_ID 0x8F3B22EDU

Is this an arbitrarily chosen value?

>  #define EV_EVENT_TAG 0x00000006U
>  #define EFI_TCG2_EVENT_HEADER_VERSION  0x1
>
> --
> 2.34.1
>
