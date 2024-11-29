Return-Path: <linux-efi+bounces-2236-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C69DBFC5
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F066B16400B
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC513D893;
	Fri, 29 Nov 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/4g+OBi"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB991537DA
	for <linux-efi@vger.kernel.org>; Fri, 29 Nov 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865522; cv=none; b=Gbz8zzr1CH1AILDlXx9m1FhcX7WTstQPG7pyCf8BeGuVyUVuaMfDg31neupHBPD5ElUpSpfjNap+5r7gIaEUodKOpe/9RcIlhAq//OGpjayszbFEoLgRysxFFnPbQV/RZegZvic1f5vHA/0Gh1boRhD5ZplLfCuffIU9OJOHrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865522; c=relaxed/simple;
	bh=xWaYTuZezpdtPQcdPqMmVue9U3gGtYVx84uQtss2cs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8uQbLVTBMHRDzOWQVPz1Lu5PhZVGJ9I3Alx3dQ4gXt28UQ61JYS1R7f9WEUCN85W+IxtA/CFm1ufbGv8h/L9cyqyw70ubBM6bs+xYoYGG5x2p29j2beqYgx9L5+NBW28ZUIwahEwmMbOzGsanPUcIvFRI8Dn27SaLoNDe8JYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/4g+OBi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732865519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
	b=f/4g+OBii4jOsk0vz3aXOgQtyGPFxs5KWjKvh8INWLW5RPSt3oglogxA6ABkofIBa8QaLd
	yN+hCkwkhxC+KoEAeVRaENxd6ludtYTHfTyAeewBgw4oj6Falg8+u/WC4v/FDI4mnBgwCj
	+y/yaFJ3HLEiqbeQ4SJVExpAdHXpE60=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-VoVlFlY1M4ya0Y_7DfAfaQ-1; Fri, 29 Nov 2024 02:31:57 -0500
X-MC-Unique: VoVlFlY1M4ya0Y_7DfAfaQ-1
X-Mimecast-MFC-AGG-ID: VoVlFlY1M4ya0Y_7DfAfaQ
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7254237c888so1415009b3a.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Nov 2024 23:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732865516; x=1733470316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
        b=NBpFZn6l+9/RMovnLGTlQlLIRDA+5Ij8Pf1QmXR7tkn/kSvvU6Xm03mOLCnOFhIhFW
         oVgyZ6/RpMDz9au/tJWjd1wOS2I+U0ZtDczzkpfFxzxHIfxbg7xGr8hTSxLquLlD60Yz
         KxW7Xl2Qbd7BX6pxZynGZyg6TWRw+4CcKKjTA8+81mqjiLUIDCcCjsT9rplVDpXgYc7/
         5C1GHfwLKDK8cqVKeWL4mflT0z9QfnbDagHlw94WLvsOpMITEnCZsxR7HsHv+N7sdEH+
         lRAm3j+tHhoqQtg8LU9iiEiewIOSHrNR/WxWOh9EcwRYADDXfKWQ7D4NmtR4pXY14t7P
         1T8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwPmja5wz2aoJ3EGz84Ginh3jvhFqgEddXXz7PQCadsBYiCYlxaMyzWv+lapSRtDDTz+FX4fneR+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHpIUb0K3ssYJuv2R5lzR/ol3BviimejPBE7YN8PkJXV//Jon
	PxXjAnV7jJxxJN4ppLQeUVLgY+2iJW8PaVcD24fg/fp/mLTInJig1/L3nUZbHm193tLQF5pebIc
	HXIG8staWK55eGFFwrPvUpAsN7it6Q9z5YFdHM2lUZKkqNCzYJKgUypv8JAzsrS+8TZ1VhXtJ1a
	EU8/xhN/BDd7rmgWskGYDrFE+sakGoaIC2
X-Gm-Gg: ASbGncuhGUiuSxbS6m5qYDJO6Gsi846ENYbMVp+s6O+j13EtUMRGMR7Mcwn/6oW7dyV
	TMXLKgmR5NFIcBdRaf11LTroSOzL5CgT7
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id d9443c01a7336-21501381ba1mr114779855ad.21.1732865516085;
        Thu, 28 Nov 2024 23:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh9PVUdRddFYSNm3UAC8iohKaFfKlk5Hz1e9QnkR2ed+tnFKg6KvsdnxD7bVahLsd/3R//CZpc/mtOTZkKAJE=
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id
 d9443c01a7336-21501381ba1mr114779725ad.21.1732865515779; Thu, 28 Nov 2024
 23:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
 <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com> <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
In-Reply-To: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:31:50 +0800
Message-ID: <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 15:11, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Nicolas,
>
> On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >
> > Hi Dave,
> >
> > On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> > >>
> > >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> > >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> > >> the original kernel. Unfortunately, that function fails to reinstate
> > >> EFI's memory attributes, which would've otherwise been set after
> > >> entering virtual mode. Remediate this by calling
> > >> efi_runtime_update_mappings() within kexec's routine.
> > >
> > > In the function __map_region(), there are playing with the flags
> > > similar to the efi_runtime_update_mappings though it looks a little
> > > different.  Is this extra callback really necessary?
> >
> > EFI Memory attributes aren't tracked through
> > `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> > `__map_region()` after kexec will not honor them.
>
> From the comment below the reason to do the mappings update is that
> firmware could perform some fixups.  But for kexec case I think doing
> the mapping correctly in the mapping code would be good enough.
>
>         /*
>          * Apply more restrictive page table mapping attributes now that
>          * SVAM() has been called and the firmware has performed all
>          * necessary relocation fixups for the new virtual addresses.
>          */
>         efi_runtime_update_mappings();
>
> Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
> create the virtual efi memmap,  but I think the __map_region is called
> after kexecing into the 2nd kernel, so I feel that at that time the
> mem attr table should be usable.

Another thing I'm not sure why the updated mem attr is not stored in
the memmap md descriptor "attribute" field, if that is possible then
the runtime-map will carry them,  anyway, the __map_region still needs
tweaking to use the attribute.

>
> Anyway thanks for explaining about this.  It is indeed something to
> improve.  I have no strong opinion as your code will also work.
>
>
> >
> > > Have you seen a real bug happened?
> >
> > If lowered security posture after kexec counts as a bug, yes. The system
> > remains stable otherwise.
> >
> > Nicolas
> >
>
> Thanks
> Dave


