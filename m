Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7665BABAF
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiIPKxH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIPKwp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 06:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956CB5A60
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 03:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA23662A7F
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E82EC433D6
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323641;
        bh=8yTXF6NzbmjeC25e7VeZA1CcymGSebKdbuBhiBfmQtE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRVm0baAvKtNfVU67dNMbfRemq7AioLKMSKO4Fu/F/otmbgjflkCsQUf7esLsdZSd
         3qi5DXyjbeQScE1dEYaCtQTjZhsbsnwtKcsDNbBrMqxtKQZXj7cm/0atlmKbmbBIQT
         zQeOMXPozCZMhrHUgty/jEAyPGkRW47+tCU2M9VMVLzZ/K7FKGDpoyPcw5aXjS2SKT
         RyuV3aFhK9PDHHBpnjW7hWVQmPmsTZx4ZpZNbR1R0RR1Aw/Yz0zjfgoFPrONOVGftg
         a0jX6G6gQ4XsUp457pqbbZdOsbb12uiPMs8AVzUo7mx1pJ0Zy2ZXhUzUPdpwF3J5vg
         b4x/DsUzMa9Cg==
Received: by mail-lj1-f181.google.com with SMTP id s10so24807259ljp.5
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 03:20:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf1MzMly53u3n+vg6ZM+pcqwxXAZoujMUnKTiblPy7xWVg3QCAtE
        J0wI05lPYrcB7fAT+t99FpbFF7sKesrLNrG0BWg=
X-Google-Smtp-Source: AMsMyM55TTm2Rmy1/nuhRA89xXyhJtRSI084WBAP8OCMW4xaFcDRFsSQCGGDiqY8ouG+3kyp00vslJYIJgV5DWZx0M4=
X-Received: by 2002:a2e:9115:0:b0:26a:c086:5138 with SMTP id
 m21-20020a2e9115000000b0026ac0865138mr1148134ljg.189.1663323639195; Fri, 16
 Sep 2022 03:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220916101843.495879-1-ardb@kernel.org>
In-Reply-To: <20220916101843.495879-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Sep 2022 12:20:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEvT92f6rULEHVZqaSS0nsidgnR3Kbt1ngqeux44FROWA@mail.gmail.com>
Message-ID: <CAMj1kXEvT92f6rULEHVZqaSS0nsidgnR3Kbt1ngqeux44FROWA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when possible
To:     linux-efi@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        andersson@kernel.org, catalin.marinas@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(use Peter's correct email address)

On Fri, 16 Sept 2022 at 12:19, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
> like to avoid using, if possible. For 64-bit architectures such as
> arm64, the user and kernel mappings are entirely disjoint, and given
> that we use the user region for mapping the UEFI runtime regions when
> running under the OS, we don't rely on SetVirtualAddressMap() in the
> conventional way, i.e., to permit kernel mappings of the OS to coexist
> with kernel region mappings of the firmware regions. This means that, in
> principle, we should be able to avoid SetVirtualAddressMap() altogether,
> and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
> omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
> spec).
>
> However, there is a corner case on arm64, which, if configured for
> 3-level paging (or 2-level paging when using 64k pages), may not be able
> to cover the entire range of firmware mappings (which might contain both
> memory and MMIO peripheral mappings).
>
> So let's avoid SetVirtualAddressMap() on arm64, but only if the VA space
> is guaranteed to be of sufficient size.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index cd3bea25c762..4fff6c32899e 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -31,6 +31,15 @@ efi_status_t check_platform_features(void)
>                         efi_err("This 16 KB granular kernel is not supported by your CPU\n");
>                 return EFI_UNSUPPORTED;
>         }
> +
> +       /*
> +        * If we have 48 bits of VA space for TTBR0 mappings, we can map the
> +        * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
> +        * unnecessary.
> +        */
> +       if (VA_BITS_MIN >= 48)
> +               efi_novamap = true;
> +
>         return EFI_SUCCESS;
>  }
>
> --
> 2.35.1
>
