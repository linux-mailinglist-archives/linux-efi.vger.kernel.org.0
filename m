Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3056A48374A
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 19:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiACS7N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 13:59:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33200 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiACS7N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 13:59:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 612F41F38A;
        Mon,  3 Jan 2022 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641236351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdDYxb7brFIwjLIMOPbmEZrjtTPyGQuN72CDxmaZLfg=;
        b=dWmDaI2oEiMKNQ/h2pK0gxKOhJGVFjqcUfy5WlLeoTMbtoQQlT8wuOTfxE0x54/RsZa+VZ
        /++EBkwRXtP2t7HGhnoqHczEUh9lk4s3e8BAYaec/1xND8s+vcu8XL+Ce07b2z3U/vd19h
        El2EFPp6oC8CiFoxXn7gR0qjByjVfrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641236351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdDYxb7brFIwjLIMOPbmEZrjtTPyGQuN72CDxmaZLfg=;
        b=YY2KJsZYLgiXY7d81omY33Rcs8bANCVR9IR8Ege9ggRmiN7gbjvK84EFOydeMNM37fS8jH
        d82mn+0A4voKtTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D3F013B14;
        Mon,  3 Jan 2022 18:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yr13Dn9H02EBPQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 03 Jan 2022 18:59:11 +0000
Date:   Mon, 3 Jan 2022 19:59:14 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <YdNHgtuVoLofL4cW@zn.tnic>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 29, 2021 at 11:42:46AM +0000, Dov Murik wrote:
> As a usage example, consider a guest performing computations on
> encrypted files.  The Guest Owner provides the decryption key (= secret)
> using the secret injection mechanism.  The guest application reads the
> secret from the efi_secret filesystem and proceeds to decrypt the files
> into memory and then performs the needed computations on the content.
> 
> In this example, the host can't read the files from the disk image
> because they are encrypted.  Host can't read the decryption key because
> it is passed using the secret injection mechanism (= secure channel).
> Host can't read the decrypted content from memory because it's a
> confidential (memory-encrypted) guest.

So maybe I don't understand the example properly or something's missing
but why can't the guest owner simply scp the secrets into the guest? Why
is this special thing needed?

The secret below says "...kata-secrets" so this sounds like
something-automated-containers-thing where they'd profit from getting
secrets automatically supplied to the guest. But I guess there you can
scp too...

So what am I missing?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
