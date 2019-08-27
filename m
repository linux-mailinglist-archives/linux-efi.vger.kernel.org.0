Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC239DDA6
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2019 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH0GXv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Aug 2019 02:23:51 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39981 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0GXv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Aug 2019 02:23:51 -0400
Received: by mail-qk1-f174.google.com with SMTP id f10so1604300qkg.7
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/hxD6Hr7ptf3a0nm0wbNiKDwCnbC2CQ3RkjlONhTig=;
        b=KArX4XqmEObsHnaBm4GjJXAaKYPwjDKAogelYpBiv9dFe6ZsED4vHJZhoudhagRq1W
         5r8RB28TQGkYfHmdt6aypcTB6kGnkxs9+5gsCwlowKkBHWVzytbsTCdfOsBOh8FpJT4f
         rh4pKTU95hwocUpqRKimsgOR3E9G+xBFPhlB3iezYeBu/UUO+CG7ODlXN5iESTcbLA0A
         /QUuUdbjBhrRTXqKkdyy7ndpbSbV1YJyzrfA8ELJPe8zfv7BqKktY+EDY9tdoWHfQYjC
         2wcyoOrtbMiP23RnT+T2kIxtSIdgd7H+fZm+oscWtJ5ECPFMfY/YSJm/tHiLoemwmppJ
         dToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/hxD6Hr7ptf3a0nm0wbNiKDwCnbC2CQ3RkjlONhTig=;
        b=S65AfhrSkp7zgO8XZLcbAbH9FpQcGxMWhG+1xI6COdZX8QpdtDA7Ea9PoBSMtavmOA
         TrwU0HdEFodzZW7x+R8pkiCX5mn9vGHnAlH3AX6P2kldPyNOSuOmcVYQKlitUCe3MDbg
         RN0LqT2lO11ZjmhxB5f0cfHdTx0IIf7QvWdVxUqWW5xtL4c7sOvsM1jjDvfzG5D6M4T7
         wMI1tRGKppQihyvl56R0cW09BPEuaNxqGGxktDJmtP1QfDAwm9qBiTPGezYsaQxe9ECM
         c6I1bJ37vdrpebziXhQiIKYU2oHaDXakkdEMBa7321753y8A4c4gUePdk4Je4l7WwnDT
         HPqg==
X-Gm-Message-State: APjAAAVnJX57jakjXP2mR4/rd9DOpzkg/m1uEF4dFcRsDkAl/H3AszXY
        gsjJI/yx9jWeoaypPmztaL6u5PCKTCmif4MsP1VXG8nsGDc=
X-Google-Smtp-Source: APXvYqym5CmRL8vHwAZrqeyLTETMdDqFYUYLDO9U8NmrNR74AAMhTnAm/keGm3idiJ+yi5+UHPn6k+e3XVxzLhF0Mxc=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr20171340qkb.457.1566887030069;
 Mon, 26 Aug 2019 23:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47V5G+3UfEzt9wNRr7U-RdLAdCO7JFLQ+QF1JbkuhCcPg@mail.gmail.com>
In-Reply-To: <CAD8Lp47V5G+3UfEzt9wNRr7U-RdLAdCO7JFLQ+QF1JbkuhCcPg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 27 Aug 2019 14:23:39 +0800
Message-ID: <CAD8Lp44Z8ZsPoxTrsXkvRg80FNyMfGH7jN-pdWjjVTdHWXcB5A@mail.gmail.com>
Subject: Re: Early EFI-related boot freeze in parse_setup_data()
To:     linux-efi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 16, 2019 at 2:14 PM Daniel Drake <drake@endlessm.com> wrote:
> Anyway, the system freeze occurs in parse_setup_data(), specifically:
>
>         data = early_memremap(pa_data, sizeof(*data));
>         data_len = data->len + sizeof(struct setup_data);
>
> Dereferencing data->len causes the system to hang. I presume it
> triggers an exception handler due to some kind of invalid memory
> access.
>
> By returning early in that function, boot continues basically fine. So
> I could then log the details: pa_data has value 0x892bb018 and
> early_memremap returns address 0xffffffffff200018. Accessing just a
> single byte at that address causes the system hang.

I noticed a complaint about NX in the logs, right where it does the
early_memremap of this data (which is now at address 0x893c0018):

 Notice: NX (Execute Disable) protection missing in CPU!
 e820: update [mem 0x893c0018-0x893cec57] usable ==> usable
 e820: update [mem 0x893c0018-0x893cec57] usable ==> usable
 e820: update [mem 0x893b3018-0x893bf057] usable ==> usable
 e820: update [mem 0x893b3018-0x893bf057] usable ==> usable

Indeed, in the BIOS setup menu, "NX Mode" was Disabled.
Setting it to Enabled avoids the hang and Linux boots as normal. Weird!

Daniel
