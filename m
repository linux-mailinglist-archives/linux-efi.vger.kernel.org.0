Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE54ED6A6
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiCaJVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiCaJVR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 05:21:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F1C3D;
        Thu, 31 Mar 2022 02:19:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62ACD1FD05;
        Thu, 31 Mar 2022 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648718368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVX7m8PokvejVbBT0wLGG/0fZjizACNdSaleDzg4mLk=;
        b=ei/Fg2tHarGnz8vJ7LMsRcqmb1ymtDqtC7cpjuqou8aiuSePhoVQGesh7C1c6/GHS7BhN0
        aPRyDcT8CEUEquymJMPawOmtWBZPXITHFp/G2mOotI8QY0+mYwHNb7eIdGjI4fZWDJV5s0
        l3srqBu4LAWrNCvljhyakT2xet4OFMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648718368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVX7m8PokvejVbBT0wLGG/0fZjizACNdSaleDzg4mLk=;
        b=X2DWzkLocSFsEb28/cz5K8Wg9TzmTAXV0qX6aEgyDZJ+/+XZVK21/3KCewo4TMnxWBwmP0
        Y5MU7MxMpF77vBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51D33132DC;
        Thu, 31 Mar 2022 09:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ChPuEyByRWK9NgAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 31 Mar 2022 09:19:28 +0000
Date:   Thu, 31 Mar 2022 11:19:28 +0200
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
Message-ID: <YkVyIE8H4Ivb6J2l@zn.tnic>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <YjydSNnG6EJ1KWx0@zn.tnic>
 <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
 <YkNQNzNa02Sndu+q@zn.tnic>
 <7696ba46-91c7-7119-bd68-b3521459cf37@linux.ibm.com>
 <247080bd-fef5-c892-7753-f9b7cf650166@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <247080bd-fef5-c892-7753-f9b7cf650166@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 30, 2022 at 09:11:54AM +0300, Dov Murik wrote:
> If that's the case, we don't need a secure channel and secret injection.
> You can use a simple "sev=debug" (or whatever) in the kernel
> command-line to indicate your needs.

Yeah, that would work for a normal SEV guest.

However, if it is an -ES guest, you need to somehow tell it as the guest
owner: "hey you're being debugged and that's fine."

Because if you want to singlestep the thing, you're going to land in
the #VC handler and destroy registers so you want to save them first if
you're being debugged and then shovel them out to the host somehow. And
that's another question but first things first.

And "if you're being debugged" needs to be somehow told the guest
through a secure channel so that the HV doesn't go and simply enable
debugging by booting with "sev=debug" and bypass it all.

And SNP has access to the policy in the attestation report, says Tom, so
that's possible there.

So we need a way to add the debugging aspect to the measurement and be
able to recreate that measurement quickly so that a simple debugging
session of a kernel in a guest can work pretty much the same with a SEV*
guest.

I'm still digging the details tho...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
