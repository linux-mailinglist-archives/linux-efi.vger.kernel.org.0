Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5376551391
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jun 2022 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiFTJA4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jun 2022 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiFTJAw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jun 2022 05:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EFF5AF;
        Mon, 20 Jun 2022 02:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A7F76112E;
        Mon, 20 Jun 2022 09:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE70C3411B;
        Mon, 20 Jun 2022 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655715650;
        bh=yzwb89a50kjFZmjIaMeAKFjLE58t4BBZb0rlVAPAnss=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PR3GANp6Ak21sG/UAxVizxxDj2i2izpRr7KA6sR0960EgFKkvixokHjg5g3fytWUO
         euXbDcHnhIJFj8EszeyH1UN5QwFc8voqbPPBdTGXurkeQbxMlVpVfWgpIJGuQRtGRJ
         zPpnlkFWHP2dDCSHxN5OmqwpKelbfwDZKfkQU7JhtaRdvOGBEfAkQgXUjPNzJcHWm8
         2VFGth6KLO/eZvUIafg4IDoPRV3dBC6yonXsEKWjWjPeYGZrNSei/JW1QHAlQRBKTZ
         bWG9eCpK2x8/jlTDsHH4BaBZaFlZz80Yrhn1pG+vU42qRtAXweOHEY0Gh/7s9V40M3
         z1AIB5PZOCitQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-input@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 0/4] efivar: remove inappropriate uses of the efivar API
References: <20220617174851.1286026-1-ardb@kernel.org>
Date:   Mon, 20 Jun 2022 12:00:45 +0300
In-Reply-To: <20220617174851.1286026-1-ardb@kernel.org> (Ard Biesheuvel's
        message of "Fri, 17 Jun 2022 19:48:47 +0200")
Message-ID: <87bkunpv42.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> The efivar layer is a caching non-volatile variable store abstraction
> that is normally backed by EFI, but in some cases, might be backed by
> Google SMI firmware interfaces instead.
>
> It is mainly used by efivarfs and EFI pstore, both of which actually
> need the caching and abstraction properties. However, there are a few
> other occurrences where efivar is not necessary, or used in an invalid
> way. So let's fix this up, and remove some impediments to refactoring
> and cleaning up the efivars layer in the future.
>
> Assuming there are no objections to these changes, I intend to queue
> them up in the EFI tree fairly soon, so that ongoing work depending on
> these changes can continue as well.
>

[...]

>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c |  25 ++---
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.c                |  96 ++++++------------

Feel free to take the wireless patches via your tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
