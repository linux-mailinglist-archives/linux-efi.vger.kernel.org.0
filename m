Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474B59B958
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiHVGZB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiHVGYy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 02:24:54 -0400
Received: from mail.inso.tuwien.ac.at (omega.inso.tuwien.ac.at [128.130.59.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF7275E5
        for <linux-efi@vger.kernel.org>; Sun, 21 Aug 2022 23:24:38 -0700 (PDT)
Received: from [10.0.0.21] (194-166-186-62.adsl.highway.telekom.at [194.166.186.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.inso.tuwien.ac.at (Postfix) with ESMTPSA id B0A42C0225;
        Mon, 22 Aug 2022 08:24:21 +0200 (CEST)
Message-ID: <4a2497ab-b0c7-e9f2-8d44-772cddf16a43@inso.tuwien.ac.at>
Date:   Mon, 22 Aug 2022 08:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, clemens.hlauschek@inso.tuwien.ac.at,
        Kees Cook <keescook@chromium.org>
References: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
 <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
 <202208180858.70C1B5A@keescook>
 <CAMj1kXHyV1+ttxaWrsY1xitBRUfoXobv-Cv0+a6P=Zs9Rhsfag@mail.gmail.com>
 <202208191519.6C4804CA53@keescook>
 <CAMj1kXH7462XEBis6wL-AOXfDBv-1iKKAn4fOPaKRve1fHkDzQ@mail.gmail.com>
From:   Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: [PATCH] efi/libstub: Disable RNG structure randomization
In-Reply-To: <CAMj1kXH7462XEBis6wL-AOXfDBv-1iKKAn4fOPaKRve1fHkDzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 20/08/2022 19:58, Ard Biesheuvel wrote:
> On Sat, 20 Aug 2022 at 00:23, Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Aug 18, 2022 at 06:12:55PM +0200, Ard Biesheuvel wrote:
>>> On Thu, 18 Aug 2022 at 18:02, Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> On Thu, Aug 18, 2022 at 09:10:23AM +0200, Ard Biesheuvel wrote:
>>>>> (cc Kees)
>>>>>
>>>>> On Thu, 18 Aug 2022 at 08:58, Daniel Marth
>>>>> <daniel.marth@inso.tuwien.ac.at> wrote:
>>>>>>
>>>>>> Randstruct by default randomizes structures that consist entirely of
>>>>>> function pointers, even if they are not explicitly labeled for
>>>>>> randomization. efi_rng_protocol contains an anonymous structure that is
>>>>>> affected by this implicit selection process. Randomization of this
>>>>>> structure causes a data layout inconsistency between the kernel and the
>>>>>> EFI. In this scenario the Arm64 boot process fails with the following
>>>>>> output:
>>>>>>     EFI stub: Booting Linux Kernel...
>>>>>>     EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
>>>>>>     EFI stub: Using DTB from configuration table
>>>>>>     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>>>>>>     Synchronous Exception at 0x0000000081310C90
>>>>>>     Synchronous Exception at 0x0000000081310C90
>>>>>>
>>>>>> efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
>>>>>> because it uses an incorrect structure layout for efi_call_proto. Add
>>>>>> the __no_randomize_layout annotation to the anonymous structure within
>>>>>> efi_rng_protocol to prevent its randomization and resolve this issue.
>>>>>>
>>>>>> This patch was tested for the Arm64 architecture using QEMU. In
>>>>>> addition to the current next branch of this subsystem, also minor
>>>>>> versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
>>>>>> (backported) version of this patch.
>>>>>>
>>>>>> Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
>>>>>
>>>>> Thanks for the patch.
>>>>>
>>>>>> ---
>>>>>>  drivers/firmware/efi/libstub/random.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
>>>>>> index 24aa37535372..54fa980cf1af 100644
>>>>>> --- a/drivers/firmware/efi/libstub/random.c
>>>>>> +++ b/drivers/firmware/efi/libstub/random.c
>>>>>> @@ -18,7 +18,7 @@ union efi_rng_protocol {
>>>>>>                 efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
>>>>>>                                                  efi_guid_t *, unsigned long,
>>>>>>                                                  u8 *out);
>>>>>> -       };
>>>>>> +       } __no_randomize_layout;
>>>>>>         struct {
>>>>>>                 u32 get_info;
>>>>>>                 u32 get_rng;
>>>>>
>>>>> This may work around the problem, but I'd like to fix this more
>>>>> thoroughly if we can. EFI protocols are not randomizable by nature, as
>>>>> they are a contract between the firmware and the OS, so struct
>>>>> randomization should just be disabled for the entire EFI stub, i.e.,
>>>>> everything below libstub/
>>>>
>>>> So, yeah, any external interface that uses function pointer tables
>>>> needs to be marked as not randomized. I think disabling randstruct for
>>>> the entire subdirectory may run into a reverse problem, if anything gets
>>>> used in there that is randomized by the rest of the kernel. I'm not clear
>>>> where there boundaries are on that, though, so I leave it up to your
>>>> judgement. IMO, it seems cleanest to just mark any all-function-pointer
>>>> structs as __no_randomize_layout.
>>>>
>>>
>>> But there are *lots* of those, and this makes it a moving target as well.
>>>
>>> The handover from EFI to the kernel proper passes very little state,
>>> so turning it off in the stub should not be an issue afaict.
>>>
>>> What would be even better is a pragma push/pop that disables it for
>>> all type definitions in between, Did anyone ever look into that?
>>
>> I don't know if that got looked at -- there wasn't a place where such a
>> mixture was needed before. Everywhere else just marks individual
>> structs. Places like vDSO do stuff like this for their Makefile:
>>
>> KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS))
>>
> 
> I think we should add this to drivers/firmware/efi/libstub/Makefile
> 
> Daniel, could you please verify whether that fixes your issue as well? Thanks.

The suggested modification of KBUILD_CFLAGS solves my issue.
