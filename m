Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB075F313
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGXK1X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jul 2023 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjGXK1F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 06:27:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914F10F4
        for <linux-efi@vger.kernel.org>; Mon, 24 Jul 2023 03:22:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so65327491fa.0
        for <linux-efi@vger.kernel.org>; Mon, 24 Jul 2023 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690194140; x=1690798940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3yt1Ke6aNIN/jv1ruK95LUKKim4xLKwMs6d1N9HoSc=;
        b=jFIv28DyvGrQUq7s7YcQS4RGDhl4fzmHSKpvLI4z2RUelm5JFFUotkTI3QRm3zolj/
         bnwaAk2lNRvUIK0ZZDSStNMIV1Hu1ajX/UKqwjLzKCdVneP4PQO0J947/QBkIHsvvCb1
         qon9fL3JSeTltaQfu5c2/Ix+sJb6AeBdKnFKZKYoWOaH05QsFt2pKvi6S/+PLolbWTLu
         M6IwSkl8E9kNB/FUJGp6pt8xljVS7IpJLpm/IxOm7cpL1A4/7rOWS+GDM8Vkq/ItgigA
         0eySTFGOFPhjLfDJdDH0L2Vl8ABW7Va4aDRWvsXJ4gSrYe3JfPD/mbYJ6yILcsSehuK0
         xB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194140; x=1690798940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3yt1Ke6aNIN/jv1ruK95LUKKim4xLKwMs6d1N9HoSc=;
        b=ZoItGZk7d+eMXae0VhBm9B2fhz21aHVEsQ4i69eWINMws+TR45hbW1qu8MvCivV6Xh
         KtDAeZPz39Z0RB2srRQ8K7w+pzH4/0tI8m60XcG269Lje0gU7XEl1Y/bHkxCpOsSfnTj
         3XWNui1NmsZqHs+5dbv8CEnrpCgzMFSui1JQZiKq3jnVvLspzNqEpuSHqySRVxMx/nBk
         qaNhRNLYtzCSZMLSDdhLGO00EGTWe4/27iRelY0+ldQwK32nCEoruLOaflVFEiXzNX2W
         1Zv5/hYY441/GVHDYsT/BhmNHuPjrQu/tNvXsl39tlLxAqyRKBf2UBmz4aM0QeqlDgeo
         wddA==
X-Gm-Message-State: ABy/qLbzhVhw5bOtZcAHOx4VMnzUIPUlz0SULVWNj7DA7803uZRrTPtV
        pyD1+YH1M8KvZ79yMJWQcRi8p9FGJuTfV2AgbYI/rw==
X-Google-Smtp-Source: APBJJlHiqJ1YE1Ay1bqPoHfzQNP6xNSqXZoYPk5HguQKWTkua66Wxoo9h2YZbixWdnK2mlsLvCf8nnjnLL9+XRutCY4=
X-Received: by 2002:a19:2d52:0:b0:4f8:6d9d:abe0 with SMTP id
 t18-20020a192d52000000b004f86d9dabe0mr2809263lft.33.1690194140137; Mon, 24
 Jul 2023 03:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org> <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
 <ZJSZbmUz583pszny@hera> <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
In-Reply-To: <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 24 Jul 2023 13:21:44 +0300
Message-ID: <CAC_iWj+-h+TbuesypQ-PpwFYOUOZ-vjd2C6dWb1oSBt7jEviPQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Kojima-san,

On Mon, 24 Jul 2023 at 05:53, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias, Jan,
>
> On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Kojima-san, Jan
> >
> > On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > > tee_stmm_efi module supports SetVariable runtime service,
> > > > but user needs to manually remount the efivarfs as RW to enable
> > > > the write access if the previous efivar operation does not support
> > > > SerVariable and efivarfs is mounted as read-only.
> > > >
> > > > This commit notifies the update of efivar operation to
> > > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > > operation supports SetVariable.
> > >
> > > But it does not re-add it and prevents further requests to the TA (that
> > > will only cause panics there) when the daemon terminates, does it?
> >
> > It doesn't, but I think I got a better way out.  Even what you suggest won't
> > solve the problem entirely.  For the sake of context
> > - The kernel decides between the RO/RW depending on the SetVariable ptr
> > - The stmm *module* registers and swaps the RT calls -- and the ptr is now
> > valid.  Note here that the module probe function will run only if the
> > supplicant is running
> > - Once the module is inserted the filesystem will be remounted even without
> > the supplicant running, which would not trigger an oops, but an hard to
> > decipher error message from OP-TEE.
> >
> > So even if we switch the permissions back to RO when the supplicant dies,
> > someone can still remount it as RW and trigger the same error.
> >
> > Which got me thinking and staring the TEE subsystem a bit more.  The
> > supplicant is backed by a /dev file, which naturally has .open() and
> > .release() callbacks.  Why don't we leave the module perform the initial
> > setup -- e.g talk to StMM and make sure it's there, setup the necessary
> > buffers etc and defer the actual swapping of the efivar ops and the
> > filesystem permissions there?  I might 'feel' a bit weird, but as I
> > mentioned the module probe function only runs if the supplicant is running
> > anyway
>
> I think we are discussing two issues.
>

Yes

> 1) efivar ops is not restored when the tee-supplicant daemon terminates.
>
> The patch[1] sent by Sumit addresses this issue.
> Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
> when the tee-supplicant daemon terminates, then restore the previous efivar ops
> and SB_RDONLY flag if necessary.

Ok but that didn't fix the original error Jan reported and I am not
sure about the patch status

>
> 2) cause panic when someone remounts the efivarfs as RW even if
> SetVariable is not supported.

Yes, this [0] is fixing that issue

[0] https://lore.kernel.org/linux-efi/20230609094532.562934-1-ilias.apalodimas@linaro.org/
Thanks
/Ilias
>
> [1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg@linaro.org/
>
> Thanks,
> Masahisa Kojima
>
> >
> > Cheers
> > /Ilias
> >
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Technology
> > > Competence Center Embedded Linux
> > >
