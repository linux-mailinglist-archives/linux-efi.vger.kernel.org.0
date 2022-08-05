Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5EF58AB16
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiHEMyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 08:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiHEMyL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 08:54:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64882205F3;
        Fri,  5 Aug 2022 05:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 000DBB828C0;
        Fri,  5 Aug 2022 12:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F21C43143;
        Fri,  5 Aug 2022 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659704044;
        bh=kv7S0eFsiAct17ZXvq0jNqmfMCiLtvDDXWKyk1Yqn2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfiRxd57Fg1PaEadZcXmCqaQjueEVyyxKAhfTXKhHRqeMwjIDbLtCiemvgYwOg1Su
         cioL85XPSq5e7VZnR8gaAky3EmKPQi2mou7+6KNpZIykIz/dnFJCAHcVHCCYYN9AGE
         qdNUfzlvDAlE6IHil176S1Z0ysigvfvoeH56PBE94LP04QyB+lQCqAS6fJhKefLbxr
         Rtsd+Bzforc5LC4KE+LEA9aoTPyRmo5J8Jvv3CSL11tZyQ5GUrbMJoIEn2bXURbT83
         HJ/YImWcOXts41Lui1V1RNqg53Qd0H91nQgQb/j/o++b42wyOqUw1VsqgfEY1nC8be
         OjEdnToc7lyvw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10ec41637b3so2843250fac.4;
        Fri, 05 Aug 2022 05:54:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo20KyrB4C3w40eJE8w9q1dRuBwiXplBdla8jHCSq3meTPve8t+E
        VDtFhXlQDwQhqh8lABKg6qsAB0Dm67dhKhqYGdY=
X-Google-Smtp-Source: AA6agR6u5bHuJAZYSvHzty7NuAi+ipTOECIu/MXNfqFegh1eIH7VP2MvKUvQAyHfuvQd72VmLiHE0Knn7UWQ0xag8Rs=
X-Received: by 2002:a05:6870:a90a:b0:10d:9e83:98a6 with SMTP id
 eq10-20020a056870a90a00b0010d9e8398a6mr6193471oab.228.1659704043595; Fri, 05
 Aug 2022 05:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com> <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
In-Reply-To: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Aug 2022 14:53:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFx_9q8t_HT=jvaKKftPNHf+iqWJM3fMiwpDyjFy0-d1g@mail.gmail.com>
Message-ID: <CAMj1kXFx_9q8t_HT=jvaKKftPNHf+iqWJM3fMiwpDyjFy0-d1g@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 5 Jul 2022 at 21:22, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 6/10/22 12:40, Ard Biesheuvel wrote:
...
> > The EFI stub to core kernel handover ABI is private to Linux,
> > architecture specific, and subject to change. This is basically the
> > point I made before: if you want to boot Linux in EFI mode, you have
> > to go via the EFI stub, and the EFI stub is in charge of booting the
> > kernel proper. This is why I (we?) suggested some kind of callback
> > mechanism, where the EFI stub makes a D-RTM specific call after EBS(),
> > but does regain control over the boot flow.
>
> Literally, this is not how the hardware works nor in line with the
> architecture developed by TrenchBoot. By doing the Dynamic Launch Event
> (DLE) the system, meaning the CPU, has effectively been reset. The
> CPU/Dynamic Configuration Environment (DCE) is expecting to be provided
> a kernel to measures, an entrypoint within that kernel to jump to, and
> that kernel understands the reset state of the system. As agreed, the
> callback approach is the most satisfactory approach to allow the
> efi-stub to do its private protocol. Once the flow has switched to a
> dynamic launch, the system is now starting the kernel via a dynamic
> launch sequence. The dynamic launch entrypoint, sl-stub, is and will be
> used as the entrypoint regardless of the firmware,
> UEFI/coreboot/oreboot/slimboot/etc., or CPU vendor, Intel/AMD, in use.
> Once efi-stub finishes and invokes the callback, its job is complete and
> the new dl-handler along with sl-stub from the current patch set will
> handle the system and security setup needed before entering into the
> kernel proper.
>
> To help provide clarity, consider the following flows for comparison,
>
> Normal/existing efi-stub:
>   EFI -> efi-stub -> head_64.S
>
> Proposed secure launch:
>   EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S
>
> Effectively, all this is doing is after efi-stub is done, instead of
> jumping into head_64.S, it will call the dynamic launch handler to do
> the dynamic launch, let sl_stub bring the system back into an expected
> state, and then enter head_64.S just as efi-stub would have done.
>

OK, understood.

> > If we add another entry point into the kernel proper for the Secure
> > Launch Entry component to use, we are again exposing an internal ABI
> > in a way that limits our future ability to make changes to the EFI <->
> > kernel handover.
>
> I am not sure how you make that jump, but as I stated above, when
> incorporating dynamic launch it is no longer a straight pass from EFI to
> kernel proper. The sl-stub is there to provide a common entry point from
> the CPU as the result of a dynamic launch, regardless of firmware or
> vendor. Once sl-stub is done with its start-of-day setup, it will jump
> to the same location efi-stub would have jumped. This means, efi-stub
> does everything it always has and is free to change what it does. The
> only addition is that it will now enable a call-out to allow secure
> launch to do what it needs to do, and then execution returns back to
> head_64.S. To be concise, it specifically returns where efi-stub would
> have jumped to without removing or circumventing anything from the
> existing flow.
>

Excellent, that answers another question I had regarding the above.

> It should also be noted that sl-stub will not be looking to reconfigure
> the kernel. It will use the kernel as it was set up by efi-stub. The
> only job of sl-stub is to make the world right, measure what efi-stub
> provided for measurement, and then enter the kernel proper. The design
> of the SLRT structure below is specifically not to bind to anything from
> the efi-stub ABI/API. The only information needed to take the
> measurements is the location of any config items, their size, and an
> identifier for each item. The efi-stub is free to add to and/or remove
> from the list of items, along with changing where it is stored, or even
> change the format of existing items. The one recommendation, not
> requirement, is that the identifiers should not freely be changed. While
> it has no impact on sl-stub, it will likely be unpopular with anyone
> attempting to keep a manifest of valid efi-stub config items for
> attestation verification. It will result in having to maintain a
> volatile two-parameter map of (kernel version, identifier) to config
> item, at a minimum.
>

OK, noted. Can we add these recommendations to the header files
please? And let's make it a requirement - it's easier to relax it
later than the other way around.

> <snip/>
>
> >> First, a short review of what the Secure Launch Resource Table is and
> >> its purpose. The SLRT is to provide a platform and kernel agnostic
> >> configuration table of the meta-data pertinent to the Secure Launch
> >> entry points for the variety of kernels the TrenchBoot project will be
> >> seeking to support. The specification for the table is in progress, but
> >> the consensus is that it will consist of a header structure followed by
> >> a packed series of TLV records. The specification will describe the
> >> various types of records, but the ones of interests in this discussion
> >> are those that efi-stub would use to record how it configured the
> >> environment.
> >>
> >> The initially proposed TLV record, see below, for EFI configuration
> >> information was devised around allowing an EFI bootloader to save
> >> multiple config events under a single TLV record. In discussions on the
> >> specification thus far, there are questions if it would be better to
> >> have a TLV record for each config event or the proposed multiple events
> >> per TLV record. It is worth noting that an assumption is being made in
> >> the proposed record. The assumption is that a config event will either
> >> be setting a configuration value between 1 and 8 bytes, or it will be a
> >> data blob for which the address and size will be recorded. The question
> >> is whether that covers all actions the efi-stub does or expects that it
> >> will have to do in the near future.
> >>
> >> struct slrt_entry_efi_config_event {
> >>          struct slrt_entry_hdr hdr;
> >>          uint32_t identifier;                /* EFI bootloader ID */
> >>          uint16_t reserved;
> >>          uint16_t nr_entries;                /* Num cfg records */
> >>          struct efi_cfg_value values[0];     /* Array of cfg values */

Nit: use [] for flex arrays please - we will become more pedantic
about this when using newer compilers.

> >>      };
> >>
> >>      struct efi_cfg_value {
> >>          uint64_t data;          /* cfg data (address or value) */
> >>          uint32_t size;          /* data size if data is an addr */
> >>          uint32_t flags;         /* 1L<0 IS_ADDR: data is an addr */
> >>          char evt_info[8];       /* event info str for TPM event log */
> >>      };
> >>
> >> Hopefully the general approach here is agreeable, as IMHO it does
> >> provide a fairly elegant approach to resolving the issues at hand.
> >> Details can always be negotiated to address various implementation
> >> concerns. Provided this is acceptable, then everyone here is welcome to
> >> provide input on the Secure Launch specification, link forthcoming.
> >>
> >
> > Given that this is EFI, I would expect all these implementation
> > details to be exposed via a protocol that the stub can invoke, in a
> > way that will likely be similar (or the same?) as the TCG protocol
> > used for recording PCR measurements.
>
> The intent here was not to devise a new EFI protocol. This table is an
> agnostic structure that all TrenchBoot Secure Launch implementations
> will be using for all firmware environments, and will provide platform
> relevant sections like the EFI section outlined above. The table will
> inform the dl-handler so that it may take appropriate setup actions for
> the dynamic launch. The larger user of the table will be the sl-stub,
> which it will use to have an understanding of the world it inherited
> from whomever invoked the dynamic launch.
>

OK. We'll need some useful abstraction for this internally in the stub
code, but that is not too relevant for this discussion. (We recently
added some code that measures the initrd into the TPM, and having
calls to two different kinds of measurement APIs all over the stub is
something I'd like to avoid)

> > So could you elaborate on the types of actions? Is this simply things
> > like the command line, initrd contents, initrd load address, kernel
> > load address etc etc? There isn't generally that much going on in the
> > stub beyond that.
>
> Actually, those items are already in well-defined locations for which we
> are already taking measurements. The items of concern are the items
> being passed or configured that are stored outside the boot params.

You mean the x86 specific struct bootparams, right? Not relevant, but
just out of interest: I take it you are also measuring the setup_data
linked list? This is currently being augmented to carry a RNG seed,
which may cause problems for you in the future.

> For
> instance, ROM files passed to the kernel or EFI environment variables
> that efi-stub may have set and/or will be used by the kernel.
>

Hmm, ok. I'd really like to get a peek at the impact on the code - if
we will have hooks all over the place, it is a strong indication that
you are intercepting this at the wrong level. Perhaps you'll need to
do something along the lines of interposing the boot and runtime
services, and measuring the invocations that are relevant to you.
