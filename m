Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F050B489D80
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiAJQ1X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 11:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237311AbiAJQ1X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 11:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641832042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeIheefqGaZ2GeSClHVA0Xt4+ifFFQupgVzVvNBmh9M=;
        b=fdjHwxPPrczJVRc7hVfbf9/GitKhH8oOJLLRoUGMnLdvWu2W+79pi/urEM7wwmHVN5zf4f
        /1c6MxmM4C5lL0JgR8zVNqcdAlSQneifi4W/a800PuagyDL0fkdsxeqzSncJ9O8Cz1gkee
        HD2W00I4ghoiDVJ15L4Aw/JhakOwEAA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-ln5j7PENNdmmsrKcehEgMQ-1; Mon, 10 Jan 2022 11:27:21 -0500
X-MC-Unique: ln5j7PENNdmmsrKcehEgMQ-1
Received: by mail-wm1-f70.google.com with SMTP id i81-20020a1c3b54000000b003467c58cbddso8791483wma.5
        for <linux-efi@vger.kernel.org>; Mon, 10 Jan 2022 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jeIheefqGaZ2GeSClHVA0Xt4+ifFFQupgVzVvNBmh9M=;
        b=RfnvW/rQvzQ7x5EJm5UzQPoPd/tTZU+fmOgvRmEKUhrSdcG37pEBH6P2SmswKgAVbv
         /oPcOQ9gaGpC2pitFlIXqQD0EUYHLXNCP/qSX1SGGOVWXaEJ2ioaPhhV4/vBNIwBXCuQ
         FRwUYOuhxu7V0FQ8M4QnffeqyTYOLSTkztov0a/nhVTfVPDq1ch9KVP2xqYKoYol9J5p
         nkynqOpPJ2Nhv5fERHVQvNOeDL3v0stWeUEP5KrvOysSjIRA0umsIHKGqMhqtgJl7UDa
         ow53/ppdYkFy6TSSrCYrZ0qLIU1RJ3ngyFgS3FggmrGNwigB68y9HZtgM5iX4o1ZSVE4
         iVew==
X-Gm-Message-State: AOAM5318U7eamzGN4pFhcoCDipsVIZzFsXq8cFQRBZwTeamDh/OJzAvj
        tQ6nJUrMhzfnVlFNJb5OcvEov0/DXNFbfIB2bkEpkx9rWRuc7YFBMF0su0Yklt0hxgdewZlOm8Y
        tHRR5iR90anAk74HhB0vI
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr3870367wms.116.1641832040373;
        Mon, 10 Jan 2022 08:27:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw78/dFkceXP7vi+FCTgn09bLS0ejoLHTG16lQIhQ5MhHYjaxHo78dnCGmFqnQo+pPk89TDmg==
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr3870348wms.116.1641832040150;
        Mon, 10 Jan 2022 08:27:20 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id e13sm7183050wmq.10.2022.01.10.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:27:19 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:27:17 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Dov Murik <dovmurik@linux.ibm.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdxeZWmQxbfa+Fa2@work-vm>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
 <YdWEXRt7Ixm6/+Dq@work-vm>
 <YdXq9t75aYLJfb69@zn.tnic>
 <YdX6aAwy0txT9Dk7@work-vm>
 <YdgrDRCJOOg4k1Za@zn.tnic>
 <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Peter Gonda (pgonda@google.com) wrote:
> On Fri, Jan 7, 2022 at 4:59 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > On Wed, Jan 05, 2022 at 08:07:04PM +0000, Dr. David Alan Gilbert wrote:
> > > I thought I saw something in their patch series where they also had a
> > > secret that got passed down from EFI?
> >
> > Probably. I've seen so many TDX patchsets so that I'm completely
> > confused what is what.
> >
> > > As I remember they had it with an ioctl and something; but it felt to
> > > me if it would be great if it was shared.
> >
> > I guess we could try to share
> >
> > https://lore.kernel.org/r/20211210154332.11526-28-brijesh.singh@amd.com
> >
> > for SNP and TDX.
> >
> > > I'd love to hear from those other cloud vendors; I've not been able to
> > > find any detail on how their SEV(-ES) systems actually work.
> >
> > Same here.
> >
> > > However, this aims to be just a comms mechanism to pass that secret;
> > > so it's pretty low down in the stack and is there for them to use -
> > > hopefully it's general enough.
> >
> > Exactly!
> >
> > > (An interesting question is what exactly gets passed in this key and
> > > what it means).
> > >
> > > All the contentious stuff I've seen seems to be further up the stack - like
> > > who does the attestation and where they get the secrets and how they
> > > know what a valid measurement looks like.
> >
> > It would be much much better if all the parties involved would sit down
> > and decide on a common scheme so that implementation can be shared but
> > getting everybody to agree is likely hard...
> 
> I saw a request for other cloud provider input here.

Thanks for the reply!

> A little
> background for our SEV VMs in GCE we rely on our vTPM for attestation,
> we do this because of SEV security properties quoting from AMD being
> to protect guests from a benign but vulnerable hypervisor. So a
> benign/compliant hypervisor's vTPM wouldn't lie to the guest. So we
> added a few bits in the PCRs to allow users to see their SEV status in
> vTPM quotes.

OK, so we're trying to protect from a malicious hypervisor - we don't
trust anything on the host (other than the CPU, and it's got to be
signing the attestation);  we don't think there's a way to do that with
a vTPM on plain SEV/SEV-ES

> It would be very interesting to offer an attestation solution that
> doesn't rely on our virtual TPM. But after reading through this cover
> letter and the linked OVMF patches I am confused what's the high level
> flow you are working towards? Are you loading in some OVMF using
> LAUNCH_UPDATE_DATA, getting the measurement with LAUNCH_MEASURE, then
> sending that to the customer who can then craft a "secret" (maybe say
> SSH key) for injection with LAUNCH_SECRET? Thats sounds good but there
> are a lot details left unattested there, how do you know you will boot
> from the image loaded with the PSP into a known state? Do you have
> some documentation I could read through to try and understand a little
> more and apologies if I missed it.

I'll defer to Dov's reply on that.

Dave

> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

