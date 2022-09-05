Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED75ACF2F
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiIEJvH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiIEJvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 05:51:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DDF40BCD;
        Mon,  5 Sep 2022 02:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B055B80F9F;
        Mon,  5 Sep 2022 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E188C433D6;
        Mon,  5 Sep 2022 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662371462;
        bh=TC4ASRI8vJbkOfziXPT5lkIUvCxfswSY9VeZgHFbt7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W1VqymmELtiUE2NCRtozTCmfWmKzZdqal3moduKeE6lW/vMEYs6D3hDDOuufk6HrE
         ej6P/EpnXzLfSpaAOvzB8tq1Qa+6Fk4vTsjs08a4tfhpVMjQ1j6advp7cA6W3SjnKQ
         fCvl9lofHZnzTxm/fxF1MzLRze4A76PBGE0LFiR1Ucw7A4n8F6FMUj6XNMOtpfJW13
         TdlwAZRnJDws/553lAxtvrqKT6mLnyotDoiL3AR4O+lLMjoPY6bFpFVlK8/JkqBtwH
         85fUrXrg/zgPadvLk8H53O/GSEdXC55BOdjbn2Av7ZySTLoCDXqFTimc4OXzcX8As4
         8eTQCj/POXP1w==
Received: by mail-lf1-f50.google.com with SMTP id bt10so12391438lfb.1;
        Mon, 05 Sep 2022 02:51:02 -0700 (PDT)
X-Gm-Message-State: ACgBeo3eMOGqvLK9bFeRxMFM0vuKdL5YZBLJ++47LUBxGZfoYiIysg5U
        kv+cAqhCcen8qUqvcW3O6xU4b/zPsy6Bmcy6E9k=
X-Google-Smtp-Source: AA6agR6z9azjJx1FLtw776LxSbwtUb4mmm2aNhcg9yzqHutGO3reia9oDTUVNtNZpr1IXXaYNruYwketugS/flEuK7I=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr15455738lfb.583.1662371460116; Mon, 05
 Sep 2022 02:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220729194532.228403-1-gpiccoli@igalia.com> <468b8369-84c2-da12-1eb0-6ec16d160b34@igalia.com>
In-Reply-To: <468b8369-84c2-da12-1eb0-6ec16d160b34@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 11:50:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMmpLF8Sfcm16E+QpKosPgUGQ7FpO9qknoKxjyXY1zUQ@mail.gmail.com>
Message-ID: <CAMj1kXGMmpLF8Sfcm16E+QpKosPgUGQ7FpO9qknoKxjyXY1zUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] The UEFI panic notification mechanism, 2nd round
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, keescook@chromium.org,
        matt@codeblueprint.co.uk, mjg59@srcf.ucam.org, tony.luck@intel.com
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

On Mon, 29 Aug 2022 at 15:04, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 29/07/2022 16:45, Guilherme G. Piccoli wrote:
> > Hey folks, this is the 2nd iteration of the patchset adding a simple
> > mechanism to notify the UEFI firmware about a panic event in the kernel.
> > V1 here:
> > https://lore.kernel.org/lkml/20220520195028.1347426-1-gpiccoli@igalia.com/
> >
> >
> > First thing, the differences in this V2:
> >
> > - Ardb response in V1 mentioned a refactor aimed for v5.20 that removes an
> > obsolete/confusing way of setting EFI variables - this led to a weird
> > condition, deleted variables stayed in sysfs after deletion. Well, I've
> > refactored the code based on efi/next, so I'm using the recommended API
> > now - thanks a bunch for the advice Ardb!
> >
> > - I've changed NULL-terminating char in patch 1 to the format I've seen
> > in Ardb's code, L'\0'.
> >
> > - Patch 2 is new, it's somewhat a fix for a patch only in efi/next, part
> > of the efivar refactor.
> >
> >
> > In the V1 review, it was mentioned we could maybe use efi-pstore as a way
> > to signal the firmware about a panic event - in the end, the efi-pstore
> > mechanism can collect a dmesg, so it's even richer in the information level.
> > But I disagree that it is the way to go, for 3 main reasons:
> >
> > a) efi-pstore could be impossible to use, if the users are already using
> > another pstore backend (like ramoops), which is _exactly_ our case!
> > Of course, we could rework pstore and allow 2 backends, quite a bit of work,
> > but...see next points!
> >
> > b) Even if (a) is a not an issue, we have another one, even more important:
> > signaling the firmware about a panic is *different* than collecting a bunch
> > of data, a full dmesg even. This could be considered a security issue for
> > some users; also, the dmesg collected consumes a bunch more memory in the
> > (potentially scarce) UEFI available memory.
> > Although related, the goal of pstore is orthogonal to our mechanism here:
> > users rely on pstore to collect data, our proposal is a simple infrastructure
> > to just let the firmware know about a panic. Our kernel module also shows a
> > message and automatically clears the UEFI variable, so it tracks a single
> > panic, whereas efi-pstore logs are kept by default, in order to provide
> > data to users.
> >
> > c) Finally, it's faster and less "invasive"/risky to just write a byte in a
> > variable on a panic event than having a ksmg dumper collecting the full dmesg
> > and writing it to the UEFI memory; again, some users wish to have the logs,
> > but not all of them.
> >
> >
> > With all of that said, I think this module makes sense, it's a very simple
> > solution that opens doors to firmware panic handling approaches, like in our
> > proposed case (a different splash screen on panic).
> >
> > Finally, the variable name (PanicWarn) and value (0xFF by default, can be
> > changed by a module parameter) are just my personal choices but I'm open to
> > suggestions, not strongly attached to them heh
> >
> > Thanks again for the reviews/suggestions!
> > Cheers,
> >
> >
> > Guilherme
> >
> >
>
> Hi Ard, sorry for the ping =]
>
> Any opinions in this one? Patch 2 is a simple fix, BTW.

Hey,

No worries about the ping - apologies for the late response, I was on vacation.

I still don't see the point of this series, but I will take the fix if
you could please rebase it so it doesn't depend on the first patch.

Thanks,
Ard.
