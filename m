Return-Path: <linux-efi+bounces-2554-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B69A07F28
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B93A83D4
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E39199385;
	Thu,  9 Jan 2025 17:45:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39787199E80;
	Thu,  9 Jan 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444717; cv=none; b=LD/gN/G5/aTgICNh+vUyf/NYX0DkhhWw9lg/MI5NaWnQ2r9Z4hFsc2uw6UkGA3CGPzuM01sFFhQgg9D34mIH10NA68b3vkjR3Jj1rnuqV3DkWZlEZvPEYvaz3DN6potoahu5ENsTkA/mJPUgwIlmB0DGLES+UUHCwOCIS5A5FqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444717; c=relaxed/simple;
	bh=Vk30NOmetJk3z0Z6xBTidqqFT9edQ1ZWs2Y4c1lequA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqFDOvoF0cQ/8c+0/TvhNsBpYm3o3W0kZcPcCaStD9pv7j2xlERjRK2Boah+Pr4LUrLedXtRd4BWYFUzmmkt41EFHruHUA/6v33/cuw8XzipOIqRs9xxkb0WqrJidgE424qPZUcP0+pR2EJOWz5DHPLE9irK8JxloZbz7ifHNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so190419066b.0;
        Thu, 09 Jan 2025 09:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444711; x=1737049511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oszPoslGfF3fOme2vdy6ypBsC2vdUH1VKFmQPmQRKg=;
        b=cT0tI/MhnuhyOYkuOgW2hkT7YvqSB/kZBo8arnWPL++qIMsGkPOc/q9nOPpsU8M7r7
         pNiibxB8qDHgKAa0SAPQGmy2QTl7xfZSFRZEu+arvEWgFHNLtdSKW9k3GcGrQBe1tblj
         11zYPNCQj8qBG3XuIpw0fmfPQDdHll4sh0wTqMgu4+O5VRW4X7Pddx9fLvrekSsHRu9r
         aEE4xh5OwUcjhhOgekxXH6vI4fEyEM61fQnUvKQdxVOCLLFz0mbfLzW0L0xM2yRvFMqS
         AWEoWE2EiB16tmOu5xXBOrRAAdpbJZ6/LXOgM2nCkq02vKUED7ipeiPq5RRbeA4LYiSC
         uMvg==
X-Forwarded-Encrypted: i=1; AJvYcCVaYUlc3MHtAE69gxmoaynVDoHMTkQRuTlT+QWQ8vanvvvfTfPrGdgTd1PsQOdYIk+HKrevFDBw+rL4Fkd/@vger.kernel.org, AJvYcCWx4aZJFiIoyNoMuBAsUEGspzuC8d31K9KQG2LjwoGXa3BfOlYKW/fDOW6ufIqUdVWtQZdJqrTEpZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cVTUb/iUKvOoZqMvcZFqI9IAmNDp6ITkI7F1m78lztQw9WYJ
	9IDwTe+7OhSId6d/44ueDz9I/Fn/Mn59qSsetIvyHV42wvj+cUZF
X-Gm-Gg: ASbGncsb74KdSr4DZGwvz2Z9UHabbWdCH90O6w2D2FGNs2fxi9d0PqvRr1FYjVih/E7
	ZraG26QlaogFMo00aA2xsG4D1GMCFeRB2gPYzq28diTF9ftcQm1sHJnzh6VC67yt7hJcSmc47fX
	eiRUn6FbOMaeKncup3g8MHu1VlvA7G1lv1cNhUW2vKz2VDqBoisPadJ9JFiaBrdLHeviCzol4ol
	W1undTzy0NQz+3tSLPVq/JOj2/Mo7xpZt5tQUBsPOAy6Ys=
X-Google-Smtp-Source: AGHT+IFteOMTIIbPWqOwXg7cb6A8xqFlFtuOYTsrv45lCAj+ofY7lG/HFOCX55baeO+nrn+WiT2Y4Q==
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d972e70945mr17099815a12.28.1736444711120;
        Thu, 09 Jan 2025 09:45:11 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af694sm92875966b.144.2025.01.09.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:45:10 -0800 (PST)
Date: Thu, 9 Jan 2025 09:45:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption
 warnings
Message-ID: <20250109-shapeless-maize-clam-895db6@leitao>
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
 <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
 <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
 <20250107-versatile-loyal-mussel-2dba59@leitao>
 <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>

On Thu, Jan 09, 2025 at 03:48:56PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2025 at 13:05, Breno Leitao <leitao@debian.org> wrote:
> > On Tue, Jan 07, 2025 at 12:24:03PM +0100, Ard Biesheuvel wrote:


> > We are seeing a bunch of `Corrupted EFI Memory Attributes Table
> > detected!` in the Meta fleet, and this is something we are
> > investigating.
> >
> > We highly think this is related to some kexec overwrites, and when we
> > get here, the EFI table is completely garbage. I haven't seen this
> > problem on cold boot.
> >
> 
> It likely means the memory is not reserved correctly.
> 
> Could you check whether this
> 
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -56,7 +56,7 @@ int __init efi_memattr_init(void)
>         }
> 
>         tbl_size = sizeof(*tbl) + size;
> -       memblock_reserve(efi_mem_attr_table, tbl_size);
> +       efi_mem_reserve(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
> 
>  unmap:
> 
> 
> makes any difference?

It doesn't seem so. This is how I tested it.

I've cherry-picked it on top of Linus' master eea6e4b4dfb8 ("Merge tag
'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi"), 
and booted a system with this kernel.

From cold boot, we never see any firmware bug (as usual). Then I kexec
the same kernel, and then I got the problem twice (I tested it 2 times
and same results):

	[    0.000000] APIC: Static calls initialized
	[    0.000000] e820: update [mem 0x107fff9400-0x107fff940f] usable ==> usable
	[    0.000000] e820: update [mem 0x107fff93e0-0x107fff93ff] usable ==> usable
	[    0.000000] e820: update [mem 0x107fff9370-0x107fff93df] usable ==> usable
	[    0.000000] extended physical RAM map:
	[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
	[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
	[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000069cd5fff] usable
	[    0.000000] reserve setup_data: [mem 0x0000000069cd6000-0x000000006bdd5fff] reserved
	[    0.000000] reserve setup_data: [mem 0x000000006bdd6000-0x000000006be90fff] ACPI data
	[    0.000000] reserve setup_data: [mem 0x000000006be91000-0x000000006c9eafff] ACPI NVS
	[    0.000000] reserve setup_data: [mem 0x000000006c9eb000-0x000000006ebedfff] reserved
	[    0.000000] reserve setup_data: [mem 0x000000006ebee000-0x000000006fffffff] usable
	[    0.000000] reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
	[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
	[    0.000000] reserve setup_data: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
	[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
	[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000107fff936f] usable
	[    0.000000] reserve setup_data: [mem 0x000000107fff9370-0x000000107fff940f] usable
	[    0.000000] reserve setup_data: [mem 0x000000107fff9410-0x000000107fffffff] usable
	[    0.000000] efi: EFI v2.6 by American Megatrends
	[    0.000000] efi: ACPI 2.0=0x6c61e000 ACPI=0x6c61e000 TPMFinalLog=0x6c9b9000 SMBIOS=0x6e69d000 SMBIOS 3.0=0x6e69c000 MEMATTR=0x64ef1018 ESRT=0x67dc9918 TPMEventLog=0x6be8e018
	[    0.000000] efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 48, num_entries == 50)
	[    0.000000] efi: Remove mem00: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
	[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
	[    0.000000] efi: Not removing mem01: MMIO range=[0xfed20000-0xfed44fff] (148KB) from e820 map
	[    0.000000] efi: Remove mem02: MMIO range=[0xfd000000-0xfe7fffff] (24MB) from e820 map
	[    0.000000] e820: remove [mem 0xfd000000-0xfe7fffff] reserved
	[    0.000000] efi: Remove mem03: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
	[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
	[    0.000000] SMBIOS 3.1.1 present.


