Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE573A6D0F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhFNRZl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 13:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233843AbhFNRZl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Jun 2021 13:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623691417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHofTgDnAfH9up9hmcVY1pzQsltC1O56Hl0KypQcsag=;
        b=PAMOchzGtOa48k4pPcxKpXNJYJ2JFe/Ep830q5B7SjEi5cR9scXNHKuTADlVe6lRLjqOmQ
        x1Hv3U8ysaCkAjLZrc64R5KX3gsblId1X/3CD61Bv/n0NnfIucOP9dGQoyQPdu1tlC3lEA
        KhCxTkzQUwAhTbGEB67CbROubaMi25A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-BCI4OM8YP6WM6ilrahYegQ-1; Mon, 14 Jun 2021 13:23:36 -0400
X-MC-Unique: BCI4OM8YP6WM6ilrahYegQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE0C580363A;
        Mon, 14 Jun 2021 17:23:33 +0000 (UTC)
Received: from work-vm (ovpn-114-158.ams2.redhat.com [10.36.114.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 016135D6A8;
        Mon, 14 Jun 2021 17:23:05 +0000 (UTC)
Date:   Mon, 14 Jun 2021 18:23:03 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
Message-ID: <YMeQd6z1iwYyj6JK@work-vm>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com>
 <YMEVedGOrYgI1Klc@work-vm>
 <aef906ea-764d-0bbc-49c6-b3ecfc192214@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aef906ea-764d-0bbc-49c6-b3ecfc192214@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> I see that Tom answered few comments. I will cover others.
> 
> 
> On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
> + /*
> >> +	 * The message sequence counter for the SNP guest request is a 64-bit value
> >> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
> >> +	 * it.
> >> +	 */
> >> +	if ((count + 1) >= INT_MAX)
> >> +		return 0;
> > Is that UINT_MAX?
> 
> Good catch. It should be UINT_MAX.

OK, but I'm also confused by two things:
  a) Why +1 given that Tom's reply says this gets incremented by 2 each
time (once for the message, once for the reply)
  b) Why >= ? I think here is count was INT_MAX-1 you'd skip to 0,
skipping INT_MAX - is that what you want?

> 
> > +	/*
> > +	 * The secret page contains the VM encryption key used for encrypting the
> > +	 * messages between the guest and the PSP. The secrets page location is
> > +	 * available either through the setup_data or EFI configuration table.
> > +	 */
> > +	if (hdr->cc_blob_address) {
> > +		paddr = hdr->cc_blob_address;
> > Can you trust the paddr the host has given you or do you need to do some
> > form of validation?
> The paddr is mapped encrypted. That means that data  in the paddr must
> be encrypted either through the guest or PSP. After locating the paddr,
> we perform a simply sanity check (32-bit magic string "AMDE"). See the
> verify header check below. Unfortunately the secrets page itself does
> not contain any magic key which we can use to ensure that
> hdr->secret_paddr is actually pointing to the secrets pages but all of
> these memory is accessed encrypted so its safe to access it. If VMM
> lying to us that basically means guest will not be able to communicate
> with the PSP and can't do the attestation etc.

OK; that nails pretty much anything bad that can happen - I was just
thinking if the host did something odd like give you an address in the
middle of some other useful structure.

Dave

> >
> > Dave
> > +	} else if (efi_enabled(EFI_CONFIG_TABLES)) {
> > +#ifdef CONFIG_EFI
> > +		paddr = cc_blob_phys;
> > +#else
> > +		return -ENODEV;
> > +#endif
> > +	} else {
> > +		return -ENODEV;
> > +	}
> > +
> > +	info = memremap(paddr, sizeof(*info), MEMREMAP_WB);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	/* Verify the header that its a valid SEV_SNP CC header */
> > +	if ((info->magic == CC_BLOB_SEV_HDR_MAGIC) &&
> > +	    info->secrets_phys &&
> > +	    (info->secrets_len == PAGE_SIZE)) {
> > +		res->start = info->secrets_phys;
> > +		res->end = info->secrets_phys + info->secrets_len;
> > +		res->flags = IORESOURCE_MEM;
> > +		snp_secrets_phys = info->secrets_phys;
> > +		ret = 0;
> > +	}
> > +
> > +	memunmap(info);
> > +	return ret;
> > +}
> > +
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

