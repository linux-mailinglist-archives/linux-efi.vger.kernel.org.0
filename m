Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4174847CF
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 19:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiADS03 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 13:26:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33236 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiADS02 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 13:26:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F00FF1F37F;
        Tue,  4 Jan 2022 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641320787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCQy3yoyFL7ECUYAU0Ae6aUvtK+Hq4hiYnMytj5+eik=;
        b=YK05IgeZLaqlRHJRD81Jr3Oh5vHQqFGLshx9xtpB7BFXFMrT+Np6Dx3fuaFwIQyqmirm8u
        4j8AYIMWQvhHAL5Hnx8BioTAHsf/JdQalSROq9A7dfHWGkzG4MdRQYnCKHfGZGGbkdFgKS
        REUsm064g7UiIFYclhkCU+RCJz0klAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641320787;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCQy3yoyFL7ECUYAU0Ae6aUvtK+Hq4hiYnMytj5+eik=;
        b=9EWMIxklog7t5O4tilO9nSmkB3H6W8Zd5Y5nwPXvGAlAVC8audRwReWlcJFgMJPldYH/RA
        cakI+rxBva851tCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE4B13B35;
        Tue,  4 Jan 2022 18:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hmG+MVKR1GEhfQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Jan 2022 18:26:26 +0000
Date:   Tue, 4 Jan 2022 19:26:34 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdSRWmqdNY7jRcer@zn.tnic>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 04, 2022 at 09:02:03AM +0200, Dov Murik wrote:
> If the Guest Owner chooses to inject secrets via scp, it needs
> to be sure it is scp-ing to the correct VM - the one that has SEV
> enabled and was measured at launch.

Hmm, I'd expect that to be part of the attestation dance. I admit,
though, I have only listened about the whole attestation bla from the
sidelines so I'm unclear whether that's part of that protocol. I guess
Tom and Brijesh should have a better idea here.

> One way to achieve that would be to inject the guest's SSH private key

Well, is that "one way" or *the way*?

> using the proposed efi_secret mechanism.  This way the Guest Owner is
> sure it is talking to the correct guest and not to some other VM that
> was started by the untrusted cloud provider (say, with SEV disabled so
> the cloud provider can steal its memory content).

Because we would need *some* way of verifying the owner is talking
to the correct guest. And if so, this should be made part of the big
picture of SEV guest attestation. Or is this part of that attestation
dance?

I guess I'm wondering where in the big picture this fits into?

> Indeed this proposed efi_secret module is in use for enabling SEV
> confidential containers using Kata containers [1], but there's nothing
> specific in the current patch series about containers.  The patch series
> just exposes the launch-injected SEV secrets to userspace as virtual files
> (under securityfs).
> 
> [1] https://github.com/confidential-containers/attestation-agent/tree/main/src/kbc_modules/offline_sev_kbc

So one of the aspects for this is to use it in automated deployments.

> It boils down to: the confidential guest needs to have access to a
> secret which the untrusted host can't read, and which is essential for
> the normal operation of the guest.  This secret can be a decryption key,
> an SSH private key, an API key to a Key Management system, etc.  If a
> malicious cloud provider tries to start that VM without a secret (or
> with the wrong one), the actual workload that the guest is supposed to
> run will not execute meaningfully.
> 
> The proposed patch series exposes the SEV injected secrets as virtual
> files, which can later be used as decryption keys (as done in the kata
> confidential containers use-case), or SSH private keys, or any other
> possible implementation.

Right, and is this going to be the proper way to authenticate SEV guests
to their owners or is this just another technique for safely supplying
secrets into the guest?

I hope I'm making some sense here...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
