Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F7609A31
	for <lists+linux-efi@lfdr.de>; Mon, 24 Oct 2022 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJXGFQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Oct 2022 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJXGFO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Oct 2022 02:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27821E1C;
        Sun, 23 Oct 2022 23:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19EB61017;
        Mon, 24 Oct 2022 06:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1439FC433C1;
        Mon, 24 Oct 2022 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666591511;
        bh=Rrzv5Tt+q59V09tub8dzMmmJEN0idvx5wD8RUNC/ZKY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBAbWFIzbMNlb+VFrkBiuNN9p7KiDqGM+sPdyqkmERmJqfoD/OhB0/tPAzQjQf+Uj
         gPzsqXdlIHlYGpkHdoRhRn9/+xHvBkl2V9X9ZhU3GrJ0aqEj25NGqxt3ONG1sr6fZJ
         pDFwwc3r5KQ4Ilu5rdGVvNHT0NJ6kxGkX31cqVGRndqFLKPYMTUfvIKwQy6ZOSSPrS
         1SQl8c2Qz3Sj2Pky/dBJMIYF9+rWej28umZLcNUio5LJ9Zqey7EXIidRDOObbsLRlB
         rrWYBGHh0SBS4b9SAA8pj0As6eJpHJCJClcrnXL5z6SJ7ndUHDLwWggW9ml8DSKDFi
         RQr9KxT32GrGw==
Received: by mail-lf1-f47.google.com with SMTP id j4so15175603lfk.0;
        Sun, 23 Oct 2022 23:05:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf364OlYu5BE4Mm//zqNTuoF4is7mDCqhwwCdvzlSINrGEv4ivaR
        Ctpmaaxnc9YJf5cLsesNBBdS6PzKqS7DhnLPhy8=
X-Google-Smtp-Source: AMsMyM7yINnt/qXtwlMuDKIDz8TuZ41KDaj9fZqKz0DLxh6o6ZZEU2VusKSBfs84kQYPzkH3w/uA1GsDoRgFLsQJxgY=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr11801286lfb.637.1666591509081; Sun, 23
 Oct 2022 23:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221022152352.1033750-1-jsnitsel@redhat.com> <Y1W5LlI/fRo6XhU9@kernel.org>
In-Reply-To: <Y1W5LlI/fRo6XhU9@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Oct 2022 08:04:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXERxgg+BGxoS-mwHU7jE4Ozs84jmTDd7bvJnaPMVv3g@mail.gmail.com>
Message-ID: <CAMj1kXHXERxgg+BGxoS-mwHU7jE4Ozs84jmTDd7bvJnaPMVv3g@mail.gmail.com>
Subject: Re: [PATCH] efi/tpm: Pass correct address to memblock_reserve
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 23 Oct 2022 at 23:59, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat, Oct 22, 2022 at 08:23:52AM -0700, Jerry Snitselaar wrote:
> > memblock_reserve() expects a physical address, but the address being
> > passed for the TPM final events log is what was returned from
> > early_memremap(). This results in something like the following:
> >
> > [    0.000000] memblock_reserve: [0xffffffffff2c0000-0xffffffffff2c00e4] efi_tpm_eventlog_init+0x324/0x370
> >
> > Pass the address from efi like what is done for the TPM events log.
> >
> > Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
> > Cc: Matthew Garrett <mjg59@google.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Bartosz Szczepanek <bsz@semihalf.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >  drivers/firmware/efi/tpm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index 8f665678e9e3..e8d69bd548f3 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -97,7 +97,7 @@ int __init efi_tpm_eventlog_init(void)
> >               goto out_calc;
> >       }
> >
> > -     memblock_reserve((unsigned long)final_tbl,
> > +     memblock_reserve(efi.tpm_final_log,
> >                        tbl_size + sizeof(*final_tbl));
> >       efi_tpm_final_log_size = tbl_size;
> >
> > --
> > 2.37.2
> >
>
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>


Queued as a fix,

Thanks all,
