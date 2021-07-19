Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816413CEE80
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388532AbhGSU6w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387493AbhGSUL1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 16:11:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C48C061762
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:50:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t9so20407722pgn.4
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFTM2GRWufz5H7ZF2I53fhdcy31mPSD1WmaoCuSp/kE=;
        b=EaCLfVRUeWm1VySqrv8i2wNaa1wkPklvEK+xtMHdsSwgX2wFqb1Td6Qxx/Gb5l+cVb
         iFDBBPj7D4Vc1AccEll1JyWJ1bUw6f6E5fWHeRlt33bQVWVeosWbQYPcJTxJJzXLzM9O
         kIducZm41jdtN6sUFDlUG707INiMICk4cgWapIwGO3HfFDCHIJXCNZP4gXRP+tRtGBAe
         upzRB6mNR4POD1tE5HNErufrnwLonZnXJR1npy0SArVe6sk5bxak769zdSKot2JBoe2R
         8I+m0tueFJM91D9WIUbZQDxA3BDZrk+shYWYLpiKWRmq9uaqtm4emtrPiHXDahsjmVPG
         OV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFTM2GRWufz5H7ZF2I53fhdcy31mPSD1WmaoCuSp/kE=;
        b=PA8oKx59mJuFrascz+fBKTRIJy5ifsdtY3pkNbbbUE1B+ACpw0h3Pylv9KnCQO3fQF
         JCN3sHayz0CHNA5S1JaCXPPEU6qjwxrJ+RzboKXqs857o7fGBbws0Q3ykoIY3xoPAPWS
         w9MsO9ZAL3ZbBl+vo9JdERyeGEogH3ryyef/P1SO8oDWhTiLHldaFGBWTUC1Xc90Hh1U
         TJiUCemlJPRt1Kkfq+28uhIQHPlZpTlTczHhOr3bKYsW0OTZPF6U96R+6Llm8XzLM0b7
         H2aZf46SA3TAVmUrX9Ex9ow7W2A0G6wBC3Xm333q0ZoXSq6gZdzWDk/J+4F2ESb+QNTp
         v9mg==
X-Gm-Message-State: AOAM530793y7dNEkK/GOR7pPWyxFSDQ8FrM51RW76p/73TdX8UBIqxHQ
        X6hGP2AEB3qclTUoLY9eAArdHA==
X-Google-Smtp-Source: ABdhPJyjItrVjb+a0pFhuKYnpkTfNH72AHGpeo/P7u6yE1PaSgsExPO2J1JwGyGZTKpxOFB6QaRDuw==
X-Received: by 2002:a62:3045:0:b029:32b:880f:c03a with SMTP id w66-20020a6230450000b029032b880fc03amr27819158pfw.22.1626727923390;
        Mon, 19 Jul 2021 13:52:03 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v10sm381814pjd.29.2021.07.19.13.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:52:02 -0700 (PDT)
Date:   Mon, 19 Jul 2021 20:51:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_UPDATE command
Message-ID: <YPXl7sVBx7lDLx/U@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-25-brijesh.singh@amd.com>
 <YPHlt4VCm6b2MZMs@google.com>
 <a574de6d-f810-004f-dad2-33e3f389482b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a574de6d-f810-004f-dad2-33e3f389482b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/16/21 3:01 PM, Sean Christopherson wrote:
> > I'm having a bit of deja vu...  This flow needs to hold kvm->srcu to do a memslot
> > lookup.
> >
> > That said, IMO having KVM do the hva->gpa is not a great ABI.  The memslots are
> > completely arbitrary (from a certain point of view) and have no impact on the
> > validity of the memory pinning or PSP command.  E.g. a memslot update while this
> > code is in-flight would be all kinds of weird.
> >
> > In other words, make userspace provide both the hva (because it's sadly needed
> > to pin memory) as well as the target gpa.  That prevents KVM from having to deal
> > with memslot lookups and also means that userspace can issue the command before
> > configuring the memslots (though I've no idea if that's actually feasible for
> > any userspace VMM).
> 
> The operation happen during the guest creation time so I was not sure if
> memslot will be updated while we are executing this command. But I guess
> its possible that a VMM may run different thread which may update
> memslot while another thread calls the encryption. I'll let userspace
> provide both the HVA and GPA as you recommended.

I'm not worried about a well-behaved userspace VMM, I'm worried about the code
KVM has to carry to guard against a misbehaving VMM.
 
> >> +			ret = -EINVAL;
> >> +			goto e_unpin;
> >> +		}
> >> +
> >> +		psize = page_level_size(level);
> >> +		pmask = page_level_mask(level);
> > Is there any hope of this path supporting 2mb/1gb pages in the not-too-distant
> > future?  If not, then I vote to do away with the indirection and just hardcode
> > 4kg sizes in the flow.  I.e. if this works on 4kb chunks, make that obvious.
> 
> No plans to do 1g/2mb in this path. I will make that obvious by
> hardcoding it.
> 
> 
> >> +		gpa = gpa & pmask;
> >> +
> >> +		/* Transition the page state to pre-guest */
> >> +		memset(&e, 0, sizeof(e));
> >> +		e.assigned = 1;
> >> +		e.gpa = gpa;
> >> +		e.asid = sev_get_asid(kvm);
> >> +		e.immutable = true;
> >> +		e.pagesize = X86_TO_RMP_PG_LEVEL(level);
> >> +		ret = rmpupdate(inpages[i], &e);
> > What happens if userspace pulls a stupid and assigns the same page to multiple
> > SNP guests?  Does RMPUPDATE fail?  Can one RMPUPDATE overwrite another?
> 
> The RMPUPDATE is available to the hv and it can call anytime with
> whatever it want. The important thing is the RMPUPDATE + PVALIDATE
> combination is what locks the page. In this case, PSP firmware updates
> the RMP table and also validates the page.
> 
> If someone else attempts to issue another RMPUPDATE then Validated bit
> will be cleared and page is no longer used as a private. Access to
> unvalidated page will cause #VC.

Hmm, and there's no indication on success that the previous entry was assigned?
Adding a tracepoint in rmpupdate() to allow tracking transitions is probably a
good idea, otherwise debugging RMP violations and/or unexpected #VC is going to
be painful.

And/or if the kernel/KVM behavior is to never reassign directly and reading an RMP
entry isn't prohibitively expensive, then we could add a sanity check that the RMP
is unassigned and reject rmpupdate() if the page is already assigned.  Probably
not worth it if the overhead is noticeable, but it could be nice to have if things
go sideways.

> >> +e_unpin:
> >> +  /* Content of memory is updated, mark pages dirty */
> >> +  memset(&e, 0, sizeof(e));
> >> +  for (i = 0; i < npages; i++) {
> >> +          set_page_dirty_lock(inpages[i]);
> >> +          mark_page_accessed(inpages[i]);
> >> +
> >> +          /*
> >> +           * If its an error, then update RMP entry to change page ownership
> >> +           * to the hypervisor.
> >> +           */
> >> +          if (ret)
> >> +                  rmpupdate(inpages[i], &e);
> > This feels wrong since it's purging _all_ RMP entries, not just those that were
> > successfully modified.  And maybe add a RMP "reset" helper, e.g. why is zeroing
> > the RMP entry the correct behavior?
> 
> By default all the pages are hypervior owned (i.e zero). If the
> LAUNCH_UPDATE was successful then page should have transition from the
> hypervisor owned to guest valid. By zero'ing it are reverting it back to
> hypevisor owned.
>
> I agree that I optimize it to clear the modified entries only and leave
> everything else as a default.

To be clear, it's not just an optimization.  Pages that haven't yet been touched
may be already owned by a different VM (or even this VM).  I.e. "reverting" those
pages would actually result in a form of corruption.  It's somewhat of a moot point
because assigning a single page to multiple guests is going to be fatal anyways,
but potentially making a bug worse by introducing even more noise/confusion is not
good.
