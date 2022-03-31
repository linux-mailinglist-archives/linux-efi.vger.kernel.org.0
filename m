Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C34ED4A9
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiCaHRZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiCaHRE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 03:17:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5E53B68;
        Thu, 31 Mar 2022 00:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 372DBCE1F4D;
        Thu, 31 Mar 2022 07:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D215C340EE;
        Thu, 31 Mar 2022 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648710817;
        bh=h25cwknPb0Gvkx1DzCuZi0Xx01g14UDu0/Ym3doypW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nodzRzmpw329d6Hk2oipfk0gsRnlwDJ0V09bzxCUao0ch6GnkJ5iBc2uzsgbWI0Ar
         RX5tQOKSojXer3e35U/r+s50Y8UtyMeNoXZyJQVPzYhYwNKEu/8NTOt0FO5GuOborD
         3WUTfnOJ22y5LhzKv71lhVBczS1273ZtG15XNMq2lhh6RmD6EuyNwF+zTfKjm9knmr
         JErh1182vv31+1/xmv/2BAx7U3ezo+u2AqDD3gNk088D+JUsA2tAaEdoQ0lI84X8ST
         nn0EjMKg7f42SFwlu3CPO6u2swezOoVy7PtDMMq+pz6EYuPiuQ2r29qQzrK8OKFaCa
         Sb/w91TUW/X8g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-df26ea5bfbso6849772fac.1;
        Thu, 31 Mar 2022 00:13:37 -0700 (PDT)
X-Gm-Message-State: AOAM5307zQmODl7Ymu46emIVC+C2NAsIApgHb22AJdxv0Ai3VxwNsu2y
        PjarbEdmocFA5Z6u5tXlLGqsI1hRvWvxBXAUuYQ=
X-Google-Smtp-Source: ABdhPJwNpfpzPDVxkwaaS9F4w6snX2C5ykGEgSJtVnMziw74Jfj/oqcd5uuIaWdeV8DiyWlFsrl9KUp2zKd2DqvxG70=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr2022915oap.228.1648710816426; Thu, 31
 Mar 2022 00:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <c3ecd65f-bb10-8d14-500d-d6e2ece9b336@apertussolutions.com>
In-Reply-To: <c3ecd65f-bb10-8d14-500d-d6e2ece9b336@apertussolutions.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Mar 2022 09:13:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
Message-ID: <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
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
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 31 Mar 2022 at 02:36, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> Greetings Matthew,
>
> First thank you to you and James for taking time out of your busy
> schedules to sit down with us and work through all of this.
>
> Hey Ard,
>
> On 3/30/22 03:02, Ard Biesheuvel wrote:>> 1) From an EFI maintainer
> perspective, is making the contract between
> >> the boot stub and the kernel explicit viable?
> >>
> >
> > No. The direction of travel has been to define EFI boot only in terms
> > of the handover from the loader to the stub. What happens next is up
> > to the architecture, and is deliberately not specified, because it is
> > considered to be internal Linux ABI. We've deviated from this once for
> > Xen on ARM, but this means we have already painted ourselves into a
> > corner when it comes the way we use DT internally at the handover
> > point between stub and kernel proper, and I am not eager to repeat
> > that. Locking down the stub-to-kernel protocol for all architectures
> > is not the way to go.
>
> To help provide some visual context, for EFI today there is,
>
>                                         bzImage
> [EFI boot manager] -> [[efi-stub] -> [setup kernel] -> [main kernel]]
>
> Where the efi-stub is responsible for interacting with firmware to
> configure the system, store that configuration for the setup kernel and
> the main kernel, and then call EBS before entering the setup kernel.
>
> For Secure Launch the flow (on Intel) is,
>
>       CPU instruction                   bzImage
> [preamble] -> [ACM] -> [[sl-stub] -> [setup kernel] -> [main kernel]]
>
> In order to make the CPU instruction call to enter the ACM the system
> must be in a very specific quiescent state. This includes but not
> exhaustively,
>   * EBS must have been called
>   * TPM should have all localities closed
>   * IOMMU PMRs must be programmed appropriately
>   * TXT heap space allocated
>   * TXT heap space populated with config structures
>   * All APs must be in a specific idle state
>   * Execution is on the BSP
> Carrying all this out is what is considered the DRTM preamble.
>

Thanks for the explanation, this is really helpful.

> This is the wrinkle because the setup kernel and main kernel are both
> predicated on the efi-stub and the efi-stub is predicated on running
> before EBS.

Matthew suggested this already, but can you explain why handling this
in a callback is not an option? I'd by sympathetic to specifying a
Linux specific protocol that can be grabbed before EBS() but can be
invoked after (but not, say after SetVirtualAddressMap(), to keep
things simple). That should allow us to call back into firmware to
perform the secure launch right before handing over.

My other suggestion, to use a minimal EFI environment just to boot the
kernel, still seems viable to me as well, but it would boil down to
mostly the same, thing, i.e., to inject an intermediate boot stage
between the call to the firmware's EBS() and calling the entrypoint of
the kernel proper. What I do like about this approach is that the EFI
stub could execute unprivileged, which means the secure launch kernel
could track *exactly* what the EFI stub is doing in terms of memory
accesses and protocol invocations, which seems a bit more robust than
the approximation of 'this might be interesting enough to measure'
that the industry seems to have settled on.

> So how can this wrinkle be addressed? The TrenchBoot project
> proposed that the information collected by the efi-stub be formally
> documented for two reasons, 1. to allow the sl-stub to be aware of what
> and where all external data is being injected into the kernel so any
> data that may be security critical could be measured, and 2. it would
> allow third parties, e.g. GRUB, could correctly configure the system,
> pass all EFI related information correctly to the setup kernel and the
> main kernel before executing the preamble. Where the former is more of a
> concern than enabling the latter.
>

The reason I am not willing to lock down the stub<->kernel boot
protocol is because it doesn't scale: currently, the discussion is
about x86, which is a bit different because we already so many ways to
boot it, but for other architectures, this is going to create a huge
maintenance burden: arm64, RISC-V and now LoongArch are all adding EFI
boot support and are looking to support ACPI, SMBIOS and other
features as well, and these are all gated on EFI boot, which requires
booting via the stub.

I'm not eager to kick this can down the road and go with something
that inevitably implies either specifying and maintaining a whole
array of internal protocols as external ABI, or revisiting this
discussion and coming up with two different ways to do DRTM depending
on whether you are running x86 or not.

> Relating to what information is security critical, this can be a bit
> subjective. For example Dave Weston has a twitter thread[1][2][3] over
> what state Azure Attestation can validate for a DRTM Windows system.
> This reflects what Microsoft believes it's customers will want to
> validate about a Windows system before accessing services and data
> stored in Azure. For Linux Secure Launch measuring everything would
> obviously provide the finest grain of assertions regarding how the
> kernel was configured to run but that comes at the expense that is
> incurred for taking the measurements. To date the selection of
> measurements have been an attempt of balancing the most meaningful
> measurements with how many measurements should be taken. For instance it
> would be possible to hash the SRTM (firmware) TPM event log to provide
> an assertion of what its contents were at dynamic launch. Is that a
> meaningful measurement? Not necessarily since there are other means to
> validate the log but there is likely someone who is super cautious and
> would like to see the extra layer of validation.
>

So how will the above translate into meaningful and fair feedback in
response to proposed changes to this documented stub<->kernel handover
protocol, once the need arrives to make changes? Is this super
cautious person going to be the one NAKing everything just because he
is super cautious?

Pardon the skepticism, but I am really reluctant to let this cat out
of the bag if the requirements are so vague and there doesn't seem to
consensus on the scope of DRTM.

Another thing I missed is how these systems are supposed to carry out
the tasks that the stub currently handles: Matt mentioned setting
MemoryOverwriteRequest, but there is also TPM event log handling, and
other bits and pieces. Are you saying this is all going to be part of
this boot protocol as well?

> >> 2) If so, is it desirable?
> >>
> >> 3) If either (1) or (2) is "no", is it reasonable to ensure that all
> >> potentially security-critical state or configuration changes to the
> >> boot stub are reviewed by DRTM people to verify whether the secure
> >> launch code needs to be updated to match?
> >
> > Wouldn't it be better for the secure launch kernel to boot the EFI
> > entrypoint directly? As it happens, I just completed a PoC last week
> > for a minimal implementation of EFI (in Rust) that only carries the
> > pieces that the EFI stub needs to boot Linux. It is currently just a
> > proof of concept that only works on QEMU/arm64, but it should not be
> > too hard to adapt it for x86 and for booting a kernel that has already
> > been loaded to memory.
>
> IIUC, as you can see above, entering the efi-stub from the dynamic
> launch will fail because EBS will have been called.
>

I think you are missing my point here, tbh. What I am suggesting here
is to run a separate, minimal EFI implementation, which has its own
EBS() which is unrelated to the firmware one. Matthew pointed out some
issues with this approach, but the fundamental idea is that it is just
an impedance matcher that looks like EFI to the EFI stub, but is
really just a loader with a memory map and some config tables.

The requirement for this came up in the confidential computing space,
but for bare metal, it seems having a tiny EFI-like shim that can only
boot a Linux kernel (or other EFI-like payloads with no dependencies
on the driver model or other UEFI/PI bloat) might be useful here as
well, especially because it would be completely generic from the EFI
side of things, as opposed to creating yet another project with
intimate knowledge of struct bootparams, device trees, where in memory
the kernel may be loaded on architecture X, where in memory the initrd
may be loaded on architecture X, etc etc.

So the bottom line is that we will have to make this work with EFI
boot one way or the other, but skipping the EFI stub altogether is
really not an option, unless you want to carry the burden of keeping
your code in sync with the kernel. Locking this down as external ABI
is not acceptable to me.

Thanks,
Ard.
