Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E34851F6
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 12:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiAELnd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 06:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235184AbiAELnd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 06:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641383012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZRqLCV1AQpi4/pbS4HKIi2vod3d/KjNFKlZbvvJOJw=;
        b=IY3MTieLduVVmc9WITDOn4pO6gsThvz1A3DFOaAlLPtJueU6XH7+KYiRlIGiEb1kj7GoCC
        7ANkq6cb8WjtyhV/4sXe8e2utP0W/zfFUJ1T9ZMIDyEB814Y7C2Bs8WItCv3YoXixjuT+o
        61nYOZOFH7RUWjdeTGk3i97N8LujNyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-mChnGkQkPzGKCLXsyd57ZQ-1; Wed, 05 Jan 2022 06:43:31 -0500
X-MC-Unique: mChnGkQkPzGKCLXsyd57ZQ-1
Received: by mail-wr1-f70.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso12570072wrg.11
        for <linux-efi@vger.kernel.org>; Wed, 05 Jan 2022 03:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vZRqLCV1AQpi4/pbS4HKIi2vod3d/KjNFKlZbvvJOJw=;
        b=k9VViHBhxGd5JSCwL0+fZF2IwMJk6GqpUdpeeV0V9HFf4Z8zVqMYPu7IRlKg8Mzgyt
         isT76/BREWsIwBKrR4NbfTOkKOByBh3TRws7wRqpUXjKH9drZfq7wHlWcWq0/dgTAWSk
         yqBNQ1Y1TCwRGaw8JFkhX8h3OiityQ6n+regkeQagYEPqi1K7B26Q2IaXHwtMbiJCF1G
         rkcR3xO4vXHxXX/XVv0+0+quUQ8grn5eO7qnhZopbgOcmpnBV4Awa/bwdHH2UjLebJIK
         ZSge+Eug9GM1fzzO1lgATDFETrTab0Z/tdXQ1ghdKYiwKkZl5x8Kot/3m5Pxyc3U7qdy
         l8Ew==
X-Gm-Message-State: AOAM530QAfQHp1OpVEg1uLzL3nh+98WJnb2X5Eyqab1Rr8MG/q9qT/2n
        4SyUx+VcyrbIjy29F3X8PwdOAqlEszinP8vgoL/UPhtTLZSliAudwByuZi1mz1epGHLCr+gRG+6
        UhxvAdOQ+xXb62E+RzYOT
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr45048001wrx.514.1641383010396;
        Wed, 05 Jan 2022 03:43:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0ND3sp1KAm9XvjE31Azjsac5utQcfs8uXXLrux4uumEKa2/x8xhMt+qfPbb1B2mJgzhIwuA==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr45047983wrx.514.1641383010177;
        Wed, 05 Jan 2022 03:43:30 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id f8sm43265636wry.16.2022.01.05.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:43:29 -0800 (PST)
Date:   Wed, 5 Jan 2022 11:43:25 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdWEXRt7Ixm6/+Dq@work-vm>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdSRWmqdNY7jRcer@zn.tnic>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Borislav Petkov (bp@suse.de) wrote:
> On Tue, Jan 04, 2022 at 09:02:03AM +0200, Dov Murik wrote:
> > If the Guest Owner chooses to inject secrets via scp, it needs
> > to be sure it is scp-ing to the correct VM - the one that has SEV
> > enabled and was measured at launch.
> 
> Hmm, I'd expect that to be part of the attestation dance. I admit,
> though, I have only listened about the whole attestation bla from the
> sidelines so I'm unclear whether that's part of that protocol. I guess
> Tom and Brijesh should have a better idea here.

There's more than one type of dance; this partially varies
depending on the system (SEV/TDX etc) and also depends on how you depend
to boot your VM (separate kernel or VM disk).   Also it's important to
note that when the dance happens varies - in SEV and SEV-ES this happens
before the guest executes any code.
So at the end of the dance, the guest owner hands over that secret - but
only then does the geust start booting; that secret has to go somewhere
to be used by something later.
For example, something might pull out that key and use it to decrypt a
disk that then has other secrets on it (e.g. your ssh key).

Dave

> > One way to achieve that would be to inject the guest's SSH private key
> 
> Well, is that "one way" or *the way*?
> 
> > using the proposed efi_secret mechanism.  This way the Guest Owner is
> > sure it is talking to the correct guest and not to some other VM that
> > was started by the untrusted cloud provider (say, with SEV disabled so
> > the cloud provider can steal its memory content).
> 
> Because we would need *some* way of verifying the owner is talking
> to the correct guest. And if so, this should be made part of the big
> picture of SEV guest attestation. Or is this part of that attestation
> dance?
> 
> I guess I'm wondering where in the big picture this fits into?
> 
> > Indeed this proposed efi_secret module is in use for enabling SEV
> > confidential containers using Kata containers [1], but there's nothing
> > specific in the current patch series about containers.  The patch series
> > just exposes the launch-injected SEV secrets to userspace as virtual files
> > (under securityfs).
> > 
> > [1] https://github.com/confidential-containers/attestation-agent/tree/main/src/kbc_modules/offline_sev_kbc
> 
> So one of the aspects for this is to use it in automated deployments.
> 
> > It boils down to: the confidential guest needs to have access to a
> > secret which the untrusted host can't read, and which is essential for
> > the normal operation of the guest.  This secret can be a decryption key,
> > an SSH private key, an API key to a Key Management system, etc.  If a
> > malicious cloud provider tries to start that VM without a secret (or
> > with the wrong one), the actual workload that the guest is supposed to
> > run will not execute meaningfully.
> > 
> > The proposed patch series exposes the SEV injected secrets as virtual
> > files, which can later be used as decryption keys (as done in the kata
> > confidential containers use-case), or SSH private keys, or any other
> > possible implementation.
> 
> Right, and is this going to be the proper way to authenticate SEV guests
> to their owners or is this just another technique for safely supplying
> secrets into the guest?
> 
> I hope I'm making some sense here...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

