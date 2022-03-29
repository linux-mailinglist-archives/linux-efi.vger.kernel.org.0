Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578D4EB354
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiC2ScD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiC2ScC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 14:32:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC74DBF958;
        Tue, 29 Mar 2022 11:30:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE7B1FDA3;
        Tue, 29 Mar 2022 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648578618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOgdSKA448mvMIFJegctVtXbSB40Eewz2P1qKdU/+4o=;
        b=jln/eGy+t9QQXg9ItPX+VThMJb1y5WfUgJWvEUUnVSi1L/Aqy1OxEYUBmA/yiAXActJAzj
        qzUmjdyKzgzkK3PUPv22U0KHv2f20i10T3YQLQXOleJb2pFmjLjygsoo2Lkmyl2bejoHqt
        PB3AwvaeFc3GlElB+X4c/+bUC+fTcKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648578618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOgdSKA448mvMIFJegctVtXbSB40Eewz2P1qKdU/+4o=;
        b=KtwN2BVo5Rf7aWs71cCI2/PAOWICzY5Ga0CrEtjEdRaCgLoGMeDINXlXA62fjYrk7MpcIv
        Bm4lthLj8agf2uAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D5A713A7E;
        Tue, 29 Mar 2022 18:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZKvHFjpQQ2KbRAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 29 Mar 2022 18:30:18 +0000
Date:   Tue, 29 Mar 2022 20:30:15 +0200
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
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YkNQNzNa02Sndu+q@zn.tnic>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <YjydSNnG6EJ1KWx0@zn.tnic>
 <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,

On Tue, Mar 29, 2022 at 03:55:38PM +0300, Dov Murik wrote:
> Let's see if I understand this correctly:
> 
> You want the guest to know if the its own SEV VM policy allows
> debugging.  And that flag has to be trusted -- so passed from the Guest
> Owner in a secure channel (otherwise the host could set it to
> ALLOW_DEBUGGING even though the Guest Owner didn't approve that).

Yeah, and then dump all the guest memory and thus bypass the whole
memory encryption fun. So yeah, it should be encrypted and accessible
only to the guest and supplied by the guest owner.

> The SEV launch secrets area can also be read by grub [1], for example,
> to fetch a luks passphrase from there (instead of from keyboard).
> That's why its structure is generic.

Ok, fair enough.

> I think Guest Owner can add a 1-byte predefined secret to the SEV secret
> table, let's say an entry with GUID 2b91a212-b0e1-4816-b021-1e9991ddb6af
> and value "\x01" to indicate debugging is allowed.
> 
> With the efi_secrets module, a 1-byte file called
> /sys/kernel/security/secrets/coco/2b91a212-b0e1-4816-b021-1e9991ddb6af

I'd love it if that were more user-friendly:

/sys/kernel/security/secrets/coco/attributes

and there's:

debugging:1
...

and others.

> will appear with "\x01" in its content.
> 
> This can indicate to the guest that debugging was permitted by the Guest
> Owner.

But yeah, that should be the gist of the functionality.

> If you want this unified in the kernel, maybe we can look for this entry
> and set the relevant kernel variable.

So now that I think of it, it would be even nicer if the fact whether
guest debugging is allowed, were available to the guest *very early*
during boot. Because I think the most important cases where you'd want
to singlestep a SEV* guest with the qemu gdbstub is early guest kernel
boot code. So it would be cool if we'd have access to the debugging
setting that early.

Lemme have a look at your patches in detail to get an idea what's
happening there.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
