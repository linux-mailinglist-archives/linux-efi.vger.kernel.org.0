Return-Path: <linux-efi+bounces-1712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B795976C15
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D19E1C23E04
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BCB1AB6E9;
	Thu, 12 Sep 2024 14:29:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58281A4E7C;
	Thu, 12 Sep 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151356; cv=none; b=XuxX9dNIt+8bMP7MbfVgNWHjbnGlGRc+SilQU22GL8DJ1CYZP1rOmbhQdwtex5g6HoN95W/g5rKEhFCyvwVCMtcwnwiwB0jPnWHWwddHyPcSFW9I51YKGnaWqFDcoHExqAk4VxNuqp59rIjUbjLkSsuwqO60/5HILB14AkeJgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151356; c=relaxed/simple;
	bh=AiewB2nyHhDhsCafWFsV1VNzT9dDxzWOrcgwaYLm81s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfv+5M2YP40a76upUdAfFwrMw2cbfcVrUXukzqJXT1SkDe4JDIhL+MYn6QUYIlRNtjiOjilYDnBPDs6CjvZeF9tBlQ30myyvX2dJOkW2tl+9Ca3aZihK1CwbmQhQJ1giZoNte3lDpBINrk8iFl4Xx1ug+BSC2k9tQwvz24ogaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d64b27c45so164652466b.3;
        Thu, 12 Sep 2024 07:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151353; x=1726756153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ojlwVPNe7KlSzk6swI2y1+uEfsmH3zHy4IiUElclC0=;
        b=KCnGaE/27FvU+FBot/fOWYywyV7LMaoCbdspOCBmof/wM5QPIT0z5UmqhWzBbrmSji
         XkqN9S1+vMOar728rkzR+tV5zcqzY7b1Hl+gK2vm9UVnxxNqdkH5FsjwcGjhmq44gxtE
         Ak/A+3Ykw6tZkmLPeD5npceTLmBBrgChdoTcsYKvcr/jKXme6kloi+QopompAJLHGLNB
         DSeK6KMqF352372htwbtWfHxP1Nq4FDRVxF1nBIga8FBpCguYHY8RWG/cPa1Wmlcw0PS
         E6+b9yBSTxSpFwdopscUtkaspFyln6Ovkxdz8zIRKmAiLWbnVIPCTO9zNPU2VKcfkNap
         tWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/4IjrMlD4oBXHv1qBPuHqzp8E2hIXCtVEoa2xhw0pwDkq0twZBrGm8oq1ktRih6xRuj5IFl8Dbo=@vger.kernel.org, AJvYcCU37um6A+SElhJ69giGAilCPxVZHd8mlrldWxE6bB1VAWe+BOeK9mBFqp59jcN3DfYt0y6PZ14I/5SFowf4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ixGN+9txyP7ZkG0u0K/f7BQguTQFzYFD3ljyPG3ynkYy6AJV
	4ScMrRKoNXgTtCN/ujINibRyYQwUg1ap7qMwmWjI5nXNXWJ7tn5v
X-Google-Smtp-Source: AGHT+IHNDDf/Q8uWvQAGDtFVftOcPwKOzxFnfjPmpTmeeCiD52hd3Vd9S9TsRJFtVvbr7CyIHyR95A==
X-Received: by 2002:a17:907:e21b:b0:a86:842a:104a with SMTP id a640c23a62f3a-a9029636efbmr290362266b.57.1726151352792;
        Thu, 12 Sep 2024 07:29:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65c8asm754656466b.215.2024.09.12.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:29:12 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:29:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
	gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240912-sapphire-koala-of-focus-918cff@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
> On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
> > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > I don't see how this could be an EFI bug, given that it does not deal
> > > with E820 tables at all.
> >
> > I want to back up a little bit and make sure I am following the
> > discussion.
> >
> > From what I understand from previous discussion, we have an EFI bug as
> > the root cause of this issue.
> >
> > This happens because the EFI does NOT mark the EFI TPM event log memory
> > region as reserved (EFI_RESERVED_TYPE).
> 
> Why do you think EFI should use EFI_RESERVED_TYPE in this case?
> 
> The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
> used for anything by EFI itself. It is quite common for EFI
> configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
> EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
> 
> Reserved memory is mostly for memory that even the firmware does not
> know what it is for, i.e., particular platform specific uses.
> 
> In general, it is up to the OS to ensure that EFI configuration tables
> that it cares about should be reserved in the correct way.

Thanks for the explanation.

So, if I understand what you meant here, the TPM event log memory range
shouldn't be listed as a memory region in EFI memory map (as passed by
the firmware to the OS).

Hence, this is not a EFI firmware bug, but a OS/Kernel bug.

Am I correct with the statements above?

Another question, looking at the Spec[1] it says:

	If the ACPI TPM2 table contains the address and size of the Platform Firmware TCG log,
	firmware “pins” the memory associated with the Platform Firmware TCG log, and reports
	this memory as “Reserved” memory via the INT 15h/E820 interface


What is the 'firmware' in the statement above, that says that reports
the memory as reserved? (Is it libstub?!)

Thank you so much for guiding us here,
--breno

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf

