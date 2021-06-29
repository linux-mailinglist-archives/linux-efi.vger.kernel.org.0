Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D318C3B7743
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jun 2021 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhF2RgC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 13:36:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2Rf6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 13:35:58 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8EFC31FD8F;
        Tue, 29 Jun 2021 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624988009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATW6Ca30ZVV7Zzd+CeAnHIUpIriktflFykS2CyCKVU=;
        b=uxNn0trq96rjaJlhGmwt9nsqODDA6IvN3PPpJ5pLk6OxC6qBfAgIVpB5NRGMBE6k8IOXmv
        ZSr1dwfkXmzSEkbW7k/NgzESvoQka9c2YO3aHmlvDbMXOxpDaDv3x93LomyFeoXQWtl7KR
        B5yx/g/zAs4hqWi4ySdPiunHS+DKSKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624988009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATW6Ca30ZVV7Zzd+CeAnHIUpIriktflFykS2CyCKVU=;
        b=Zka4re+vRWBErBR3ow9OxmqXnLm6TloqkjJiAV7fQVsYLeVWuXjSfTukR3Tr5dKPJE6Dm0
        FDRQ/vAhvGvrrBBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7477A11906;
        Tue, 29 Jun 2021 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624988009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATW6Ca30ZVV7Zzd+CeAnHIUpIriktflFykS2CyCKVU=;
        b=uxNn0trq96rjaJlhGmwt9nsqODDA6IvN3PPpJ5pLk6OxC6qBfAgIVpB5NRGMBE6k8IOXmv
        ZSr1dwfkXmzSEkbW7k/NgzESvoQka9c2YO3aHmlvDbMXOxpDaDv3x93LomyFeoXQWtl7KR
        B5yx/g/zAs4hqWi4ySdPiunHS+DKSKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624988009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ATW6Ca30ZVV7Zzd+CeAnHIUpIriktflFykS2CyCKVU=;
        b=Zka4re+vRWBErBR3ow9OxmqXnLm6TloqkjJiAV7fQVsYLeVWuXjSfTukR3Tr5dKPJE6Dm0
        FDRQ/vAhvGvrrBBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id H0KjHGlZ22C1YAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 29 Jun 2021 17:33:29 +0000
Date:   Tue, 29 Jun 2021 19:33:24 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] Allow access to confidential computing secret
 area
Message-ID: <YNtZZLWOO+qO/oAu@zn.tnic>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <YNoiydeow+ftvfYX@zn.tnic>
 <90fa45e6-8c24-6c72-2ef5-35a4b3c4d5d7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90fa45e6-8c24-6c72-2ef5-35a4b3c4d5d7@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 29, 2021 at 10:16:22AM +0300, Dov Murik wrote:
> OK, I'll add it in the cover letter; something along the lines of:
>
> An example would be a guest performing computations on encrypted files.
>  The Guest Owner provides the decryption key (= secret) using the secret
> injection mechanism.  The guest application reads the secret from the
> sev_secret filesystem and proceeds to decrypt the files into memory and
> then performs the needed computations on the content.
>
> Host can't read the files from the disk image because they are
> encrypted. Host can't read the decryption key because it is passed using
> the secret injection mechanism (= secure channel). Host can't read the
> decrypted content from memory because it's a confidential
> (memory-encrypted) guest.

Yap, much better, thanks!

And that whole deal with the providing the secret this way is because
you want to be starting the same guest image in the cloud over and over
again but each guest owner would have their own decryption key which
they would supply this way.

Yap, good.

> On one hand, I agree.  This entire series has no SEV-specific code (but
> I tested it only on SEV).
> 
> On the other hand, secret injection mechanisms in SEV-SNP and TDX are
> different beasts than the one used here (SEV).  In SEV the secrets must
> be injected at VM launch time; so when OVMF runs and kernel efistub runs
> the secrets are already there (patches 1+2).  However, in SNP there's no
> secret injection at launch; (/me hand-waving) the guest can securely
> talk with the PSP hardware, check the attestation, and if OK then
> securely contact some Guest Owner secret provider to get the required
> secrets.  Not sure it makes sense for the kernel to be part of this
> "getting secrets from secret provider and exposing them in securityfs".

Which begs the question: why are you even doing this for only SEV
instead of supporting SEV-SNP/TDX only?

I'm under the impression that people should run only SNP and the
equivalent of that in TDX, guests but not those earlier technologies
which are lacking in some situations.

> So maybe for regular SEV we'll use this sev_secret module to get one
> secret which will allow the guest to contact to the Guest Owner secret
> provider (and from here continue like SNP or TDX).  Brijesh (AMD) also
> suggested collapsing the proposed sev_secret module into the new
> sev-guest module ("[PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest
> driver", sent 2021-06-02),

Which reminds me - I still need to take a look at that one.

> and the logic suggested here will be used when SNP is not active.
>
> Or taking a step back: Maybe the kernel should not try to unify
> SEV/SEV-SNP/TDX/PEF/s390x-SE.  Each should have its own API.  A
> userspace process will have to understand what is available and get the
> required info to run the application in a confidential environment.
> 
> Or maybe we can find an API that fits all these confidential computing
> mechanisms and expose a unified API that hides the underlying
> implementation.
> 
> (I'm not really sure - that's the reason this is an RFC series.)

I'm gravitating towards a common API so that userspace doesn't have to
care. But that comes at the price of having to define that API properly
so that it fits them all. And we all know how that bikeshedding works.

:-\

> When I wrote this I didn't yet encounter "coco" as an abbreviation. Now
> there's a linux-coco mailing list, but I saw no other mentions of it in
> the kernel (as an abbreviation for confidential computing).

That's what Joerg and me came up with - "coco" :-)

> I agree that the full term is too long; I considered conf-comp (but in
> my mind "conf" is short for "configuration").  I used it in one place:
> "ConfCompSecret" in patch 2/3.
> 
> If as a community we settle on coco / CoCo / COCO then I agree these
> should be renamed.
> 
> (in QEMU they use CGS = Confidential Guest Support [1].)

That's not bad too.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
