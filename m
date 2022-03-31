Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEBC4ED812
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiCaLBX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiCaLBW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 07:01:22 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45714925F
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 03:59:34 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C63683F80A
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648724371;
        bh=1XwtTbs27LDyM3VTjm8BQT5UEJXtUlqRoeZftmejZys=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ONpdnygtHcisxG1ReqxShuBU30YFR/tePQjbtsfwbaw1bsFbymla1iz84mw0PYBiI
         Krki6u7nhoz9kb/o9KlUZKccl0Gv56XA0RY6dgX+tcPaWgNW+lk3EfD4PDWbQ0JRhE
         Qg3e6s7pr+C0vHimZqPGRTBvYvGLYETP7l9kPwKqoeqebpddn2Et11cXlNywZ0WTDe
         IjEIYSfngiS44EkLAAQT5ufBe0PhO00IA+F1Pp9JCW3No35flH7lv166GfT79sAAhI
         ZwQnZmDd0lu+Tv0OES07GdkPAcFu24uK+OrXAXG+GcJPrQmH9ExHWbDuRNFZhgKfDn
         qIO1OfkN1P9Sw==
Received: by mail-ej1-f72.google.com with SMTP id my15-20020a1709065a4f00b006dfd2b16e6cso11333493ejc.1
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 03:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1XwtTbs27LDyM3VTjm8BQT5UEJXtUlqRoeZftmejZys=;
        b=mCsXw5BF75VwEYDyqyrjeOUsQOl4zVK023D/0X6WcoGCZGSQpn2+S19/nUBaoHJHCz
         yk7EAF3Ch9LTKWVmZOSM8lLqnuMwIm41e/0OLMkE3S/DCifD/lMZj90pGok9bic4oK9v
         KC0cdeRkBZSiOl05+89JeGVJ8GIW/aMLIpRvlwxruvW0MDquvpiXVXgw/N8wLqBgIBYA
         gFUrxbI3OIsFC+4H2wMbAUj9bAwYg1NVCsyr/hkhJfyrKg1D5J6dKrAePnq4alWlOhRL
         JQLAQUF6xCQMSO6jNG2IyM5oke41FEcV1TT3HE+l3VK0cyJXow1fAOpJKt7POIZjijH8
         M2dQ==
X-Gm-Message-State: AOAM532d4rf7OsUtwGNwREKiXaBFLFxK4mRKYOZi62kb0u1AeNmqDIkh
        xlsEU9VWw5PhgBolYmya/+ox7qlFxuibkR2epegUh4/4CsCblJ2rqf/Zl24jlm6n6HL+8hlYhru
        aWIFgqGtZFVHn9rUAJbpRErBPzhZiR51o9ITZJg==
X-Received: by 2002:a50:fd04:0:b0:419:9c4a:7d79 with SMTP id i4-20020a50fd04000000b004199c4a7d79mr16183199eds.99.1648724370142;
        Thu, 31 Mar 2022 03:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwilDd+b52EM2iM/qyahZOGp/AIisd8dLBYGUdk+jIoHPeMOd2vbk4yImdWEBr9uUx9uogIHA==
X-Received: by 2002:a50:fd04:0:b0:419:9c4a:7d79 with SMTP id i4-20020a50fd04000000b004199c4a7d79mr16183162eds.99.1648724369782;
        Thu, 31 Mar 2022 03:59:29 -0700 (PDT)
Received: from [192.168.123.94] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0041b501eab8csm3703479edb.57.2022.03.31.03.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 03:59:29 -0700 (PDT)
Message-ID: <6e69cc4c-dcfa-ed97-b675-54873972ace7@canonical.com>
Date:   Thu, 31 Mar 2022 12:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Linux DRTM on UEFI platforms
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
        Kees Cook <keescook@chromium.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>
References: <20220329174057.GA17778@srcf.ucam.org>
 <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <c3ecd65f-bb10-8d14-500d-d6e2ece9b336@apertussolutions.com>
 <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXFq=MAj75CnwMKnfvFTxUxFbiq9rWwpSu=JeoXFV5=otg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/31/22 09:13, Ard Biesheuvel wrote:
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
>>                                          bzImage
>> [EFI boot manager] -> [[efi-stub] -> [setup kernel] -> [main kernel]]
>>
>> Where the efi-stub is responsible for interacting with firmware to
>> configure the system, store that configuration for the setup kernel and
>> the main kernel, and then call EBS before entering the setup kernel.
>>
>> For Secure Launch the flow (on Intel) is,
>>
>>        CPU instruction                   bzImage
>> [preamble] -> [ACM] -> [[sl-stub] -> [setup kernel] -> [main kernel]]
>>
>> In order to make the CPU instruction call to enter the ACM the system
>> must be in a very specific quiescent state. This includes but not
>> exhaustively,
>>    * EBS must have been called
>>    * TPM should have all localities closed
>>    * IOMMU PMRs must be programmed appropriately
>>    * TXT heap space allocated
>>    * TXT heap space populated with config structures
>>    * All APs must be in a specific idle state
>>    * Execution is on the BSP
>> Carrying all this out is what is considered the DRTM preamble.
>>
> 
> Thanks for the explanation, this is really helpful.
> 
>> This is the wrinkle because the setup kernel and main kernel are both
>> predicated on the efi-stub and the efi-stub is predicated on running
>> before EBS.
> 
> Matthew suggested this already, but can you explain why handling this
> in a callback is not an option? I'd by sympathetic to specifying a

The idea of the UEFI specification is that it is OS agnostic. So 
anything that is Linux-, Windows-, BSD-, etc. specific should not live 
in the UEFI firmware.

If you want to implement any Linux specific extra protocol, you should 
implement it in Shim, GRUB, the kernel stub or any other UEFI binary 
loaded by the UEFI firmware but, please, don't rely on the UEFI firmware 
itself to implement it.

If you are able to abstract the requirements for furthering secure boot 
in a way that is OS agnostic, then implementation in the UEFI firmware 
starts to make sense. But remember that there is a large installed base 
that is still lagging behind the current UEFI standard.

Best regards

Heinrich

> Linux specific protocol that can be grabbed before EBS() but can be
> invoked after (but not, say after SetVirtualAddressMap(), to keep
> things simple). That should allow us to call back into firmware to
> perform the secure launch right before handing over.
> 
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
> 
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
> 
> I'm not eager to kick this can down the road and go with something
> that inevitably implies either specifying and maintaining a whole
> array of internal protocols as external ABI, or revisiting this
> discussion and coming up with two different ways to do DRTM depending
> on whether you are running x86 or not.
> 
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
> 
> Pardon the skepticism, but I am really reluctant to let this cat out
> of the bag if the requirements are so vague and there doesn't seem to
> consensus on the scope of DRTM.
> 
> Another thing I missed is how these systems are supposed to carry out
> the tasks that the stub currently handles: Matt mentioned setting
> MemoryOverwriteRequest, but there is also TPM event log handling, and
> other bits and pieces. Are you saying this is all going to be part of
> this boot protocol as well?
> 
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
> 
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
> 
> Thanks,
> Ard.
> 
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel

