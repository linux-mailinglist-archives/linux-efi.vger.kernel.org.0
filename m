Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C784179396
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbgCDPfg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:35:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35696 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388222AbgCDPfg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 10:35:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB8D68EE11D;
        Wed,  4 Mar 2020 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583336135;
        bh=yvUo8IjzRxclOUjv2L0BqatO0ZoZ57dg6J4dJmfyKiE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQKMY/tgJYu79uu/Ab1FOmQPT/juFlN89GT+e2FMpLZ8cqHx1ddwMw2iKV4d/5zZy
         0TqIUW+PmiFiMBkPi8i1o+M9tTlJoTA2jWGZZl877fmTR0miZrpGDWaEbOVlk1rBdv
         Dy2XC5ARK0cSRzxALmpMKLJon41wBtUk0gNzmOI0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f31uS89INl0f; Wed,  4 Mar 2020 07:35:35 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C59938EE0FC;
        Wed,  4 Mar 2020 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583336135;
        bh=yvUo8IjzRxclOUjv2L0BqatO0ZoZ57dg6J4dJmfyKiE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQKMY/tgJYu79uu/Ab1FOmQPT/juFlN89GT+e2FMpLZ8cqHx1ddwMw2iKV4d/5zZy
         0TqIUW+PmiFiMBkPi8i1o+M9tTlJoTA2jWGZZl877fmTR0miZrpGDWaEbOVlk1rBdv
         Dy2XC5ARK0cSRzxALmpMKLJon41wBtUk0gNzmOI0=
Message-ID: <1583336133.3284.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 07:35:33 -0800
In-Reply-To: <1583325309.6264.23.camel@linux.ibm.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
         <1583307813.3907.4.camel@HansenPartnership.com>
         <1583325309.6264.23.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-03-04 at 07:35 -0500, Mimi Zohar wrote:
> On Tue, 2020-03-03 at 23:43 -0800, James Bottomley wrote:
> > On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:
> > > diff --git a/security/integrity/ima/Kconfig
> > > b/security/integrity/ima/Kconfig
> > > index 3f3ee4e2eb0d..d17972aa413a 100644
> > > --- a/security/integrity/ima/Kconfig
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> > >  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> > >  	depends on SYSTEM_TRUSTED_KEYRING
> > >  	default y
> > > +
> > > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > +	bool
> > > +	depends on IMA
> > > +	depends on IMA_ARCH_POLICY
> > > +	default n
> > 
> > You can't do this: a symbol designed to be selected can't depend on
> > other symbols because Kconfig doesn't see the dependencies during
> > select.  We even have a doc for this now:
> > 
> > Documentation/kbuild/Kconfig.select-break
> 
> The document is discussing a circular dependency, where C selects B.
>  IMA_SECURE_AND_OR_TRUSTED_BOOT is not selecting anything, but is
> being selected.  All of the Kconfig's are now dependent on
> IMA_ARCH_POLICY being enabled before selecting
> IMA_SECURE_AND_OR_TRUSTED_BOOT.
> 
> As Ard pointed out, both IMA and IMA_ARCH_POLICY are not needed, as
> IMA_ARCH_POLICY is already dependent on IMA.

Then removing them is fine, if they're not necessary ... you just can't
 select a symbol with dependencies because the two Kconfig mechanisms
don't mix.

James

