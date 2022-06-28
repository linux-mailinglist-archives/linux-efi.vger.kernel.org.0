Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CE55EACF
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiF1RRU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1RRQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:17:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D242F02B;
        Tue, 28 Jun 2022 10:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 761C0B81A9D;
        Tue, 28 Jun 2022 17:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23337C341CE;
        Tue, 28 Jun 2022 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436633;
        bh=usxaCMDh/Kg4ZK2P/XBDr6Ic3D5rTWyFphZ3cTcB6/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QFUc7IWGaq6zAHxv+aizLOigiBCl2YkN5uV508xzGBlOEm+dPAVHYQ26KOcWSEbtR
         jocVZVPBGzYiMe7jj2wKX9SDjPU9cMGvEeYNrwkleeKZA+xAtw0OTUTreAqSUtlBmJ
         1rAP0EGUqPn60FCv3qd67fDPInobFph2AYLHQJUoNukNHgeBGCuZyN02LCBXzbG5QI
         +C8mMV6g/KDVWOc9PJQVxdznZYo+EKOpR+XhNNCnGdmvUJRsvbge9rZZJBkrIT6Tm1
         QM6Sjxf3Q98rk4aSRzbyzVci6KmuST4pFGbHCqQ02gV/HNTVI9fkbjfG01gv6nTY2k
         X5C1iOuMpyTtA==
Received: by mail-oi1-f182.google.com with SMTP id y77so18107881oia.3;
        Tue, 28 Jun 2022 10:17:13 -0700 (PDT)
X-Gm-Message-State: AJIora92ld9kal1Lzq3srK5drF0ETOZAPyvUdE42KWBKuH3UHZmW5lbV
        2UHSib4KlCeHNPHuuiV/d3TBQJVzA7rriZMaPW4=
X-Google-Smtp-Source: AGRyM1uO0YWjWyCv1x123jP8A9Qhqpz+q8tixxDZLG2jp9eg0NDSehl7NyZDgaKJIJwRmATEZ+y0Qn5hTDIhHYRqYc4=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr421842oiw.228.1656436632278; Tue, 28 Jun
 2022 10:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com> <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com> <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com> <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
In-Reply-To: <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:17:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
Message-ID: <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@alien8.de>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 00:38, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jun 27, 2022 at 06:33:51PM +0200, Ard Biesheuvel wrote:
> > > > > >
> > > > > > Just as an idea, we can put info into UTS_VERSION which can be read from
> > > > > > the built bzImage. We have info on SMP and preeption there already.
> > > > > >
> > > > >
> > > > > Instead of hacking this into the binary, couldn't we define a protocol
> > > > > that the kernel will call from the EFI stub (before EBS()) to identify
> > > > > itself as an image that understands unaccepted memory, and knows how
> > > > > to deal with it?
> > > > >
> > > > > That way, the firmware can accept all the memory on behalf of the OS
> > > > > at ExitBootServices() time, unless the OS has indicated there is no
> > > > > need to do so.
> > > >
> > > > I agree it would be better. But I think it would require change to EFI
> > > > spec, no?
> > >
> > > Could this somehow be amended on to the UEFI Specification version 2.9
> > > change which added all of the unaccepted memory features?
> > >
> >
> > Why would this need a change in the EFI spec? Not every EFI protocol
> > needs to be in the spec.
>
> My EFI knowledge is shallow. Do we do this in other cases?
>

The E in EFI means 'extensible' and the whole design of a protocol
database using GUIDs as identifiers (which will not collide and
therefore need no a priori coordination when defining them) is
intended to allow extensions to be defined and implemented in a
distributed manner.

Of course, it would be fantastic if we can converge on a protocol that
all flavors of confidential compute can use, across different OSes, so
it is generally good if a protocol is defined in *some* shared
specification. But this doesn't have to be the EFI spec.
