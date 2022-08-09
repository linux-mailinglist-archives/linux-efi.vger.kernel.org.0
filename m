Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DAD58D5EF
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiHIJDO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiHIJDL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 05:03:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5A2251C
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 02:03:10 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C59FB3F468
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660035786;
        bh=5MuajndEt7d/zMd/r+tNrJ/KaeQkb8BuHwH6i8PdbSg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pJ0MqejsJHJzQwmpfisGnNAs/G+TNv3K4kHfm0Jw+xPyHxlhwyinYkSTsARR1Pwbg
         CKbaTl2H2G5a2Q5KWAwdRzUScikYg49HWLU2OGTKVZFgFTF4NQ65yjecxT0iUpZzUI
         ThI8r+MV9Ibtog+okuAFgio6D1mBrp5WXq7PyXl6ZRp+8fV2r2dZwR1XotTvfuW/6w
         xAYJ208mO/2T/SMDPI1y/J5tZVxbb6GJantK2351Xt3KGpDrkX7BxbkeIxGSdRlo80
         OGWzvsXB07nM1QgR6FTzsrpfsmvI69iCd/FbiBkE03GkOPMnuq6kL2TdR7EpTKaZwp
         oQjhX/B/1IXtQ==
Received: by mail-ej1-f69.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso3228488ejc.3
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 02:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5MuajndEt7d/zMd/r+tNrJ/KaeQkb8BuHwH6i8PdbSg=;
        b=UCXlb6Wpl8+DYGytz14sP/GZXTLj0iJKVMr2dTGNGc0aBtzT5CdJZ2UJqE6kVz0q68
         VIhluJFwYtHrU4koRJKYwuwvox4TFXMEL1r9EXL0OFyuhjLZH7pap1SaaSROEVp0oYtf
         xEUHrO5OIXk4430cbQx+jEqQBx/OLRLwra4Ii/1LaGdOuTLgEeMPUVNo7V2+/GF/64h4
         Ozw1vBfZUgZk9C3YQpS9OfOSmRZFtlaH7E5TewWNfwIcOOk1pNpXvKI6ZDNU/lCtpfLS
         znByD6GZjB0PMnhzt5EBIRaLukr1hTWzqCVrpVfRvgdmNwiJLQMzEighJHtJ3DvMSkjS
         Qo0w==
X-Gm-Message-State: ACgBeo0WvQJR3tSCShZoS8w9Ox33KfLL+IUOdyZ2c7K6tDlDOxziQOc1
        hwtsqamyYiJ8cnnH9PXP3n41v1pr1mcyBCbc9foVUIUTQkiY17ht+rhhgGCDxGrR5zA4Gaq/SyW
        CgE9M4qcfE2CLci/MNJlnIniUMdNlOvVIG9hJUA==
X-Received: by 2002:a05:6402:40d0:b0:43f:8f56:6b0e with SMTP id z16-20020a05640240d000b0043f8f566b0emr17621212edb.380.1660035786470;
        Tue, 09 Aug 2022 02:03:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4a2KFvgNqNuGvx451roq6jOvGwQ/uOpzvOudisFnuG+CGtNL4WW7TNqQNEtLKBwTNEvPrmBw==
X-Received: by 2002:a05:6402:40d0:b0:43f:8f56:6b0e with SMTP id z16-20020a05640240d000b0043f8f566b0emr17621191edb.380.1660035786233;
        Tue, 09 Aug 2022 02:03:06 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b00730453877b1sm867160ejh.217.2022.08.09.02.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 02:03:05 -0700 (PDT)
Message-ID: <ca0a22d9-d80c-836d-9b04-fa9d3e2c79c0@canonical.com>
Date:   Tue, 9 Aug 2022 11:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 0/6] efi: implement generic compressed boot support
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        linux-efi@vger.kernel.org
References: <20220809080944.1119654-1-ardb@kernel.org>
 <28a84915-7fa0-7691-08e7-69db792979c7@canonical.com>
 <CAMj1kXHLw419xpULVP5wZUW0fnAz0ovJ+RmkFFdDGtUmNM2wSQ@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXHLw419xpULVP5wZUW0fnAz0ovJ+RmkFFdDGtUmNM2wSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/9/22 10:46, Ard Biesheuvel wrote:
> On Tue, 9 Aug 2022 at 10:38, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 8/9/22 10:09, Ard Biesheuvel wrote:
>>> Relatively modern architectures such as arm64 or RISC-V don't implement
>>> a self-decompressing kernel, and leave it up to the bootloader to
>>> decompress the compressed image before executing it. For bare metal
>>> boot, this policy makes sense, as a self-decompressing image essentially
>>> duplicates a lot of fiddly preparation work to create a 1:1 mapping and
>>> set up the C runtime, and to discover or infer where DRAM lives from
>>> device trees or other firmware tables.
>>>
>>> For EFI boot, the situation is a bit different: the EFI entrypoint is
>>> called with a 1:1 cached mapping covering all of DRAM already active,
>>> and with a stack, a heap, a memory map and boot services to load and
>>> start images. This means it is rather trivial to implement a
>>> self-decompressing wrapper for EFI boot in a generic manner, and reuse
>>> it across architectures that implement EFI boot.
>>>
>>> The only slight downside is that when UEFI secure boot is enabled, the
>>> generic LoadImage/StartImage only allow signed images to be loaded and
>>> started, and we prefer to avoid the need to sign both the inner and
>>> outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
>>> override an internal UEFI/PI protocol that is used by the image loader,
>>> to allow the inner image to be booted after decompression. This has been
>>
>> We should avoid requiring anything that is not in the UEFI
>> specification. If you have any additional requirements, please, create a
>> change request for the UEFI specification.
>>
> 
> As I have explained numerous times before, the EFI spec was intended
> to be extensible (hence the 'E'). The ACPI, SMBIOS and TCG specs all
> augment the EFI specification by defining protocols, GUIDs and other
> things that are only relevant in a EFI context, but none of those are
> covered by the EFI spec itself.
> 
>> Overriding the services of the system table is dangerous and should be
>> avoided.
>>
> 
> Agreed. But this is not what is happening here.
> 
>> There is no need for two UEFI binaries one inside the other and we
>> should avoid such overengineering.
>>
> 
> I disagree. Using an EFI app to encapsulate another one is the only
> generic way to go about this, as far as I can tell.

Please, elaborate why the inner compressed binary needs to be UEFI to 
boot into Linux while currently we don't need a an uncompressed inner 
UEFI binary.

> 
>> Today we append an uncompressed kernel to the EFI stub. The stub
>> relocates it, sets up the memory map and calls it entry point.
>>
> 
> Not exactly. On arm64 as well as RISC-V, the EFI stub and the kernel
> proper are essentially the same executable image.

Currently on ARM and RISC-V you have a file with two entry points:

* EFI stub
* legacy entry point

The EFI stub calls the legacy entry point. In the EFI case some part of 
the EFI stub lives on at runtime. The same pointers passed to the legacy 
entry point could also be passed to a decompressed legacy kernel.

The EFI stub and the kernel should be completely separate binaries. Then 
you just need the cp command to join them.

> 
>> Just add decompressor code to the EFI stub and instead of appending an
>> uncompressed kernel append a compressed one. Then sign a binary
>> consisting of the EFI stub and the compressed kernel.
>>
> 
> Yes, this would be a cleaner approach, although it would require more
> re-engineering of the EFI stub, in particular, it would require
> cloning more code, and adding additional build and link steps.

If this is the cleanest approach, we should go for it.

Best regards

Heinrich

> 
>> This way you don't need any change to UEFI firmware at all and you don't
>> need to override UEFI services.
>>
>> Another reasonable approach would be to zip the signed UEFI binary (EFI
>> stub with uncompressed kernel) and let the UEFI firmware unzip it and
>> check the signature of the decompressed UEFI binary. This would not
>> require any patch in Linux at all and would be simple to implement in
>> U-Boot.
>>
> 
> This is how it works today. One problem with this is that the image
> needs to be decompressed in order to sign it, or verify its signature.
> In general, having compression at the outside like this is fiddly
> because it is no longer a PE/COFF image, and the EFI spec only reasons
> about PE/COFF images as executable images. So we'd need to change the
> UEFI spec or the PE/COFF spec.

