Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFD5ACFC6
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiIEKTr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiIEKTS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 06:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28857897;
        Mon,  5 Sep 2022 03:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9CE611E7;
        Mon,  5 Sep 2022 10:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C1CC43140;
        Mon,  5 Sep 2022 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662373110;
        bh=hLdOxeWf6PepFSoB3hp2gA418/rSC6EzXXNfy1AWh8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DQBpyhNmqKZPAhgq5+1oQny1tqnIVrOyhhdWQI3AGGlIY/exSpUFNWVaFbigZtTGg
         eMspRYQvIXHa4O/uuT4KEqR5dF4QTTGWaZo9fw9msBmfC8LGR3JrTOnxAEAd/4SsvO
         ZsvU82NfxtdNeOo/nw3VYNGRY3tvj04SRKEJJKdHqnD/SQhocC08Os4RsHWPqcerh3
         G4w87wOQN2JDJAVMGMO/uoqH0ZmxZq2SGxr0zccPNYgK/HLsEWTP2X7Lqo35oWLAYs
         1HqpvClp53CsEK8unNhQ9lMVzPVQDhBzh78Kl79FNv0tot/7v3zkaAVaM1KTezC9YF
         NgtuIuBuS3Cjw==
Received: by mail-lj1-f174.google.com with SMTP id z23so8767948ljk.1;
        Mon, 05 Sep 2022 03:18:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo0LZtN4/6v2xnVB/tlVNPEgV77DQbebhgB/qXXF2vO3Q8HisBvn
        hePNwM2yHqc7YYAL3Q3KsRLYUAm+uhuoZmzEDIY=
X-Google-Smtp-Source: AA6agR56XNeuKOoQVmN0t7K/dgRDEizNnGNwGN+h/cgd3whw7R7lqUg8tJU0PGjMFJ4F+Tvk1E43ct6SkgxGksdI3MM=
X-Received: by 2002:a05:651c:11c6:b0:265:d1cb:b7b4 with SMTP id
 z6-20020a05651c11c600b00265d1cbb7b4mr8929907ljo.69.1662373107992; Mon, 05 Sep
 2022 03:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220831011248.28632-1-michel@lespinasse.org> <20220831011248.28632-2-michel@lespinasse.org>
In-Reply-To: <20220831011248.28632-2-michel@lespinasse.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 12:18:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG03PdCpSQQHvOFFk=_L-JVgy6DYob6ZLFd8WfDdaTnCQ@mail.gmail.com>
Message-ID: <CAMj1kXG03PdCpSQQHvOFFk=_L-JVgy6DYob6ZLFd8WfDdaTnCQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Remove unused variable et in efi_get_system_table()
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 31 Aug 2022 at 03:12, Michel Lespinasse <michel@lespinasse.org> wrote:
>
> This avoids a build warning with CONFIG_EFI enabled.
>
> Fixes: 7c4146e88855 (x86/compressed/acpi: Move EFI detection to helper)

Please use " inside the ()

Also, the commit id looks wrong to me.

> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  arch/x86/boot/compressed/efi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 6edd034b0b30..c42ee7874eb9 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -59,7 +59,6 @@ unsigned long efi_get_system_table(struct boot_params *bp)
>  {
>         unsigned long sys_tbl_pa;
>         struct efi_info *ei;
> -       enum efi_type et;
>
>         /* Get systab from boot params. */
>         ei = &bp->efi_info;
> --
> 2.20.1
>
