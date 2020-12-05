Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7962CFEC8
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 21:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLEUYx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 15:24:53 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:56836 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgLEUYx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Dec 2020 15:24:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A735712807EE;
        Sat,  5 Dec 2020 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607199852;
        bh=RJWRKeM75TPcaSmixH5brJ7GCscGOZgWeb4zEy4dY/E=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dDZX3ESnB2MSNgiTIlfcQPDZyzqdkQAa+fuJGGnRahW9junzHoJHKMOZ0/s4ptGla
         cUW6x4+a9URmzQSfeazKZxqddGAllqWaGwEf8Z/ETK8YMIdsHM2CZcd9+0greLvBdp
         d1PzM1pixKSrbdmOnwQRVnkeSsnET4nz51v7kDH4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MH9Raau2aptJ; Sat,  5 Dec 2020 12:24:12 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4282012806C7;
        Sat,  5 Dec 2020 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607199852;
        bh=RJWRKeM75TPcaSmixH5brJ7GCscGOZgWeb4zEy4dY/E=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dDZX3ESnB2MSNgiTIlfcQPDZyzqdkQAa+fuJGGnRahW9junzHoJHKMOZ0/s4ptGla
         cUW6x4+a9URmzQSfeazKZxqddGAllqWaGwEf8Z/ETK8YMIdsHM2CZcd9+0greLvBdp
         d1PzM1pixKSrbdmOnwQRVnkeSsnET4nz51v7kDH4=
Message-ID: <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 05 Dec 2020 12:24:10 -0800
In-Reply-To: <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
         <20201204170319.20383-8-laniel_francis@privacyrequired.com>
         <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
         <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
         <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2020-12-05 at 20:36 +0100, Ard Biesheuvel wrote:
> On Fri, 4 Dec 2020 at 19:02, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> > > On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> > > wrote:
> > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > > 
> > > > The two functions indicates if a string begins with a given
> > > > prefix. The only difference is that strstarts() returns a bool
> > > > while str_has_prefix() returns the length of the prefix if the
> > > > string begins with it or 0 otherwise.
> > > > 
> > > 
> > > Why?
> > 
> > I think I can answer that.  If the conversion were done properly
> > (which it's not) you could get rid of the double strings in the
> > code which are error prone if you update one and forget
> > another.  This gives a good example: 3d739c1f6156 ("tracing: Use
> > the return of str_has_prefix() to remove open coded numbers"). so
> > in your code you'd replace things like
> > 
> >     if (strstarts(option, "rgb")) {
> >         option += strlen("rgb");
> >         ...
> > 
> > with
> > 
> >     len = str_has_prefix(option, "rgb");
> >     if (len) {
> >         option += len
> >         ...
> > 
> > Obviously you also have cases where strstart is used as a boolean
> > with no need to know the length ... I think there's no value to
> > converting those.
> > 
> 
> This will lead to worse code being generated. strlen() is evaluated
> at build time by the compiler if the argument is a string literal, so
> your 'before' version gets turned into 'option += 3', whereas the
> latter needs to use a runtime variable.

str_has_prefix() is an always_inline function so it should be build
time evaluated as well.  I think most compilers see len as being a
constant and unchanged, so elide the variable.  This means the code
generated should be the same.

> So I don't object to using str_has_prefix() in new code in this way,
> but I really don't see the point of touching existing code.

That's your prerogative as a Maintainer ... I was just explaining what
the original author had in mind when str_has_prefix() was created.

James


