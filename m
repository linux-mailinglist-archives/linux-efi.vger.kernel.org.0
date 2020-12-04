Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174AF2CF387
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgLDSCv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 13:02:51 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:58148 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgLDSCv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 13:02:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 30E731280B75;
        Fri,  4 Dec 2020 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607104931;
        bh=kOups0pd4uEFpCdetzEgznZGlD3//AIfOfCED5b+e0I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=SiyMTvReH4FFSnovORg1mgYJBXbQmz/EXo22Lk8D5z2wtCvENwSAtBEIHEiCXFl1t
         nljLJqzX8eXkbedHoO8YmiwVnuUQoA8j/Q/Zd/XBzlgqBx37g8ObxbAQZwhKyvm7PC
         +prnLWheDZKgb+CN/mZm5rHurR2QiODgOte/SiZs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DX3AvhYmf693; Fri,  4 Dec 2020 10:02:11 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CEB241280B74;
        Fri,  4 Dec 2020 10:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607104930;
        bh=kOups0pd4uEFpCdetzEgznZGlD3//AIfOfCED5b+e0I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ii7hqO3wVrD7YJMrWWfA626JSjOnYCNm/166zh3ZIrM1IFDN5xaeSbegcjY5SD7mu
         tX4mnvACJxDjafeBfIf2FcqzG+AKgxddsX4e+i1r2nXwrND5x68i65ou4gVGGQKVWK
         ejQ2qzALaSse6ukjejDyu3G9yo3wBVaEh7mAXvWI=
Message-ID: <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        laniel_francis@privacyrequired.com
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Dec 2020 10:02:09 -0800
In-Reply-To: <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
         <20201204170319.20383-8-laniel_francis@privacyrequired.com>
         <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > 
> > The two functions indicates if a string begins with a given prefix.
> > The only difference is that strstarts() returns a bool while
> > str_has_prefix()
> > returns the length of the prefix if the string begins with it or 0
> > otherwise.
> > 
> 
> Why? 

I think I can answer that.  If the conversion were done properly (which
it's not) you could get rid of the double strings in the code which are
error prone if you update one and forget another.  This gives a good
example: 3d739c1f6156 ("tracing: Use the return of str_has_prefix() to
remove open coded numbers"). so in your code you'd replace things like

    if (strstarts(option, "rgb")) {
        option += strlen("rgb");
        ...

with 

    len = str_has_prefix(option, "rgb");
    if (len) {
        option += len
        ...
 
Obviously you also have cases where strstart is used as a boolean with
no need to know the length ... I think there's no value to converting
those.

James


