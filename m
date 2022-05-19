Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A552DEDB
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 23:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiESVAA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiESU75 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 16:59:57 -0400
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA39EC3E2;
        Thu, 19 May 2022 13:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652993956; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WJNn34+G4A64afL3otrZliBKRWx7KsBiKqioA4MaC4nDdQsgE8iMNZqoLFBQsUcClMNGTimZbgbWYvJaL4up/iIg/C5U3htDKDHIZt7wuJads88c5kQgUa/Zju7XmhDbIJ1erVJB2uWRazHkhlxA7mdv5v7GrW2uCzjxyMOFW2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652993956; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rHYczDgL+lz9N/UJoNSd7UINmHOH4ayImxnD3Rivz3E=; 
        b=GS28jRLW64euYJOIn0QGjGyKOiQRVQwGtyLXNehM8RSKjnZc4EsHu7CRTcknOWnX/00C3w8gl49fngYW8MVmE/UgsJsiafn4cQ4pEIlN9cOEqWf2wwx+AMm/HZK1MaDvD3Cxnw56y4zeoN4iUYu7mff5/AMbYIE2gmAXnw8YJvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652993956;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=rHYczDgL+lz9N/UJoNSd7UINmHOH4ayImxnD3Rivz3E=;
        b=okJd78uZje9VyoaLilt/EoK5MIud+O8QaLEjUdU5iiIY3cKnQyUukMXl5bFNwcvr
        zSMeJVH1nxUo76mxt6cgLlSi0aMaR0KWwN4D+lZp6PBWJkPIRkE2QcY7PjUbBxBKSO7
        hCiEswNyajoON3ZWYtV9nXpbDk0juk2z9Ajpm/AM=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1652993952581408.89124709104976; Thu, 19 May 2022 13:59:12 -0700 (PDT)
Message-ID: <9f5f9da6-0f48-9838-beaf-ae97b3507dd2@apertussolutions.com>
Date:   Thu, 19 May 2022 16:57:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
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
References: <20220329174057.GA17778@srcf.ucam.org>
 <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <c3ecd65f-bb10-8d14-500d-d6e2ece9b336@apertussolutions.com>
 <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: Linux DRTM on UEFI platforms
In-Reply-To: <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hey Ard,

Apologies for the lag in response, I wanted to have this to you sooner,
but between a variety of events and working on building consensus on how
to address your comments made it drag out a little. Before reading this
message, I would recommend reading the proposal posted to the top of
this thread, as it details an approach that builds on Matthew's callback
proposal along with addressing your concerns with measurements. In this
message, I want to provide you direct answers to the points you raised
independent of the reply at the top of this thread to help map where
your concerns influenced the proposal.

On 3/31/22 03:13, Ard Biesheuvel wrote:
> On Thu, 31 Mar 2022 at 02:36, Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> Greetings Matthew,
>>
>> First thank you to you and James for taking time out of your busy
>> schedules to sit down with us and work through all of this.
>>
>> Hey Ard,
>>
>> On 3/30/22 03:02, Ard Biesheuvel wrote:>> 1) From an EFI maintainer
>> perspective, is making the contract between
>>>> the boot stub and the kernel explicit viable?
>>>>
>>>
>>> No. The direction of travel has been to define EFI boot only in terms
>>> of the handover from the loader to the stub. What happens next is up
>>> to the architecture, and is deliberately not specified, because it is
>>> considered to be internal Linux ABI. We've deviated from this once for
>>> Xen on ARM, but this means we have already painted ourselves into a
>>> corner when it comes the way we use DT internally at the handover
>>> point between stub and kernel proper, and I am not eager to repeat
>>> that. Locking down the stub-to-kernel protocol for all architectures
>>> is not the way to go.
>>
>> To help provide some visual context, for EFI today there is,
>>
>>                                         bzImage
>> [EFI boot manager] -> [[efi-stub] -> [setup kernel] -> [main kernel]]
>>
>> Where the efi-stub is responsible for interacting with firmware to
>> configure the system, store that configuration for the setup kernel and
>> the main kernel, and then call EBS before entering the setup kernel.
>>
>> For Secure Launch the flow (on Intel) is,
>>
>>       CPU instruction                   bzImage
>> [preamble] -> [ACM] -> [[sl-stub] -> [setup kernel] -> [main kernel]]
>>
>> In order to make the CPU instruction call to enter the ACM the system
>> must be in a very specific quiescent state. This includes but not
>> exhaustively,
>>   * EBS must have been called
>>   * TPM should have all localities closed
>>   * IOMMU PMRs must be programmed appropriately
>>   * TXT heap space allocated
>>   * TXT heap space populated with config structures
>>   * All APs must be in a specific idle state
>>   * Execution is on the BSP
>> Carrying all this out is what is considered the DRTM preamble.
>>
> 
> Thanks for the explanation, this is really helpful.

Your welcome.

>> This is the wrinkle because the setup kernel and main kernel are both
>> predicated on the efi-stub and the efi-stub is predicated on running
>> before EBS.
> 
> Matthew suggested this already, but can you explain why handling this
> in a callback is not an option? I'd by sympathetic to specifying a
> Linux specific protocol that can be grabbed before EBS() but can be
> invoked after (but not, say after SetVirtualAddressMap(), to keep
> things simple). That should allow us to call back into firmware to
> perform the secure launch right before handing over.

Apologies, I was not meaning to suggest this was not an option. As you
can see in the proposal posted, this approach is in fact being embraced.
It is not explicit stated in the proposal, but the approach for the
Secure Launch spec is to not explicitly dictate the location of the DL
Handler. If a firmware manufacturer wants to implement a Secure Launch
compliant DL Handler in firmware, this certainly would be welcomed, but
should not be a requirement to enable Secure Launch. For instance, in
the prototype the DL Handler is actually implemented as a stub in the
setup kernel as that is the direction we are moving towards but may not
be how the final implementation works.

> My other suggestion, to use a minimal EFI environment just to boot the
> kernel, still seems viable to me as well, but it would boil down to
> mostly the same, thing, i.e., to inject an intermediate boot stage
> between the call to the firmware's EBS() and calling the entrypoint of
> the kernel proper. What I do like about this approach is that the EFI
> stub could execute unprivileged, which means the secure launch kernel
> could track *exactly* what the EFI stub is doing in terms of memory
> accesses and protocol invocations, which seems a bit more robust than
> the approximation of 'this might be interesting enough to measure'
> that the industry seems to have settled on.

IMHO that is the beauty of the Secure Launch spec. Just as you suggest,
your EFI environment shim could track what the EFI stub does and record
it in the SLRT. In addition, your shim could also implement the DL
Handler to invoke the Dynamic Launch.

>> So how can this wrinkle be addressed? The TrenchBoot project
>> proposed that the information collected by the efi-stub be formally
>> documented for two reasons, 1. to allow the sl-stub to be aware of what
>> and where all external data is being injected into the kernel so any
>> data that may be security critical could be measured, and 2. it would
>> allow third parties, e.g. GRUB, could correctly configure the system,
>> pass all EFI related information correctly to the setup kernel and the
>> main kernel before executing the preamble. Where the former is more of a
>> concern than enabling the latter.
>>
> 
> The reason I am not willing to lock down the stub<->kernel boot
> protocol is because it doesn't scale: currently, the discussion is
> about x86, which is a bit different because we already so many ways to
> boot it, but for other architectures, this is going to create a huge
> maintenance burden: arm64, RISC-V and now LoongArch are all adding EFI
> boot support and are looking to support ACPI, SMBIOS and other
> features as well, and these are all gated on EFI boot, which requires
> booting via the stub.

As I mentioned in the Secure Launch spec proposal, it was not correct
for us to seek that the efi-stub<->kernel interface to be standardized.
The reality is that Secure Launch is an entrypoint itself and like the
efi-stub should provide an interface specifying how and what needs to be
provided to it for it to function correctly.

> I'm not eager to kick this can down the road and go with something
> that inevitably implies either specifying and maintaining a whole
> array of internal protocols as external ABI, or revisiting this
> discussion and coming up with two different ways to do DRTM depending
> on whether you are running x86 or not.

Agreed, which is why we went back and worked on what is the proper way
to address this problem. As has been mentioned many times, while x86 may
have the most mature Dynamic Launch capability, it is not the only
platform with Dynamic Launch. The goal for TrenchBoot is to provide a
common experience, to the extent possible, for using Dynamic Launch
across the different platforms that provide the capability. And to be
clear, that is especially true for different environments on the same
architecture. Specifically, we want setup and configuration to be the
same on x86 coreboot and x86 UEFI.

>> Relating to what information is security critical, this can be a bit
>> subjective. For example Dave Weston has a twitter thread[1][2][3] over
>> what state Azure Attestation can validate for a DRTM Windows system.
>> This reflects what Microsoft believes it's customers will want to
>> validate about a Windows system before accessing services and data
>> stored in Azure. For Linux Secure Launch measuring everything would
>> obviously provide the finest grain of assertions regarding how the
>> kernel was configured to run but that comes at the expense that is
>> incurred for taking the measurements. To date the selection of
>> measurements have been an attempt of balancing the most meaningful
>> measurements with how many measurements should be taken. For instance it
>> would be possible to hash the SRTM (firmware) TPM event log to provide
>> an assertion of what its contents were at dynamic launch. Is that a
>> meaningful measurement? Not necessarily since there are other means to
>> validate the log but there is likely someone who is super cautious and
>> would like to see the extra layer of validation.
>>
> 
> So how will the above translate into meaningful and fair feedback in
> response to proposed changes to this documented stub<->kernel handover
> protocol, once the need arrives to make changes? Is this super
> cautious person going to be the one NAKing everything just because he
> is super cautious?

There is only a mentioning of it in the proposal, but for the Secure
Launch specification there will be a policy entry that will remove the
need for having what will be measured codified in the kernel. It will
allow measurement mechanisms to be implemented in the sl-stub and the
policy will allow the selection and configuration of the mechanisms.

> Pardon the skepticism, but I am really reluctant to let this cat out
> of the bag if the requirements are so vague and there doesn't seem to
> consensus on the scope of DRTM.

I would say the scope is no less vague than it is for efi-stub. UEFI and
kernel features will increase that will change the behavior of the
kernel and affect its ability to protect information within the system.
As this changes, DRTM will need to be able to measure this expansion so
that it may be able to assert the system state/abilities to a user, a
cloud or an enterprise.

> Another thing I missed is how these systems are supposed to carry out
> the tasks that the stub currently handles: Matt mentioned setting
> MemoryOverwriteRequest, but there is also TPM event log handling, and
> other bits and pieces. Are you saying this is all going to be part of
> this boot protocol as well?

This is no longer an issue with the new proposal.

>>>> 2) If so, is it desirable?
>>>>
>>>> 3) If either (1) or (2) is "no", is it reasonable to ensure that all
>>>> potentially security-critical state or configuration changes to the
>>>> boot stub are reviewed by DRTM people to verify whether the secure
>>>> launch code needs to be updated to match?
>>>
>>> Wouldn't it be better for the secure launch kernel to boot the EFI
>>> entrypoint directly? As it happens, I just completed a PoC last week
>>> for a minimal implementation of EFI (in Rust) that only carries the
>>> pieces that the EFI stub needs to boot Linux. It is currently just a
>>> proof of concept that only works on QEMU/arm64, but it should not be
>>> too hard to adapt it for x86 and for booting a kernel that has already
>>> been loaded to memory.
>>
>> IIUC, as you can see above, entering the efi-stub from the dynamic
>> launch will fail because EBS will have been called.
>>
> 
> I think you are missing my point here, tbh. What I am suggesting here
> is to run a separate, minimal EFI implementation, which has its own
> EBS() which is unrelated to the firmware one. Matthew pointed out some
> issues with this approach, but the fundamental idea is that it is just
> an impedance matcher that looks like EFI to the EFI stub, but is
> really just a loader with a memory map and some config tables.

I apologize, but I read "Wouldn't it be better for the secure launch
kernel to boot the EFI entrypoint directly?" to mean that you would be
looking for EFI entrypoint to be called by the Dyanmic Launch. If that
is the case, then again I am not sure how you would make this work as is
suggested.

Let me clarify a little further on how Dynamic Launch hardware works.
When the Dynamic Launch CPU instruction is called by the preamble, the
system enters a new type of execution state, on Intel it is literally a
separate CPU mode referred to as SMX. A very simplistic way to think of
this is that the system has gone through a soft warm boot, but
everything is now different. Instead of coming in through the reset
vector, the system will jump to the DLME entrypoint that was registered
during the preamble. There will be DMA protections in place protecting
the regions specified during the preamble, and the CPU will function in
a slightly different manner. For instance the AP rendezvous procedure
has to be done differently, if a standard INIT-SIPI-SIPI rendezvous is
attempted the system will fault. In the end, this is done to ensure to
the best ability that the system is in a proper state and the only
software executing is that which was measured by the CPU. It is a bit
impressive what the CPU does, and for Intel CPUs there is a fair amount
of detail documented under the SDM documentation for GETSEC[SENTER] [1].
This is one of the reasons there is a fair bit of assembly in the secure
launch patch series, as there is a very specific way in which the system
needs to be brought up from the minimal state it is left in by the
GETSEC[SENTER] instruction to a state that the setup kernel is able to
take control.

This might be made to work by making this EFI shim capable of being
entered by the Dynamic Launch and then call into the efi-stub. But tbh
this is a non-starter from our perspective as this would then force all
x86 environments to run this EFI shim, specifically coreboot
environments. Just as Linux-EFI is not being pushed to work like a
non-efi environment for Dynamic Launch, it would not be fair to force
non-EFI environments to function like an EFI environment.

As suggested above, under the Secure Launch spec proposal, the EFI shim
would work very well as a preamble environment that implements the
Secure Launch spec.

[1] https://github.com/HJLebbink/asm-dude/wiki/GETSEC%5BSENTER%5D

> The requirement for this came up in the confidential computing space,
> but for bare metal, it seems having a tiny EFI-like shim that can only
> boot a Linux kernel (or other EFI-like payloads with no dependencies
> on the driver model or other UEFI/PI bloat) might be useful here as
> well, especially because it would be completely generic from the EFI
> side of things, as opposed to creating yet another project with
> intimate knowledge of struct bootparams, device trees, where in memory
> the kernel may be loaded on architecture X, where in memory the initrd
> may be loaded on architecture X, etc etc.
> 
> So the bottom line is that we will have to make this work with EFI
> boot one way or the other, but skipping the EFI stub altogether is
> really not an option, unless you want to carry the burden of keeping
> your code in sync with the kernel. Locking this down as external ABI
> is not acceptable to me.

Agreed, which is why just as efi-stub has its entry interface that every
bootmanager/bootloader must implement, the sl-stub is an entrypoint that
will implement the Secure Launch specification for how it should be
entered, whether that is by efi-stub or an EFI shim underneath efi-stub.

V/r,
Daniel P. Smith
