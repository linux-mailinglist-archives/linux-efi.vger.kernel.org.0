Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517B417985F
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDSt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:49:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41760 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729600AbgCDSt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 13:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583347767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHb22ZNqG3VdXQ8p9z0of17QamZM23l0jE3Q0crNdFg=;
        b=RmT8MXZDWmCKw9s4ygklygXtrjQDNnk9nuMfkAuDHdEvS+OaxYlWNesCDgG3V9lfsSWeZL
        4olyANnPL8q8MBHKf6LJZHBwp9LDHLVeTaTMQv1fIk8GOjvSQVFR1IWPKilA1WBRxpNF42
        VxfP6FwWIsL0VfoWkyvL9VEX9YWKgzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488--QnerxfBOSKXyRa_oBiTGQ-1; Wed, 04 Mar 2020 13:49:22 -0500
X-MC-Unique: -QnerxfBOSKXyRa_oBiTGQ-1
Received: by mail-wm1-f72.google.com with SMTP id y18so2160768wmi.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 10:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=HHb22ZNqG3VdXQ8p9z0of17QamZM23l0jE3Q0crNdFg=;
        b=PGFydkbDHFxVdmRsMwduNZW6kRSXTWv/EpFcGQ5/iKeTgZf8unISMZEHH9qp5EUZmY
         TY/6U2ADc7pu8n76lMkzmZWK9LLjcjKg+ouR5Oe2XwvndqNWR8LcbqY4jk86D0/y2+ZO
         wG8233pUv35bk5y+txg53kIYieEEyhla1RTXjMd1CiUuwZP/yMncZSfPZci33uIQlqog
         SdGLOlTfHulOfXyjin0LfUUfUTULSrg84FjSNEh+5ucscOckYXGjaoJ+ULjEG9Yc084v
         lxdKLKvSBeagy2qBi+pEykF/lG7GG4AHAhMf6U+SWteqEvJmz88jJB/fKukPdCPLlaVe
         iZmQ==
X-Gm-Message-State: ANhLgQ02uSIctIA/9u7DksbOmTQl3Gv/MSvQmZxrw625wI6ibMvj343y
        zHom/ztMSksMjQF9U1mf0j3hTwY31mMglfQpQcKp/QYJh9lGT682mCt1NGQrRxo6VHXJeIOdnO7
        3qfcfr/D7xEE311r8+sti
X-Received: by 2002:adf:df8d:: with SMTP id z13mr3785451wrl.302.1583347761300;
        Wed, 04 Mar 2020 10:49:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsMlSXsnChGwMG1h4a4nERh4Pwrj6MT/WiuaW5CcSHemL6/hQ1bSnfni47dsFh3TsHReAjJYQ==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr3785428wrl.302.1583347760980;
        Wed, 04 Mar 2020 10:49:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id y12sm371951wmi.48.2020.03.04.10.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:49:20 -0800 (PST)
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-22-ardb@kernel.org>
 <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com>
 <CAKv+Gu-bafCk_A27q=hyvbk6KW997D=snHUjOQG+t-NkY4PrKw@mail.gmail.com>
 <2a641bee-5f23-daaf-019a-3636fa6966c5@redhat.com>
 <CAKv+Gu9RwGhDrUNCa8JqbDv5ckuWiiA_81RehoZMMEFAwfbn+g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <de8c1023-c637-263b-b5d0-2a71ddb24d6e@redhat.com>
Date:   Wed, 4 Mar 2020 19:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9RwGhDrUNCa8JqbDv5ckuWiiA_81RehoZMMEFAwfbn+g@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------733A624EB9663F7F0AC8C3FE"
Content-Language: en-US
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a multi-part message in MIME format.
--------------733A624EB9663F7F0AC8C3FE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/4/20 7:26 PM, Ard Biesheuvel wrote:
> On Wed, 4 Mar 2020 at 11:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 2/6/20 3:35 PM, Ard Biesheuvel wrote:
>>> On Thu, 6 Feb 2020 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
>>>>> From: Matthew Garrett <matthewgarrett@google.com>
>>>>>
>>>>> Add an option to disable the busmaster bit in the control register on
>>>>> all PCI bridges during the invocation of ExitBootServices() and passing
>>>>> control to the runtime kernel. System firmware may configure the IOMMU
>>>>> to prevent malicious PCI devices from being able to attack the OS via DMA.
>>>>> However, since firmware can't guarantee that the OS is IOMMU-aware, it
>>>>> will tear down IOMMU configuration when ExitBootServices() is called.
>>>>> This leaves a window between where a hostile device could still cause
>>>>> damage before Linux configures the IOMMU again.
>>>>>
>>>>> If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
>>>>> command line argument is passed, the EFI stub will clear the busmaster
>>>>> bit on all PCI bridges before ExitBootServices() completes. This will
>>>>> prevent any malicious PCI devices from being able to perform DMA until
>>>>> the kernel reenables busmastering after configuring the IOMMU.
>>>>>
>>>>> This option is disabled when in EFI mixed mode environments (ie, 64-bit
>>>>> kernels with a 32-bit EFI implementation), given that the use of EFI
>>>>> events is not supported in this case.
>>>>>
>>>>> This option may cause failures with some poorly behaved hardware and
>>>>> should not be enabled without testing. The kernel commandline options
>>>>> "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
>>>>> override the default.
>>>>>
>>>>> Co-developed-by: Matthew Garrett <mjg59@google.com>
>>>>> Signed-off-by: Matthew Garrett <mjg59@google.com>
>>>>> [ardb: use EFI events to defer DMA disabling to the end of ExitBootServices()]
>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> I guess this might not be the latest version of this patch, but
>>>> this does seem to be the thread where most discussion on it
>>>> has happened.
>>>>
>>>> My personal kernel tree atm consists of v5.5 + efi/next + my own patches
>>>> and yesterday I noticed that will not boot on a Lenovo X1 7th gen connected
>>>> to a Lenovo thunderbolt 3 gen 2 dock.
>>>>
>>>> My first hunch was that I have CONFIG_EFI_DISABLE_PCI_DMA=y and that that
>>>> was causing it and indeed that is the problem.
>>>>
>>>> So as (somewhat) expected CONFIG_EFI_DISABLE_PCI_DMA=y indeed stops the kernel
>>>> from booting on some systems.
>>>>
>>>> When I hit this problem the efistub prints 2 messages and then the system
>>>> just hangs:
>>>>
>>>> exit_boot() failed!
>>>> efi_main() failed!
>>>>
>>>> When I boot the system without it being connected to the thunderbolt dock
>>>> then efi=disable_pci_dma works fine.
>>>>
>>>> Let me know if I can do anything to help and getting booting while
>>>> connected to the dock to work with efi=disable_pci_dma.
>>>>
>>>
>>> Thanks Hans.
>>>
>>> Can you run the UEFI shell on this system? If so, could you share the
>>> output of devtree, both in the docked and the undocked states?
>>>
>>> That should help us pinpoint which device is throwing an error at
>>> ExitBootServices() time due to its driver having been disconnected.
>>
>> Sorry for being slow to respond. Attached are the outputs of devtree in
>> both states. Not sure if the list will accept this, but you should
>> get a direct copy.
>>
> 
> Interesting. The only difference that UEFI seems to know about in
> terms of device hierarchy is a XHCI controller with a Realtek USB NIC
> attached.
> 
> Could you try unloading the driver for that manually, or disconnecting
> it? Or disconnect the whole thing from the shell?

How would I go about that / do that ?

> If just unloading the realtek driver does not make a difference, but
> unload/disconnecting the xhci makes it work, it is likely that it this
> feature will break a lot of systems.

Notice that it is not just the XHCI controller which gets added though,
there also is an extra PCI-e switch added to the route to the XHCI controller,
I've attached both docked and undocked lspci output under Linux. I guess
this might be transparent from a UEFI pov though.

Regards,

Hans



> --- Downloads/devtree-not-docked 2020-03-04 19:18:14.596315280 +0100
> +++ Downloads/devtree-docked 2020-03-04 19:18:08.856257969 +0100
> @@ -11,6 +11,7 @@
>      Ctrl[] PciRoot(0x0)/Pci(0x0,0x0)
>      Ctrl[] Intel(R) Graphics Controller
>        Ctrl[] EDP1
> +     Ctrl[] DP1
>          Ctrl[] Primary Console Output Device
>      Ctrl[] PciRoot(0x0)/Pci(0x4,0x0)
>      Ctrl[] PciRoot(0x0)/Pci(0x8,0x0)
> @@ -44,6 +45,110 @@
>      Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x0,0x0)
>      Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)
>      Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)
> +   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)
> +   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)
> +   Ctrl[] eXtensible Host Controller (USB 3.0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x4,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x2,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)/USB(0x1,0x0)
> +       Ctrl[] Realtek USB Ethernet Controller
> <lots of network stuff>
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x1)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x2)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x3)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x2,0x0)/USB(0x3,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)
> +     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)/USB(0x1,0x0)
> +     Ctrl[] Generic Usb Keyboard
> +       Ctrl[] Primary Console Input Device
> +     Ctrl[] Generic Usb Mouse
> +       Ctrl[] Primary Console Input Device
> +     Ctrl[] Generic Usb Mouse
> +       Ctrl[] Primary Console Input Device
> +   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x4,0x0)
>      Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x2,0x0)
>      Ctrl[] eXtensible Host Controller (USB 3.0)
>      Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x4,0x0)
> @@ -69,5 +174,3 @@
>    Ctrl[] VenHw(2C0EEABD-4107-44A8-A787-2E38FFC52B2B)
>    Ctrl[] VenHw(48B9FB42-B3B9-4A0E-BF66-36AE1C302369)
>    Ctrl[] VenHw(A7F26116-CFDC-4296-8224-ED7D140170C7)
> - Ctrl[] MemoryMapped(0xB,0xFF2E0000,0xFF37FFFF)
> - Ctrl[] Fv(B92CF322-8AFA-4AA4-B946-005DF1D69778)
> 

--------------733A624EB9663F7F0AC8C3FE
Content-Type: text/plain; charset=UTF-8;
 name="lspci-docked"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci-docked"

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQ29mZmVlIExha2UgSE9T
VCBhbmQgRFJBTSBDb250cm9sbGVyIChyZXYgMGMpCjAwOjAyLjAgVkdBIGNvbXBhdGlibGUg
Y29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVUhEIEdyYXBoaWNzIDYyMCAoV2hpc2tl
eSBMYWtlKSAocmV2IDAyKQowMDowNC4wIFNpZ25hbCBwcm9jZXNzaW5nIGNvbnRyb2xsZXI6
IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTMtMTIwMCB2NS9FMy0xNTAwIHY1LzZ0aCBHZW4g
Q29yZSBQcm9jZXNzb3IgVGhlcm1hbCBTdWJzeXN0ZW0gKHJldiAwYykKMDA6MDguMCBTeXN0
ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFMy0xMjAwIHY1L3Y2IC8g
RTMtMTUwMCB2NSAvIDZ0aC83dGgvOHRoIEdlbiBDb3JlIFByb2Nlc3NvciBHYXVzc2lhbiBN
aXh0dXJlIE1vZGVsCjAwOjEyLjAgU2lnbmFsIHByb2Nlc3NpbmcgY29udHJvbGxlcjogSW50
ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIFRoZXJtYWwgQ29udHJvbGxlciAocmV2
IDExKQowMDoxNC4wIFVTQiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24g
UG9pbnQtTFAgVVNCIDMuMSB4SENJIENvbnRyb2xsZXIgKHJldiAxMSkKMDA6MTQuMiBSQU0g
bWVtb3J5OiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24gUG9pbnQtTFAgU2hhcmVkIFNSQU0g
KHJldiAxMSkKMDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IENhbm5vbiBQb2ludC1MUCBDTlZpIFtXaXJlbGVzcy1BQ10gKHJldiAxMSkKMDA6MTUuMCBT
ZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24g
UG9pbnQtTFAgU2VyaWFsIElPIEkyQyBDb250cm9sbGVyICMwIChyZXYgMTEpCjAwOjE1LjEg
U2VyaWFsIGJ1cyBjb250cm9sbGVyIFswYzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9u
IFBvaW50LUxQIFNlcmlhbCBJTyBJMkMgQ29udHJvbGxlciAjMSAocmV2IDExKQowMDoxNi4w
IENvbW11bmljYXRpb24gY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBv
aW50LUxQIE1FSSBDb250cm9sbGVyICMxIChyZXYgMTEpCjAwOjE2LjMgU2VyaWFsIGNvbnRy
b2xsZXI6IEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBQb2ludC1MUCBLZXlib2FyZCBhbmQg
VGV4dCAoS1QpIFJlZGlyZWN0aW9uIChyZXYgMTEpCjAwOjFkLjAgUENJIGJyaWRnZTogSW50
ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAj
OSAocmV2IGYxKQowMDoxZC40IFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIENhbm5v
biBQb2ludC1MUCBQQ0kgRXhwcmVzcyBSb290IFBvcnQgIzEzIChyZXYgZjEpCjAwOjFmLjAg
SVNBIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIExQQyBDb250
cm9sbGVyIChyZXYgMTEpCjAwOjFmLjMgQXVkaW8gZGV2aWNlOiBJbnRlbCBDb3Jwb3JhdGlv
biBDYW5ub24gUG9pbnQtTFAgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgKHJl
diAxMSkKMDA6MWYuNCBTTUJ1czogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQ
IFNNQnVzIENvbnRyb2xsZXIgKHJldiAxMSkKMDA6MWYuNSBTZXJpYWwgYnVzIGNvbnRyb2xs
ZXIgWzBjODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24gUG9pbnQtTFAgU1BJIENvbnRy
b2xsZXIgKHJldiAxMSkKMDA6MWYuNiBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRlbCBDb3Jw
b3JhdGlvbiBFdGhlcm5ldCBDb25uZWN0aW9uICg2KSBJMjE5LUxNIChyZXYgMTEpCjAzOjAw
LjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyOiBTYW5kaXNrIENvcnAgV0QgQmxh
Y2sgMjAxOC9QQyBTTjcyMCBOVk1lIFNTRAowNTowMC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMS4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMi4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowNC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNzowMC4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBKSEw2NTQwIFRodW5kZXJib2x0IDMgTkhJIChDIHN0ZXApIFtB
bHBpbmUgUmlkZ2UgNEMgMjAxNl0gKHJldiAwMikKMDg6MDAuMCBQQ0kgYnJpZGdlOiBJbnRl
bCBDb3Jwb3JhdGlvbiBKSEw3NTQwIFRodW5kZXJib2x0IDMgQnJpZGdlIFtUaXRhbiBSaWRn
ZSBERCAyMDE4XSAocmV2IDA2KQowOTowMi4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0
aW9uIEpITDc1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgW1RpdGFuIFJpZGdlIEREIDIwMThd
IChyZXYgMDYpCjA5OjA0LjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gSkhMNzU0
MCBUaHVuZGVyYm9sdCAzIEJyaWRnZSBbVGl0YW4gUmlkZ2UgREQgMjAxOF0gKHJldiAwNikK
MGE6MDAuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gSkhMNzU0MCBUaHVu
ZGVyYm9sdCAzIFVTQiBDb250cm9sbGVyIFtUaXRhbiBSaWRnZSA0QyAyMDE4XSAocmV2IDA2
KQoyZDowMC4wIFVTQiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBKSEw2NTQwIFRo
dW5kZXJib2x0IDMgVVNCIENvbnRyb2xsZXIgKEMgc3RlcCkgW0FscGluZSBSaWRnZSA0QyAy
MDE2XSAocmV2IDAyKQo=
--------------733A624EB9663F7F0AC8C3FE
Content-Type: text/plain; charset=UTF-8;
 name="lspci-not-docked"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci-not-docked"

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQ29mZmVlIExha2UgSE9T
VCBhbmQgRFJBTSBDb250cm9sbGVyIChyZXYgMGMpCjAwOjAyLjAgVkdBIGNvbXBhdGlibGUg
Y29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVUhEIEdyYXBoaWNzIDYyMCAoV2hpc2tl
eSBMYWtlKSAocmV2IDAyKQowMDowNC4wIFNpZ25hbCBwcm9jZXNzaW5nIGNvbnRyb2xsZXI6
IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTMtMTIwMCB2NS9FMy0xNTAwIHY1LzZ0aCBHZW4g
Q29yZSBQcm9jZXNzb3IgVGhlcm1hbCBTdWJzeXN0ZW0gKHJldiAwYykKMDA6MDguMCBTeXN0
ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFMy0xMjAwIHY1L3Y2IC8g
RTMtMTUwMCB2NSAvIDZ0aC83dGgvOHRoIEdlbiBDb3JlIFByb2Nlc3NvciBHYXVzc2lhbiBN
aXh0dXJlIE1vZGVsCjAwOjEyLjAgU2lnbmFsIHByb2Nlc3NpbmcgY29udHJvbGxlcjogSW50
ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIFRoZXJtYWwgQ29udHJvbGxlciAocmV2
IDExKQowMDoxNC4wIFVTQiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24g
UG9pbnQtTFAgVVNCIDMuMSB4SENJIENvbnRyb2xsZXIgKHJldiAxMSkKMDA6MTQuMiBSQU0g
bWVtb3J5OiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24gUG9pbnQtTFAgU2hhcmVkIFNSQU0g
KHJldiAxMSkKMDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IENhbm5vbiBQb2ludC1MUCBDTlZpIFtXaXJlbGVzcy1BQ10gKHJldiAxMSkKMDA6MTUuMCBT
ZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24g
UG9pbnQtTFAgU2VyaWFsIElPIEkyQyBDb250cm9sbGVyICMwIChyZXYgMTEpCjAwOjE1LjEg
U2VyaWFsIGJ1cyBjb250cm9sbGVyIFswYzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9u
IFBvaW50LUxQIFNlcmlhbCBJTyBJMkMgQ29udHJvbGxlciAjMSAocmV2IDExKQowMDoxNi4w
IENvbW11bmljYXRpb24gY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBv
aW50LUxQIE1FSSBDb250cm9sbGVyICMxIChyZXYgMTEpCjAwOjE2LjMgU2VyaWFsIGNvbnRy
b2xsZXI6IEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBQb2ludC1MUCBLZXlib2FyZCBhbmQg
VGV4dCAoS1QpIFJlZGlyZWN0aW9uIChyZXYgMTEpCjAwOjFkLjAgUENJIGJyaWRnZTogSW50
ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAj
OSAocmV2IGYxKQowMDoxZC40IFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIENhbm5v
biBQb2ludC1MUCBQQ0kgRXhwcmVzcyBSb290IFBvcnQgIzEzIChyZXYgZjEpCjAwOjFmLjAg
SVNBIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQIExQQyBDb250
cm9sbGVyIChyZXYgMTEpCjAwOjFmLjMgQXVkaW8gZGV2aWNlOiBJbnRlbCBDb3Jwb3JhdGlv
biBDYW5ub24gUG9pbnQtTFAgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgKHJl
diAxMSkKMDA6MWYuNCBTTUJ1czogSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIFBvaW50LUxQ
IFNNQnVzIENvbnRyb2xsZXIgKHJldiAxMSkKMDA6MWYuNSBTZXJpYWwgYnVzIGNvbnRyb2xs
ZXIgWzBjODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24gUG9pbnQtTFAgU1BJIENvbnRy
b2xsZXIgKHJldiAxMSkKMDA6MWYuNiBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRlbCBDb3Jw
b3JhdGlvbiBFdGhlcm5ldCBDb25uZWN0aW9uICg2KSBJMjE5LUxNIChyZXYgMTEpCjAzOjAw
LjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyOiBTYW5kaXNrIENvcnAgV0QgQmxh
Y2sgMjAxOC9QQyBTTjcyMCBOVk1lIFNTRAowNTowMC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMS4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowMi4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNjowNC4wIFBDSSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEpITDY1NDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgKEMgc3RlcCkgW0FscGlu
ZSBSaWRnZSA0QyAyMDE2XSAocmV2IDAyKQowNzowMC4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBKSEw2NTQwIFRodW5kZXJib2x0IDMgTkhJIChDIHN0ZXApIFtB
bHBpbmUgUmlkZ2UgNEMgMjAxNl0gKHJldiAwMikKMmQ6MDAuMCBVU0IgY29udHJvbGxlcjog
SW50ZWwgQ29ycG9yYXRpb24gSkhMNjU0MCBUaHVuZGVyYm9sdCAzIFVTQiBDb250cm9sbGVy
IChDIHN0ZXApIFtBbHBpbmUgUmlkZ2UgNEMgMjAxNl0gKHJldiAwMikK
--------------733A624EB9663F7F0AC8C3FE
Content-Type: text/plain; charset=UTF-8;
 name="lspci-t-docked"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci-t-docked"

LVswMDAwOjAwXS0rLTAwLjAKICAgICAgICAgICArLTAyLjAKICAgICAgICAgICArLTA0LjAK
ICAgICAgICAgICArLTA4LjAKICAgICAgICAgICArLTEyLjAKICAgICAgICAgICArLTE0LjAK
ICAgICAgICAgICArLTE0LjIKICAgICAgICAgICArLTE0LjMKICAgICAgICAgICArLTE1LjAK
ICAgICAgICAgICArLTE1LjEKICAgICAgICAgICArLTE2LjAKICAgICAgICAgICArLTE2LjMK
ICAgICAgICAgICArLTFkLjAtWzAzXS0tLS0wMC4wCiAgICAgICAgICAgKy0xZC40LVswNS01
Ml0tLS0tMDAuMC1bMDYtNTJdLS0rLTAwLjAtWzA3XS0tLS0wMC4wCiAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLTAxLjAtWzA4LTJjXS0tLS0wMC4wLVsw
OS0yY10tLSstMDIuMC1bMGFdLS0tLTAwLjAKICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXC0wNC4w
LVswYi0yY10tLQogICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ky0wMi4wLVsyZF0tLS0tMDAuMAogICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXC0wNC4wLVsyZS01Ml0tLQogICAgICAgICAgICstMWYuMAogICAgICAgICAg
ICstMWYuMwogICAgICAgICAgICstMWYuNAogICAgICAgICAgICstMWYuNQogICAgICAgICAg
IFwtMWYuNgo=
--------------733A624EB9663F7F0AC8C3FE
Content-Type: text/plain; charset=UTF-8;
 name="lspci-t-not-docked"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci-t-not-docked"

LVswMDAwOjAwXS0rLTAwLjAKICAgICAgICAgICArLTAyLjAKICAgICAgICAgICArLTA0LjAK
ICAgICAgICAgICArLTA4LjAKICAgICAgICAgICArLTEyLjAKICAgICAgICAgICArLTE0LjAK
ICAgICAgICAgICArLTE0LjIKICAgICAgICAgICArLTE0LjMKICAgICAgICAgICArLTE1LjAK
ICAgICAgICAgICArLTE1LjEKICAgICAgICAgICArLTE2LjAKICAgICAgICAgICArLTE2LjMK
ICAgICAgICAgICArLTFkLjAtWzAzXS0tLS0wMC4wCiAgICAgICAgICAgKy0xZC40LVswNS01
Ml0tLS0tMDAuMC1bMDYtNTJdLS0rLTAwLjAtWzA3XS0tLS0wMC4wCiAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLTAxLjAtWzA4LTJjXS0tCiAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLTAyLjAtWzJkXS0tLS0wMC4w
CiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcLTA0LjAtWzJl
LTUyXS0tCiAgICAgICAgICAgKy0xZi4wCiAgICAgICAgICAgKy0xZi4zCiAgICAgICAgICAg
Ky0xZi40CiAgICAgICAgICAgKy0xZi41CiAgICAgICAgICAgXC0xZi42Cg==
--------------733A624EB9663F7F0AC8C3FE--

