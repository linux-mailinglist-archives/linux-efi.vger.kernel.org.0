Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141685677EB
	for <lists+linux-efi@lfdr.de>; Tue,  5 Jul 2022 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiGEThv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Jul 2022 15:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiGEThv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Jul 2022 15:37:51 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 12:37:49 PDT
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640319288
        for <linux-efi@vger.kernel.org>; Tue,  5 Jul 2022 12:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657048934; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=R+i/10CubkQKQxupaoY6Pa5/pNc+VVVK6Nb5TMEOiDwlTEd5Z7AlsJEmad2jzVftXV8hxYmVJO/RJ9ZUSuRc4gsMUOHUaOkCExKEoqc8/KVmq8g7p5eqNWH+/xyINx1tNS7wf3sTg/dguaWqmLz8hDIhPZ7qUHFluAS58dAANw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657048934; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=h8u63U5FPJ6pjlW5C6Nu887VeZvT7RcUODfYIFabzcA=; 
        b=AeDLeUi4OEgTr06c6cc/j7LY5INjmIrHK5Q2SXQh50CYM/L2DTb6swazeycBf2FHswibUcYc9uqWlqsJGj7u5mBfu4FKml0qX3oR04oO46TpL9KtwPH3SI14Eldnshm3b5ieJAOXETuWZI+83PPtOc2cEnmAamr23reFm8y6p8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657048934;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=h8u63U5FPJ6pjlW5C6Nu887VeZvT7RcUODfYIFabzcA=;
        b=Dcz1lFizyGgQq3KQltEmaqyDJWesWI6LhOSKSjVtNpxbenxwyShceMSaM6ktTHAp
        /tFonBYrHbL/taarSao3Kzh6LsOxhnZd4z+beoFfva2np0c7ZUB5jVII89M992Dgbxy
        wQZsonUlQmZHm0Mj2MSEC8oAQnNK5l9hmP0rYWEs=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1657048927351307.17400736196646; Tue, 5 Jul 2022 12:22:07 -0700 (PDT)
Message-ID: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
Date:   Tue, 5 Jul 2022 14:35:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: Linux DRTM on UEFI platforms
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grub-devel@gnu.org, James Morris <jmorris@namei.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>>
>> Greetings,
>>
<snip/>

>> While Matthew's original proposal was around having a location in the
>> efi-stub for the callback to be registered, it is felt that it would be
>> better suited as part of the Secure Launch specification. What is
>> proposed is for the address of the DL Handler to be stored in the SLRT,
>> details for the SLRT are below. Then the bootloader that is responsible
>> for loading the DL Handler will register the SLRT in the EFI
>> configuration table. Checking for the SLRT GUID in the EFI configuration
>> table will enable the EFI bootoader responsible for calling EBS, in this
>> case efi-stub, to know that a Dynamic Launch has been requested. It also
>> seems this would be more in line with how EFI tends to work, versus a
>> Linux-specific callback boot param or something similar.
>>
>
> This all looks reasonable but it is not clear to me what a 'Linux
> setup kernel' is, and what the boot protocol is for that handover.

I used the term 'Linux setup kernel' just to encapsulate the
entrypoints, compressed kernel, and pre-"kernel proper" code. As for
boot protocol, I believe the SLRT is what you are looking for, and we
are in the process of drafting and verifying with a prototype.

> The EFI stub to core kernel handover ABI is private to Linux,
> architecture specific, and subject to change. This is basically the
> point I made before: if you want to boot Linux in EFI mode, you have
> to go via the EFI stub, and the EFI stub is in charge of booting the
> kernel proper. This is why I (we?) suggested some kind of callback
> mechanism, where the EFI stub makes a D-RTM specific call after EBS(),
> but does regain control over the boot flow.

Literally, this is not how the hardware works nor in line with the
architecture developed by TrenchBoot. By doing the Dynamic Launch Event
(DLE) the system, meaning the CPU, has effectively been reset. The
CPU/Dynamic Configuration Environment (DCE) is expecting to be provided
a kernel to measures, an entrypoint within that kernel to jump to, and
that kernel understands the reset state of the system. As agreed, the
callback approach is the most satisfactory approach to allow the
efi-stub to do its private protocol. Once the flow has switched to a
dynamic launch, the system is now starting the kernel via a dynamic
launch sequence. The dynamic launch entrypoint, sl-stub, is and will be
used as the entrypoint regardless of the firmware,
UEFI/coreboot/oreboot/slimboot/etc., or CPU vendor, Intel/AMD, in use.
Once efi-stub finishes and invokes the callback, its job is complete and
the new dl-handler along with sl-stub from the current patch set will
handle the system and security setup needed before entering into the
kernel proper.

To help provide clarity, consider the following flows for comparison,

Normal/existing efi-stub:
  EFI -> efi-stub -> head_64.S

Proposed secure launch:
  EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S

Effectively, all this is doing is after efi-stub is done, instead of
jumping into head_64.S, it will call the dynamic launch handler to do
the dynamic launch, let sl_stub bring the system back into an expected
state, and then enter head_64.S just as efi-stub would have done.

> If we add another entry point into the kernel proper for the Secure
> Launch Entry component to use, we are again exposing an internal ABI
> in a way that limits our future ability to make changes to the EFI <->
> kernel handover.

I am not sure how you make that jump, but as I stated above, when
incorporating dynamic launch it is no longer a straight pass from EFI to
kernel proper. The sl-stub is there to provide a common entry point from
the CPU as the result of a dynamic launch, regardless of firmware or
vendor. Once sl-stub is done with its start-of-day setup, it will jump
to the same location efi-stub would have jumped. This means, efi-stub
does everything it always has and is free to change what it does. The
only addition is that it will now enable a call-out to allow secure
launch to do what it needs to do, and then execution returns back to
head_64.S. To be concise, it specifically returns where efi-stub would
have jumped to without removing or circumventing anything from the
existing flow.

It should also be noted that sl-stub will not be looking to reconfigure
the kernel. It will use the kernel as it was set up by efi-stub. The
only job of sl-stub is to make the world right, measure what efi-stub
provided for measurement, and then enter the kernel proper. The design
of the SLRT structure below is specifically not to bind to anything from
the efi-stub ABI/API. The only information needed to take the
measurements is the location of any config items, their size, and an
identifier for each item. The efi-stub is free to add to and/or remove
from the list of items, along with changing where it is stored, or even
change the format of existing items. The one recommendation, not
requirement, is that the identifiers should not freely be changed. While
it has no impact on sl-stub, it will likely be unpopular with anyone
attempting to keep a manifest of valid efi-stub config items for
attestation verification. It will result in having to maintain a
volatile two-parameter map of (kernel version, identifier) to config
item, at a minimum.

<snip/>

>> First, a short review of what the Secure Launch Resource Table is and
>> its purpose. The SLRT is to provide a platform and kernel agnostic
>> configuration table of the meta-data pertinent to the Secure Launch
>> entry points for the variety of kernels the TrenchBoot project will be
>> seeking to support. The specification for the table is in progress, but
>> the consensus is that it will consist of a header structure followed by
>> a packed series of TLV records. The specification will describe the
>> various types of records, but the ones of interests in this discussion
>> are those that efi-stub would use to record how it configured the
>> environment.
>>
>> The initially proposed TLV record, see below, for EFI configuration
>> information was devised around allowing an EFI bootloader to save
>> multiple config events under a single TLV record. In discussions on the
>> specification thus far, there are questions if it would be better to
>> have a TLV record for each config event or the proposed multiple events
>> per TLV record. It is worth noting that an assumption is being made in
>> the proposed record. The assumption is that a config event will either
>> be setting a configuration value between 1 and 8 bytes, or it will be a
>> data blob for which the address and size will be recorded. The question
>> is whether that covers all actions the efi-stub does or expects that it
>> will have to do in the near future.
>>
>> struct slrt_entry_efi_config_event {
>>          struct slrt_entry_hdr hdr;
>>          uint32_t identifier;                /* EFI bootloader ID */
>>          uint16_t reserved;
>>          uint16_t nr_entries;                /* Num cfg records */
>>          struct efi_cfg_value values[0];     /* Array of cfg values */
>>      };
>>
>>      struct efi_cfg_value {
>>          uint64_t data;          /* cfg data (address or value) */
>>          uint32_t size;          /* data size if data is an addr */
>>          uint32_t flags;         /* 1L<0 IS_ADDR: data is an addr */
>>          char evt_info[8];       /* event info str for TPM event log */
>>      };
>>
>> Hopefully the general approach here is agreeable, as IMHO it does
>> provide a fairly elegant approach to resolving the issues at hand.
>> Details can always be negotiated to address various implementation
>> concerns. Provided this is acceptable, then everyone here is welcome to
>> provide input on the Secure Launch specification, link forthcoming.
>>
>
> Given that this is EFI, I would expect all these implementation
> details to be exposed via a protocol that the stub can invoke, in a
> way that will likely be similar (or the same?) as the TCG protocol
> used for recording PCR measurements.

The intent here was not to devise a new EFI protocol. This table is an
agnostic structure that all TrenchBoot Secure Launch implementations
will be using for all firmware environments, and will provide platform
relevant sections like the EFI section outlined above. The table will
inform the dl-handler so that it may take appropriate setup actions for
the dynamic launch. The larger user of the table will be the sl-stub,
which it will use to have an understanding of the world it inherited
from whomever invoked the dynamic launch.

> So could you elaborate on the types of actions? Is this simply things
> like the command line, initrd contents, initrd load address, kernel
> load address etc etc? There isn't generally that much going on in the
> stub beyond that.

Actually, those items are already in well-defined locations for which we
are already taking measurements. The items of concern are the items
being passed or configured that are stored outside the boot params. For
instance, ROM files passed to the kernel or EFI environment variables
that efi-stub may have set and/or will be used by the kernel.

V/r,
Daniel P. Smith

