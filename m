Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9379A52F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjIKH5j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIKH5h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 03:57:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93999BB;
        Mon, 11 Sep 2023 00:57:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E43C433CA;
        Mon, 11 Sep 2023 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694419050;
        bh=HGA58eRNTJRiVEXtx1sSsGz1XtJ0X3tvzq40Mcr7LVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XV2av1NlmHvoHt+8pbBDijmsvUFKnB8iy+HP9fV1gjXKyYMYFDVGz7/3ORNnht3/R
         RIe9ZmOkYsRuU7bJYSn7QNHnsKwBoMsYDTPDKQvQ3iPFmE7avEQYG9EYFFZJyZCTkC
         o4OIxNd7pFiERuOsBxdUrICSoLmFkfNHrt7J3RwQ56bQ2HcGQPzVYliaVO5DJlsIZ1
         +1tRkg3BSrVa1lm2EjV+n893FCpfJZ30rTZhvTmJM8SK9jNRxLHa1f9tvo2dn/fZfk
         CxwnuD+2qw5dFT4x/fYBMzHHsNGqsyXH0LFN/yWE3x5FB5IUiMUAamkXhPZVyfAS6A
         LCTnC7svv4cnw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b703a0453fso69135091fa.3;
        Mon, 11 Sep 2023 00:57:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywbh0lou2/ncZ5im7wd3Erk9lEUeYi96Xl6CY1XusjVP/YEAzks
        Z0oersWEhGYUs1gPw56vx1hlAh6+CwvjVCyKLP0=
X-Google-Smtp-Source: AGHT+IHVQNnrKc5b+hWWufet/lOVWBC7JLLz/fIr4ezY5N8/YbulkHtkaFVky8nlNxamAjl7qERQrT24w0TEK+4CIxY=
X-Received: by 2002:a2e:818f:0:b0:2bc:d33e:ccc5 with SMTP id
 e15-20020a2e818f000000b002bcd33eccc5mr7883415ljg.41.1694419048318; Mon, 11
 Sep 2023 00:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax> <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
 <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com> <27e76823-5464-4fd7-844d-7ed273a8a902@canonical.com>
In-Reply-To: <27e76823-5464-4fd7-844d-7ed273a8a902@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 Sep 2023 09:57:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6g=obpUgptBvQwYtikaDk6biQiTrW6-tJAfhuDCXx0g@mail.gmail.com>
Message-ID: <CAMj1kXG6g=obpUgptBvQwYtikaDk6biQiTrW6-tJAfhuDCXx0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Anisse Astier <anisse@astier.eu>, Jeremy Kerr <jk@ozlabs.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 Sept 2023 at 09:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 9/11/23 08:45, Ard Biesheuvel wrote:
> > On Sun, 10 Sept 2023 at 22:42, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 9/10/23 20:53, Anisse Astier wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
> >>>> Some firmware (notably U-Boot) provides GetVariable() and
> >>>> GetNextVariableName() but not QueryVariableInfo().
> >>>
> >>>   From a quick search, it seems u-boot, does support QueryVariableInfo, is
> >>> it on a given version ?
> >>>
> >>> https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391
> >>
> >> QueryVariableInfo() and SetVariable() are available before
> >> ExitBootServices(), i.e. in Linux' EFI stub.
> >>
> >> ExitBootServices() results in calling efi_variables_boot_exit_notify()
> >> which disables these services during the UEFI runtime.
> >>
> >>>
> >>>>
> >>>> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> >>>> statfs syscall was broken for such firmware.
> >>>
> >>> Could you be more specific ? What breaks, and what regressed ? I imagine
> >>> it could be some scripts running df, but maybe you had something else in
> >>> mind ?
> >>
> >> Some more details can be found in
> >> https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.
> >>
> >> Though EFI variables are exposed via GetVariable() and
> >> GetNextVariableName() the efivar command refuses to display variables
> >> when statfs() reports an error.
> >>
> >>>
> >>>>
> >>>> If QueryVariableInfo() does not exist or returns an error, just report the
> >>>> file-system size as 0 as statfs_simple() previously did.
> >>>
> >>> I considered doing this [2] , but we settled on returning an error
> >>> instead for clarity:
> >>> https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
> >>>
> >>> I still think it would be a good idea if necessary.
> >>
> >> We should never break user APIs.
> >>
> >
> > Indeed.
> >
> >>>
> >>> On the approach, I prefer what Ard proposed, to fall back to the old
> >>> approach. I think the difference in block size could also be a good
> >>> marker that something wrong is happening:
> >>> https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/
> >>
> >> This will allow user code making assumptions based on block size:
> >> If block size > 1, assume setting variables is possible.
> >>
> >> We should really avoid this.
> >>
> >
> > I agree that having different block sizes depending on which code path
> > is taken is not great. But that is the situation we are already in,
> > given that older kernels will always report PAGE_SIZE. And actually,
> > PAGE_SIZE does not make sense either - PAGE_SIZE could be larger than
> > 4k on ARM for instance, so the efivarfs block size will be dependent
> > on the page size of the kernel you happened to boot.
> >
> > So I think we should go with the below:
> >
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry,
> > struct kstatfs *buf)
> >          u64 storage_space, remaining_space, max_variable_size;
> >          efi_status_t status;
> >
> > -       status = efivar_query_variable_info(attr, &storage_space,
> > &remaining_space,
> > -                                           &max_variable_size);
> > -       if (status != EFI_SUCCESS)
> > -               return efi_status_to_err(status);
> > +       /* Some UEFI firmware does not implement QueryVariableInfo() */
> > +       storage_space = remaining_space = 0;
> > +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> > +               status = efivar_query_variable_info(attr, &storage_space,
> > +                                                   &remaining_space,
> > +                                                   &max_variable_size);
> > +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> > +                       pr_warn_ratelimited("query_variable_info()
> > failed: 0x%lx\n",
> > +                                           status);
>
> Adding a warning here is helpful. The else branch would be:
>
> +               } else {
> +                       buf->f_blocks   = storage_space;
> +                       buf->f_bfree    = remaining_space;
> +               }
>

The else branch is redundant if we leave the assignments of f_blocks
and f_bfree where they were before.
