Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA74512A408
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXTeJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 14:34:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbfLXTeI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 14:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577216045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSrjz4TJwa4Broc/WozyzlCBNB1dhT0fE0fq8DRrmfo=;
        b=LOLYFbZQvsiupWck5W2YszFw2ZFX7WtBOCVO/RLyCRxa2GVJ2x9U/d8ycg+We8Bn8I47m4
        ntIeIuT25K6VP0hjWx94+zlNelPsopo/vZBPwPxCFK5funpQAZneTgtOdF6ukRtR0jvTFI
        V9Dgwls6LO/IyMI+yEjWggtVH0FboE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-W_JxX64-OgGKxObXxUqoog-1; Tue, 24 Dec 2019 14:34:04 -0500
X-MC-Unique: W_JxX64-OgGKxObXxUqoog-1
Received: by mail-wr1-f69.google.com with SMTP id 90so9918228wrq.6
        for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2019 11:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSrjz4TJwa4Broc/WozyzlCBNB1dhT0fE0fq8DRrmfo=;
        b=b6dOzboK7m+63phCNZwMMEBKpB16yIpA7fHeMyuSrFNsi8jHmvGs+mG3ZWxG3xLWgI
         3Y8/zLT7kK+pCXARvejcDiQHf/RYK8pmJ2KcbKtpNiDJxPhYu18mcTVwvmREgey9tYkk
         KclRWBPg61Q1+WvhbU+d29vdagump0Z5zTJOWJnOzoFHQEIfvn4YXcBRFuFm7cAZPbiz
         DdRIO9q7ykm6LCwkHFwyoDdnQMill6f8XQiiDCMwjwwVc9K39H78IC+lklKiMaiXVk+b
         ll0ew+KxkmCT6udE9dke6JjyadiKw11xpJH2rST1rLzC47aCn0u2DMZ6f7SSYXHHxEOW
         RVBA==
X-Gm-Message-State: APjAAAWWuvoiZW5lwQgkZ0BBN/09gKTrObjwQtMzIBrz7P1Q5h1vu8bL
        eblt+/Jlejxgl0Z7RwgaYxkLmo/411uADqmM2aBcSyiF9nrdgh5UZgYe3GG+soMvfBe/ywVn6sI
        MuDU4RPlEizcs2q60ZDpE
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr212910wme.108.1577216042977;
        Tue, 24 Dec 2019 11:34:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXuI+hzBJAqEL7QTnorzmUiJ3/lT5/xS33dvNrzkgLzribciot4+teD6JbM05KLsTFaZE/QA==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr212890wme.108.1577216042694;
        Tue, 24 Dec 2019 11:34:02 -0800 (PST)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id n8sm25648722wrx.42.2019.12.24.11.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:34:01 -0800 (PST)
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <463b0b17-3be7-697e-1227-5d3df52996d6@redhat.com>
Date:   Tue, 24 Dec 2019 20:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218170139.9468-14-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> The various pointers we stash in the efi_config struct which we
> retrieve using __efi_early() are simply copies of the ones in
> the EFI system table, which we have started accessing directly
> in the previous patch. So drop all the __efi_early() related
> plumbing, except for the access to a boolean which tells us
> whether the firmware is 64-bit or not.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I synced my personal tree yesterday to 5.5-rc3 + the most
recent version (as of yesterday afternoon) of your
efistub-x86-cleanup-v3 branch on top.

This has been working fine on a bunch of devices, but it fails
on a Teclast X89 Bay Trail (mixed mode) device. When reverting all
the commits from your efistub-x86-cleanup-v3 branch one by one, things
start working again after reverting this one.

Regards,

Hans


> ---
>   arch/x86/boot/compressed/eboot.c   | 36 ++++++++------------
>   arch/x86/boot/compressed/head_32.S |  2 +-
>   arch/x86/boot/compressed/head_64.S |  4 +--
>   arch/x86/include/asm/efi.h         | 23 +++++--------
>   4 files changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 2bcab1ef5a56..53e67334c4c3 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -20,11 +20,17 @@
>   
>   static efi_system_table_t *sys_table;
>   
> -static struct efi_config *efi_early;
> +struct efi_config {
> +	u64 image_handle;
> +	u64 table;
> +	bool is64;
> +} __packed;
>   
> -__pure const struct efi_config *__efi_early(void)
> +static bool is64;
> +
> +__pure bool __efi_early_is64(void)
>   {
> -	return efi_early;
> +	return is64;
>   }
>   
>   __pure efi_system_table_t *efi_system_table(void)
> @@ -32,13 +38,6 @@ __pure efi_system_table_t *efi_system_table(void)
>   	return sys_table;
>   }
>   
> -static void setup_boot_services(struct efi_config *c)
> -{
> -	c->runtime_services	= efi_table_attr(efi_system_table, runtime, sys_table);
> -	c->boot_services	= efi_table_attr(efi_system_table, boottime, sys_table);
> -	c->text_output		= efi_table_attr(efi_system_table, con_out, sys_table);
> -}
> -
>   static efi_status_t
>   preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>   {
> @@ -382,16 +381,14 @@ struct boot_params *make_boot_params(struct efi_config *c)
>   	unsigned long ramdisk_addr;
>   	unsigned long ramdisk_size;
>   
> -	efi_early = c;
> -	sys_table = (efi_system_table_t *)(unsigned long)efi_early->table;
> -	handle = (void *)(unsigned long)efi_early->image_handle;
> +	sys_table = (efi_system_table_t *)(unsigned long)c->table;
> +	handle = (void *)(unsigned long)c->image_handle;
> +	is64 = c->is64;
>   
>   	/* Check if we were booted by the EFI firmware */
>   	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
>   		return NULL;
>   
> -	setup_boot_services(efi_early);
> -
>   	status = efi_call_early(handle_protocol, handle,
>   				&proto, (void *)&image);
>   	if (status != EFI_SUCCESS) {
> @@ -738,10 +735,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>   	efi_system_table_t *_table;
>   	unsigned long cmdline_paddr;
>   
> -	efi_early = c;
> -
> -	_table = (efi_system_table_t *)(unsigned long)efi_early->table;
> -	handle = (void *)(unsigned long)efi_early->image_handle;
> +	_table = (efi_system_table_t *)(unsigned long)c->table;
> +	handle = (void *)(unsigned long)c->image_handle;
> +	is64 = c->is64;
>   
>   	sys_table = _table;
>   
> @@ -749,8 +745,6 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>   	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
>   		goto fail;
>   
> -	setup_boot_services(efi_early);
> -
>   	/*
>   	 * make_boot_params() may have been called before efi_main(), in which
>   	 * case this is the second time we parse the cmdline. This is ok,
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 7da4dfc53df6..c026ab881405 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -261,7 +261,7 @@ SYM_FUNC_END(.Lrelocated)
>   #ifdef CONFIG_EFI_STUB
>   	.data
>   efi32_config:
> -	.fill 7,4,0
> +	.fill 4,4,0
>   	.byte 0
>   #endif
>   
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 6dc6a7ebb9e1..72065735abc1 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -672,13 +672,13 @@ SYM_DATA_LOCAL(efi_config, .quad 0)
>   
>   #ifdef CONFIG_EFI_MIXED
>   SYM_DATA_START(efi32_config)
> -	.fill	5,8,0
> +	.fill	2,8,0
>   	.byte	0
>   SYM_DATA_END(efi32_config)
>   #endif
>   
>   SYM_DATA_START(efi64_config)
> -	.fill	5,8,0
> +	.fill	2,8,0
>   	.byte	1
>   SYM_DATA_END(efi64_config)
>   #endif /* CONFIG_EFI_STUB */
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index e0789ec5c9f6..8137d4f5c104 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -200,16 +200,7 @@ static inline efi_status_t efi_thunk_set_virtual_address_map(
>   
>   /* arch specific definitions used by the stub code */
>   
> -struct efi_config {
> -	u64 image_handle;
> -	u64 table;
> -	efi_runtime_services_t *runtime_services;
> -	efi_boot_services_t *boot_services;
> -	efi_simple_text_output_protocol_t *text_output;
> -	bool is64;
> -} __packed;
> -
> -__pure const struct efi_config *__efi_early(void);
> +__pure bool __efi_early_is64(void);
>   
>   static inline bool efi_is_64bit(void)
>   {
> @@ -219,7 +210,7 @@ static inline bool efi_is_64bit(void)
>   	if (!IS_ENABLED(CONFIG_EFI_MIXED))
>   		return true;
>   
> -	return __efi_early()->is64;
> +	return __efi_early_is64();
>   }
>   
>   static inline bool efi_is_native(void)
> @@ -252,14 +243,16 @@ static inline bool efi_is_native(void)
>   
>   #define efi_call_early(f, ...)						\
>   	(efi_is_native()						\
> -		? __efi_early()->boot_services->f(__VA_ARGS__)		\
> -		: efi64_thunk(__efi_early()->boot_services->mixed_mode.f,\
> +		? efi_system_table()->boottime->f(__VA_ARGS__)		\
> +		: efi64_thunk(efi_table_attr(efi_boot_services,		\
> +			boottime, efi_system_table())->mixed_mode.f,	\
>   			__VA_ARGS__))
>   
>   #define efi_call_runtime(f, ...)					\
>   	(efi_is_native()						\
> -		? __efi_early()->runtime_services->f(__VA_ARGS__)	\
> -		: efi64_thunk(__efi_early()->runtime_services->mixed_mode.f,\
> +		? efi_system_table()->runtime->f(__VA_ARGS__)		\
> +		: efi64_thunk(efi_table_attr(efi_runtime_services,	\
> +			runtime, efi_system_table())->mixed_mode.f,	\
>   			__VA_ARGS__))
>   
>   extern bool efi_reboot_required(void);
> 

