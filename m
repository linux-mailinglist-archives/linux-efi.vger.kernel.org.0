Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21B249EB2
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHSMvw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 08:51:52 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:38771 "EHLO
        19.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgHSMvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 08:51:52 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 08:51:50 EDT
Received: from player774.ha.ovh.net (unknown [10.110.208.203])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 62431175FB2
        for <linux-efi@vger.kernel.org>; Wed, 19 Aug 2020 13:33:48 +0200 (CEST)
Received: from 3mdeb.com (85-222-117-222.dynamic.chello.pl [85.222.117.222])
        (Authenticated sender: norbert.kaminski@3mdeb.com)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 4F755156DFC42;
        Wed, 19 Aug 2020 11:33:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G0044e7cd190-6ab3-4129-814e-8667b55db14d,
                    B5113B1F129CC0B9F1E0060F55C82130F969EC62) smtp.auth=norbert.kaminski@3mdeb.com
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>,
        Maciej Pijanowski <maciej.pijanowski@3mdeb.com>,
        piotr.krol@3mdeb.com
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger> <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger> <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger> <20200818184018.GN1679@mail-itl>
 <20200819081930.GQ828@Air-de-Roger>
From:   Norbert Kaminski <norbert.kaminski@3mdeb.com>
Message-ID: <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
Date:   Wed, 19 Aug 2020 13:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819081930.GQ828@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Ovh-Tracer-Id: 1016687616953653708
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheppfhorhgsvghrthcumfgrmhhinhhskhhiuceonhhorhgsvghrthdrkhgrmhhinhhskhhiseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelveehudekjedtkedtgefggfeijeelhfefvdevuefhjeehgeetgfevvdeufeduleenucffohhmrghinhepfehmuggvsgdrtghomhenucfkpheptddrtddrtddrtddpkeehrddvvddvrdduudejrddvvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehnohhrsggvrhhtrdhkrghmihhnshhkihesfehmuggvsgdrtghomhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 19.08.2020 10:19, Roger Pau Monné wrote:
> On Tue, Aug 18, 2020 at 08:40:18PM +0200, Marek Marczykowski-Górecki wrote:
>> On Tue, Aug 18, 2020 at 07:21:14PM +0200, Roger Pau Monné wrote:
>>>> Let me draw the picture from the beginning.
>>> Thanks, greatly appreciated.
>>>
>>>> EFI memory map contains various memory regions. Some of them are marked
>>>> as not needed after ExitBootServices() call (done in Xen before
>>>> launching dom0). This includes EFI_BOOT_SERVICES_DATA and
>>>> EFI_BOOT_SERVICES_CODE.
>>>>
>>>> EFI SystemTable contains pointers to various ConfigurationTables -
>>>> physical addresses (at least in this case). Xen does interpret some of
>>>> them, but not ESRT. Xen pass the whole (address of) SystemTable to Linux
>>>> dom0 (at least in PV case). Xen doesn't do anything about tables it
>>>> doesn't understand.
>>>>
>>>> Now, the code in Linux takes the (ESRT) table address early and checks
>>>> the memory map for it. We have 3 cases:
>>>>   - it points at area marked as neither EFI_*_SERVICES_DATA, nor with
>>>>     EFI_MEMORY_RUNTIME attribute -> Linux refuse to use it
>>>>   - it points to EFI_RUNTIME_SERVICES_DATA or with EFI_MEMORY_RUNTIME
>>>>     attribute - Linux uses the table; memory map already says the area
>>>>     belongs to EFI and the OS should not use it for something else
>>>>   - it points to EFI_BOOT_SERVICES_DATA - Linux mark the area as reserved
>>>>     to not release it after calling ExitBootServices()
>>>>
>>>> The problematic is the third case - at the time when Linux dom0 is run,
>>>> ExitBootServices() was already called and EFI_BOOT_SERVICES_* memory was
>>>> already released. It could be already used for something else (for
>>>> example Xen could overwrite it while loading dom0).
>>>>
>>>> Note the problematic case should be the most common - UEFI specification
>>>> says "The ESRT shall be stored in memory of type EfiBootServicesData"
>>>> (chapter 22.3 of UEFI Spec v2.6).
>>>>
>>>> For this reason, to use ESRT in dom0, Xen should do something about it
>>>> before ExitBootServices() call. While analyzing all the EFI tables is
>>>> probably not a viable option, it can do some simple action:
>>>>   - retains all the EFI_BOOT_SERVICES_* areas - there is already code
>>>>     for that, controlled with /mapbs boot switch (to xen.efi, would need
>>>>     another option for multiboot2+efi)
>>>>   - have a list of tables to retain - since Xen already do analyze some
>>>>     of the ConfigurationTables, it can also have a list of those to
>>>>     preserve even if they live in EFI_BOOT_SERVICES_DATA. In this case,
>>>>     while Xen doesn't need to parse the whole table, it need to parse it's
>>>>     header to get the table size - to reserve that memory and not reuse
>>>>     it after ExitBootServices().
>>> Xen seems to already contain skeleton
>>> XEN_EFI_query_capsule_capabilities and XEN_EFI_update_capsule
>>> hypercalls which is what should be used in order to perform the
>>> updates?
>> I think those covers only runtime service calls similarly named. But you
>> need also ESRT table to collect info about devices that you can even
>> attempt to update.
> Right, the ESRT must be available so that dom0 can discover the
> resources.
>
>> TBH, I'm not sure if those runtime services are really needed. I think
>> Norbert succeeded UEFI update from within Xen PV dom0 with just access
>> to the ESRT table, but without those services.
>>
Marek is right here. I was able to successfully update and downgrade
UFEI when the ESRT table was provided to the Xen PV dom0. I didn't
need any extra services to make the UEFI capsule update work.
> OK, by reading the UEFI spec I assumed that you needed access to
> QueryCapsuleCapabilities and UpdateCapsule in order to perform the
> updates, and those should be proxied using hyopercalls. Maybe this is
> not mandatory and there's a side-band mechanism of doing this?
>
> I think we need more info here.
>
>>> So yes, I agree Xen should make sure the region of the table is not
>>> freed when exiting boot services, and that dom0 can access it. I
>>> guess we should move the checks done by Linux to Xen, and then only
>>> provide the ESRT table to dom0 if the checks (now done by Xen) pass.
>> Yes, something like this. But note currently in the (PV) dom0 case, Xen
>> provides dom0 with a pointer to the whole SystemTable, not individual
>> ConfigurationTables. Making it filter what dom0 gets would require Xen
>> to re-construct the whole thing with just those elements that are
>> desired. Not exactly sure if worth the effort given the privilege dom0
>> has.
> We already do this for ACPI in PVH dom0, where Xen rebuilds the RSDT
> in order to filter out tables that shouldn't be exposed to dom0. If
> possible using something similar for UEFI would be my preference, but
> I certainly haven't investigated at all whether this is feasible.
>
>> BTW How does it look in PVH dom0 case? Does it also get unmodified host
>> EFI SystemTable? In that case, it would be more tricky, because (IIUC)
>> physical addresses (like the one for ESRT table) are not meaningful to
>> PVH dom0.
> For PVH dom0 we should make sure the ESRT is identity mapped into the
> physmap, so that dom0 has access to it. PVH dom0 gets a physical
> memory map that's basically the native one with the RAM regions
> adjusted to match the assigned memory.
>
> We already identity map a bunch of stuff there, so identity mapping
> the ESRT would be likely fine.
>
>>> It might be helpful to see the whole picture here with the hooks to
>>> perform the updates also implemented, as those are missing in Xen (and
>>> Linux?). That would give a clearer view of what you are trying to
>>> achieve IMO.
>> Norbert, can you shed some light on this process?
>>
>> While those two runtime services seems relevant, I see also an update
>> process involving simply dropping some file into ESP (/boot/efi). I'm
>> not sure if some runtime services were involved.
> So then the update is done when rebooting? If we expose the ESRT we
> should also make sure the run-time services related to it are
> available.

Fwupd uses system firmware GUID to recognize its type. UEFI GUID is
provided in the ESRT. Then fwupd checks if the updates/downgrades are
available. In the next step the tool downloads and extracts cabinet
archives in the EFI capsule file format and the capsule updates firmware
after the OS reboot.

---
Best Regards,
Norbert Kamiński
Embedded Systems Engineer
GPG key ID: 9E9F90AFE10F466A
3mdeb.com

