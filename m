Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E48EA1E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2019 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHOLVj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Aug 2019 07:21:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52840 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOLVj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Aug 2019 07:21:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so984054wmh.2
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6nyfuCopJj2adR1qGDzlfll057Ee/X+g7GhOaBeG3Y=;
        b=Zfp4bJrFLKmvateXnLFVB2aOO8rcYNC8IVlalgbJeNQAEqD8iTrcbBQnIc3TCFFvKU
         gz0cIBhKKNZ2eg85AGi26Ik2uvmFMjD7VVCe821PvIAdePTFw4zbbUKUyaraYFYja3+w
         IGdf7EzY3kTvizpaxvUHgouBuDZbiGVPDlCsVdB8crkRNOc8kIfER2GZyTuisBsrfiai
         zvifycBlWYn83kMvX3Iu4cZIy7Dm7C56IIBlJz8auqrmWtpC9wtq4anjdsVhVNQ1mAmF
         Fe7WAlnbWE4s7GhCCUoB/yGJtd79DhkuSoOC7soSlEMbOnfa1jUCVdxX9ab2W3GR1oJU
         QMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6nyfuCopJj2adR1qGDzlfll057Ee/X+g7GhOaBeG3Y=;
        b=NB4CDGjBWAdAYuYcTD/rGJvN3t2a5GsaOxXOJGZS4yJxMqy736iPE50vP+ZUnwVcgj
         ZIcl4ay6KLVa43Dwu3z9fjpDvVYCZjU3HM0xcI1XKe4T7Qlwm88e/95nEFaDi9ww8eav
         niBOXbeoiPLV6q/0WwGBPCJCTG9wrazKbM1r4rADuDeVb1NNDvtvxlP6teZ/IWt9osco
         Mfg9ow68ixSlKZT59voHrvR1mzTWIjwOVIrE52hKh7G2LnAVQwLrM6q4d4poZSmOmPX+
         Ddia4IhJdMOB1SbNFtp9qfOfCazaxSrOows/zVebxmF1K2DkqfWsU4mrL3FMfUblz3E2
         r0yg==
X-Gm-Message-State: APjAAAW6qfrCLd24/9RK6+4/C3HXcoRWZQ5mTSMRiRLQiW7ZuEkl47Vm
        /h5oHzgxvJb2fOUudk33Uj07kJXRMtlv156w/Iwl4g==
X-Google-Smtp-Source: APXvYqw1rtSrgYPyYY8MZcpgO33hubNWpERUaWBsa1dSN+iGC41sb/bhxCxRhQEDV3IhCoI1bBifQ3BVlst6RDBEmsU=
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr2298289wma.53.1565868097096;
 Thu, 15 Aug 2019 04:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJrUJt_HV+8MCGxv4=bq97JFiKqPtgN4ntfei0TmxGhDT-bCQg@mail.gmail.com>
 <20190815110308.GA22153@lakrids.cambridge.arm.com>
In-Reply-To: <20190815110308.GA22153@lakrids.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 15 Aug 2019 14:21:26 +0300
Message-ID: <CAKv+Gu-OoFZRy_fv1z3GmTH3rp=TKviO7rEeFXwqqiWzbgJf3A@mail.gmail.com>
Subject: Re: arm64/efistub boot error with CONFIG_GCC_PLUGIN_STACKLEAK
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     skodde <skodde@gmail.com>, linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Aug 2019 at 14:03, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Aug 15, 2019 at 05:56:27AM -0400, skodde wrote:
> > Hi,
> >
> > I've enabled CONFIG_GCC_PLUGIN_STACKLEAK on 5.2.8 for an arm64
> > macchiatobin board and I get the following error when loading the
> > kernel (using grub-efi on top of edk ii):
> >
> > EFI stub: Booting Linux Kernel...
> > EFI stub: ERROR: efi_get_random_bytes() failed
> > EFI stub: ERROR: Failed to relocate kernel
> >
> > The kernel boots fine with that option disabled, but strangely
> > presents the same error when disabling only CONFIG_RANDOMIZE_BASE.
>
> That shouldn't be possible, given the IS_ENABLED(CONFIG_RANDOMIZE_BASE)
> guard around the efi_get_random_bytes() call, so something sounds wrong.
>
> Are you certain that you're running the same kernel Image that you
> rebuilt?
>
> Ard, do you reckon it would be worth adding the UTS_RELEASE and
> UTS_VERSION to the " Booting Linux Kernel..." string? It would make
> debugging that potential issue easier.
>

Use of the UTS_xxx macros already triggers an annoying number of
object rebuilds every time you change anything entirely unrelated in
your kernel sources, so I'd prefer to avoid this tbh.

> > Let me know if I can provide more info or do some tests.
>
> Maybe there's a problem with stale objects. If you're not doing so
> already, could you try a clean build with CONFIG_RANDOMIZE_BASE
> deselected?
>

Also, can you try booting with the nokaslr command line option added?
