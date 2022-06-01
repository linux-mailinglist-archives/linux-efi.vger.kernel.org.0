Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4EE53AAE5
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356062AbiFAQVK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355318AbiFAQVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 12:21:08 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078079398
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 09:21:04 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ff7b90e635so24294347b3.5
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XM2sFuyFihZDnGzhAB4JxCOAcgDlpIBTgTnkAxWbr84=;
        b=lMek/BkxQa8hv44N1om24qgTIDg1kFiuJlm9BKTspin+LuL4ZcpzeO6ef5+1JqRqzH
         eTjspKdDLx/ESSKRsDegdO4tZmPBrz98/9xtEft/xG2KW2kHRTTsHTpy2Fc2izCOA1+X
         B3eyiPdkcF1rnwhdgwUcnzUM3VGKnaTRDSaQ32D1xI5dsdXSrKFnJluFWWLZs1UvPFur
         bfSx/59hLvwuGGyN1pkKW527TSj4j6efXx9ErI/0LpGQtxHY14S9699iONDheKf1OgMF
         CAGaFxq9FsQu8kIKP6J9Gd6aDeqVcjTCM7nM5h1cgKZTaAV77V4x/7XwKVw/lGFyX3wY
         wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XM2sFuyFihZDnGzhAB4JxCOAcgDlpIBTgTnkAxWbr84=;
        b=YyENauUzu8/gzgKBzF6uClX/gcIjgMvMzRPDPcAQZ77koQ1CRsjIjQjzqKGFbiRHT8
         Dz1Q3ZqRHeqGsjd1bXxo/oigl855a90KTN9Yq621QExt4cnlvGv0HFRJHkeWga5wozSn
         E+kdA0/jLw2hgs4Bwb1Etyd1g1RN146G1HXuNUtxwreWAgyzT37IzulpdVSqoJSTzTEX
         F836nYa4/9yEE2NxJK5JDusMh2avFnAnV3z0ZMC8OHZlHIkgP04w2qCkgRTd+9HBgE4q
         +QpkK5/jjHfZIx36TxNrlfXHOeCoJJSEPZGgvMkoxtIIx0ZZbqeH29Fd2T9+N3ny/rZX
         pR9w==
X-Gm-Message-State: AOAM533d/a1LlfUDQqHyvpQbW+HpEIiWgTvPtt5KLbqyEPq7kRS/E0tw
        V7fUkwR3MT1XHOQom5l9mA+mFgS/eF6iA6WnnWQ7fw==
X-Google-Smtp-Source: ABdhPJwWahlE3pqn9nKswr8nhVQBzIKT0sCXZaqjvrw9e9E/P3Zu7D+IQwJ8Ep2fzsFpY7MZhj3zfxcLdU0UER1lpF0=
X-Received: by 2002:a0d:c484:0:b0:302:168f:6c15 with SMTP id
 g126-20020a0dc484000000b00302168f6c15mr260333ywd.490.1654100463103; Wed, 01
 Jun 2022 09:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com> <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name> <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic> <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com> <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
In-Reply-To: <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 1 Jun 2022 09:20:52 -0700
Message-ID: <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory accounting in Linux is probably the issue. Both times I ran
the test were from a freshly booted VM. The test parses the output of
$(free -k) to determine the amount of free memory it should allocate
and write/read from, with a given stride of pages to skip before
touching the next page.

We grab the third column of numbers from the Mem output that looks like thi=
s

               total        used        free      shared  buff/cache   avai=
lable
Mem:        65856604     4128688    48558952       11208    13168964    609=
42928
Swap:        1953788      118124     1835664

So my workstation has 48558952 free bytes. We take that, give it to
memtouch to allocate that much anonymous memory rounded down to the
nearest MB with mmap and randomly read/write the buffer.

For an 8GB machine, the UEFI will have the initial 0-0xA000 memory and
0x10_0000 to 0xC00_0000 (beginning of mmio hole) prevalidated. The
next 5GB is classified as the UEFI v2.9 memory type
EFI_RESOURCE_MEMORY_UNACCEPTED, 0x1_4000_000 to 0x2_0000_0000.
The Linux e820 map should see that range as unaccepted rather than
EFI_CONVENTIONAL_MEMORY (i.e., EDK2's EFI_RESOURCE_SYSTEM_MEMORY), but
I think it needs to be accounted as free conventional memory.

So when I see 2044MB free vs 7089MB free in my VMs, the two are
roughly 5GB different.

On Wed, Jun 1, 2022 at 8:49 AM Gupta, Pankaj <pankaj.gupta@amd.com> wrote:
>
>
> > Hi y'all, I've made minimal changes to OVMF to prevalidate only up to
> > 4GB and leave the rest unaccepted, as Thomas Lendacky recommended
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2FAMDESE%2Fovmf%2Fpull%2F4%23issuecomment-1138606275&amp;data=3D05%=
7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0%7C%7C%7C&amp;sdata=3DK93%2F1FrPOo4bIWcssHoisM8vDkOBjWh69bUWosT%2Bt0E%3D&a=
mp;reserved=3D0 and ran
> > a memtouch test to see if this change behaves as expected. One thing
> > that struck me is that an 8GB machine reports 2044MB free with this
> > change (free -k) whereas without it, I see 7089MB free. I think that
> > unaccepted memory should be classified as free in meminfo, no? I'm not
> > familiar enough with that code to say what specific change needs to be
> > made.
> >
>
> Is it memory accounting issue when accepting all the memory at boot time
> compared to 4GB:4GB preboot_acceptance:use_time_acceptance split?
>
> You said you ran memtouch (don't know how it works, assuming it uses
> memory)? Doesn't that mean most of the memory used and hence accepted?
> So, free memory reduced?
>
> Just trying to understand the issue.
>
> Thanks,
> Pankaj
> >
> >
> > On Sun, May 15, 2022 at 11:47 PM Xu, Min M <min.m.xu@intel.com> wrote:
> >>
> >> On May 13, 2022 10:45 PM, Kirill A. Shutemov wrote:
> >>> On Fri, May 13, 2022 at 11:01:43AM +0200, Borislav Petkov wrote:
> >>>> + mroth
> >>>> - brijesh
> >>>>
> >>>> On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
> >>>>> Kirill, I've been tracking these changes to see if we can handle th=
e
> >>>>> unaccepted memory type for SEV-SNP, but testing has been an issue.
> >>>>> The proposed patch in Ovmf to introduce unaccepted memory seems to
> >>>>> have stalled out last September
> >>>>> (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fwww.mail-archive.com%2Fdevel%40edk2.groups.io%2Fmsg35842.html&amp;data=3D=
05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
3000%7C%7C%7C&amp;sdata=3DHku8nQJGOg%2FdQqypHxw2eLFG0e%2FE6HoF5VXSIhMpmx0%3=
D&amp;reserved=3D0)
> >>>>> and is particularly difficult to adapt to SEV-SNP since it doesn't
> >>>>> follow the TDVF way of initializing all memory. Is there a differen=
t
> >>>>> development I might have missed so that we might test these cases?
> >>>>> Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any
> >>> kernel
> >>>>> uses are essentially dead code.
> >>>
> >>> + Min, Jiaqi.
> >>>
> >>> I don't follow firmware development. Min, Jiaqi, could you comment?
> >>>
> >> We have prepared the patch for unaccepted memory and it is now working=
 in our internal release.
> >> But there is an obstacle to upstream it to edk2 master branch.
> >> The patch-set depends on the definition of UEFI_RESOURCE_MEMORY_UNACCE=
PTED in PI spec. This is proposed in https://nam11.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Fmicrosoft%2Fmu_basecore%2Fpull%2=
F66%2Ffiles%23diff-b20a11152d1ce9249c691be5690b4baf52069efadf2e2546cdd2eb66=
3d80c9e4R237&amp;data=3D05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420=
bd7408da43568f68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378963363425=
40814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dv7s68GZWXJfaXB7vfvXjAlTD2=
KLOSghk%2Bj3GXF3FTVg%3D&amp;reserved=3D0, according to UEFI-Code-First. The=
 proposal was approved in 2021 in UEFI Mantis, and will be added to the new=
 PI.next specification. (Till now it has not been added in the latest PI sp=
ec.)
> >> So UEFI_RESOURCE_MEMORY_UNACCEPTED cannot be added in MdePkg which mak=
e it difficult to submit the patch to edk2 community for review. See this l=
ink: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fed=
k2.groups.io%2Fg%2Fdevel%2Fmessage%2F87558&amp;data=3D05%7C01%7Cpankaj.gupt=
a%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sda=
ta=3DWVIJ2yRRd2URwIF85Dp0WD4ovibZlsobijIGbN6MWZQ%3D&amp;reserved=3D0
> >>
> >> Please be noted: UEFI_RESOURCE_MEMORY_UNACCEPTED (defined in PI spec) =
is different from EFI_UNACCEPTED_MEMORY (defined in UEFI spec)
> >>
> >> I will submit the patch-set once the new definition is added in the ne=
w PI.next spec.
> >>
> >> Thanks
> >> Min
> >
> >
> >
>


--=20
-Dionna Glaze, PhD (she/her)
