Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E596C48773C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jan 2022 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiAGL7F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jan 2022 06:59:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiAGL7E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jan 2022 06:59:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5280E2113B;
        Fri,  7 Jan 2022 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641556743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZViy4ha+GjCcmI2PF81BweyGx62I6IF+pFFopJC3jJs=;
        b=oi9wEuzAhRVZkEW8F/3BAYMe10ZGDWGvvlGZex5LcOM3C/0LXwqg9lLMc0FDR4E2YVIY9U
        3hEaYh4j44STfUXp2Vr6O6tk7F0eAGv1gmrBUMWZ/4BQmkjV9DESlQotQyjs13thwZ7L78
        wpF1m2PfIOj2j45xWcbmWGOjLXz2zS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641556743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZViy4ha+GjCcmI2PF81BweyGx62I6IF+pFFopJC3jJs=;
        b=aVXmdDPISblXMUjDHSNZygTWSUqec5goc3MEtwkn4Sy6Fx8BgMCQN3Uym4SdP6p+1yLDAI
        mGDYrj5O05/qEhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3115A13350;
        Fri,  7 Jan 2022 11:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gZuQCwcr2GEtMQAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 07 Jan 2022 11:59:03 +0000
Date:   Fri, 7 Jan 2022 12:59:09 +0100
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
Message-ID: <YdgrDRCJOOg4k1Za@zn.tnic>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
 <YdWEXRt7Ixm6/+Dq@work-vm>
 <YdXq9t75aYLJfb69@zn.tnic>
 <YdX6aAwy0txT9Dk7@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdX6aAwy0txT9Dk7@work-vm>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 08:07:04PM +0000, Dr. David Alan Gilbert wrote:
> I thought I saw something in their patch series where they also had a
> secret that got passed down from EFI?

Probably. I've seen so many TDX patchsets so that I'm completely
confused what is what.

> As I remember they had it with an ioctl and something; but it felt to
> me if it would be great if it was shared.

I guess we could try to share

https://lore.kernel.org/r/20211210154332.11526-28-brijesh.singh@amd.com

for SNP and TDX.

> I'd love to hear from those other cloud vendors; I've not been able to
> find any detail on how their SEV(-ES) systems actually work.

Same here.

> However, this aims to be just a comms mechanism to pass that secret;
> so it's pretty low down in the stack and is there for them to use -
> hopefully it's general enough.

Exactly!

> (An interesting question is what exactly gets passed in this key and
> what it means).
> 
> All the contentious stuff I've seen seems to be further up the stack - like
> who does the attestation and where they get the secrets and how they
> know what a valid measurement looks like.

It would be much much better if all the parties involved would sit down
and decide on a common scheme so that implementation can be shared but
getting everybody to agree is likely hard...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
