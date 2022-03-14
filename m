Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F64D8ADE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiCNRgK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiCNRgI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 13:36:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEAB64E6
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 10:34:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g17so28518417lfh.2
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8A3cxPbkf5/imDcGfqUsgEkAZ/Yq4pAldU3s8K2mQzc=;
        b=tfX+LbUtQWULAhzeWtmsYWPMAURZzqdsjSM/aDGl+qglrfZ5bNzfGleMtHFaTt3jZv
         3UyQ5yndXqQ8IyXR6tjdhKwpYv9aaculLUgdA6PMil4v28IhdiEX2uhZI0KYNH460tQ6
         GKcfKXGVcGVxcLcjPvKm3Y+xr7jKp0lTmNP15knWHThq1yVvN8ocGYyB/el//U+71WsO
         9kxkVPpZ6bjpiPklFVZMRSxBgbjd89SZz6rNYPQo0Uto/u5sjUUJwJwIeOikglGO6VNE
         lvYLAnfBrGRNUOM81j19C9LApg+tiwD55XcFvJbf4tDEynsa5BMJpjgefQARvNRiNVXn
         Zf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8A3cxPbkf5/imDcGfqUsgEkAZ/Yq4pAldU3s8K2mQzc=;
        b=Q7Jr5byGMKEW4JJA6H7a6ulhJoH9U42lkqFQgeM9ECMKZp9YG2ZHsgwOH6eLrB8DpZ
         dJwZwQTaH54zlW20U3mcUCVgill1Hg6Z0VHwSOGpSxklW/4XUVWEMhJ1LICxF3qNxn1M
         DgSmezt+C+w6AvYO8Mond4//lQaE49GvaG+DrxO5oewVauHQIaiIn/pytcUbD9Sz1ld9
         8/a3Qk/v+M3VjVTnNh7pso8/I19umc3mGawz4RLWX2z2ISLzwF4+PFBylsEAtSNlJfk3
         s3wjd9I6Uc7+WBHEpcUKgCZEG8muNNXUHKODYnZ8lYRJlvQMN4skRPMAs76p6r+zk5oS
         XOpw==
X-Gm-Message-State: AOAM532wcYaKa0D7U0SwH5QBDjvnOG3qjy5q1eVb+t3ddPv4Igb7Bc5Q
        HNml3K8drOTVk0/g5RSedPFSKjc1ey8/OQFbWGIktw==
X-Google-Smtp-Source: ABdhPJwyJUQnuBymc31Rm47cQ/NdVZrkI9p8VQjPdQxJrZbxv7kE4yinBibZy7OcE53BDtGYf0q134NUBFysmwbOxgc=
X-Received: by 2002:a19:ca07:0:b0:448:7eab:f1a with SMTP id
 a7-20020a19ca07000000b004487eab0f1amr7790394lfg.456.1647279294144; Mon, 14
 Mar 2022 10:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-33-brijesh.singh@amd.com> <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
 <20220310212504.2kt6sidexljh2s6p@amd.com> <YiuBqZnjEUyMfBMu@suse.de>
In-Reply-To: <YiuBqZnjEUyMfBMu@suse.de>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 14 Mar 2022 11:34:42 -0600
Message-ID: <CAMkAt6r==_=U4Ha6ZTmii-JL3htJ3-dD4tc+QBqN7dVt711N2A@mail.gmail.com>
Subject: Re: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 11, 2022 at 10:06 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Thu, Mar 10, 2022 at 03:25:04PM -0600, Michael Roth wrote:
> > Joerg, do you have more background on that? Would it make sense, outsid=
e
> > of this series, to change it to a terminate? Maybe with a specific set
> > of error codes for ES_{OK,UNSUPPORTED,VMM_ERROR,DECODE_FAILED}?
>
> This seems to be a left over from development of the SEV-ES guest
> patch-set. I wanted to see whether the VM crashed due to a triple fault
> or an error in the #VC handler. The halt loop can be replaced by
> termination request now.
>
> > > I am still working on why the early_printk()s in that function are no=
t
> > > working, it seems that they lead to a different halt.
> >
> > I don't see a different halt. They just don't seem to print anything.
> > (keep in mind you still need to advance the IP or else the guest is
> > still gonna end up spinning here, even if you're removing the halt loop
> > for testing purposes)
>
> The early_printks() also cause #VC exceptions, and if that handling is
> broken for some reason nothing will be printed.
>
> >
> > > working, it seems that they lead to a different halt. Have you tested
> > > any of those error paths manually? For example if you set your CPUID
> > > bits to explicitly fail here do you see the expected printks?
> >
> > I think at that point in the code, when the XSAVE stuff is setup, the
> > console hasn't been enabled yet, so messages would get buffered until t=
hey
> > get flushed later (which won't happen since there's halt loop after). I
> > know in some cases devs will dump the log buffer from memory instead to=
 get
> > at the error messages for early failures. (Maybe that's also why Joerg
> > decided to use a halt loop there instead of terminating?)
>
> It is hard to dump the log-buffer from encrypted memory :) But I
> remember having seen messages from these early_printks under SEV-ES for
> different bugs. Not sure why they don't appear in this situation.
>
> > So maybe reworking the error handling in handle_vc_boot_ghcb() to use
> > sev_es_terminate() might be warranted, but probably worth checking with
> > Joerg first, and should be done as a separate series since it is not
> > SNP-related.
>
> I am fine with this change.

I'll send a patch out for that.

I was also thinking about adding a vcpu run exit reason for
termination. It would be nice to get a more informative exit reason
than -EINVAL in userspace. Thoughts?

>
> Regards,
>
> --
> J=C3=B6rg R=C3=B6del
> jroedel@suse.de
>
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5
> 90409 N=C3=BCrnberg
> Germany
>
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
>
