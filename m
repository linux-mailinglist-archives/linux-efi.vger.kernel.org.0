Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF514858C6
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiAETBK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 14:01:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37068 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiAETBK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 14:01:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B50811F37F;
        Wed,  5 Jan 2022 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641409268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMk/iBCnuolFfaVy2sRecgDIKimfkn7v/VHUdkSCka4=;
        b=VtYseXoPFrEXNU/xiEHDrVD53w0VlbY0RAoEVKmDwu5MOcoE6wQEns0mxnoFWm4KdghqcE
        iFE7LBE/MtOMpy1Iiair3N4zhFnbOzDH4+Uravan9ZYMJKvJ6Txjfk//Bda0MREidaBTjm
        YTvVn6bhyJhtEHefWg9j4T+2xQY0+Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641409268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMk/iBCnuolFfaVy2sRecgDIKimfkn7v/VHUdkSCka4=;
        b=DokSUB8No6Xf8uFG+iQtw++vQ1lCVr1hAzWfJ8DHuH02B1pS96+jYMIcpJURwBaiDeAB8U
        mvNxAwVyPfVaagAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96D0B13C09;
        Wed,  5 Jan 2022 19:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbhDI/Tq1WEJSgAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 05 Jan 2022 19:01:08 +0000
Date:   Wed, 5 Jan 2022 20:01:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Message-ID: <YdXq9t75aYLJfb69@zn.tnic>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
 <YdWEXRt7Ixm6/+Dq@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdWEXRt7Ixm6/+Dq@work-vm>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 11:43:25AM +0000, Dr. David Alan Gilbert wrote:
> There's more than one type of dance;

So Brijesh and I talked about this a bit yesterday. There's all kinds of
dances...

> this partially varies depending on the system (SEV/TDX etc)

By "SEV" I guess you mean pre-SNP because SNP attestation is reportedly
much better.

TDX I'm being told is not interested in something like that atm. I guess
they wanna do something different wrt attestation.

So what we're talking about here is pre-SNP attestation, AFAICT.

> and also depends on how you depend to boot your VM (separate kernel
> or VM disk). Also it's important to note that when the dance happens
> varies - in SEV and SEV-ES this happens before the guest executes any
> code. So at the end of the dance, the guest owner hands over that
> secret - but only then does the geust start booting;

Right.

> that secret has to go somewhere to be used by something later. For
> example, something might pull out that key and use it to decrypt a
> disk that then has other secrets on it (e.g. your ssh key).

That is the other example I heard about.

So, to sum up: this looks like part of a pre-SNP attestation flow, i.e.,
for SEV and SEV-ES guests.

Follow-up question: is this going to be used by other cloud vendors too?
Or am I gonna get another implementation of sharing secrets with a guest
which is just a little bit different but sender #2 can't use this one
because raisins?

Because that would not be good.

So, is this what cloud vendors using SEV/-ES guests would like to use
and what they all agree upon?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
