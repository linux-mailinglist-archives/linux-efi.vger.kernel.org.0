Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AB48FEC1
	for <lists+linux-efi@lfdr.de>; Sun, 16 Jan 2022 21:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiAPULD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Jan 2022 15:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiAPULD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Jan 2022 15:11:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1DC061574;
        Sun, 16 Jan 2022 12:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F922B80D49;
        Sun, 16 Jan 2022 20:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6D3C36AE7;
        Sun, 16 Jan 2022 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642363859;
        bh=K8dq2SS/1E+MId/jLcvnwzthKldgV0LgxQD+HLDX/hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heOAdNTz/aUqMZPUeB9F0UtRH9Lly8SoLlhjUh91VDyfjSozHaCEjZiE9JDLTo4yK
         l4MyM3+FWAdlgN5o11OyOiQCF5CzE22NqOUFDoMESe2kH/5DXW11/0soNv+h49dkjc
         cUAS1I7VAyUtRqmwoVhB6JzL1vuv12NQIAC9F2rNP2D505LSpmIYP/UHxzrM2mNa9y
         GtUT72ZpI7LNG+fg4vpPSuQE0PqBtJ2lM2TOG40ElMlzuVnsNcc8afN7DGTaVFU+nr
         8Z4C9Wo7jcYa0swkLzo9I7usOHwOLfdqn9Uyu0ivrlOXx+cg7+Ba5kSeBqA/hrOnir
         m7iX6Fam6SODQ==
Date:   Sun, 16 Jan 2022 22:10:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, eric.snowberg@oracle.com
Cc:     David Howells <dhowells@redhat.com>,
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
Message-ID: <YeR7x9fMuvW/dvRA@iki.fi>
References: <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
 <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
 <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
 <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
 <YeMAURSR8/fRjBHD@iki.fi>
 <153F495F-EAF9-4C11-A476-293CC3B78F0A@oracle.com>
 <YeMdIrMXbSq7BgzY@iki.fi>
 <YeMdY+FLM32tmRMz@iki.fi>
 <f8598ca4e51e0b98aa98a1386c6f40bd04acdf15.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8598ca4e51e0b98aa98a1386c6f40bd04acdf15.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 15, 2022 at 09:55:47PM -0500, Mimi Zohar wrote:
> On Sat, 2022-01-15 at 21:15 +0200, Jarkko Sakkinen wrote:
> > On Sat, Jan 15, 2022 at 09:14:45PM +0200, Jarkko Sakkinen wrote:
> > > On Sat, Jan 15, 2022 at 07:12:35PM +0000, Eric Snowberg wrote:
> > > > 
> > > > 
> > > > > On Jan 15, 2022, at 10:11 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > 
> > > > > On Wed, Jan 12, 2022 at 02:41:47PM -0500, Mimi Zohar wrote:
> > > > >> On Tue, 2022-01-11 at 20:14 -0500, Mimi Zohar wrote:
> > > > >>> On Tue, 2022-01-11 at 21:26 +0000, Eric Snowberg wrote:
> > > > >>>> 
> > > > >>>>> On Jan 11, 2022, at 11:16 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > >>>>> 
> > > > >>>>> On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> > > > >>>>>>> Jarkko, my concern is that once this version of the patch set is
> > > > >>>>>>> upstreamed, would limiting which keys may be loaded onto the .machine
> > > > >>>>>>> keyring be considered a regression?
> > > > >>>>>> 
> > > > >>>>>> 
> > > > >>>>>> Currently certificates built into the kernel do not have a CA restriction on them.  
> > > > >>>>>> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> > > > >>>>>> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> > > > >>>>>> 
> > > > >>>>>> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> > > > >>>>>> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> > > > >>>>>> Kconfig option was not set for enforcement, it would work as it does in this series, 
> > > > >>>>>> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> > > > >>>>>> the restriction placed in this patch. Let me know your thoughts on whether this would 
> > > > >>>>>> be an appropriate solution.  I believe this would get around what you are identifying as 
> > > > >>>>>> a possible regression.
> > > > >>>>> 
> > > > >>>>> True the problem currently exists with the builtin keys, but there's a
> > > > >>>>> major difference between trusting the builtin keys and those being
> > > > >>>>> loading via MOK.  This is an integrity gap that needs to be closed and
> > > > >>>>> shouldn't be expanded to keys on the .machine keyring.
> > > > >>>>> 
> > > > >>>>> "plus it would allow IMA to work with non-CA keys" is unacceptable.
> > > > >>>> 
> > > > >>>> Ok, I’ll leave that part out.  Could you clarify the wording I should include in the future 
> > > > >>>> cover letter, which adds IMA support, on why it is unacceptable for the end-user to
> > > > >>>> make this decision?
> > > > >>> 
> > > > >>> The Kconfig IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> > > > >>> "help" is very clear:
> > > > >> 
> > > > >> [Reposting the text due to email formatting issues.]
> > > > >> 
> > > > >> help
> > > > >>  Keys may be added to the IMA or IMA blacklist keyrings, if the
> > > > >>  key is validly signed by a CA cert in the system built-in or
> > > > >>  secondary trusted keyrings.
> > > > >> 
> > > > >>  Intermediate keys between those the kernel has compiled in and the 
> > > > >>  IMA keys to be added may be added to the system secondary keyring,
> > > > >>  provided they are validly signed by a key already resident in the
> > > > >>  built-in or secondary trusted keyrings.
> > > > >> 
> > > > >> 
> > > > >> The first paragraph requires "validly signed by a CA cert in the system
> > > > >> built-in or secondary trusted keyrings" for keys to be loaded onto the
> > > > >> IMA keyring.  This Kconfig is limited to just the builtin and secondary
> > > > >> keyrings.  Changing this silently to include the ".machine" keyring
> > > > >> introduces integrity risks that previously did not exist.  A new IMA
> > > > >> Kconfig needs to be defined to allow all three keyrings - builtin,
> > > > >> machine, and secondary.
> > > > >> 
> > > > >> The second paragraph implies that only CA and intermediate CA keys are
> > > > >> on secondary keyring, or as in our case the ".machine" keyring linked
> > > > >> to the secondary keyring.
> > > > >> 
> > > > >> Mimi
> > > > >> 
> > > > > I have also now test environment for this patch set but if there are
> > > > > any possible changes, I'm waiting for a new version, as it is anyway
> > > > > for 5.18 cycle earliest.
> > > > 
> > > > Other than the two sentence changes, I have not seen anything identified 
> > > > code wise requiring a change.  If you’d like me to respin a v10 with the sentence 
> > > > changes let me know.  Or if you want to remove the ima reference, that works 
> > > > too.  Just let me know how you want to handle this.  Thanks.
> > > 
> > > I'm basically waiting also Mimi to test this as I do not have IMA test
> > > environment.
> > > 
> > > From my side:
> > > 
> > > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > I can pick the whole thing at the time when I get green light.
> 
> The MOK keys are not loaded onto the .machine keyring if
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled. 
> From an IMA perspective nothing has changed.
> 
> After the IMA references in the patch descriptions are removed, feel
> free to add Tested-by: Mimi Zohar <zohar@linux.ibm.com> on patches 1 -
> 5.
> 
> thanks,
> 
> Mimi

Eric, for me it would be at least a convenience, and overally it would
make sure that I pick the right thing if you would fix the typos (and
you can add all the tested-by tags of course as no functional changes).

There's been times when I've manually "just fixed typos", and failed in a
way or another because of human error. Just want to make sure that we
have exactly the right content applied, I hope you understand my point
of view. And we are early for the 5.18 release cycle anyway.

BR, Jarkko
