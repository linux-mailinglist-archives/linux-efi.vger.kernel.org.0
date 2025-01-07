Return-Path: <linux-efi+bounces-2524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81DA03E85
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 13:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A39B3A1EE9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294581E47CE;
	Tue,  7 Jan 2025 12:05:22 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7841DFE3D;
	Tue,  7 Jan 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251522; cv=none; b=ITj2j1OaoVtBb3EjepS8qWpyJIfNQ2nKUOfmyey7swr5FKGiWXMxAq3j8C7kmHUwa+L3MjWGoj21L9Fp6fINIrfXaV9DV7PaWt74JKEhMgk7XaDtrsjWZN8Z5NRdXBjWybk7IJ9WyZm+1s+fU5pzM1EK+WU+lDpZb6/qtPvvpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251522; c=relaxed/simple;
	bh=KIQlWLvjuiktsZ2AIRA8/V5kchE4/mtsMj6vbQceMa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxz9wCmSxo59wYKW0S5b1ReOW8T/qVuIEjh3IylsDu9GkWItRMSLp1zaWeHfV2qGHDPhrXcC9aTM7FtknwCeOJU63Rf+GizlH1zWRgT75pzeFffqEQUtuioIuLS1Pa6FcgBHC/FKtX2SUCGc6F4iCXuP66nkwDV81h52f6xzKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa696d3901bso2067378966b.1;
        Tue, 07 Jan 2025 04:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251518; x=1736856318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5qbBF0Wwj46E5g41Mm5n10R2VTqZYSHeBDJhfOVoZs=;
        b=uhQmYPJzwZjOFtWGpTD8uJ0xqUh16ZQqNt0+Y7rsNwPBx9tuv7YW/9MjDZ6Zp9OkzG
         Dm9hIHCyLLnxZCV7m86QcFIhnWOUfdEJ/sFVtUOULuRcM6YKdoDnIr7I44qwsopPozo7
         7mVBL0Mmy+6vIy1UAVVoEBjZZ35ODpxQeh7EJQXXNX3xlUHz4+aZs8uQBuNL1bk1FSvv
         koyYTxopw/rnwPr7IjfrwICX+SLXVokKsyW051qnPF6tYwUiWbaQuBxbaEuSgjhB6nLj
         6YuSOmHymy46V6Q7M+KfuFqzMGQCQgoFBLXpNc5urc7kya0NLkA8CUUZZpjmeUu6Vhw/
         Na8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzAI6ja0Y9A+ci+LqD9E3ttumhLTCk+LpXG5Z6Ob47Gn8viwYUvfq4Rb33S1cS16vBlxKZbIEyeCFd73w3@vger.kernel.org, AJvYcCVaz4RKr6UppypSgEzwowf4ncUyP3N+W49w3jFjk72wNhq3aCRptJcKXNIKXOH4XASMn9gbDJeec5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgHymaL+rXWK3Bm9sQasdZgxJqpYvhICi1nv5xbHl5aR93Hmb
	EYXNCcvge+ZWVlaYiAqABLYuc1VFv//QfR8Us5MqRHM8TNcKQVboyFySnA==
X-Gm-Gg: ASbGncsfDbAOgPOnO3ZiY/vnmzvW2FBOV0WoTpcXV+Z2iJb37s89tFmPe/7pOFlaip5
	1Ql8gt5l9/Yu53xL0zFfQPXJPva3CE9Ja9yR+F2I9j+ZAeV7QSkTeRCKRUSyvyGsBSRSUJkUUQL
	xRO48ETFMf75WtsgiGGi3fUP2Pdag9ceAlqSc0QJTRFjlLtYE/ae0kHAdP5FL0kL/ZcliS1/o22
	L2hHFoaMaj6SI/Lxzjet8Bt+iFGkKQ8BU7c5qkoWckG6gQ=
X-Google-Smtp-Source: AGHT+IHpKvUxrGtgTSBX+8fOsmCgN6hfOZlJ36omuKVNOGnm6QaVBcC2wEpZLAl1wVW7dT9Dys9SGg==
X-Received: by 2002:a17:907:3d86:b0:aa6:9eac:4b7e with SMTP id a640c23a62f3a-aac2d455458mr6587764266b.30.1736251518096;
        Tue, 07 Jan 2025 04:05:18 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f016babsm2379113066b.169.2025.01.07.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:05:17 -0800 (PST)
Date: Tue, 7 Jan 2025 04:05:15 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption
 warnings
Message-ID: <20250107-versatile-loyal-mussel-2dba59@leitao>
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
 <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
 <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>

Hello Ard,

On Tue, Jan 07, 2025 at 12:24:03PM +0100, Ard Biesheuvel wrote:
> On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
> >
> > Add EFI memory map size to warning messages when a corrupted Memory
> > Attributes Table is detected, making it easier to diagnose firmware issues.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/firmware/efi/memattr.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> > index 5f83cdea88b05cb325e9f90c14a0048131e53cfa..2c276bcc0df48352bec6cd96b69edf67a16f6069 100644
> > --- a/drivers/firmware/efi/memattr.c
> > +++ b/drivers/firmware/efi/memattr.c
> > @@ -22,7 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
> >  void __init efi_memattr_init(void)
> >  {
> >         efi_memory_attributes_table_t *tbl;
> > -       unsigned long size;
> > +       unsigned long size, efi_map_size;
> >
> >         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
> >                 return;
> > @@ -49,9 +49,10 @@ void __init efi_memattr_init(void)
> >          * just be ignored altogether.
> >          */
> >         size = tbl->num_entries * tbl->desc_size;
> > -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
> > -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
> > -                       tbl->version, tbl->desc_size, tbl->num_entries);
> > +       efi_map_size = efi.memmap.nr_map * efi.memmap.desc_size;
> > +       if (size > 3 * efi_map_size) {
> > +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u, efi_map_size == %lu)\n",
> > +                       tbl->version, tbl->desc_size, tbl->num_entries, efi_map_size);
> >                 goto unmap;
> >         }
> >
> >
> 
> Hello Breno,
> 
> I don't mind the patch per se, but I don't think it is terribly useful either.
> 
> Could you explain how this helps?

We are seeing a bunch of `Corrupted EFI Memory Attributes Table
detected!` in the Meta fleet, and this is something we are
investigating.

We highly think this is related to some kexec overwrites, and when we
get here, the EFI table is completely garbage. I haven't seen this
problem on cold boot.

Here are sof the instances I see:

	efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 18058, num_entries == 33554432)
	efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 2072184435, num_entries == 3248688968)
	efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 83886080, num_entries == 304)
	efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 2, desc_size == 48, num_entries == 40)	

Anyway, back to you question, this patch helped us to narrow down and
find where the problem was, by printing all variables taken in
consideration to get the conclusion that the firmware is buggy.

Regarding the problem, Usama and I are suspecting that it might be
related to some 77d48d39e99170 ("efistub/tpm: Use ACPI reclaim memory for
event log to avoid corruption"), but at this time with memattr table, where it
might not preserved during kexec(?).

Thanks,
--breno

