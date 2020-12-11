Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596632D7A95
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbgLKQLx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 11:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390382AbgLKQLd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Dec 2020 11:11:33 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149CC0613D3;
        Fri, 11 Dec 2020 08:10:53 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id j18so2491911qvu.3;
        Fri, 11 Dec 2020 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ivnpuio/ONwC8m2sDHJB3t8+zfHEDLtHHvkUKfGXc2E=;
        b=Ts2g+mousub8ze2Gj/nNpDc88OVX/NhYA17JdjCvAQt2N+02nYZup+dP8W0DbHLsaW
         8n0Sr9w/G2eRCI3Uo9X17GT8CO4HgRXiwLHc/kT1fk6KtGitD8YZOJXvXsTWUdmAnenr
         jdyDTMgUjAtn4kQxGbP/2lOhbIYuBjkuPGirt9VWPgGbz+x/ayRHRbuqKcmfHGYSIGCT
         Co2or2zPxmyOU7EAEPckh8FqKDKxKqL0tCXqOH7eUD2Xobpm1/zyUN9LUzYNMyvU8sdn
         wtPFQrc9EUlFUGCY7IdPz0vr93JriVKekWCtt3AlaRMOCXTGXfDTyGL/ZaRfuEmEqlif
         918g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ivnpuio/ONwC8m2sDHJB3t8+zfHEDLtHHvkUKfGXc2E=;
        b=tkj+lNv7zTO4itScb9RPAXIbhYg82eaa00eGMknneXeOUCSU22zdSTIB/3wUL2uol8
         dLo6nj+7aVOsLYyglRSeJLV6wWrT+kdGrwgUJnB/pNwxpfhfK/qNMOvsmzKJHO7+qasN
         GVtabIxFTcv4gMD+cyGpFP1G+amGJOb31bmquqyOzeZ4S8thGS4Y8uthzNnCA+3wxwis
         LIZdXlWK2akWf5pxqOHdawG9E7+VLTSD3PCtz/hOLdehKzhzOfotuDsP0n6gvSXoF08W
         xmlg7HgyUqRb/dpR0Ihd4cd1SyIrtpMY+9aljqULnv8u1S0S85erstWSRRCh2YnTyhPl
         YXyQ==
X-Gm-Message-State: AOAM531eqoqdAgyCAy6cHY4qWYF9wwjdOT659pgEIB8Tr9aTGpXaABFM
        M9zojSpF4Hh8Q1QzJKGNHu4=
X-Google-Smtp-Source: ABdhPJwK9FWdm3oUSg3pX+2faWLWxHQSswaSJcz6fAEoF9gjm0rtHJ9CHiQxREGmqmDblqkxKCQc8Q==
X-Received: by 2002:a0c:ebc2:: with SMTP id k2mr16536807qvq.24.1607703052541;
        Fri, 11 Dec 2020 08:10:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f185sm7209352qkb.119.2020.12.11.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 08:10:50 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 11 Dec 2020 11:10:48 -0500
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "laniel_francis@privacyrequired.com" 
        <laniel_francis@privacyrequired.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Message-ID: <X9OaCEPwNW3K++t+@rani.riverdale.lan>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
 <X9Jlfqiu/vCOAm3U@rani.riverdale.lan>
 <4c251bcaf8234dd19ca0ecd0a756cf7f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c251bcaf8234dd19ca0ecd0a756cf7f@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 11, 2020 at 09:45:15AM +0000, David Laight wrote:
> From: Arvind Sankar
> > Sent: 10 December 2020 18:14
> ...
> > I wasn't aware of str_has_prefix() at the time. It does seem useful to
> > eliminate the duplication of the string literal, I like the
> > skip_prefix() API suggestion, maybe even
> > 
> > 	bool str_skip_prefix(const char **s, const char *pfx)
> > 	{
> > 		size_t len = str_has_prefix(*s, pfx);
> > 		*s += len;
> > 		return !!len;
> > 	}
> > 	...
> > 	if (str_skip_prefix(&option, prefix)) { ... }
> > 
> > to avoid the intermediate variable.
> 
> That'll generate horrid code - the 'option' variable has to be
> repeatedly reloaded from memory (unless it is all inlined).
> 
> Perhaps the #define
> 
> #define str_skip_prefix(str, prefix) \
> {( \
> 	size_t _pfx_len = strlen(prefix)); \
> 	memcmp(str, pfx, _pfx_len) ? 0 : ((str) += _pfx_len, 1); \
> )}
> 
> There's probably something that'll let you use sizeof() instead
> of strlen() for quoted strings (if only sizeof pfx != sizeof (char *)).
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

Avoiding the intermediate varable is for readability at the call-site,
not performance. The performance of this function shouldn't matter --
you shouldn't be parsing strings in a hotpath anyway, and nobody cares
if the EFI stub takes a few nanoseconds longer if that makes the code
more robust and/or readable.

That said,
- I'd be surprised if the overhead of an L1D cache access was measurable
  over the strncmp()/strlen() calls.
- You can't replace strncmp() with memcmp().
- Regarding sizeof() vs strlen(), you can simply use __builtin_strlen()
  to optimize string literals, there's no need for hacks using the
  preprocessor.
