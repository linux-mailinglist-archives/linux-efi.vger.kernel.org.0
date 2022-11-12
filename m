Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E80626B05
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKLSVH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiKLSVH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 13:21:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6896325
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 10:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4348B6023F
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 18:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A6C433D7
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668277260;
        bh=3UDCHmYDh3L/W5aKHoB0Ur1oueCbfS2ljbNJcy+s1w8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cRhJHb3288yRsn3vadbo2Fr0hCHE99mYOD2WDiI8ajzZKJwtESubhVd8nyLFZ5/YJ
         OsPkWmvk5GgcqQNKuP9RFciDqsHm9vQ9JqhsKaC76nWAELUFpypL2nMQKCZkQL7ro6
         TaOVFAWOxZw8xj7TvrxDb2bZzdIK5EItmoP1RkrMEs5GecIbdGbfcFZk6tenE3DzC3
         0R3WVLyrvlcwrtVcRsqgF//41XlZmpLuCJQBA85fLLhfaxvSxHkga1APJB8FKg01pr
         N+QIvJ+sQ9CukNZXAbctk6kJk9rgKveyAYEhQzXfzqRuFTHUwFMeYJwmX0fRD6mDmJ
         XOCRUtOBoyPpA==
Received: by mail-lf1-f51.google.com with SMTP id f37so12964419lfv.8
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 10:21:00 -0800 (PST)
X-Gm-Message-State: ANoB5plY9R+KHTjqpG37eXlc3TFqDkEYFdO3pFAlXBLKPw7iI/w0vcYt
        pAbfCcdsjBrTH7gdkWQLMfdQRZJepZuQwkPH1C4=
X-Google-Smtp-Source: AA0mqf5fpr/wqSKx4NRLjSZs/rpgGLWbqsCkI2LYrNlSB9psPmjtrqhxx/HSNOsLqvXpO9wvTuDbnMpyngCh+EQioM8=
X-Received: by 2002:a05:6512:1042:b0:4a2:2aad:95c4 with SMTP id
 c2-20020a056512104200b004a22aad95c4mr2740856lfb.110.1668277258570; Sat, 12
 Nov 2022 10:20:58 -0800 (PST)
MIME-Version: 1.0
References: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
 <202211121626.12652.ulrich.gemkow@ikr.uni-stuttgart.de> <CAMj1kXENHPP4DjT+37HHo9=UYpi5HKEw-+hLmJHRKD+JzdQEmg@mail.gmail.com>
 <202211121755.13372.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202211121755.13372.ulrich.gemkow@ikr.uni-stuttgart.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 12 Nov 2022 19:20:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGJGW9Bt3MWcxQVsPnWWm2HQRo_T=atjwvt8zoaQfp5fQ@mail.gmail.com>
Message-ID: <CAMj1kXGJGW9Bt3MWcxQVsPnWWm2HQRo_T=atjwvt8zoaQfp5fQ@mail.gmail.com>
Subject: Re: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI
 boot entries
To:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Nov 2022 at 17:55, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> Hello Ard,
>
> On Saturday 12 November 2022, you wrote:
> > On Sat, 12 Nov 2022 at 16:26, Ulrich Gemkow
> > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > >
> > > Hello Ard,
> > >
> > > thanks for looking into this!
> > >
> > > On Saturday 12 November 2022, you wrote:
> > > > On Sat, 12 Nov 2022 at 14:42, Ulrich Gemkow
> > > > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
> > > > > not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
> > > > > are not supported on this system". The directory /sys/firmware/efi/efivars/
> > > > > exists but is empty.
> > > > >
> > > > > This worked fine with the latest 5.19 kernel. The config was transferred
> > > > > from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
> > > > > and without changes from the kernel.org downloads.
> > > > >
> > > > > I saw earlier messages about bugs in this area, the fixes applied
> > > > > seem to be not complete.
> > > > >
> > > > > Please let me know when additional information would help to debug.
> > > > >
> > > >
> > > > Hello Ulrich,
> > > >
> > > > Can you please share the complete kernel boot log when booting with
> > > > efi=debug, and the .config used to build the kernel? Thanks.
> > > >
> > >
> > > please find attached the two files. Please do not get confused about
> > > the kernel uname, the used kernel is 6.0.8. I use my own automated
> > > setup and build environment which requires a different naming.
> > >
> >
> > Does it work if you enable CONFIG_EFI_STUB?
> >
>
> Enabling CONFIG_EFI_STUB does not help, the problem remains.
>
> I digged around and found that mounting the efivarfs solves the
> problem. This was not required with 5.19. Is this an expected
> or wanted change of behavior?
>

That is surprising. It is entirely up to user space whether and when
efivarfs gets mounted - the kernel just provides the facilities but
does not decide if they get used.

Which distro are you using?
