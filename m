Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF26B5D31
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCKPJi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCKPJh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 10:09:37 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EB1524A;
        Sat, 11 Mar 2023 07:09:35 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A574C40737CF;
        Sat, 11 Mar 2023 15:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A574C40737CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678547373;
        bh=zDtdDisuOVpo+LVgUx80N2IrP23n/FpVuA+p57hry2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQ169L29RkU5TME2eWOgSPKOUnwedTQAze/wANT0pfmGXx+NgY3ZD0YqqroPbBfNH
         1L4781Vbyc6vDgvCMMU4FhzjEfXH8dbwMhnY+j+O8WIvu4chArXK2epcRlO1fQ1oXY
         lVdGnmQnGqX1hFaWiiCXiWNhdfn85+jMlkjMpZH4=
MIME-Version: 1.0
Date:   Sat, 11 Mar 2023 18:09:33 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 21/26] efi/x86: Explicitly set sections memory
 attributes
In-Reply-To: <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <c38ad7a1b89aff743d4a29882a7022d97d4fea58.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <f29b8efc018819cbb8202d13795ba89e@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-10 18:20, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Explicitly change sections memory attributes in efi_pe_entry in case
>> of incorrect EFI implementations and to reduce access rights to
>> compressed kernel blob. By default it is set executable due to
>> restriction in maximum number of sections that can fit before zero
>> page.
>> 
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 
> I don't think we need this patch. Firmware that cares about W^X will
> map the PE image with R-X for text/rodata and RW- for data/bss, which
> is sufficient, and firmware that doesn't is a lost cause anyway.

This patch were here mainly here to make .rodata non-executable and for
the UEFI handover protocol, for which attributes are usually not getting
applied.

Since the UEFI handover protocol is deprecated, I'll exclude patches 
from
v5 and maybe submit it separately modified to apply attributes only when
booting via this protocol.

> 
> 
>> ---
>>  drivers/firmware/efi/libstub/x86-stub.c | 54 
>> +++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>> 
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
>> b/drivers/firmware/efi/libstub/x86-stub.c
>> index 1f0a2e7075c3..60697fcd8950 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -27,6 +27,12 @@ const efi_dxe_services_table_t *efi_dxe_table;
>>  u32 image_offset __section(".data");
>>  static efi_loaded_image_t *image __section(".data");
>> 
>> +extern char _head[], _ehead[];
>> +extern char _compressed[], _ecompressed[];
>> +extern char _text[], _etext[];
>> +extern char _rodata[], _erodata[];
>> +extern char _data[];
>> +
>>  static efi_status_t
>>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct 
>> pci_setup_rom **__rom)
>>  {
>> @@ -343,6 +349,52 @@ void __noreturn efi_exit(efi_handle_t handle, 
>> efi_status_t status)
>>                 asm("hlt");
>>  }
>> 
>> +
>> +/*
>> + * Manually setup memory protection attributes for each ELF section
>> + * since we cannot do it properly by using PE sections.
>> + */
>> +static void setup_sections_memory_protection(unsigned long 
>> image_base)
>> +{
>> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
>> +       efi_dxe_table = 
>> get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>> +
>> +       if (!efi_dxe_table ||
>> +           efi_dxe_table->hdr.signature != 
>> EFI_DXE_SERVICES_TABLE_SIGNATURE) {
>> +               efi_warn("Unable to locate EFI DXE services table\n");
>> +               efi_dxe_table = NULL;
>> +               return;
>> +       }
>> +
>> +       /* .setup [image_base, _head] */
>> +       efi_adjust_memory_range_protection(image_base,
>> +                                          (unsigned long)_head - 
>> image_base,
>> +                                          EFI_MEMORY_RO | 
>> EFI_MEMORY_XP);
>> +       /* .head.text [_head, _ehead] */
>> +       efi_adjust_memory_range_protection((unsigned long)_head,
>> +                                          (unsigned long)_ehead - 
>> (unsigned long)_head,
>> +                                          EFI_MEMORY_RO);
>> +       /* .rodata..compressed [_compressed, _ecompressed] */
>> +       efi_adjust_memory_range_protection((unsigned long)_compressed,
>> +                                          (unsigned long)_ecompressed 
>> - (unsigned long)_compressed,
>> +                                          EFI_MEMORY_RO | 
>> EFI_MEMORY_XP);
>> +       /* .text [_text, _etext] */
>> +       efi_adjust_memory_range_protection((unsigned long)_text,
>> +                                          (unsigned long)_etext - 
>> (unsigned long)_text,
>> +                                          EFI_MEMORY_RO);
>> +       /* .rodata [_rodata, _erodata] */
>> +       efi_adjust_memory_range_protection((unsigned long)_rodata,
>> +                                          (unsigned long)_erodata - 
>> (unsigned long)_rodata,
>> +                                          EFI_MEMORY_RO | 
>> EFI_MEMORY_XP);
>> +       /* .data, .bss [_data, _end] */
>> +       efi_adjust_memory_range_protection((unsigned long)_data,
>> +                                          (unsigned long)_end - 
>> (unsigned long)_data,
>> +                                          EFI_MEMORY_XP);
>> +#else
>> +       (void)image_base;
>> +#endif
>> +}
>> +
>>  void __noreturn efi_stub_entry(efi_handle_t handle,
>>                                efi_system_table_t *sys_table_arg,
>>                                struct boot_params *boot_params);
>> @@ -687,6 +739,8 @@ asmlinkage unsigned long efi_main(efi_handle_t 
>> handle,
>>                 efi_dxe_table = NULL;
>>         }
>> 
>> +       setup_sections_memory_protection(bzimage_addr - image_offset);
>> +
>>  #ifdef CONFIG_CMDLINE_BOOL
>>         status = efi_parse_options(CONFIG_CMDLINE);
>>         if (status != EFI_SUCCESS) {
>> --
>> 2.37.4
>> 
