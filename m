Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5492CFF25
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLEVQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 16:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEVQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Dec 2020 16:16:32 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FEC0613CF;
        Sat,  5 Dec 2020 13:15:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 90E4A12804A3;
        Sat,  5 Dec 2020 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607202951;
        bh=OckBqgE0BaUlnIbRshFb8j9AGvCdApdXfSoQejQkmtU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hcmBlNlsGENkWstMLc2EmWRbCXwty/p7UWTBMcfsrOin6O2EtnFm48Rtt/p0v54Nt
         RANgVRSMW/CGCh2CRKfVWnvN0djWXQO0mhvwERrfFcnc7krMouoMB5hVx7hcSIG48b
         xUYfqkZOOHauQxcew8LQZ/J/9A5EJE2BJDFGigOU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IyJdAlYja8mM; Sat,  5 Dec 2020 13:15:51 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 215D7128048D;
        Sat,  5 Dec 2020 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607202951;
        bh=OckBqgE0BaUlnIbRshFb8j9AGvCdApdXfSoQejQkmtU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hcmBlNlsGENkWstMLc2EmWRbCXwty/p7UWTBMcfsrOin6O2EtnFm48Rtt/p0v54Nt
         RANgVRSMW/CGCh2CRKfVWnvN0djWXQO0mhvwERrfFcnc7krMouoMB5hVx7hcSIG48b
         xUYfqkZOOHauQxcew8LQZ/J/9A5EJE2BJDFGigOU=
Message-ID: <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 05 Dec 2020 13:15:50 -0800
In-Reply-To: <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
         <20201204170319.20383-8-laniel_francis@privacyrequired.com>
         <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
         <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
         <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
         <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
         <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Rostedt added because this is all his fault]
On Sat, 2020-12-05 at 21:57 +0100, Ard Biesheuvel wrote:
> On Sat, 5 Dec 2020 at 21:24, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > > So I don't object to using str_has_prefix() in new code in this
> > > way, but I really don't see the point of touching existing code.
> > 
> > That's your prerogative as a Maintainer ... I was just explaining
> > what the original author had in mind when str_has_prefix() was
> > created.
> > 
> 
> Sure, I fully understand you are not the one proposing these changes.
> 
> But if the pattern in question is so common, couldn't we go one step
> further and define something like
> 
> static inline const u8 *skip_prefix_or_null(const u8 *str, const u8
> *prefix)
> {
> }
> 
> which returns a pointer into the original string, or NULL if the
> prefix is not present.
> 
> The current patch as proposed has no benefit whatsoever, but even the
> meaningful alternative you are proposing is not actually an
> improvement, given that it is not self-explanatory from the name
> 'str_has_prefix' what it returns, and so the code becomes more
> difficult to understand.

Ah, so this is the kernel maintainer's syndrome: you see an API which
isn't quite right for your use case, so you update or change it.  Then
you see other use cases for it and suddenly to you it becomes the best
thing since sliced bread and with a one ring to rule them all mentality
you exhort everyone to use this new API everywhere.  See this comment
in the merge commit (495d714ad1400) which comes from the merge cover
letter:

>     - Addition of str_has_prefix() and a few use cases. There
>       currently is a similar function strstart() that is used in a 
>       few places, but only returns a bool and not a length. These 
>       instances will be removed in the future to use 
>       str_has_prefix() instead.

Then you forget about it until someone else acts on your somewhat ill
considered instruction and actually tries the replacement.  Once
someone takes up your cause, the API shows up in dozens of emails and
the actual debate about whether or not this is such a good API really
begins, with the poor person who picked it up caught in the crossfire.

As maintainers we really should learn to put the cart before the horse.

James


