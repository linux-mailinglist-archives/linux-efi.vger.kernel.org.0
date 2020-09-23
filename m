Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4827595D
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWOF0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgIWOFX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Sep 2020 10:05:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12EC0613CE;
        Wed, 23 Sep 2020 07:05:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d13003cb05fb00c1da4a2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:3cb0:5fb0:c1d:a4a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46B171EC0409;
        Wed, 23 Sep 2020 16:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600869919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6HuhANw8kbWERcNW/iYnFeMlMcA2HBN5jS0VRKC6GY0=;
        b=BNmI2iEv7W8wMHaxMaIsoNNrU2ow8f9CCZwlYDC4adBakZBU8UcRXV8R7oTeLatu2gHkFi
        XTfrEyMzKDNc3ZfWwjLHwKEIm5KYhCoMrwXDTFJa/W6ErpvFgYVRkZAGqCAfkXBLpvJrjV
        UyMOQmGfjVvmsUWt81zcy9qHqKndi5Y=
Date:   Wed, 23 Sep 2020 16:05:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200923140512.GJ28545@zn.tnic>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita,

pls sync the time of the box where you create the patch:

 Date: Fri,  4 Sep 2020 09:04:44 -0500

but your mail headers have:

 Received: from ... with mapi id 15.20.3370.019; Fri, 18 Sep 2020 14:49:12 +0000
 						^^^^^^^^^^^^^^^^^^

On Wed, Sep 23, 2020 at 07:07:17PM +0900, Punit Agrawal wrote:
> I know Boris asked you to add the reason for the Reported-by, but
> usually we don't track version differences in the committed patch.
> 
> Boris, can you confirm if you want the Reported-by to be retained?

How else would you explain what the Reported-by: tag is for on a patch
which adds a feature?

> > + * The first expected register in the register layout of MCAX address space.
> > + * The address defined must match with the first MSR address extracted from
> > + * BERT which in SMCA systems is the bank's MCA_STATUS register.
> > + *
> > + * Note that the decoding of the raw MSR values in BERT is implementation
> > + * specific and follows register offset order of MCAX address space.
> > + */
> > +#define MASK_MCA_STATUS 0xC0002001
> 
> The macro value is already defined in mce.h as
> MSR_AMD64_SMCA_MC0_STATUS.  Is there any reason to not use it?

Good point.

> You can move the comment to where you check the status register.

No need if he really wants to use the first MCi_STATUS address.

> > +	m.apicid = lapic_id;
> > +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
> > +	m.status = *i_mce;
> > +	m.addr = *(i_mce + 1);
> > +	m.misc = *(i_mce + 2);
> > +	/* Skipping MCA_CONFIG */
> > +	m.ipid = *(i_mce + 4);
> > +	m.synd = *(i_mce + 5);
> 
> Instead of using the raw pointer arithmetic, it is better to define a
> structure for the MCA registers? Something like -
> 
>     struct {
>         u64 addr;
>         u64 misc;
>         u64 config;
>         u64 ipid;
>         ...
>     }
> 
> Checking back, this was mentioned in the previous review comments as
> well. Please address all comments before posting a new version - either
> by following the suggestion or explaining why it is not a good idea.

Well, that was addressed in his reply last time:

https://lkml.kernel.org/r/a28aa613-8353-0052-31f6-34bc733abf59@amd.com

You might've missed it because you weren't CCed directly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
