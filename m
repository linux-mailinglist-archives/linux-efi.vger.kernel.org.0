Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9433855A059
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiFXSFw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiFXSFv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 14:05:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59615766B0
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 11:05:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t24so5797550lfr.4
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=amHl1LwfBMa5KDjXqZHtC9+AbtdwaHnaESVYa8U2byA=;
        b=H3sKSrgk4dk9/Hswlf5QYJecr2rGepFCacSgMNlU5bXC/icuTUS4zFuhsYf8UFjjCl
         7/uIbmhnQiOjSjUOFuIuBSts3AMRMzgWX3yVxFfx3qaF3if0Z9wLFrEPzXxT6ROgcn0l
         gaMeTc9x99Xx1Wx+cZ9YaO54F8L5PBMeuY0cPogpowiUHI3o8nS6Q72kFDv3YskTyoW6
         ei3dsCuqyqMjnfD+uwcmzgj2yWMVDCsAxOUG/UsCydZsHdLxr7Pr0cfTobtEFm6CV0JK
         gWUVtOIWoX1tS164asj2tha1HSnVTDEw1BECD2k7dNu62R2ysxNEmQ41MUY+c/3LHM49
         C0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=amHl1LwfBMa5KDjXqZHtC9+AbtdwaHnaESVYa8U2byA=;
        b=3XHi8+7AFRBoHyPMPtjbtlgJ6E6gPymrmp5V3NcGOwvD/a6SgX5ZAdBfYiLyPgzCAw
         kVjOb4m9E3Ron51vp3GNwgqmzOLbWeZ2O8eiXMQ2/VxUxj7gc8OFmG+sjkC6F8YAJb6c
         esTcMT+XXV/ag0+KmSQq4TWISp/YBEvCzyQlLQTj9ELrhiRiPJaVgj8NVSGvgd4XMx6Z
         WYfsPJc0XCRVL+/BRF7md7LjDybejauPWJrHyWFw1wfNYZ2Qd8/mTanppw3QN/VutTfV
         Jxi70ebRbFutJ0M4Ez3TPdIavaaA0CwihCImmYk+rc98tKwfC+sHIPJCNzwtO3cr3VK8
         BHNA==
X-Gm-Message-State: AJIora9yWvxMGcolp+V7a+geHA5Iqs73oU1MjLcLfTj2MlADM5i1R5VM
        O18ERkeId+4dIyuHjuHyxy89iCWoYSrFBdhkaUzcpA==
X-Google-Smtp-Source: AGRyM1tQtvJ18kWM/znxc03I5G944GYbAvbUIXDCbDeZWIxGFl9h3QrIwEsXgHtgvQ25f40ZDrIp4mN4pcgMt5IV8i0=
X-Received: by 2002:a05:6512:a94:b0:47f:6621:cf2a with SMTP id
 m20-20020a0565120a9400b0047f6621cf2amr73823lfu.193.1656093948467; Fri, 24 Jun
 2022 11:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com> <20220624174057.72dwo7v36lokmoub@amd.com>
In-Reply-To: <20220624174057.72dwo7v36lokmoub@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 12:05:36 -0600
Message-ID: <CAMkAt6oRv_X_af1tEdi0-eXUd23SekAkssHGo5h8f+8+KP8eHw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Michael Roth <michael.roth@amd.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo <marcelo.cerri@canonical.com>, tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 11:41 AM Michael Roth <michael.roth@amd.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> > On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > UEFI Specification version 2.9 introduces the concept of memory
> > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > guest. Accepting happens via a protocol specific for the Virtual
> > > Machine platform.
> > >
> > > Accepting memory is costly and it makes VMM allocate memory for the
> > > accepted guest physical address range. It's better to postpone memory
> > > acceptance until memory is needed. It lowers boot time and reduces
> > > memory overhead.
> > >
> > > The kernel needs to know what memory has been accepted. Firmware
> > > communicates this information via memory map: a new memory type --
> > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > >
> > > Range-based tracking works fine for firmware, but it gets bulky for
> > > the kernel: e820 has to be modified on every page acceptance. It lead=
s
> > > to table fragmentation, but there's a limited number of entries in th=
e
> > > e820 table
> > >
> > > Another option is to mark such memory as usable in e820 and track if =
the
> > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > physical address space.
> > >
> > > In the worst-case scenario -- a huge hole in the middle of the
> > > address space -- It needs 256MiB to handle 4PiB of the address
> > > space.
> > >
> > > Any unaccepted memory that is not aligned to 2M gets accepted upfront=
.
> > >
> > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > faster for 4G TDX VM and ~4x faster for 64G.
> > >
> > > TDX-specific code isolated from the core of unaccepted memory support=
. It
> > > supposed to help to plug-in different implementation of unaccepted me=
mory
> > > such as SEV-SNP.
> > >
> > > The tree can be found here:
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fintel%2Ftdx.git&amp;data=3D05%7C01%7Cmichael.roth%40amd.com%7C7=
3bacba017c84291482a08da55ffd481%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%=
7C637916854542432349%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DP%2FUJOL30=
5xo85NLXGxGouQVGHgzLJpmBdNyZ7Re5%2FB0%3D&amp;reserved=3D0 guest-unaccepted-=
memory
> >
> > Hi Kirill,
> >
> > I have a couple questions about this feature mainly about how cloud
> > customers can use this, I assume since this is a confidential compute
> > feature a large number of the users of these patches will be cloud
> > customers using TDX and SNP. One issue I see with these patches is how
> > do we as a cloud provider know whether a customer's linux image
> > supports this feature, if the image doesn't have these patches UEFI
> > needs to fully validate the memory, if the image does we can use this
> > new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> > and the customer doesn't input into which UEFI we run, as far as I can
> > tell from the Azure SNP VM documentation it seems very similar. We
> > need to somehow tell our UEFI in the VM what to do based on the image.
> > The current way I can see to solve this issue would be to have our
> > customers give us metadata about their VM's image but this seems kinda
> > burdensome on our customers (I assume we'll have more features which
> > both UEFI and kernel need to both support inorder to be turned on like
> > this one) and error-prone, if a customer incorrectly labels their
>
> > image it may fail to boot.. Has there been any discussion about how to
> > solve this? My naive thoughts were what if UEFI and Kernel had some
> > sort of feature negotiation. Maybe that could happen via an extension
> > to exit boot services or a UEFI runtime driver, I'm not sure what's
> > best here just some ideas.
>
> Not sure if you've seen this thread or not, but there's also been some
> discussion around this in the context of the UEFI support:
>
>   https://patchew.org/EDK2/cover.1654420875.git.min.m.xu@intel.com/cce5ea=
2aaaeddd9ce9df6fa7ac1ef52976c5c7e6.1654420876.git.min.m.xu@intel.com/#20220=
608061805.vvsjiqt55rqnl3fw@sirius.home.kraxel.org
>
> 2 things being discussed there really, which I think roughly boil down
> to:
>
>  1) how to configure OVMF to enable/disable lazy acceptance
>     - compile time option most likely: accept-all/accept-minimum/accept-1=
GB
>
>  2) how to introduce an automatic mode in the future where OVMF does the
>     right thing based on what the guest supports. Gerd floated the idea o=
f
>     tying it to ExitBootServices as well, but not sure there's a solid
>     plan on what to do here yet.
>
> If that's accurate, it seems like the only 'safe' option is to disable it=
 via
> #1 (accept-all), and then when #2 comes along, compile OVMF to just Do Th=
e
> Right Thing.
>
> Users who know their VMs implement lazy acceptance can force it on via
> accept-all OVMF compile option.

Thanks for this Mike! I will bring this to the EDK2 community.

The issue for us is our users use a GCE built EDK2 not their own
compiled version so they don't have the choice. Reading the Azure docs
it seems the same for them, and for AWS so I don't know how often
customers actually get to bring their own firmware.

>
> -Mike
