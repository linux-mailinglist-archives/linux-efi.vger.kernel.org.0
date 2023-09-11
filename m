Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473679A3AB
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjIKGpb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIKGp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 02:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A412C;
        Sun, 10 Sep 2023 23:45:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A8BC433C9;
        Mon, 11 Sep 2023 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694414724;
        bh=lVH3ZV18q9r7GfPi3ryauvNgE6lBICH5JipZiU2IW/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQW5Yn9WeXRjVkITyeU3WNBja1xfkc3TGqwaPI6ZIYbrvAmJTTNpMPr5p+CLuZFqE
         SX7acUDtROMaPqnrScSDrxcpz2ope6xqfh9RDN/zlRZXX/t2RD5KYaMAfX8xckkGzY
         Rc4SB+73xhljrNME0PoWtA/NUB2t9TnZ9bBbV6nOYTCxV/Viy9fxS2v3jfJgu536dO
         Rj5+hRqM9E7XBi7PNbhySsjjS+QVfM4OtLZB1o8AV3toREQuNjm5O8mgaHqsf36vtV
         k1h79PXwYPwg+6/WdCrKmbKJM/ufKQBlfjlpCHlOmAEypfRaTVHNOsRe1Wy4wE2Grv
         DJq2vETUrXmmg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so11098841fa.0;
        Sun, 10 Sep 2023 23:45:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YyyEH4dRoCerFanDuoUqFwFSNHjUe1gIKsdSbNO0kDR8YBfVqk8
        +sXQOo5y103LLS3x28i3L8gapGWZCQw6/8Ds8OQ=
X-Google-Smtp-Source: AGHT+IFVjgWenNbT1Pk8jbEx/Gqui6LU3fLIy5pYgjjfvUARJhbtKwJ2IpAD6bYDArGbUD3WawILf37PXjiywALsIDM=
X-Received: by 2002:a05:651c:1027:b0:2b9:ba02:436c with SMTP id
 w7-20020a05651c102700b002b9ba02436cmr6814832ljm.28.1694414722144; Sun, 10 Sep
 2023 23:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax> <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
In-Reply-To: <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 Sep 2023 08:45:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
Message-ID: <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 22:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 9/10/23 20:53, Anisse Astier wrote:
> > Hi Heinrich,
> >
> > On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
> >> Some firmware (notably U-Boot) provides GetVariable() and
> >> GetNextVariableName() but not QueryVariableInfo().
> >
> >  From a quick search, it seems u-boot, does support QueryVariableInfo, is
> > it on a given version ?
> >
> > https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391
>
> QueryVariableInfo() and SetVariable() are available before
> ExitBootServices(), i.e. in Linux' EFI stub.
>
> ExitBootServices() results in calling efi_variables_boot_exit_notify()
> which disables these services during the UEFI runtime.
>
> >
> >>
> >> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> >> statfs syscall was broken for such firmware.
> >
> > Could you be more specific ? What breaks, and what regressed ? I imagine
> > it could be some scripts running df, but maybe you had something else in
> > mind ?
>
> Some more details can be found in
> https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.
>
> Though EFI variables are exposed via GetVariable() and
> GetNextVariableName() the efivar command refuses to display variables
> when statfs() reports an error.
>
> >
> >>
> >> If QueryVariableInfo() does not exist or returns an error, just report the
> >> file-system size as 0 as statfs_simple() previously did.
> >
> > I considered doing this [2] , but we settled on returning an error
> > instead for clarity:
> > https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
> >
> > I still think it would be a good idea if necessary.
>
> We should never break user APIs.
>

Indeed.

> >
> > On the approach, I prefer what Ard proposed, to fall back to the old
> > approach. I think the difference in block size could also be a good
> > marker that something wrong is happening:
> > https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/
>
> This will allow user code making assumptions based on block size:
> If block size > 1, assume setting variables is possible.
>
> We should really avoid this.
>

I agree that having different block sizes depending on which code path
is taken is not great. But that is the situation we are already in,
given that older kernels will always report PAGE_SIZE. And actually,
PAGE_SIZE does not make sense either - PAGE_SIZE could be larger than
4k on ARM for instance, so the efivarfs block size will be dependent
on the page size of the kernel you happened to boot.

So I think we should go with the below:

--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
        u64 storage_space, remaining_space, max_variable_size;
        efi_status_t status;

-       status = efivar_query_variable_info(attr, &storage_space,
&remaining_space,
-                                           &max_variable_size);
-       if (status != EFI_SUCCESS)
-               return efi_status_to_err(status);
+       /* Some UEFI firmware does not implement QueryVariableInfo() */
+       storage_space = remaining_space = 0;
+       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
+               status = efivar_query_variable_info(attr, &storage_space,
+                                                   &remaining_space,
+                                                   &max_variable_size);
+               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
+                       pr_warn_ratelimited("query_variable_info()
failed: 0x%lx\n",
+                                           status);
+       }

        /*
         * This is not a normal filesystem, so no point in pretending
it has a block
