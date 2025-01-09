Return-Path: <linux-efi+bounces-2553-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58833A07E0B
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29EE188BE32
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9457139D19;
	Thu,  9 Jan 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rCcgVUlH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA513B2B8
	for <linux-efi@vger.kernel.org>; Thu,  9 Jan 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441263; cv=none; b=gcsMFAzAnUoE8+gSYvR1WpAuqP7xrs88V3pSM1VUOtbH7j6uiarIESEQGSqpk8WRP4nePaVlP//xKdF1gw9tbQ3wsXcRIwhXRhqRTujanDW0UVUsifvKkMufG/Z9r8trgXEwN+8pUddvCAc1/hST2RCWMrQnPrgz4LI5Ayz0BXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441263; c=relaxed/simple;
	bh=rEWkWtxIvU5P+S99zdNwZlHNIBaylLXnWQ/BBwDyn40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM1MXSylSrTkd9fJsGfqJXYO+dXsB9Xxiona9MpcS9p24StveZnwDudtXQ5UNcOiyoAk2H3pqUGq4ev/lYRMgbm0o1hPKwrcmu6KF3jrMhLcMhTCcJwYQO8SUHl22NqpAltA3Vjeda74Jm7GWdOvumbuBxAiB9p7M59ZlkjeJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rCcgVUlH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a3c85e11so6571601cf.2
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2025 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736441259; x=1737046059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWLLNj4Jpt+nD7oagFzGVAygPHcJROez4GbTM54vWxI=;
        b=rCcgVUlHY6DeLCRPpPxQVvxvjaeM5FEXA5be7XBQKzwQra2jT/dHRPX2UM/dXcfB02
         EwB0KbFptQlh+M5orZELK9M86OPDcf6xswCLPbSBu19H3C3KtSX1amxfD2XNHSYeyrGc
         B27VOWI0i56fbGQwKhRJFXAVWHH7n4hnhp8/35oC/QuUept9AiAN4zhaqGJywu9UfkYu
         QZql6nDnr5+50GX8LZwHl14qyMwNE/J5uAUrDu7jqAT3j9FF3HTwqZ/+hqMroNvp2tce
         DQTBFWxbMf734f3728aMpEpCIqB+RmpGYv3m3luvCBqJ+HJ8MtNgZme/iyMkJhMWS+oA
         4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736441259; x=1737046059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWLLNj4Jpt+nD7oagFzGVAygPHcJROez4GbTM54vWxI=;
        b=OsrLQiH/8Mna4E3rZtkGzd7Kwk3D7nGPGgsyzia6M8/lUbqDWNPU8g/QBoY1BdOoWD
         62CS0qHJMTnByrQtZPagy+5dG9sTi2jjgVusHD4GPXnvraEBORNTuKAUopav4PNjdoey
         lNtCkFZmiW3Uqg2Zjen9H36V8J1QtS8dJwGGPrd6yo4r+thTV9qbNOosek7hIW5sSLZg
         U2YVWXydjFJXF0vVWDhNxjLHjlChFktjg5/EcuW8La9fB9sMiEmQuIQUp/jhUPe0IdeI
         2qw0aydeSX+Yz+MrnHbQTJCPkKzalwwbXAwjaE+JKq/+dekXMDngthJwl0wif/7oHxsZ
         i6jA==
X-Forwarded-Encrypted: i=1; AJvYcCWyRKqKYNYcSnQ+XwfCFh05noQjC3Lw+Sfmkz4S7X7xPtSVKUiJ8WsJmEFeQHPtnFIFpiYD0UPSIrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4VNoSMXFynN8F47XCaKPr8c0jcfgmJx+7C80nuVNcOjM9uRZ
	XTs1CAE6TU7W+hr4Js9XoDg9ELTmwY5bTSHOlf7k065YGcLuoCFAWeB4VEN4Q60=
X-Gm-Gg: ASbGncvyglAAwtpngLFWEINSCInrnb2eoITqnKLJqeobXUaize2K/HwsMK+a9rGHtA5
	XAe93+iNFySfYoYUj7pch4JAZ1VVB8vTUIk/BotxTTvWS1bjLpoh2sA8pruPmQS2VAF3TKI+l7k
	Z8ZNbkfBWil7udhHjdtytnIe6ucJ/S+JeicpSzsI1kA27Qq+W0ZCHNB4rhrJY8v5dVTNpcKhpTe
	e9N5RNUBxDYOB963q9qpIsGJj12d7d89edtF7Jel2DwG9+MAULzA6Aj3t+15llzvegSjW9nzRqZ
	BHLUSobEsaBLYhpIbDZzZB0W2pvOzMfsLC7SJzQ=
X-Google-Smtp-Source: AGHT+IEfGB7EQOEZkMT+90Rjc0IctwMlybh+WaRko0ZJ/riaoBe4SP1QGKvazsluuU8xPEQoq7TRcQ==
X-Received: by 2002:a05:6214:da5:b0:6d8:96a6:ec27 with SMTP id 6a1803df08f44-6df9b2d37abmr121742496d6.35.1736441259182;
        Thu, 09 Jan 2025 08:47:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9b07d1sm81596d6.60.2025.01.09.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:47:38 -0800 (PST)
Date: Thu, 9 Jan 2025 11:47:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
	dyoung@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, kernel-team@meta.com
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
Message-ID: <Z3_9qDY1uTbxV5AE@gourry-fedora-PF4VCD3F>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>

On Thu, Jan 09, 2025 at 04:32:10PM +0000, Usama Arif wrote:
> 
> 
> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >>
> >> Since the patch in [1] was merged, all boots after kexec
> >> are producing the warning that it introduced.
> >>
> >> Having a fix in firmware can be difficult to get through.
> > 
> > I don't follow. I don't think there is anything wrong with the
> > firmware here. Could you elaborate?
> > 
> 
> So the problem is, kexec sees this memory as System RAM, and decides
> it can be used to place an image here.
> 
> I guess the question is (and I actually don't know the answer here),
> whose responsibility is it to mark this region as reserved so that 
> its not touched by anyone else. I would have thought it should be
> firmware?
> 
> Maybe its not the firmwares' job to mark it as reserved, but just pass
> it to kernel and the kernel is supposed to make sure it gets reserved
> in a proper way, even across kexecs.

Reservation is a kernel concept, the firmware/EFI etc give the kernel
guidance - but the actual maps here are largely informational and the
kernel can do whatever it wants (within reason).

So what you're really saying is either
  a) the hardware is mis-reporting the memory map configurations
     (e.g. some EFI_* bit is missing), or
  b) the kernel isn't doing the right thing.

I believe Ard is pointing out that the additional map abstraction is just
trying to retain a "current" versus "original" configuration - and this
is more of a headache than it is worth as it appears to be causing
confusion as to which one should be respected across kexec.

So the separate maps should just be one, and we should just smash the
"original" configuration rather than keeping a copy.

Please correct me if i'm misunderstanding anything.

> 
> I think in the end whoevers' responsibility it is, the easiest path forward
> seems to be in kernel? (and not firmware or libstub)
> 
> > 
> >> The next ideal place would be in libstub. However, it looks like
> >> InstallMemoryAttributesTable [2] is not available as a boot service
> >> call option [3], [4], and install_configuration_table does not
> >> seem to work as a valid substitute.
> >>
> > 
> > To do what, exactly?
> > 
> 
> To change the memory type from System RAM to either reserved or
> something more appropriate, i.e. any type that is not touched by
> kexec or any other userspace.
> 
> Basically the example code I attached at the end of the cover letter in 
> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
> touched by kexec.
> 
> >> As a last option for a fix, this patch marks that region as reserved in
> >> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
> >> use it for kernel segments.
> >>
> >> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
> >> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
> >> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
> >>
> >> Reported-by: Breno Leitao <leitao@debian.org>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  arch/x86/include/asm/e820/api.h | 2 ++
> >>  arch/x86/kernel/e820.c          | 6 ++++++
> >>  arch/x86/platform/efi/efi.c     | 9 +++++++++
> >>  drivers/firmware/efi/memattr.c  | 1 +
> >>  include/linux/efi.h             | 7 +++++++
> >>  5 files changed, 25 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> >> index 2e74a7f0e935..4e9aa24f03bd 100644
> >> --- a/arch/x86/include/asm/e820/api.h
> >> +++ b/arch/x86/include/asm/e820/api.h
> >> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
> >>
> >>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
> >>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> >> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> >> +                                       enum e820_type new_type);
> >>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
> >>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> >>
> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >> index 82b96ed9890a..01d7d3c0d299 100644
> >> --- a/arch/x86/kernel/e820.c
> >> +++ b/arch/x86/kernel/e820.c
> >> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
> >>         return __e820__range_update(t, start, size, old_type, new_type);
> >>  }
> >>
> >> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> >> +                                      enum e820_type new_type)
> >> +{
> >> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
> >> +}
> >> +
> >>  /* Remove a range of memory from the E820 table: */
> >>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
> >>  {
> >> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> >> index a7ff189421c3..13684c5d7c05 100644
> >> --- a/arch/x86/platform/efi/efi.c
> >> +++ b/arch/x86/platform/efi/efi.c
> >> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
> >>         e820__update_table(e820_table);
> >>  }
> >>
> >> +/* Reserve firmware area if it was marked as RAM */
> >> +void arch_update_firmware_area(u64 addr, u64 size)
> >> +{
> >> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
> >> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >> +               e820__update_table(e820_table_firmware);
> >> +       }
> >> +}
> >> +
> >>  /*
> >>   * Given add_efi_memmap defaults to 0 and there is no alternative
> >>   * e820 mechanism for soft-reserved memory, import the full EFI memory
> >> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> >> index d3bc161361fb..d131781e2d7b 100644
> >> --- a/drivers/firmware/efi/memattr.c
> >> +++ b/drivers/firmware/efi/memattr.c
> >> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
> >>         size = tbl->num_entries * tbl->desc_size;
> >>         tbl_size = sizeof(*tbl) + size;
> >>         memblock_reserve(efi_mem_attr_table, tbl_size);
> >> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
> >>         set_bit(EFI_MEM_ATTR, &efi.flags);
> >>
> >>  unmap:
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index e5815867aba9..8eb9698bd6a4 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
> >>  void efivars_generic_ops_register(void);
> >>  void efivars_generic_ops_unregister(void);
> >>
> >> +#ifdef CONFIG_X86_64
> >> +void __init arch_update_firmware_area(u64 addr, u64 size);
> >> +#else
> >> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
> >> +{
> >> +}
> >> +#endif
> >>  #endif /* _LINUX_EFI_H */
> >> --
> >> 2.43.5
> >>
> 

