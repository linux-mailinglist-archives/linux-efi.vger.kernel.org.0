Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91BE546127
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348327AbiFJJMS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbiFJJMB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434A2864A0;
        Fri, 10 Jun 2022 02:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0931E61D06;
        Fri, 10 Jun 2022 09:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72889C34114;
        Fri, 10 Jun 2022 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654852190;
        bh=/qdROdWD24rBg3azmTj1UmmI9WAWTh2B8jeXrv1aSiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GlgkqHLdmwi2zxs5qnJMHzxG60wRAb49jUqvpQzpmsDMbXvQ8/G0jPJuXKS5BPJL/
         0aqPXCYxRasi77UbaQWD4peserc9Uu1JWNSWTmyOQsxtya8un9zsYBvMlVBI8mm1O9
         IBUYmAdoCJOQOItgB03T2ao3GcrAYBM7zWbzHnOsJiin6cncdbLMSy23xGhrmWrcWW
         fzwavPACYRxnlNM9HVa1JgyxZXcfpizzc1pFwbUtRqHnolnkyMHCXd2B/ELxdfPchE
         bv81RhnJ7/+T9NgFLCLpc/x95JnKDdWQMa6eywgF09YIDlQFdtjdlkPPhpLnChWrX9
         VRRP6IRcFf4PQ==
Received: by mail-oi1-f175.google.com with SMTP id k24so8159283oij.2;
        Fri, 10 Jun 2022 02:09:50 -0700 (PDT)
X-Gm-Message-State: AOAM530wi4fB4Cbs8sA74a3X7eVlauGiXJtD2IqnC50MZafPgVN8nyjZ
        fjLdRrvq3hQvBqkACUNoZ8PmKmhjQBROoWIBRpk=
X-Google-Smtp-Source: ABdhPJxnmzJJt3U8HkiFRCYk7NouLU7Mp9v+nABUnRUH7tUXo9HgFJRR3FqSp0C8PUmdigDCMLUQjaaR9ONFsn/iDPo=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr4014898oib.126.1654852189628; Fri, 10
 Jun 2022 02:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220610090005.1358402-1-javierm@redhat.com>
In-Reply-To: <20220610090005.1358402-1-javierm@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 11:09:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5HfkqYYb+MKbEVNtpQnRULgZSCm7cWDP0SmrjthOFPQ@mail.gmail.com>
Message-ID: <CAMj1kXH5HfkqYYb+MKbEVNtpQnRULgZSCm7cWDP0SmrjthOFPQ@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: remove unnecessary <asm/efi.h> include
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Jun 2022 at 11:00, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Nothing defined in the header is used by drivers/firmware/efi/sysfb_efi.c
> but also, including it can lead to build errors when built on arches that
> don't have an asm/efi.h header file.
>
> This can happen for example if a driver that is built when COMPILE_TEST is
> enabled selects the SYSFB symbol, e.g. on powerpc with allyesconfig:
>
> drivers/firmware/efi/sysfb_efi.c:29:10: fatal error: asm/efi.h: No such file or directory
>    29 | #include <asm/efi.h>
>       |          ^~~~~~~~~~~
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Queued up in efi/urgent, thanks

> ---
>
>  drivers/firmware/efi/sysfb_efi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 4c7c9dd7733f..7882d4b3f2be 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -26,8 +26,6 @@
>  #include <linux/sysfb.h>
>  #include <video/vga.h>
>
> -#include <asm/efi.h>
> -
>  enum {
>         OVERRIDE_NONE = 0x0,
>         OVERRIDE_BASE = 0x1,
> --
> 2.36.1
>
