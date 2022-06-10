Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2D546AB2
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349856AbiFJQlf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbiFJQlO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 12:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71AB19031;
        Fri, 10 Jun 2022 09:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 886FAB83640;
        Fri, 10 Jun 2022 16:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53212C341C4;
        Fri, 10 Jun 2022 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654879268;
        bh=pAdz++aE+4RP4T7B3ruJVc+D7hErfuaYU5oKbDu8EmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gEcl11kmgr1KMeIZwSXSRyCvo8ObflBhq7pv7JRikFEbkisNF3tF+fC4NRJ3sGUoU
         TBH61xWMTbVLCtjKHBEOqc9mxWsO054eHFpI+fqz5m9r31Cw57q+Ic9OSVE5/TZsw3
         Zvxnbi2fzOv6nHO/c1Xb2yEGnspXECYgnptK69AZXUGYaDml8h9UT1fFd5oAI7nqUa
         JeapFlydkDt1KKjxuBYByl6mEmQAfCoy855YvD+hcu+RICZyBfQAQ1zDWWr09j8yrM
         y4HXO7+EJG+h0OkxSDfGNafSX+4hMoSDCxRBIioqqlWYlc8xTKyfLmla7GS4mVjt5w
         /9kWOO8GoYtug==
Received: by mail-oi1-f169.google.com with SMTP id y69so22405647oia.7;
        Fri, 10 Jun 2022 09:41:08 -0700 (PDT)
X-Gm-Message-State: AOAM533eB7RngrT0j1szZpRd0mJrpj/pPslTXCpaMz2eXirOmIm+0dSX
        z8Qis0P5LeRCXn6jF+80AnFtw+FBxLZkbqjbTsw=
X-Google-Smtp-Source: ABdhPJztkPGLoTJZN81zwpZywu2nmc1BbqQHx87+gMgcUq4NGlSgUjSKcQyiEiYhxPTeDcflatIExEqxx60IF4YDUf0=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr397582oib.126.1654879267364; Fri, 10
 Jun 2022 09:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
In-Reply-To: <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 18:40:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
Message-ID: <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grub-devel@gnu.org, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 May 2022 at 22:59, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
>
> Greetings,
>
> Based on the discussions that occurred in this thread, there seems to be
> two issues at hand that should be decoupled, as their solutions can and
> should be implemented independently. These are:
> - the handling of the Dynamic Launch preamble
> - providing the complete kernel configuration for measurement
>
> For the former, it is believed there is a consensus that Matthew's
> proposed callback approach would be the preferred method. Through some
> contemplating and prototyping, the determination is that this will in
> fact be an approach that will ultimately benefit the TrenchBoot project
> itself.
>
> In general, the preamble consists of two activities: 1. preparing the
> contents in memory and 2. preparing the hardware in order to call the
> Dynamic Launch instruction. In past implementations, these two
> activities were conducted sequentially, but in reality the time delta
> between the two may be arbitrary. Introducing this separation does not
> introduce any security concerns due to how the Dynamic Launch works. Any
> tampering of the contents in memory will either cause the Dynamic Launch
> to fail or result in a detectable difference in the Dynamic Launch
> measurement chain.
>
> In order to separate the hardware interactions into what will be called
> the DLE Handler, this will require a collection of information regarding
> how the environment is set up. When working through what would be
> required, this led to the realization that this really should be
> generalized into a formal specification for TrenchBoot's Secure Launch.
> This will enable a reusable solution for the TrenchBoot project, versus
> implementing a one-off solution for Linux. A prototype of is near
> completion, for which below is a visual depiction along with a
> step-by-step walk through of how it would work for efi-stub.
>
> Secure Launch Flow:
>
>                          +-----------------+
>                          |                 |
>          +-------------->| Secure Launch   +---------------+
>          |               | Resource Table  |               |
>          |               |                 |    +------|---------------+
>          |               +--------+--------+    |      |         DLME  |
>          |                        |             |      v               |
>          |                        |             | +---------------+    |
>    +-----+---------+              v             | |               |    |
> +--+-------------+ |       +-------------+      | | Secure Launch |    |
> |                | +------>|             +------->|     Entry     |    |
> | Bootloader(s)  | |       | DLE Handler |      | |               |    |
> |                +-+       |             |      | +---------------+    |
> +----------------+         +-------------+      +----------------------+
>
> A quick note on the flow diagram, for simplicity all entities prior to
> the DLE Handler are represented by the "Bootloader(s)" block due to the
> fact that what entities are involved can and will vary. This is where
> both GRUB and efi-stub are being represented even though for Linux EFI,
> GRUB is considered the bootmanager while efi-stub is the bootloader.
>
> An efi-stub walk-thru:
>
> 1. - GRUB
> 1.1 - GRUB will initialize the Secure Launch Resource Table (SLRT)
> 1.2 - GRUB will set up DLE Handler and register it in SLRT
> 1.5 - GRUB will load Linux kernel
> 1.3 - GRUB will set up DL environment appropriately for HW platform
> 1.4 - GRUB will record DL setup in SLRT
> 1.5 - GRUB will record SLRT location in platform's DL config structure
> 1.5 - GRUB will register SLRT in EFI configuration table under SL GUID
> 1.6 - GRUB will invoke efi-stub
>
> 2. - efi-stub
> 2.1 - efi-stub will check if SL GUID is in EFI configuration table
> 2.2 - for each efi-stub config action, an SLRT EFI config event will be
>       recorded
> 2.3 - efi-stub calls EBS() then jumps to DLE Handler registered in SLRT
>       while passing the SLRT address
>
> 3. - DL Handler
> 3.1 - DL Handler will retrieve SL Entry from SLRT
> 3.2 - DL Handler will prepare HW for calling DL CPU instruction
> 3.3 - DL Handler will execute DL CPU instruction
>
> 4. SL Entry
> 4.1 SL Entry will retrieve SLRT address from platform's DL config struct
> 4.2 SL Entry will use policy in SLRT to determine what to measure
> 4.3 SL Entry will set up HW to what Linux expects
> 4.4 SL Entry will jump into Linux setup kernel
> 4.5 SL Entry will record measurements into TPM prior to init process
>     starting
>
> While Matthew's original proposal was around having a location in the
> efi-stub for the callback to be registered, it is felt that it would be
> better suited as part of the Secure Launch specification. What is
> proposed is for the address of the DL Handler to be stored in the SLRT,
> details for the SLRT are below. Then the bootloader that is responsible
> for loading the DL Handler will register the SLRT in the EFI
> configuration table. Checking for the SLRT GUID in the EFI configuration
> table will enable the EFI bootoader responsible for calling EBS, in this
> case efi-stub, to know that a Dynamic Launch has been requested. It also
> seems this would be more in line with how EFI tends to work, versus a
> Linux-specific callback boot param or something similar.
>

This all looks reasonable but it is not clear to me what a 'Linux
setup kernel' is, and what the boot protocol is for that handover.

The EFI stub to core kernel handover ABI is private to Linux,
architecture specific, and subject to change. This is basically the
point I made before: if you want to boot Linux in EFI mode, you have
to go via the EFI stub, and the EFI stub is in charge of booting the
kernel proper. This is why I (we?) suggested some kind of callback
mechanism, where the EFI stub makes a D-RTM specific call after EBS(),
but does regain control over the boot flow.

If we add another entry point into the kernel proper for the Secure
Launch Entry component to use, we are again exposing an internal ABI
in a way that limits our future ability to make changes to the EFI <->
kernel handover.

> Hopefully this resolves the first of the two issues mentioned at the
> beginning of this email in a manner that addresses most of the concerns
> raised in the earlier discussions. This leaves the second issue over how
> to get an accurate measurement of how the kernel was configured by
> efi-stub. When reviewing the comments in the discussion, it was realized
> the originally requested approach was in fact in reverse. Instead of
> asking for efi-stub's internal API/ABI to be documented, Secure Launch
> should specify an ABI for how any bootloader should be invoking a Secure
> Launch entrypoint, particularly capturing how an EFI bootloader
> configured the environment. This is the second motivation for devising
> the SLRT. Specifying this ABI also provided the opportunity to
> incorporate a measurement policy and thus allowing for it to be
> separated away from sl-stub, as it is in the current implementation. For
> this discussion the focus will be on the portions of the SLRT relating
> to EFI Environments and in particular the EFI config event record
> mentioned in step 2.2 of the efi-stub walk-thru.
>
> First, a short review of what the Secure Launch Resource Table is and
> its purpose. The SLRT is to provide a platform and kernel agnostic
> configuration table of the meta-data pertinent to the Secure Launch
> entry points for the variety of kernels the TrenchBoot project will be
> seeking to support. The specification for the table is in progress, but
> the consensus is that it will consist of a header structure followed by
> a packed series of TLV records. The specification will describe the
> various types of records, but the ones of interests in this discussion
> are those that efi-stub would use to record how it configured the
> environment.
>
> The initially proposed TLV record, see below, for EFI configuration
> information was devised around allowing an EFI bootloader to save
> multiple config events under a single TLV record. In discussions on the
> specification thus far, there are questions if it would be better to
> have a TLV record for each config event or the proposed multiple events
> per TLV record. It is worth noting that an assumption is being made in
> the proposed record. The assumption is that a config event will either
> be setting a configuration value between 1 and 8 bytes, or it will be a
> data blob for which the address and size will be recorded. The question
> is whether that covers all actions the efi-stub does or expects that it
> will have to do in the near future.
>
> struct slrt_entry_efi_config_event {
>         struct slrt_entry_hdr hdr;
>         uint32_t identifier;                /* EFI bootloader ID */
>         uint16_t reserved;
>         uint16_t nr_entries;                /* Num cfg records */
>         struct efi_cfg_value values[0];     /* Array of cfg values */
>     };
>
>     struct efi_cfg_value {
>         uint64_t data;          /* cfg data (address or value) */
>         uint32_t size;          /* data size if data is an addr */
>         uint32_t flags;         /* 1L<0 IS_ADDR: data is an addr */
>         char evt_info[8];       /* event info str for TPM event log */
>     };
>
> Hopefully the general approach here is agreeable, as IMHO it does
> provide a fairly elegant approach to resolving the issues at hand.
> Details can always be negotiated to address various implementation
> concerns. Provided this is acceptable, then everyone here is welcome to
> provide input on the Secure Launch specification, link forthcoming.
>

Given that this is EFI, I would expect all these implementation
details to be exposed via a protocol that the stub can invoke, in a
way that will likely be similar (or the same?) as the TCG protocol
used for recording PCR measurements.

So could you elaborate on the types of actions? Is this simply things
like the command line, initrd contents, initrd load address, kernel
load address etc etc? There isn't generally that much going on in the
stub beyond that.
