Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935F13B2FCD
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhFXNLz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 09:11:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:7195 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhFXNLy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Jun 2021 09:11:54 -0400
IronPort-SDR: dd5904ovP9yVDVEZQeku83TqRhYhQstyOPb3ld1j/hXq7iBOWZ3HXeLeGNkHLc7iywMlFmOYbH
 k2gLoC7N3OOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="229049274"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="229049274"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 06:09:32 -0700
IronPort-SDR: HxzSTYXQksPgutqeSE3iKfp9Xrj592UZplSuYL2yf9w+lHbS62QYhzBJO10kJz62rm97NrSuSm
 rFnbbRcQ70VA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="487748748"
Received: from llvujovi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.82.142])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 06:09:30 -0700
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
To:     Michael Roth <michael.roth@amd.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com> <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com> <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com> <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5706421e-c88e-bcda-e637-610b5db297d0@linux.intel.com>
Date:   Thu, 24 Jun 2021 06:09:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624031911.eznpkbgjt4e445xj@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+ Andi, Kirill (For TDX specific review)

On 6/23/21 8:19 PM, Michael Roth wrote:
> On Wed, Jun 23, 2021 at 12:22:23PM +0200, Borislav Petkov wrote:
>> On Tue, Jun 22, 2021 at 11:30:43PM -0500, Michael Roth wrote:
>>> Quoting Borislav Petkov (2021-06-18 10:05:28)
>>>> On Fri, Jun 18, 2021 at 08:57:12AM -0500, Brijesh Singh wrote:
>>>>> Don't have any strong reason to keep it separate, I can define a new
>>>>> type and use the setup_data to pass this information.
>>>>
>>>> setup_data is exactly for use cases like that - pass a bunch of data
>>>> to the kernel. So there's no need for a separate thing. Also see that
>>>> kernel_info thing which got added recently for read_only data.
>>>
>>> Hi Boris,
>>>
>>> There's one side-effect to this change WRT the CPUID page (which I think
>>> we're hoping to include in RFC v4).
>>>
>>> With CPUID page we need to access it very early in boot, for both
>>> boot/compressed kernel, and the uncompressed kernel. At first this was
>>> implemented by moving the early EFI table parsing code from
>>> arch/x86/kernel/boot/compressed/acpi.c into a little library to handle early
>>> EFI table parsing to fetch the Confidential Computing blob to get the CPUID
>>> page address.
>>>
>>> This was a bit messy since we needed to share that library between
>>> boot/compressed and uncompressed, and at that early stage things like
>>> fixup_pointer() are needed in some places, else even basic things like
>>> accessing EFI64_LOADER_SIGNATURE and various EFI helper functions could crash
>>> in uncompressed otherwise, so the library code needed to be fixed up
>>> accordingly.
>>>
>>> To simplify things we ended up simply keeping the early EFI table parsing in
>>> boot/compressed, and then having boot/compressed initialize
>>> setup_data.cc_blob_address so that the uncompressed kernel could access it
>>> from there (acpi does something similar with rdsp address).
>>
>> Yes, except the rsdp address is not vendor-specific but an x86 ACPI
>> thing, so pretty much omnipresent.
>>
>> Also, acpi_rsdp_addr is part of boot_params and that struct is full
>> of padding holes and obsolete members so reusing a u32 there is a lot
>> "easier" than changing the setup_header. So can you put that address in
>> boot_params instead?
> 
> Thanks for the suggestion! I tried something like the below and that seems to
> work pretty well. I'm not sure if that's the best spot or not though, it
> seems like it might be a good idea to leave some padding after eddbuf in
> case it needs to grow in the future. I'll look into that a bit more.
> 
> One downside to this is we still need something in the boot protocol,
> either via setup_data, or setup_header directly. Having it in
> setup_header avoids the need to also have to add a field to boot_params
> for the boot/compressed->uncompressed passing, but maybe that's not a good
> enough justification. Perhaps if the TDX folks have similar needs though.
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 1ac5acca72ce..0824c8646861 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -218,7 +218,8 @@ struct boot_params {
>          struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
>          __u8  _pad8[48];                                /* 0xcd0 */
>          struct edd_info eddbuf[EDDMAXNR];               /* 0xd00 */
> -       __u8  _pad9[276];                               /* 0xeec */
> +       __u32 cc_blob_address;							/* 0xeec */
> +       __u8  _pad9[272];                               /* 0xef0 */
>   } __attribute__((packed));
> 
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index 981fe923a59f..53e9b0620d96 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>                          BOOT_PARAM_PRESERVE(hdr),
>                          BOOT_PARAM_PRESERVE(e820_table),
>                          BOOT_PARAM_PRESERVE(eddbuf),
> +                       BOOT_PARAM_PRESERVE(cc_blob_address),
>                  };
> 
>                  memset(&scratch, 0, sizeof(scratch));
> 
>>
>>> Now that we're moving it to setup_data, this becomes a bit more awkward,
>>> since we need to reserve memory in boot/compressed to store the setup_data
>>> entry, then add it to the linked list to pass along to uncompressed kernel.
>>> In turn that also means we need to add an identity mapping for this in
>>> ident_map_64.c, so I'm not sure that's the best approach.
>>>
>>> So just trying to pin what the best approach is:
>>>
>>> a) move cc_blob to setup_data, and do the above-described to pass
>>>     cc_blob_address from boot/compressed to uncompressed to avoid early
>>>     EFI parsing in uncompressed
>>> b) move cc_blob to setup_data, and do the EFI table parsing in both
>>>     boot/compressed. leave setup_data allocation/init for BIOS/bootloader
>>> c) keep storing cc_blob_address in setup_header.cc_blob_address
>>> d) something else?
>>
>> Leaving in the whole text for newly CCed TDX folks in case they're going
>> to need something like that.
>>
>> And if so, then both vendors should even share the field definition.
>>
>> Dave, Sathya, you can find the whole subthread here:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20210602140416.23573-21-brijesh.singh%40amd.com&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C3b352c4b944c4d95bbdb08d93630d0eb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637600405622460196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=464O7JxibsbjC3bc0LkGcztdb4kCYH7kcQAcqohJhug%3D&amp;reserved=0
>>
>> in case you need background info on the topic at hand.
>>
>> Thx.
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C3b352c4b944c4d95bbdb08d93630d0eb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637600405622460196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ruCM7CNgPCNPkrOoiNts1ZKi5k7JSUumln7qQMP%2BMi0%3D&amp;reserved=0

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
