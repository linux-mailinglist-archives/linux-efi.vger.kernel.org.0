Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA90E57BC39
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jul 2022 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiGTRDz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jul 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGTRDy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jul 2022 13:03:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0A6B25F
        for <linux-efi@vger.kernel.org>; Wed, 20 Jul 2022 10:03:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c131so32457177ybf.9
        for <linux-efi@vger.kernel.org>; Wed, 20 Jul 2022 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOA19tVTAiTzTuOKYOjsbz3H5LWG3tc39ee1PdsInaY=;
        b=eH8DfSUXfgZbV4o8x2tqd+uHCK00gNxyeV23UnRyl2NEqFrrv5LwU2PG2xBhksRNcP
         qS7iLrMIZpsxtaEQ/qBskkcrdLuCYYgMzLi+TtbuSs4f5MgiwniXAlxCsETB6+1IRAmE
         rMTt6csKOwhCtw0ESoG2dWiOJS/Ce4cmZCfR74QtEUlVZTimDvnzoGl7jkYN6DsnUUf1
         /W3fid4i309QeRCWguiNIhdqU9ADeJR3BpajeUJx5/Y+QufmNFVk+GCEY16adfuvEO3h
         Fv3C1jB+2yMiBwC5Lr1BTkWHTDH4MrmxTcKUycRCIE8UUlUCcTG8SNOuGKPBPBgFHuRX
         TTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOA19tVTAiTzTuOKYOjsbz3H5LWG3tc39ee1PdsInaY=;
        b=MBSqvF3GDAGJSQFKRW16JOpQzTDXl8m4iJwDDS59fjDrs3fjSyHNd7bXcrvs1C426W
         DcVtpARZL1KKt8ADH8mJPzr6tUggGKhh+4zb4aZKrYVsPb1vXyGNCiDfcNLxUVVWlBfa
         6edm2UYYlJ/5IhfYcK8s7TrIqoxJHLFv7Q74YKe43XWqV091sd6OYIMitmC7lgdxxxOK
         mZsWsybnJJ6sgnAMCkTSseO5m3tMrfgRWd+btXH0+oVcsSPWNScKNPnMrHqt6T2yeAYe
         iDaN+oIFkZx9NNUKeyjbKLSRS/zNKvU3d4SOCZyFpDWv4aWVPTqJhQ2RheWgiWsPsHtH
         YFBQ==
X-Gm-Message-State: AJIora/7609G7fzLUvOo5tecsE2f39ozZqSy5q4ijL7GtRlGKEbJbHIm
        moDSmYR18ThvVSrfgWDCxvWzd+2h2cmbJ4tfvEtocA==
X-Google-Smtp-Source: AGRyM1uXDNpNChJqMpeAj68PB9QtQc3sH/drFsMIMDp7snrUyeSTOG30AnpLZhkLxTTfI4lMQ6NISaGgHQQJP5Q7AZQ=
X-Received: by 2002:a05:6902:1082:b0:670:9307:b0eb with SMTP id
 v2-20020a056902108200b006709307b0ebmr5042788ybu.335.1658336631697; Wed, 20
 Jul 2022 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic> <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic> <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic> <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
 <CAA03e5FMEyswDhoXRJ5U_n9RG4QM524aQYpF4473ydnAVJr1PA@mail.gmail.com> <YteWPj7HytPrcplB@zn.tnic>
In-Reply-To: <YteWPj7HytPrcplB@zn.tnic>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 20 Jul 2022 10:03:40 -0700
Message-ID: <CAA03e5H8-n23eZ5sMWLQADpJ+AQCrhMoDng_aiw3-C5cPHEwnA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 19, 2022 at 10:44 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 19, 2022 at 05:26:21PM -0700, Marc Orr wrote:
> > These feature tags are a mess to keep track of.
>
> Well, looking at those tags, it doesn't look like you'll stop using them
> anytime soon.
>
> And once all the required SNP/TDX features are part of the guest image,
> - including unaccepted memory - if anything, you'll have less tags.
>
> :-)

Yeah, once all of the features are a part of the guest image AND any
older images with SNP/TDX minus the features are deprecated. I agree.

> > - Do we anticipate (many) more features for confidential compute in
> > the future that require code in both the guest FW and guest kernel? If
> > yes, then designing a FW-kernel feature negotiation could be useful
> > beyond this situation.
>
> Good question.
>
> > - Dave's suggestion to "2. Boot some intermediate thing like a
> > bootloader that does acceptance ..." is pretty clever! So if upstream
> > thinks this FW-kernel negotiation is not a good direction, maybe we
> > (Google) can pursue this idea to avoid introducing yet another tag on
> > our images.
>
> Are those tags really that nasty so that you guys are looking at
> upstream changes just to avoid them?

Generally, no. But the problem with tags is that distros tag their
images wrong sometimes. And that leads to problems. For example, I
just got a bug assigned to me yesterday about some ARM image tagged as
SEV_CAPABLE. Oops. Lol :-). (Though, I'm pretty sure we won't try to
boot an ARM image on a non-ARM host anyway; but it's still wrong...)

That being said, this lazy accept problem is sort of a special case,
since it requires deploying code to the guest FW and the guest kernel.
I'm still relatively new at all of this, but other than the
SNP/TDX-enlightenment patches themselves,  I haven't really seen any
other examples of this. So that goes back to my previous question. Is
this going to happen a lot more? If not, I can definitely see value in
the argument to skip the complexity of the FW/kernel feature
negotiation.

Another thing I thought of since my last reply, that's mostly an
internal solution to this problem on our side: Going back to Dave's
10k-foot view of the different angles of how to solve this. For "1.
Deal with that at the host level configuration", I'm thinking we could
tag the images with their internal guest kernel version. For example,
if an image has a 5.15 kernel, then we could have a `KERNEL_5_15` tag.
This would then allow us to have logic in the guest FW like:

if (guest_kernel_is_at_least(/*major=*/5, /*minor=*/15)
     enable_lazy_accept = true;

One detail I actually missed in all of this, is how the guest image
tag gets propagated into the guest FW in this approach. (Apologies for
this, as that's a pretty big oversight on my part.) Dionna: Have you
thought about this? Presumably this requires some sort of paravirt for
the guest to ask the host. And for any paravirt interface, now we need
to think about if it degrades the security of the confidential VMs.
Though, using it to get the kernel version to decide whether or not to
accept the memory within the guest UEFI or mark it as unaccepted seems
fine from a security angle to me.

Also, tagging images with their underlying kernel versions still seems
susceptible to mis-labeling. But this seems like it can be mostly
"fixed" via automation (e.g., write a tool to boot the guest and ask
it what it's kernel version is and use the result to attach the tag).
Also, tagging the images with their kernel version seems like a much
more general solution to these sorts of issues.

Thoughts?
