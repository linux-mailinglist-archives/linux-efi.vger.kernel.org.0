Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DDC4EBB83
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiC3HOT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiC3HOS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 03:14:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C3151D3E;
        Wed, 30 Mar 2022 00:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA89DB81B80;
        Wed, 30 Mar 2022 07:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D220C34111;
        Wed, 30 Mar 2022 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648624351;
        bh=uJ8fGWafwTAlv9l0mlHzIkRAfu4fTlLcAJxukJfW5Rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pgvUDWE9UXji6tVNbju1EZUgfKHoVHnkibIlMTHQncldluAvnLmS+7VbjoxPH/+8O
         J6bgcoogOQVhw/uDL54psXULio0507TAKJ9bM7sm/y+vmBd0PVBz5JgCrgHEg/weG8
         JwGG/nF8lD5f8MdZAYKLgglOQgPMe8QhzTXwPEI1dV6+wT2qJkPDKy7xXfvNKw19TA
         99hvMjinK3OZVfRfSw+OhgCh0bJaG/vNLbO1sYZ/ILgp2v7sGeCTe8rwT51Xr17uCY
         fEMLHw5HFCiV84a9v6nghikBs9CPoVoAa2q/C0C/OXFyM7OcrPOHRU92dW5QlQAt38
         YSNFWJce+kRvw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-deb9295679so13995637fac.6;
        Wed, 30 Mar 2022 00:12:31 -0700 (PDT)
X-Gm-Message-State: AOAM531j0ntctz051Z4Ha1IWOHKd85rOKkinJjWFNV6S/Ql2LszwRkQs
        PGS8gHXgI2ca2dZi+q0PbktQmiIz3tB6j9dMF30=
X-Google-Smtp-Source: ABdhPJxUvOo3MLyXaPjpIEoqV4i5winXVegOaRAvp1e7xbRtwJg6iAXeFC7gAfpAF8Sq86Di9+bzf3vjCz2xm9LO2Sk=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr1592279oae.126.1648624350700; Wed, 30
 Mar 2022 00:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <20220330071103.GA809@srcf.ucam.org>
In-Reply-To: <20220330071103.GA809@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 09:12:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
Message-ID: <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
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

On Wed, 30 Mar 2022 at 09:11, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Mar 30, 2022 at 09:02:18AM +0200, Ard Biesheuvel wrote:
>
> > Wouldn't it be better for the secure launch kernel to boot the EFI
> > entrypoint directly? As it happens, I just completed a PoC last week
> > for a minimal implementation of EFI (in Rust) that only carries the
> > pieces that the EFI stub needs to boot Linux. It is currently just a
> > proof of concept that only works on QEMU/arm64, but it should not be
> > too hard to adapt it for x86 and for booting a kernel that has already
> > been loaded to memory.
>
> The EFI stub carries out a bunch of actions that have meaningful
> security impact, and that's material that should be measured. Having the
> secure launch kernel execute the stub without awareness of what it does
> means it would need to measure the code without measuring the state,
> while the goal of DRTM solutions is to measure state rather than the
> code.

But how is that any different from the early kernel code?
