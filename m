Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278353999C
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbiEaWk3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 May 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbiEaWk1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 May 2022 18:40:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E89EB6C
        for <linux-efi@vger.kernel.org>; Tue, 31 May 2022 15:40:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h75so20378633ybg.4
        for <linux-efi@vger.kernel.org>; Tue, 31 May 2022 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iSXfdXWQRyUCbk0G9o7KyBhlDTpNCnQev8nhR/I/TdY=;
        b=HsksBcqdyPpSCCWP1DiXPiE1a14eVxR7MRHdI7Z5cpzZAy9lO7ruMphxUv9jF2C2sw
         /pgCZCCeJVk9cxgvTdmK1FsevcWFWH/+i8JgrsxFWUScnpMihGH6PE+aKcXA03iPeJdj
         dZ4Fy8JMSO77H9VgxNZVjTS2CE7+rjPwOQ1nkywPuJ4OjM7zlIgYglNeD5R5RdHU9TQd
         ZGEbQvqw79MCww+sZgynuaRCvhUuCusnjWfYIg9yFNCv09hwSDywXkSSafnIp55ACSaP
         7kfB7e7yTdJwIGcs5EiZYEHjSftx3J+hMbbAJxZGkLLhtDcVt5vIiRiCUs6uyPTV7LFu
         JzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iSXfdXWQRyUCbk0G9o7KyBhlDTpNCnQev8nhR/I/TdY=;
        b=UjwEhze0KvanZJ5dXtiOoWwRXz3RWSZXJ5g+NVKEqvJK4uDTe9Q8XgGDwma3nSSOWc
         ooNxLCPvzC1MetXKTeoWJZA4JLHEa4k/245a8xs44MKXgSUwVY17iLB4gUf51xN7vpFL
         4gxGyhwpYmH388/RJw4zBpqLfnPfzubOiP/EzcbvAG4yTHqpbe/umaRQPQq+ZMu8uQ2U
         8CQR4i3rh1MjqMOae6Qmsp6l6ECl9C0nS9CR13tlg1fUgVmNw4Q+k0Ksg045ow2FFq5R
         v3m2HcBgwdW1E9YSmSdT0HGooDW7tYiDa7+U1Efqnfsf5SsAszO4vOyEYMNZxGXacbxu
         VYKA==
X-Gm-Message-State: AOAM532+r9KS4GwtLNtnPz+6Xyb6ea7TaTqg+qmY6SC70fg9mEhCyNcf
        M25pL4LWo2BKxCi98ujlefsArC+1dYwuHJi3NovdtA==
X-Google-Smtp-Source: ABdhPJzmrJqSRhhHz6N0GieGJg5FYLwCAVR0BwL5OtlM2bEaoCxd7rSGbpFZm9hJ3VmDFMNfIbaxRaCkI7t+1HHGplQ=
X-Received: by 2002:a5b:411:0:b0:65c:d336:ddf7 with SMTP id
 m17-20020a5b0411000000b0065cd336ddf7mr13814723ybp.321.1654036825375; Tue, 31
 May 2022 15:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com> <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name> <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic> <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 31 May 2022 15:40:14 -0700
Message-ID: <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
To:     "Xu, Min M" <min.m.xu@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi y'all, I've made minimal changes to OVMF to prevalidate only up to
4GB and leave the rest unaccepted, as Thomas Lendacky recommended
https://github.com/AMDESE/ovmf/pull/4#issuecomment-1138606275 and ran
a memtouch test to see if this change behaves as expected. One thing
that struck me is that an 8GB machine reports 2044MB free with this
change (free -k) whereas without it, I see 7089MB free. I think that
unaccepted memory should be classified as free in meminfo, no? I'm not
familiar enough with that code to say what specific change needs to be
made.

(resent in text mode)


On Sun, May 15, 2022 at 11:47 PM Xu, Min M <min.m.xu@intel.com> wrote:
>
> On May 13, 2022 10:45 PM, Kirill A. Shutemov wrote:
> > On Fri, May 13, 2022 at 11:01:43AM +0200, Borislav Petkov wrote:
> > > + mroth
> > > - brijesh
> > >
> > > On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
> > > > Kirill, I've been tracking these changes to see if we can handle th=
e
> > > > unaccepted memory type for SEV-SNP, but testing has been an issue.
> > > > The proposed patch in Ovmf to introduce unaccepted memory seems to
> > > > have stalled out last September
> > > > (https://www.mail-archive.com/devel@edk2.groups.io/msg35842.html)
> > > > and is particularly difficult to adapt to SEV-SNP since it doesn't
> > > > follow the TDVF way of initializing all memory. Is there a differen=
t
> > > > development I might have missed so that we might test these cases?
> > > > Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any
> > kernel
> > > > uses are essentially dead code.
> >
> > + Min, Jiaqi.
> >
> > I don't follow firmware development. Min, Jiaqi, could you comment?
> >
> We have prepared the patch for unaccepted memory and it is now working in=
 our internal release.
> But there is an obstacle to upstream it to edk2 master branch.
> The patch-set depends on the definition of UEFI_RESOURCE_MEMORY_UNACCEPTE=
D in PI spec. This is proposed in https://github.com/microsoft/mu_basecore/=
pull/66/files#diff-b20a11152d1ce9249c691be5690b4baf52069efadf2e2546cdd2eb66=
3d80c9e4R237, according to UEFI-Code-First. The proposal was approved in 20=
21 in UEFI Mantis, and will be added to the new PI.next specification. (Til=
l now it has not been added in the latest PI spec.)
> So UEFI_RESOURCE_MEMORY_UNACCEPTED cannot be added in MdePkg which make i=
t difficult to submit the patch to edk2 community for review. See this link=
: https://edk2.groups.io/g/devel/message/87558
>
> Please be noted: UEFI_RESOURCE_MEMORY_UNACCEPTED (defined in PI spec) is =
different from EFI_UNACCEPTED_MEMORY (defined in UEFI spec)
>
> I will submit the patch-set once the new definition is added in the new P=
I.next spec.
>
> Thanks
> Min



--=20
-Dionna Glaze, PhD (she/her)
