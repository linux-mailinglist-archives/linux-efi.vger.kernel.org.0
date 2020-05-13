Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E81D1789
	for <lists+linux-efi@lfdr.de>; Wed, 13 May 2020 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbgEMO0a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 May 2020 10:26:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8391 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388827AbgEMO03 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 May 2020 10:26:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebc030c0000>; Wed, 13 May 2020 07:24:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 07:26:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 May 2020 07:26:28 -0700
Received: from [10.40.103.138] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 14:26:19 +0000
Subject: Re: RE: [PATCH v6 09/10] arm64: efi: Export screen_info
To:     Michael Kelley <mikelley@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
 <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
 <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Nikhil Mahale <nmahale@nvidia.com>
Message-ID: <f2b63853-24ae-d6b7-cd43-5792c0d4d31b@nvidia.com>
Date:   Wed, 13 May 2020 19:56:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589379852; bh=x1UAKVn8+/u2cz6MzDi8dZRv1jolqDgwkL4uosH9XXA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cW+1fl8Ga69Q1QXp46sGezHshzti2A6hHcqXU68jSAv0HbHLeJQvepipXJ0eSuDBo
         51KMndVzf/sPPYlWVGm/bE21jU3XJS+EeiVEM2ruDJCnu64Jz80k49jv2OjlI7Vnjj
         DhPtiz/99TQ94aCjvD+0pTQoBQQ/lwcbhEddYghMCPLZE9sM9eXPYXm18cFxeGfTO2
         15ETxGo1tsLmjRLBCgkqhz7TYdryxI170K82U/Oez6e+yjci90BE8uVyGq0TXp/K63
         ks9G06QTA88P3fNC9kzZfxZonCfJndFQz5TkuaWAKoONJmCQ+9rIQ5hxcdLWAb+Cng
         7pKiTeecW804A==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/20/20 3:16 AM, Michael Kelley wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:27 AM
>>
>> On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>> On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>>>>>
>>>>> The Hyper-V frame buffer driver may be built as a module, and
>>>>> it needs access to screen_info. So export screen_info.
>>>>>
>>>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>>>
>>>> Is there any chance of using a more modern KMS based driver for the screen
>>>> than the old fbdev subsystem? I had hoped to one day completely remove
>>>> support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
>>>> architectures.
>>>>
>>>
>>> The current hyperv_fb.c driver is all we have today for the synthetic Hyper-V
>>> frame buffer device.  That driver builds and runs on both ARM64 and x86.
>>>
>>> I'm not knowledgeable about video/graphics drivers, but when you
>>> say "a more modern KMS based driver", are you meaning one based on
>>> DRM & KMS?  Does DRM make sense for a "dumb" frame buffer device?
>>> Are there any drivers that would be a good pattern to look at?
>>
>> It used to be a lot harder to write a DRM driver compared to an fbdev
>> driver, but this has changed to the opposite over the years.
>>
>> A fairly minimal example would be drivers/gpu/drm/pl111/pl111_drv.c
>> or anything in drivers/gpu/drm/tiny/, but you may want to look at the
>> other hypervisor platforms first, i.e drivers/gpu/drm/virtio/virtgpu_drv.c,
>> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c, drivers/gpu/drm/xen/xen_drm_front.c,
>> drivers/gpu/drm/qxl/qxl_drv.c, and drivers/gpu/drm/bochs/bochs_drv.c.
>>
> 
> Thanks for the pointers, especially for the other hypervisors.
> 
Sorry if anybody in 'to' or 'cc' is receiving this reply multiple times.
I had configured by email client incorrectly to reply.

screen_info is still useful with a modern KMS-based driver.  It exposes
the mode parameters that the GOP driver chose.  This information is
needed to implement seamless or glitchless boot, by both ensuring that
the scanout parameters don't change and being able to read back the
scanout image to populate the initial contents of the new surface.

This works today on arches which implement (U)EFI and export
screen_info, including x86 and powerpc, but doesn't work on arm or
arm64.  As arm64 systems that implement UEFI with real GOP drivers
become more prevalent, it would be nice to be have these features there
as well.

Thanks,
Nikhil Mahale

> Michael
> 
