Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020F548F82B
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jan 2022 18:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiAORMC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Jan 2022 12:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiAORMB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Jan 2022 12:12:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B90C061574;
        Sat, 15 Jan 2022 09:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9E07B80967;
        Sat, 15 Jan 2022 17:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD832C36AE7;
        Sat, 15 Jan 2022 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642266718;
        bh=+x1DbKa0d1NTgP8AulnZ1HHW73xrwlfQWVgKa1MsQrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUxmXO3WdFK/4ksG4uOE9ayZhS2f4mBq8i5ikcYJ8i9mmWnVtiFag0kq4UveAG9gc
         yk6U+OH9WKT82707LHv9vcX76LgRzHijxrXm0A6u6Y2Pl3CiSSO9LvZmA/m9vhnluE
         OXmMJvRtKROpc35/IZXnez8t/eUrteOCCxTxmqhAtG7fy4IHsVxq3yOilIYba3cA4n
         QLttt2oZ2iey6DbWQ2hiQWYs7oSdRpBTfOn3zdtLpoWcpk+Ruq673CSfhSRCIeRzeu
         +zQlVdzag9K+inCpiwUKLDqmNGdSw1HZ3YTJz28QscCW8rClQsk2CUVOITIioRhvVk
         h9twzQeEuOIOg==
Date:   Sat, 15 Jan 2022 19:11:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Message-ID: <YeMAURSR8/fRjBHD@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-3-eric.snowberg@oracle.com>
 <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
 <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
 <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
 <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
 <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 12, 2022 at 02:41:47PM -0500, Mimi Zohar wrote:
> On Tue, 2022-01-11 at 20:14 -0500, Mimi Zohar wrote:
> > On Tue, 2022-01-11 at 21:26 +0000, Eric Snowberg wrote:
> > > 
> > > > On Jan 11, 2022, at 11:16 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > 
> > > > On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> > > >>> Jarkko, my concern is that once this version of the patch set is
> > > >>> upstreamed, would limiting which keys may be loaded onto the .machine
> > > >>> keyring be considered a regression?
> > > >> 
> > > >> 
> > > >> Currently certificates built into the kernel do not have a CA restriction on them.  
> > > >> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> > > >> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> > > >> 
> > > >> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> > > >> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> > > >> Kconfig option was not set for enforcement, it would work as it does in this series, 
> > > >> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> > > >> the restriction placed in this patch. Let me know your thoughts on whether this would 
> > > >> be an appropriate solution.  I believe this would get around what you are identifying as 
> > > >> a possible regression.
> > > > 
> > > > True the problem currently exists with the builtin keys, but there's a
> > > > major difference between trusting the builtin keys and those being
> > > > loading via MOK.  This is an integrity gap that needs to be closed and
> > > > shouldn't be expanded to keys on the .machine keyring.
> > > > 
> > > > "plus it would allow IMA to work with non-CA keys" is unacceptable.
> > > 
> > > Ok, I’ll leave that part out.  Could you clarify the wording I should include in the future 
> > > cover letter, which adds IMA support, on why it is unacceptable for the end-user to
> > > make this decision?
> > 
> > The Kconfig IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> > "help" is very clear:
> 
> [Reposting the text due to email formatting issues.]
> 
> help
>   Keys may be added to the IMA or IMA blacklist keyrings, if the
>   key is validly signed by a CA cert in the system built-in or
>   secondary trusted keyrings.
> 
>   Intermediate keys between those the kernel has compiled in and the 
>   IMA keys to be added may be added to the system secondary keyring,
>   provided they are validly signed by a key already resident in the
>   built-in or secondary trusted keyrings.
> 
> 
> The first paragraph requires "validly signed by a CA cert in the system
> built-in or secondary trusted keyrings" for keys to be loaded onto the
> IMA keyring.  This Kconfig is limited to just the builtin and secondary
> keyrings.  Changing this silently to include the ".machine" keyring
> introduces integrity risks that previously did not exist.  A new IMA
> Kconfig needs to be defined to allow all three keyrings - builtin,
> machine, and secondary.
> 
> The second paragraph implies that only CA and intermediate CA keys are
> on secondary keyring, or as in our case the ".machine" keyring linked
> to the secondary keyring.
> 
> Mimi
> 
I have also now test environment for this patch set but if there are
any possible changes, I'm waiting for a new version, as it is anyway
for 5.18 cycle earliest.

/Jarkko
