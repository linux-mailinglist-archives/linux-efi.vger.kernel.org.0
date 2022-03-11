Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBD4D6731
	for <lists+linux-efi@lfdr.de>; Fri, 11 Mar 2022 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbiCKRIH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Mar 2022 12:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350607AbiCKRH4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Mar 2022 12:07:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08611D63A2;
        Fri, 11 Mar 2022 09:06:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 200491F441;
        Fri, 11 Mar 2022 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647018411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSXcqRdGy8e39Bfyh4bjxSE8ya8/hJV+iGXqtr1mwZU=;
        b=zQyt4+5n13hOeCa9xgCswD1KUwJoBAVHqClZsOVB/PC81hDRKVuQgH1NmYqJHrPtu7uSBy
        PhKQMACw5TXT3jEJnxs41RXUlcaW2trrHTw/O9jZxqtPwhLGzXcXKc1h5hTKvlf/IDc0dP
        5Ixbw+BN/hU3tzWgbjphSRqoV6EI8m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647018411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSXcqRdGy8e39Bfyh4bjxSE8ya8/hJV+iGXqtr1mwZU=;
        b=QCVBTLAApqTWfX+QacBXJ4GMfGLfvOFCxwcaEUXx1xHk0oPnraa4sv0x634bkXioi9HjnJ
        26OphLW7CWS9nCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05DD013A8E;
        Fri, 11 Mar 2022 17:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7gxNOqmBK2IROQAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 11 Mar 2022 17:06:49 +0000
Date:   Fri, 11 Mar 2022 18:06:49 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <YiuBqZnjEUyMfBMu@suse.de>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-33-brijesh.singh@amd.com>
 <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
 <20220310212504.2kt6sidexljh2s6p@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310212504.2kt6sidexljh2s6p@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 10, 2022 at 03:25:04PM -0600, Michael Roth wrote:
> Joerg, do you have more background on that? Would it make sense, outside
> of this series, to change it to a terminate? Maybe with a specific set
> of error codes for ES_{OK,UNSUPPORTED,VMM_ERROR,DECODE_FAILED}?

This seems to be a left over from development of the SEV-ES guest
patch-set. I wanted to see whether the VM crashed due to a triple fault
or an error in the #VC handler. The halt loop can be replaced by
termination request now.

> > I am still working on why the early_printk()s in that function are not
> > working, it seems that they lead to a different halt.
> 
> I don't see a different halt. They just don't seem to print anything.
> (keep in mind you still need to advance the IP or else the guest is
> still gonna end up spinning here, even if you're removing the halt loop
> for testing purposes)

The early_printks() also cause #VC exceptions, and if that handling is
broken for some reason nothing will be printed.

> 
> > working, it seems that they lead to a different halt. Have you tested
> > any of those error paths manually? For example if you set your CPUID
> > bits to explicitly fail here do you see the expected printks?
> 
> I think at that point in the code, when the XSAVE stuff is setup, the
> console hasn't been enabled yet, so messages would get buffered until they
> get flushed later (which won't happen since there's halt loop after). I
> know in some cases devs will dump the log buffer from memory instead to get
> at the error messages for early failures. (Maybe that's also why Joerg
> decided to use a halt loop there instead of terminating?)

It is hard to dump the log-buffer from encrypted memory :) But I
remember having seen messages from these early_printks under SEV-ES for
different bugs. Not sure why they don't appear in this situation.

> So maybe reworking the error handling in handle_vc_boot_ghcb() to use
> sev_es_terminate() might be warranted, but probably worth checking with
> Joerg first, and should be done as a separate series since it is not
> SNP-related.

I am fine with this change.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

