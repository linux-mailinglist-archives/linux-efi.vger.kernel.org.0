Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91C043D3AC
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhJ0VSq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbhJ0VSG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Oct 2021 17:18:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4163DC0613B9
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 14:15:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so8943916lfb.10
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUzj8OdRUyoCesvY9oYCJsi3ZMdPAltpXbUySPTyBuc=;
        b=ZIKZfwDyLiBXM4FTpiIdXUlr5R+dGI4KZkzsZUVmNpqPvYo82Eg9+mHUocDVdvsZRp
         bHC9ooluOVD3eOGj7LPilAH9no8kzTwRRuYP+1gemifBf9EmDbJHIc5OrlyAX3AErpYL
         rCUkbQ4oC/0/RC8tdZ8NSo7568axnml9rN/sSJ5mA2MGDa5CgiyJRlLuhtN1U3Q4WSCG
         AnMNeoEa0RpKePUuZlZiGhzIsuYPu5BLCjJhMGzARP7vYLxtIXT7UyovYQkTwrt82WqU
         9RBNxTpyNJrocw3u98bizPwdzQxbEvMV670aQO7grbt5qAOhoDZmzAPqEDsUVxS/KD76
         ZNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUzj8OdRUyoCesvY9oYCJsi3ZMdPAltpXbUySPTyBuc=;
        b=2wKMDPIVGDfiGMRROpW7t0HOuuD4Pct4lS76Row7OOtziHImmlhB5B2uGTlK7snY0y
         7KIlV43fgHdiqXGWAef8iqmopKWFYGbDHtXpjiOdD9s27Ig0DTa+lyRcwXja3vdRHUle
         xZ/NAGCWsBnz+fmpwoT3FsrKrCdaBU17P1slUdYAdIQoZobsjnqS0sC8mthpzvEIh7rM
         rvtwQsijLgQ/i1n4S25O0MgpJWuzmjg5c5PkDtTkukQktwc1EgoK/yA6TQp9fXX93fDC
         Um3m9g4NvZQexCsmsIRUICqFjKYkpcHPbbrtl4Yq0wrkzPq8t+KZRK4ZPG3mhprOEklN
         1hog==
X-Gm-Message-State: AOAM533ei+MWuAlH1g+k2DvpvoHofZfVIofnlNFiGHnJ5DzMYBZ8Hy4j
        wcC8tNuK2EwCtDjb3vPPekw99g+7K1YseUlw2tWrcw==
X-Google-Smtp-Source: ABdhPJybiFy4oIGNhhlBmd8VY61nM798zr2vK1FyUgViR6EzKUCgaGgxcLv7n9sV9CUY4RPDWZNVBYEO2FFLs9wKsoY=
X-Received: by 2002:a05:6512:39d1:: with SMTP id k17mr95057lfu.79.1635369338308;
 Wed, 27 Oct 2021 14:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com> <CAMkAt6rPVsJpvdzwG3Keu3gv=n0hmYdDpYJMVoDP7XgwzvH7vQ@mail.gmail.com>
 <bf55b53c-cc3d-f2c3-cf21-df6fb4882e13@amd.com> <CAMkAt6pCSNZiB7zVXp=70fF-qORZT0D5KCSY=GrJU0iiLZN_Mw@mail.gmail.com>
 <943a1b7d-d867-5daa-e2e7-f0d91de37103@amd.com> <CAMkAt6qPHtOy8ONBtjn4V28P5F5qqQtnP2sD5YrBjbe_Uwkdcg@mail.gmail.com>
 <ecfe3b3a-0a7d-86e7-08fb-f693bfa9255b@amd.com>
In-Reply-To: <ecfe3b3a-0a7d-86e7-08fb-f693bfa9255b@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 27 Oct 2021 15:15:26 -0600
Message-ID: <CAMkAt6pgXJ5vop5j7BNF_FQ6ZbWKWCCfUmic2yx3kk0Z1AvJwA@mail.gmail.com>
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 27, 2021 at 3:13 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
>
>
> On 10/27/21 4:05 PM, Peter Gonda wrote:
> ....
>
> >>>>>
> >>>>> Thanks for updating this sequence number logic. But I still have some
> >>>>> concerns. In verify_and_dec_payload() we check the encryption header
> >>>>> but all these fields are accessible to the hypervisor, meaning it can
> >>>>> change the header and cause this sequence number to not get
> >>>>> incremented. We then will reuse the sequence number for the next
> >>>>> command, which isn't great for AES GCM. It seems very hard to tell if
> >>>>> the FW actually got our request and created a response there by
> >>>>> incrementing the sequence number by 2, or if the hypervisor is acting
> >>>>> in bad faith. It seems like to be safe we need to completely stop
> >>>>> using this vmpck if we cannot confirm the PSP has gotten our request
> >>>>> and created a response. Thoughts?
> >>>>>
> >>>>
> >>>> Very good point, I think we can detect this condition by rearranging the
> >>>> checks. The verify_and_dec_payload() is called only after the command is
> >>>> succesful and does the following checks
> >>>>
> >>>> 1) Verifies the header
> >>>> 2) Decrypts the payload
> >>>> 3) Later we increment the sequence
> >>>>
> >>>> If we arrange to the below order then we can avoid this condition.
> >>>> 1) Decrypt the payload
> >>>> 2) Increment the sequence number
> >>>> 3) Verify the header
> >>>>
> >>>> The descryption will succeed only if PSP constructed the payload.
> >>>>
> >>>> Does this make sense ?
> >>>
> >>> Either ordering seems fine to me. I don't think it changes much though
> >>> since the header (bytes 30-50 according to the spec) are included in
> >>> the authenticated data of the encryption. So any hypervisor modictions
> >>> will lead to a decryption failure right?
> >>>
> >>> Either case if we do fail the decryption, what are your thoughts on
> >>> not allowing further use of that VMPCK?
> >>>
> >>
> >> We have limited number of VMPCK (total 3). I am not sure switching to
> >> different will change much. HV can quickly exaust it. Once we have SVSM
> >> in-place then its possible that SVSM may use of the VMPCK. If the
> >> decryption failed, then maybe its safe to erase the key from the secrets
> >> page (in other words guest OS cannot use that key for any further
> >> communication). A guest can reload the driver will different VMPCK id
> >> and try again.
> >
> > SNP cannot really cover DOS at all since the VMM could just never
> > schedule the VM. In this case we know that the hypervisor is trying to
> > mess with the guest, so my preference would be to stop sending guest
> > messages to prevent that duplicated IV usage. If one caller gets an
> > EBADMSG it knows its in this case but the rest of userspace has no
> > idea. Maybe log an error?
> >
> >>
>
> Yap, we cannot protect against the DOS. This is why I was saying that we
> zero the key from secrets page so that guest cannot use that key for any
> future communication (whether its from rest of userspace or kexec
> kernel). I can update the driver to log the message and ensure that
> future messages will *not* use that key. The VMPCK ID is a module
> params, so a guest can reload the driver to use different VMPCK.

Duh! Sorry I thought you said we needed a VMPL0 SVSM to do that. That
sounds great.

>
>
> >> thanks
