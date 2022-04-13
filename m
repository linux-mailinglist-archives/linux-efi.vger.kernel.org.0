Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011504FFC43
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiDMRWo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiDMRWm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3752E6C;
        Wed, 13 Apr 2022 10:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1A461E9C;
        Wed, 13 Apr 2022 17:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A9CC385A8;
        Wed, 13 Apr 2022 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649870420;
        bh=cd1OS579F8P5cfiY9Bbwx5RCM4PGh4h+DqwC6PuVcR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kf18OhECYLGZH8wbde+UHfoN5fbuDIlSLuNazbIh+Nal+k/f20tXp8K0mWpk19ItQ
         6rmJguL3geTZ3HeNft4CdzXgu7YHwYI0ZIMS27Nto7/p4wBPbgXo+GqcHqUq+pVnBa
         FmuwIcglmddoVtp2R6PYF4SPfMzfsKXhSHE/PbYngrdNzlau/yEuH05Hwk6Qo3oEgr
         pK0IWUJqdC15h6Yoop5dsaREVG6HYlf5cFLljUap0aiMAqxSS767wA6y0HRIXQ9U6e
         luy4ZgPk/y7wgWnwFPH/BEgApc7GHuQESZolqvtmGw9JD39EHqWq3p+TUFr68hg6xX
         n+2BN7WAME4+Q==
Received: by mail-oo1-f52.google.com with SMTP id w20-20020a4ae9f4000000b003243aa2c71aso463765ooc.0;
        Wed, 13 Apr 2022 10:20:20 -0700 (PDT)
X-Gm-Message-State: AOAM530slrhd1C6xxNfX0pNPAa1qNMP13hewtd1wHcCGqEcP8cPTSzoV
        94CyDVmvJ6l+p841gaO1qjqZSZ7BIByxihper6E=
X-Google-Smtp-Source: ABdhPJzSqbHk9eXUEuAkD5T3Q/MtGbeX3UEr1WcBXvB0gbVie0xrcXPCwdHKBSP1XJbTxSIH6U1W/r7doz7hYYy3rwo=
X-Received: by 2002:a4a:95f3:0:b0:331:3e74:ed5d with SMTP id
 p48-20020a4a95f3000000b003313e74ed5dmr1604304ooi.60.1649870419423; Wed, 13
 Apr 2022 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <c28d3f86-dd72-27d1-e2c2-40971b8da6bd@siemens.com>
In-Reply-To: <c28d3f86-dd72-27d1-e2c2-40971b8da6bd@siemens.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:20:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkDES_b9NA6KHd6mf_UeS0gjbfdtknK24aBD0hAE7pVw@mail.gmail.com>
Message-ID: <CAMj1kXFkDES_b9NA6KHd6mf_UeS0gjbfdtknK24aBD0hAE7pVw@mail.gmail.com>
Subject: Re: [PATCH] efi: Add missing prototype for efi_capsule_setup_info
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, 4 Mar 2022 at 07:36, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Fixes "no previous declaration for 'efi_capsule_setup_info'" warnings
> under W=1.
>
> Fixes: 2959c95d510c ("efi/capsule: Add support for Quark security header")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks Jan, I've queued this up now.

> ---
>  include/linux/efi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ccd4d3f91c98..cc6d2be2ffd5 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -213,6 +213,8 @@ struct capsule_info {
>         size_t                  page_bytes_remain;
>  };
>
> +int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
> +                           size_t hdr_bytes);
>  int __efi_capsule_setup_info(struct capsule_info *cap_info);
>
>  /*
> --
> 2.34.1
